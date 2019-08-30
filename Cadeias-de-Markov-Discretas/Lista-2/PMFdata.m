 
%  PMFdata.m
%
%  This program generates the outcomes for N trials 
%  of an experiment for a discrete random variable.
%  Uses the method of Section 5.9.  
%  It is a function subprogram.
%
%  Input parameters:
%
%    N   - number of trials desired
%    xi  - values of x_i's of discrete random variable (M x 1 vector)
%    pX  - PMF of discrete random variable (M x 1 vector)
%
%  Output parameters:
%
%    x   - outcomes of N trials (N x 1 vector)
%
function x=PMFdata(N,xi,pX)
M=length(xi);M2=length(pX);
    if M~=M2
    message='xi and pX must have the same dimension'
    end
    for k=1:M ; % see Section 5.9 and Figure 5.14 for approach used here
    if k==1
        bin(k,1)=pX(k); % set up first interval of CDF as [0,pX(1)]
   
    else
            bin(k,1)=bin(k-1,1)+pX(k); % set up succeeding intervals
                                   % of CDF
    end
    end  
    u=rand(N,1); % generate N outcomes of uniform random variable
    for i=1:N % determine which interval of CDF the outcome lies in
            % and map into value of xi
        if u(i)>0&&u(i)<=bin(1)  
           x(i,1)=xi(1);
        end
        for k=2:M
           if u(i)>bin(k-1)&&u(i)<=bin(k)
              x(i,1)=xi(k);
           end
        end
    end
end