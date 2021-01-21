# Behavior of adjusted Rand index in simulated setting

Adjusted Rand index (`ari`) is a commonly used mesaure for assessing agreement between two partitions. 
`ari` [adjusts the Rand index for chance level](https://en.wikipedia.org/wiki/Rand_index#Adjusted_Rand_index) and hence is preferred in applications.
However, interpretation of `ari` is rather tricky as it depends on properties of the partitions and a given value of `ari` (e.g. 0.4) cannot be directly compared across datasets.

This repository provides a simple simulation analysis that reinforces the difficulty in interpreting `ari` values. 
The simulations compare binary partitions of a fixed size (default 100) with added noise (degree of mismatch) and also different levels of imbalance in the two classes.

This simple simulation was performed using the following code: 
`a <- run_ari_behave(cl_balance = c(0.5, 0.7, 0.8, 0.9, 0.95), n_repeat = 100, n=1000)`

![results](image.png?raw=true "Results")

As the results show, `ari` scales non-linearly with the amount of noise and is affected by the imbalance.

