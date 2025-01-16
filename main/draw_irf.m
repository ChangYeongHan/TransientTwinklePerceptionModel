function irf = draw_irf(params, type)
% Type 1: Gaussian filter
% Type 2: Gaussian filter Origin
% Type 3: Biphaisc filter

origin_params_bi = [0.0027, 15.2459, 1.9814, 10.5 0.2];

if type == 1
    t = 1:round(params(1))*6;
    mu = params(1)*3;
    var = params(1);
    irf = normpdf(t,mu,var);
    
elseif type == 2
    t = 1:params(1);
    mu = params(1)/2;
    var = params(2);
    irf = normpdf(t,mu,var);
else
    tau1 = origin_params_bi(1)*params(1);
    gamma_shape = origin_params_bi(2);
    gamma_neg_tauScale = origin_params_bi(3);

    
    dt = 1/1440;
    t_irf = dt:dt:1;

    
    irf_pos = gampdf(t_irf, gamma_shape, tau1);
    irf_neg = gampdf(t_irf, gamma_shape, tau1*gamma_neg_tauScale);
    
    irf     = irf_pos - irf_neg;
    irf     = irf/( sum( abs(irf) ));
end


end
