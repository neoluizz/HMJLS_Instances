Markov Jump Linear Systems (MJLS) are linear dynamical systems whose parameters are governed by a Markov chain {θ(k), k ≥ 0}. 
The term “hidden” refers to the fact that, the parameter θ is indirectly observed via a related process {η(k), k ≥ 0}.

The system equations are:

x(k+1) = A_θ(k)x(k) + B_θ(k)u(k) + E_θ(k)w(k),

  z(k) = C_θ(k)x(k) + D_θ(k)u(k), \\

  θ(0) ∼ π(0), x(0) = 0, k ≥ 0,\\ 
  
where the processes {u(k), k ≥ 0}, {z(k), k ≥ 0} and {w(k), k ≥ 0} denote the control, the output and impulsive disturbance, respectively.
