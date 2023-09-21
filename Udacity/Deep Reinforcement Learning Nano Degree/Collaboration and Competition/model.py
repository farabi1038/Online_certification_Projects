import numpy as np

import torch
import torch.nn as nn
import torch.nn.functional as F


# Default hyperparameters
                           
SEED = 10                          # Random seed

NB_EPISODES = 10000                # Max nb of episodes
NB_STEPS = 1000                    # Max nb of steps per episodes 
UPDATE_EVERY_NB_EPISODE = 4        # Nb of episodes between learning process
MULTIPLE_LEARN_PER_UPDATE = 3      # Nb of multiple learning process performed in a row

BUFFER_SIZE = int(1e5)             # replay buffer size
BATCH_SIZE = 200                   # minibatch size

ACTOR_FC1_UNITS = 400  #256        # Number of units for the layer 1 in the actor model
ACTOR_FC2_UNITS = 300  #128        # Number of units for the layer 2 in the actor model
CRITIC_FCS1_UNITS = 400  #256      # Number of units for the layer 1 in the critic model
CRITIC_FC2_UNITS = 300  #128       # Number of units for the layer 2 in the critic model
NON_LIN = F.relu   #F.leaky_relu   # Non linearity operator used in the model
LR_ACTOR = 1e-4    #1e-4           # learning rate of the actor 
LR_CRITIC = 5e-3   #2e-3           # learning rate of the critic
WEIGHT_DECAY = 0   #0.0001         # L2 weight decay

GAMMA = 0.995 #0.99                # Discount factor
TAU = 1e-3                         # For soft update of target parameters
CLIP_CRITIC_GRADIENT = False       # Clip gradient during Critic optimization

ADD_OU_NOISE = True                # Add Ornstein-Uhlenbeck noise
MU = 0.                            # Ornstein-Uhlenbeck noise parameter
THETA = 0.15                       # Ornstein-Uhlenbeck noise parameter
SIGMA = 0.2                        # Ornstein-Uhlenbeck noise parameter
NOISE = 1.0                        # Initial Noise Amplitude 
NOISE_REDUCTION = 1.0 # 0.995      # Noise amplitude decay ratio



def hidden_init(layer):
    fan_in = layer.weight.data.size()[0]
    lim = 1. / np.sqrt(fan_in)
    return (-lim, lim)

class Actor(nn.Module):
    """Actor (Policy) Model."""

    def __init__(self, input_dim, output_dim, seed=10, fc1_units=ACTOR_FC1_UNITS, fc2_units=ACTOR_FC2_UNITS):
        """Initialize parameters and build model.
        Params
        ======
            input_dim (int): Input dimension (Dimension of each state)
            output_dim (int): Output dimension (Dimension of each action)
            seed (int): Random seed
            fc1_units (int): Number of nodes in first hidden layer
            fc2_units (int): Number of nodes in second hidden layer
        """
        super(Actor, self).__init__()
        self.seed = torch.manual_seed(seed)
        self.nonlin = NON_LIN
        
        # Dense layers
        self.fc1 = nn.Linear(input_dim, fc1_units)
        self.fc2 = nn.Linear(fc1_units, fc2_units)
        self.fc3 = nn.Linear(fc2_units, output_dim)
        
        # Normalization layers
        self.bn1 = nn.BatchNorm1d(fc1_units)
        #self.bn2 = nn.BatchNorm1d(fc2_units)
        
        self.reset_parameters()
        

    def reset_parameters(self):
        self.fc1.weight.data.uniform_(*hidden_init(self.fc1))
        self.fc2.weight.data.uniform_(*hidden_init(self.fc2))
        self.fc3.weight.data.uniform_(-3e-3, 3e-3)
        

    def forward(self, state):
        """Build an actor (policy) network that maps states -> actions."""
        
        # Reshape the state to comply with Batch Normalization
        if state.dim() == 1:
            state = torch.unsqueeze(state,0)
            
        h1 = self.nonlin(self.fc1(state))
        h1 = self.bn1(h1) # Batch Normalization after Activation  
        h2 = self.nonlin(self.fc2(h1))
        return F.tanh(self.fc3(h2))    



class Critic(nn.Module):
    """Critic (Value) Model."""

    def __init__(self, input_dim, action_size, seed=10, fcs1_units=CRITIC_FCS1_UNITS, fc2_units=CRITIC_FC2_UNITS):
        """Initialize parameters and build model.
        Params
        ======
            input_dim (int): Input dimension (Dimension of each state)
            action_size : Dimension of each action
            seed (int): Random seed
            fcs1_units (int): Number of nodes in the first hidden layer
            fc2_units (int): Number of nodes in the second hidden layer
        """
        super(Critic, self).__init__()
        self.seed = torch.manual_seed(seed)
        self.nonlin = NON_LIN
        
        # Dense layers 
        
        # Vanilla DDPG architecture
        #self.fcs1 = nn.Linear(input_dim, fcs1_units)
        #self.fc2 = nn.Linear(fcs1_units+action_size, fc2_units)
        
        # Modified DDPG architecture
        self.fcs1 = nn.Linear(input_dim+action_size, fcs1_units)
        self.fc2 = nn.Linear(fcs1_units, fc2_units)
        
        self.fc3 = nn.Linear(fc2_units, 1)
        
        # Normalization layers
        self.bn1 = nn.BatchNorm1d(fcs1_units)
        #self.bn2 = nn.BatchNorm1d(fc2_units)
        
        self.reset_parameters()
        

    def reset_parameters(self):
        self.fcs1.weight.data.uniform_(*hidden_init(self.fcs1))
        self.fc2.weight.data.uniform_(*hidden_init(self.fc2))
        self.fc3.weight.data.uniform_(-3e-3, 3e-3)
        

    def forward(self, state, action):
        """Build a critic (value) network that maps (state, action) pairs -> Q-values."""
          
        # Reshape the state to comply with Batch Normalization
        if state.dim() == 1:
            state = torch.unsqueeze(state,0)

        # Vanilla DDPG architecture    
        #xs = self.nonlin(self.fcs1(state))
        ###xs = self.bn1(xs) # Batch Normalization after Activation  
        #x = torch.cat((xs, action.float()), dim=1)
        
        # Modified DDPG architecture
        xs = torch.cat((state, action.float()), dim=1)
        x = self.nonlin(self.fcs1(xs))
        x = self.bn1(x) # Batch Normalization after Activation 
        
        x = self.nonlin(self.fc2(x))
        return self.fc3(x)

   