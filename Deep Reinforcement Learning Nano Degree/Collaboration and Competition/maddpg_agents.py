import numpy as np
import random
import copy
from collections import namedtuple, deque
import torch

from ddpg_agent import Agent

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



device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

class ReplayBuffer:
    """Fixed-size buffer to store experience tuples."""

    def __init__(self, action_size, buffer_size, batch_size, seed):
        """Initialize a ReplayBuffer object.
        Params
        ======
            buffer_size (int): maximum size of buffer
            batch_size (int): size of each training batch
        """
        self.action_size = action_size
        self.memory = deque(maxlen=buffer_size)  # internal memory (deque)
        self.batch_size = batch_size
        self.experience = namedtuple("Experience", field_names=["state", "action", "reward", "next_state", "done"])
        self.seed = random.seed(seed)
    
    def add(self, state, action, reward, next_state, done):
        """Add a new experience to memory."""
        e = self.experience(state, action, reward, next_state, done)
        self.memory.append(e)
        
        #if (len(self.memory)%10000==0):
        #    print("\n[INFO] Replay memory size =", len(self.memory))
    
    def sample(self):
        """Randomly sample a batch of experiences from memory."""
        experiences = random.sample(self.memory, k=self.batch_size)

        states = torch.from_numpy(np.vstack([e.state for e in experiences if e is not None])).float().to(device)
        actions = torch.from_numpy(np.vstack([e.action for e in experiences if e is not None])).float().to(device)
        rewards = torch.from_numpy(np.vstack([e.reward for e in experiences if e is not None])).float().to(device)
        next_states = torch.from_numpy(np.vstack([e.next_state for e in experiences if e is not None])).float().to(device)
        dones = torch.from_numpy(np.vstack([e.done for e in experiences if e is not None]).astype(np.uint8)).float().to(device)

        return (states, actions, rewards, next_states, dones)

    def __len__(self):
        """Return the current size of internal memory."""
        return len(self.memory)


device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

