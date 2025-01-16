function [log_likeli, m_reciprocal_model,moving_fil] = work_vrr_moving_average(params, data)


% Moving Average Model (2015)
% t_fil = round(1440*params(3)/1000);
t = 1:round(params(1))*6;
% k = 7.45.*1000/1440;
mu = params(1)*3;
var = params(1);
criterion = params(2);
sigma = params(3);
moving_fil = normpdf(t,mu,var);

stim_sine = data.stim_sine;
Cont_list = exp( linspace(log(0.0001), log(1), 1000) );
Cont_list = Cont_list';

maxGivenHzCont = zeros( length(Cont_list), length(stim_sine) );
conThreshFreq = zeros( 1, length(stim_sine) );
m_reciprocal_model = [];
total_reciprocal_model = [];
total_reciprocal = [];


for i = 1:size(stim_sine,2)

    for ifreq = 1:(length(stim_sine))
        
        stm = stim_sine{ifreq,i};
        temp_data = data.data{ifreq + 12*(i - 1)};
        
        if isempty(temp_data)
            exp_cont = [];
            reciprocal = [];
        else
            exp_cont = temp_data(1,:);
            reciprocal = temp_data(2,:);
        end
        temp_stim = stm;
        moving_out= filter(moving_fil,1,temp_stim);
        
        linrsp = max(abs(moving_out));
        Resp = exp_cont.*linrsp;
        Relu_Resp = max(Resp-criterion,0);        
        thres_Resp = Cont_list.*linrsp;
        maxGivenHzCont(:,ifreq) = thres_Resp;
        [conThresh] = find( maxGivenHzCont(:,ifreq) > criterion + norminv(0.75)*sigma, 1, 'first' );
        if isempty(conThresh) 
            conThresh = 1000;
        end
    
        conThreshFreq(ifreq) = Cont_list(conThresh);

        reciprocal_model = 1-normcdf(0,Relu_Resp,sigma);
        total_reciprocal_model = [total_reciprocal_model reciprocal_model];
        total_reciprocal = [total_reciprocal reciprocal];    
    end
    m_reciprocal_model = cat(2,m_reciprocal_model, conThreshFreq);
        
end

total_reciprocal_model( total_reciprocal_model == 1 ) = 1-eps;

total_reciprocal_model( total_reciprocal == 0 ) = 1 - total_reciprocal_model( total_reciprocal == 0 );
    
   
log_likeli = -sum( log( total_reciprocal_model ));

end
