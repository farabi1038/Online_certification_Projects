# Results report

## Selected hyperparameters

|Name|Value|
|---|---:|
|Episodes|616|
|Epsilon start|1.0|
|Epsilon decay|0.99|
|Epsilon end|0.01|
|Learning rate|0.0005|
|Gamma|0.95|
|Tau|0.001|
|Alpha|0.5|
|Beta|0.5|
|Buffer size|100000|
|Batch size|64|
|Target|15.0|

## [Deep Q Network](https://arxiv.org/abs/1312.5602)

Deep Q network:
- ReLU linear layer (in: number of states, out: 64)
- ReLU linear layer (in: 64, out: 64)
- Linear layer (in: 64, out: number of actions)

Rewards per episode with sampled replay buffer:
![Q Network with sampled replay buffer](./q_sample.png)

Rewards per episode with prioritized replay buffer:
![Q Network with prioritized replay buffer](./q_prio.png)




Noisy linear layer is similar to standard linear layer (Wx + b) but W and b matrices contains random noise 
with normal distribution sampled on each step. 



## Comparison table

|Algorithm|Episodes until solved|
|---|---|
|Deep Q network with sampled replay buffer|220|
|Deep Q network with prioritized replay buffer|&gt;750|