class Maddpg():
    """MADDPG Agent : Interacts with and learns from the environment."""
    
    def __init__(self, state_size, action_size, num_agents, random_seed):
        """Initialize a MADDPG Agent object.
        
        Params
        ======
            state_size (int): dimension of each state
            action_size (int): dimension of each action
            num_agents (int): number of agents
            random_seed (int): random seed
        """
        
        super(Maddpg, self).__init__()
        
        self.state_size = state_size
        self.action_size = action_size
        self.num_agents = num_agents
        self.seed = random.seed(random_seed)
        
        # Instantiate Multiple  Agent
        self.agents = [ Agent(state_size,action_size, random_seed, num_agents) 
                       for i in range(num_agents) ]
        
        # Instantiate Memory replay Buffer (shared between agents)
        self.memory = ReplayBuffer(action_size, BUFFER_SIZE, BATCH_SIZE, random_seed)
        
                  
    def reset(self):
        """Reset all the agents"""
        for agent in self.agents:
            agent.reset()

    def act(self, states, noise):
        """Return action to perform for each agents (per policy)"""        
        return [ agent.act(state, noise) for agent, state in zip(self.agents, states) ]
                
    
    def step(self, states, actions, rewards, next_states, dones, num_current_episode):
        """ # Save experience in replay memory, and use random sample from buffer to learn"""
 
        #self.memory.add(states, It mainly reuse function from ``actions, rewards, next_states, dones)
        self.memory.add(encode(states), 
                        encode(actions), 
                        rewards,
                        encode(next_states),
                        dones)

        # If enough samples in the replay memory and if it is time to update
        if (len(self.memory) > BATCH_SIZE) and (num_current_episode % UPDATE_EVERY_NB_EPISODE ==0) :
            
            # Note: this code only expects 2 agents
            assert(len(self.agents)==2)
            
            # Allow to learn several time in a row in the same episode
            for i in range(MULTIPLE_LEARN_PER_UPDATE):
                # Sample a batch of experience from the replay buffer 
                experiences = self.memory.sample()   
                # Update Agent #0
                self.maddpg_learn(experiences, own_idx=0, other_idx=1)
                # Sample another batch of experience from the replay buffer 
                experiences = self.memory.sample()   
                # Update Agent #1
                self.maddpg_learn(experiences, own_idx=1, other_idx=0)
                
    
    def maddpg_learn(self, experiences, own_idx, other_idx, gamma=GAMMA):
        """
        Update the policy of the MADDPG "own" agent. The actors have only access to agent own 
        information, whereas the critics have access to all agents information.
        
        Update policy and value parameters using given batch of experience tuples.
        Q_targets = r + γ * critic_target(next_state, actor_target(next_state))
        where:
            actor_target(states) -> action
            critic_target(all_states, all_actions) -> Q-value

        Params
        ======
            experiences (Tuple[torch.Tensor]): tuple of (s, a, r, s', done) tuples 
            own_idx (int) : index of the own agent to update in self.agents
            other_idx (int) : index of the other agent to update in self.agents
            gamma (float): discount factor
        """
        
        states, actions, rewards, next_states, dones = experiences
               
        # Filter out the agent OWN states, actions and next_states batch
        own_states =  decode(self.state_size, self.num_agents, own_idx, states)
        own_actions = decode(self.action_size, self.num_agents, own_idx, actions)
        own_next_states = decode(self.state_size, self.num_agents, own_idx, next_states) 
                
        # Filter out the OTHER agent states, actions and next_states batch
        other_states =  decode(self.state_size, self.num_agents, other_idx, states)
        other_actions = decode(self.action_size, self.num_agents, other_idx, actions)
        other_next_states = decode(self.state_size, self.num_agents, other_idx, next_states)
        
        # Concatenate both agent information (own agent first, other agent in second position)
        all_states=torch.cat((own_states, other_states), dim=1).to(device)
        all_actions=torch.cat((own_actions, other_actions), dim=1).to(device)
        all_next_states=torch.cat((own_next_states, other_next_states), dim=1).to(device)
   
        agent = self.agents[own_idx]
        
            
        # ---------------------------- update critic ---------------------------- #
        # Get predicted next-state actions and Q values from target models        
        all_next_actions = torch.cat((agent.actor_target(own_states), agent.actor_target(other_states)),
                                     dim =1).to(device) 
        Q_targets_next = agent.critic_target(all_next_states, all_next_actions)
        
        
        # Compute Q targets for current states (y_i)
        Q_targets = rewards + (gamma * Q_targets_next * (1 - dones))
        
        # Compute critic loss
        Q_expected = agent.critic_local(all_states, all_actions)
        critic_loss = F.mse_loss(Q_expected, Q_targets)
        
        # Minimize the loss
        agent.critic_optimizer.zero_grad()
        critic_loss.backward()
        if (CLIP_CRITIC_GRADIENT):
            torch.nn.utils.clip_grad_norm(agent.critic_local.parameters(), 1)
        agent.critic_optimizer.step()

        # ---------------------------- update actor ---------------------------- #
        # Compute actor loss
        all_actions_pred = torch.cat((agent.actor_local(own_states), agent.actor_local(other_states).detach()),
                                     dim = 1).to(device)      
        actor_loss = -agent.critic_local(all_states, all_actions_pred).mean()
        
        # Minimize the loss
        agent.actor_optimizer.zero_grad()
        actor_loss.backward()        
        agent.actor_optimizer.step()

        # ----------------------- update target networks ----------------------- #
        agent.soft_update(agent.critic_local, agent.critic_target, TAU)
        agent.soft_update(agent.actor_local, agent.actor_target, TAU)                   
    
    
                        
    def checkpoints(self):
        """Save checkpoints for all Agents"""
        for idx, agent in enumerate(self.agents):
            actor_local_filename = 'model_dir/checkpoint_actor_local_' + str(idx) + '.pth'
            critic_local_filename = 'model_dir/checkpoint_critic_local_' + str(idx) + '.pth'           
            actor_target_filename = 'model_dir/checkpoint_actor_target_' + str(idx) + '.pth'
            critic_target_filename = 'model_dir/checkpoint_critic_target_' + str(idx) + '.pth'            
            torch.save(agent.actor_local.state_dict(), actor_local_filename) 
            torch.save(agent.critic_local.state_dict(), critic_local_filename)             
            torch.save(agent.actor_target.state_dict(), actor_target_filename) 
            torch.save(agent.critic_target.state_dict(), critic_target_filename)
            
            
def encode(sa):
    """
    Encode an Environment state or action list of array, which contain multiple agents action/state information, 
    by concatenating their information, thus removing (but not loosing) the agent dimension in the final output. 
    
    The ouput is a list intended to be inserted into a buffer memmory originally not designed to handle multiple 
    agents information, such as in the context of MADDPG)
    
    Params
    ======       
            sa (listr) : List of Environment states or actions array, corresponding to each agent
                
    """
    return np.array(sa).reshape(1,-1).squeeze()



def decode(size, num_agents, id_agent, sa, debug=False):
    """
    Decode a batch of Environment states or actions, which have been previously concatened to store 
    multiple agent information into a buffer memmory originally not designed to handle multiple 
    agents information(such as in the context of MADDPG)
    
    This returns a batch of Environment states or actions (torch.tensor) containing the data 
    of only the agent specified.
    
    Params
    ======
            size (int): size of the action space of state spaec to decode
            num_agents (int) : Number of agent in the environment (and for which info hasbeen concatenetaded)
            id_agent (int): index of the agent whose informationis going to be retrieved
            sa (torch.tensor) : Batch of Environment states or actions, each concatenating the info of several 
                                agents (This is sampled from the buffer memmory in the context of MADDPG)
            debug (boolean) : print debug information
    
    """
    
    list_indices  = torch.tensor([ idx for idx in range(id_agent * size, id_agent * size + size) ]).to(device)    
    out = sa.index_select(1, list_indices)
   
    if (debug):
        print("\nDebug decode:\n size=",size, " num_agents=", num_agents, " id_agent=", id_agent, "\n")
        print("input:\n", sa,"\n output:\n",out,"\n\n\n")
    return  out

