
# Summary
In this report, the result from the navigation project is presdented usinfg a **DQN**.

## Project's Description 
For this project we have to train an agent to navigate a large square world and collect yellow bananas. The world contains both yellow and blue banana as depicted in the animated gif below.
![In Project 1, train an agent to navigate a large world.](images/banana.gif)

### Rewards:
1. The agent is given a reward of +1 for collecting a yellow banana
1. Reward of -1 for collecting a blue banana.

### State Space 
Has 37 dimensions and the contains the agents velocity, along with ray-based precpetion of objects around the agents foward direction.

### Actions 
Four discrete actions are available, corresponding to:

- 0 - move forward.
- 1 - move backward.
- 2 - turn left.
- 3 - turn right.


## Project's goal
The goal for the project is for the to collect as many yellow bananas as possible while avoiding blue bananas. The task is episodic, and in order to solve the environment, the agent must get an average score of +13 over 100 consecutive episodes.



# Learning Algorithm
Source code of learning algorithm is placed in `dqn/` directory.
The algorithm is composed mainly of next three parts.

## 1. DQN
As reinforcement learning algorithm, I implemented **DDQN**.
Because DQN seems to be working pretty well where I got reward till 15 with not that much episodes
Inside DQN,a three layer neural network has bee used as Q-Value Estimator.
Hidden layers are composed of ``State -> 64 -> ReLU -> 64 ->ReLU -> Action``

## 2. Experience Replay
Similarly to original DQN paper, **Experience Replay** has been implemented
In this technique, DQN model is trained by mini-batch from replay buffer.

## 3. Epsilon Greedy
Agent select next action based on Epsilon Greedy. At probability epsilon,
agent select at random from action space.
The value of epsilon is set 0.999, and decrease gradually with time until 0.001.

# Rewards Result
This is plot of rewards when training.
At Episode 616, agent performance met the criteria and stopped training.
(The mean score of last 100 episodes is more than +15)

![plot of rewards](./index.png)

# Ideas for Future Work
For further performance improvement, I wish to implement the DDQN algorithm. [Deep Reinforcement Learning with Double Q-learning](https://arxiv.org/abs/1509.06461)
- Performing Grid search can be an option for hyper-parameter tuning, especially Q-value model.

# Trained model
[Trained model (DDQN)](./checkpoint.pth)



### Exploring the Environment 

#### Step 1: Clone the DRLND Repository
1. Configure your Python environment by following [instructions in the DRLND GitHub repository](https://github.com/udacity/deep-reinforcement-learning#dependencies). These instructions can be found in the [Readme.md](https://github.com/Unity-Technologies/ml-agents/blob/master/docs/Readme.md)
1. By following the instructions you will have PyTorch, the ML-Agents toolkits, and all the Python packages required to complete the project.
1. (For Windows users) The ML-Agents toolkit supports Windows 10. It has not been test on older version but it may work.

#### Step 2: Download the Unity Environment 
- For this projects you will need to install the Unity environment as described in the [Getting Started section](https://github.com/udacity/deep-reinforcement-learning/blob/master/p1_navigation/README.md) (The Unity ML-agant environment is already configured by Udacity)

  
1. Check [this nanodegree's prerequisite](https://github.com/udacity/deep-reinforcement-learning/#dependencies), and follow the instructions.

2. Download the environment from one of the links below.  You need only select the environment that matches your operating system:
    - Linux: [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana_Linux.zip)
    - Mac OSX: [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana.app.zip)
    - Windows (32-bit): [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana_Windows_x86.zip)
    - Windows (64-bit): [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana_Windows_x86_64.zip)

    (_For Windows users_) Check out [this link](https://support.microsoft.com/en-us/help/827218/how-to-determine-whether-a-computer-is-running-a-32-bit-version-or-64) if you need help with determining if your computer is running a 32-bit version or 64-bit version of the Windows operating system.

#### Step 3: Explore the Environment
After you have followed the instructions above,to train the agent, start jupyter notebook, open navigation.ipynb and execute! For more information, please check instructions inside the notebook.

### Train a agent
There are 2 options for training the Agent:
1. Execute the provided notebook within this Nanodegree Udacity Online Workspace for "project #1  Navigation".
1. Or build your own local environment and make necessary adjustements for the path to the UnityEnvironment in the code.

Note: that the Workspace does not allow you to see the simulator of the environment; so, if you want to watch the agent while it is training, you should train locally.



