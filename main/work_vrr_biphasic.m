function [log_likeli, m_reciprocal_model, irf] = work_vrr_biphasic(params, data)


tau1 = data.params(1)*params(1);
% tau1 = params(1);
gamma_shape = data.params(2);
% gamma_shape = params(1);
gamma_neg_tauScale = data.params(3);
% gamma_neg_tauScale = params(3);
% tau1 = data.filters(1);
% gamma_shape = data.filters(2);
% gamma_neg_tauScale = data.filters(3);

dt = 1/1440;
t_irf = dt:dt:1;
criterion = params(2);
var = params(3);

irf_pos = gampdf(t_irf, gamma_shape, tau1);
irf_neg = gampdf(t_irf, gamma_shape, tau1*gamma_neg_tauScale);

irf     = irf_pos - irf_neg;
irf     = irf/( sum( abs(irf) ));


stim_sine = data.stim_sine;
% power = data.power;
Cont_list = exp( linspace(log(0.0001), log(1), 1000) );
Cont_list = Cont_list';

maxGivenHzCont = zeros( length(Cont_list), length(stim_sine) );
conThreshFreq = zeros( 1, length(stim_sine) );
m_reciprocal_model = [];
total_reciprocal_model = [];
total_reciprocal = [];

for i = 1:size(stim_sine,2)    
    for ifreq = 1:(length(stim_sine))
        
        stim = stim_sine{ifreq,i};
        conv_sine = conv( stim, irf, 'valid' );
        temp_data = data.data{ifreq + 12*(i - 1)};
        
        if isempty(temp_data)
            exp_cont = [];
            reciprocal = [];
        else
            exp_cont = temp_data(1,:);
            reciprocal = temp_data(2,:);
        end
        linrsp = max(abs(conv_sine));
        Resp = exp_cont.*linrsp;
        Relu_Resp = max(Resp-criterion,0);
        thres_Resp = Cont_list.*linrsp;
        maxGivenHzCont(:,ifreq) = thres_Resp;
        [conThresh] = find( maxGivenHzCont(:,ifreq) > criterion + norminv(0.75)*var, 1, 'first' );
        if isempty(conThresh) 
            conThresh = 1000;
        end
    
        conThreshFreq(ifreq) = Cont_list(conThresh);

        reciprocal_model = 1-normcdf(0,Relu_Resp,var);
        total_reciprocal_model = [total_reciprocal_model reciprocal_model];
        total_reciprocal = [total_reciprocal reciprocal];              
    end
    m_reciprocal_model = cat(2,m_reciprocal_model, conThreshFreq);
end

total_reciprocal_model( total_reciprocal_model == 1 ) = 1-eps;

total_reciprocal_model( total_reciprocal == 0 ) = 1 - total_reciprocal_model( total_reciprocal == 0 );
    
   
log_likeli = -sum( log( total_reciprocal_model ));

end
