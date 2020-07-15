

# Summary
In this report, the result from the navigation project is presdented usinfg a **DQN**.

## Project's Description 
For this project we have to train an agent to navigate a large square world and collect yellow bananas. The world contains both yellow and blue banana as depicted in the animated gif below.
![In Project 1, train an agent to navigate a large world.](images/banana.gif)

### Rewards:
- If an agent hits the ball over the net, it receives a reward of +0.1. 
- If an agent lets a ball hit the ground or hits the ball out of bounds, it receives a reward of -0.01.
### State Space 
The observation space consists of 8 variables corresponding to the position and velocity of the ball and racket.

### Actions 
The observation space consists of 8 variables corresponding to the position and velocity of the ball and racket. Each agent receives its own, local observation. Two continuous actions are available, corresponding to movement toward (or away from) the net, and jumping.


## Project's goal
In this environment, two agents control rackets to bounce a ball over a net. If an agent hits the ball over the net, it receives a reward of +0.1. If an agent lets a ball hit the ground or hits the ball out of bounds, it receives a reward of -0.01. Thus, the goal of each agent is to keep the ball in play.

The task is episodic and the environment is considered solved, when the average (over 100 episodes) of those scores is at least +0.5.



# Learning Algorithm
Source code of learning algorithm is placed in the root directory of the project.




# Rewards Result
This is plot of rewards when training.
At Episode 616, agent performance met the criteria and stopped training.
(The mean score of last 100 episodes is more than +15)

![plot of rewards](./reward.png)


# Trained model
[Trained model (DDQN)](./model)



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
After you have followed the instructions above,to train the agent, start jupyter notebook, open tennis.ipynb and execute! For more information, please check instructions inside the notebook.

### Train a agent
There are 2 options for training the Agent:
1. Execute the provided notebook within this Nanodegree Udacity Online Workspace for "project #3  Collaboration and Competition.
1. Or build your own local environment and make necessary adjustements for the path to the UnityEnvironment in the code.

Note: that the Workspace does not allow you to see the simulator of the environment; so, if you want to watch the agent while it is training, you should train locally.



