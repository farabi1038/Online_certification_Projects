
# Summary
In this report, the result from the navigation project is presdented usinfg a **DQN**.

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

# Getting started 
1. Check [this nanodegree's prerequisite](https://github.com/udacity/deep-reinforcement-learning/#dependencies), and follow the instructions.

2. Download the environment from one of the links below.  You need only select the environment that matches your operating system:
    - Linux: [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana_Linux.zip)
    - Mac OSX: [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana.app.zip)
    - Windows (32-bit): [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana_Windows_x86.zip)
    - Windows (64-bit): [click here](https://s3-us-west-1.amazonaws.com/udacity-drlnd/P1/Banana/Banana_Windows_x86_64.zip)

    (_For Windows users_) Check out [this link](https://support.microsoft.com/en-us/help/827218/how-to-determine-whether-a-computer-is-running-a-32-bit-version-or-64) if you need help with determining if your computer is running a 32-bit version or 64-bit version of the Windows operating system.


To train the agent, start jupyter notebook, open navigation.ipynb and execute! For more information, please check instructions inside the notebook.



