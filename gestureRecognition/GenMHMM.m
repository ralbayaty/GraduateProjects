function [ loglik, LL, prior1, transmat1, mu1, Sigma1, mixmat1 ] = GenMHMM( data,O,M,Q )

    cov_type = 'full';


    % initial guess of parameters
    prior0 = normalise(rand(Q,1));
    transmat0 = mk_stochastic(rand(Q,Q));

    [mu0, Sigma0] = mixgauss_init(Q*M, data, cov_type);
    mu0 = reshape(mu0, [O Q M]);
    Sigma0 = reshape(Sigma0, [O O Q M]);
    mixmat0 = mk_stochastic(rand(Q,M));


    [LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
        mhmm_em(data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 100);


    loglik = mhmm_logprob(data, prior1, transmat1, mu1, Sigma1, mixmat1);

    
    
end