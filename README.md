Markov Jump Linear Systems (MJLS) are linear dynamical systems whose parameters are governed by a Markov chain {θ(k), k ≥ 0}. 
The term “hidden” refers to the fact that, the parameter θ is indirectly observed via a related process {η(k), k ≥ 0}.


The dataset contains the instances used in the statistical analysis presented in the article "A New Method for the H2 Problem of Hidden Markov Jump Linear Systems." The data are stored in MATLAB .mat format using a structured data type for easy access. After unzipping and loading an instance in MATLAB (e.g., using load('instance1.mat')), you will find a single struct variable named S, which contains the following fields:

A: System matrices for each mode.

B: Input matrices for each mode.

C: Output matrices for each mode.

D: Feedthrough matrices for each mode.

E: Disturbance input matrices for each mode.

Q: Detector matrix used in the hidden mode modeling.

Prob: Transition probability matrix for the Markov chain.

init_distrib: Initial mode distribution (e.g., [1 0 0 0] indicates the system starts in mode 1).

The dimensions of each matrix are detailed in the article.


% ------------------------------------------------------------------------------

Loading data in MATLAB:

load('instance_1.mat');   % Load a specific instance

A = S.A;            % Access system matrix A

Q = S.Q;            % Access detector matrix Q

% ------------------------------------------------------------------------------


You can use the matrices in S to simulation routines. Each instance captures a specific system configuration with a defined mode transition structure and initial condition.
