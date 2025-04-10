function hmjlsg(n_s)

% hmjlsg(n_s)
%
% creates n_s hidden Markov jump linear systems and saves them in
% a subfolder. The system equations are:
%
% x(k+1) = A(:,:,theta(k))x(k) + B(:,:,theta(k))u(k) + E(:,:,theta(k))w(k)
%   z(k) = C(:,:,theta(k))x(k) + D(:,:,theta(k))u(k)
%
%
% The initial condition x(0) is not created in this code.
% The initial distribution of the Markov chain \theta(0) is
% set as pi0 = [ 1 0 ... 0 ].
%
%

% Authors and contact:
% Luiz H. Romero        and     Eduardo F. Costa
% neoluizz@gmail.com            edu.fontoura.costa@gmail.com
%
% March 10th, 2025
%


% -- The folder in which each example will be stored.
% If it does not exist, the algorithm automatically creates it.
folder = './examples/';
try
    eval(sprintf('mkdir ''%s'' ',folder))
catch
    error('Error! This folder does exist.');
end


% ----------
for k = 1:n_s   % -- NUMBER OF INSTANCES.
    
    % ----
    % Random dimensions:
    N = randi([4,5]);     % -- Number of Markov states, ranging between 4 and 5
    M = randi([1,5]);     % -- Number of outputs of the Markov chain, ranging between 1 and 5 and not greater than N
    M = min(M,N);
    n = randi([2,3]);     % -- Dimension of x, ranging between 2 and 3
    m = randi([1,2]);     % -- Dimension of u, ranging between 1 and 2
    r = randi([1,2]);     % -- Dimension of w, ranging between 1 and 2
    s = m + n;            % -- Output
    
    
    % -----
    % Markov chain data:
    % Creating P
    %
    check_P = 0;      % auxiliary variable, 0 if P fails to meet some criteria
    while check_P == 0
        % -- The algorithm starts by preallocating memory for an N x N matrix.
        % After that, approximately half of the elements are randomly selected
        % and filled according to a Gaussian distribution.
        P = zeros(N,N);
        for i = 1:round(N^2/2)
            P(randi(N),randi(N)) = rand;
        end
        % -- Checks whether any column sums to zero; in positive case, set
        %    the diagonal element to 1, meaning that the corresponding
        %    Markov state only reaches itselt
        aux = sum(P,1);
        aux = find(aux==0);
        for  i = aux
            P(i,i) = 1;
        end
        % -- Ensuring that each row sums to one.
        aux = sum(P,2);
        aux = find(aux == 0);
        for i = aux
            P(i,i) = 1;
        end
        aux_ = sum(P,2);
        for i = 1:N
            P(i,:) = P(i,:)  / aux_(i);
        end
        % If P satisfies fundamental properties of a stochastic matrix
        % (non-negative entries, sum of the  elements in each row equals one)
        % the code continues, otherwise it goes back and create another P
        if any(P(:) < 0) || any(P(:) > 1) || any(abs(sum(P,2) - 1) > 0) || any(all(P == 0,1))
            continue;
        else
            check_P = 1;
        end
    end % ends while check_P
    
    
    % Creating Q:
    %
    % The code below is not commented as it follows the same steps as P
    %
    check_Q = 0;
    while check_Q == 0
        Q = zeros(N,M);
        for i = 1:round((N*M)/2)
            Q(randi(N),randi(M)) = rand;
        end
        aux = sum(Q,1);
        aux = find(aux==0);
        for  i = aux
            Q(i,i) = 1;
        end
        aux = sum(Q,2);
        aux = find(aux == 0);
        for i = aux
            Q(i,i) = 1;
        end
        aux_ = sum(Q,2);
        for i = 1:N
            Q(i,:) = Q(i,:)  / aux_(i);
        end
        if any(Q(:) < 0) || any(Q(:) > 1) || any(abs(sum(Q,2) - 1) > 0) || any(all(Q == 0,1))
            continue;
        else
            check_Q = 1;
        end
    end % ends while check_Q
    
    
    % -- Initial distribution.
    pi0 = zeros(1,N);
    pi0(1) = 1;
    
    
    % -----  Other MJLS's parameters (A--E)
    % --
    
    % Creating set of matrices A
    A = zeros(n,n,N);   % -- preallocate A
    % Half(*) of the elements in each mode are randomly selected
    % and filled according to a standard Gaussian distribution:
    % (*): half if n^2 is even, or half plus one if n^2 is odd
    for nn = 1:N
        for i = 1:ceil(n^2/2)
            A(randi(n),randi(n),nn) = randn;
        end
    end
    
    % Creating sets of matrices B,E with standard gaussian elements
    %
    B = randn(n,m,N);
    E = randn(n,r,N);
    
    
    % Creating set of matrices C and D:
    C = [];
    D = [];
    % Auxiliary variables
    aux_C = randn(s,n,N);
    aux_D = randn(s,m,N);
    % C and D satisfy C'D = 0:
    for i = 1:N
        C(:,:,i) = [ aux_C(:,:,i) ; zeros(s,n) ];
        D(:,:,i) = [ zeros(s,m) ; aux_D(:,:,i) ];
    end
    
    
    % --- SAVING DATA.
    eval(sprintf(['save ',folder,'example_%d A B C D Q P pi0'],k));
    clearvars -except k folder NINSTANCES;
    
end  % ends for k, number of instances / systems created
