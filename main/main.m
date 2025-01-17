%%
clear
close all
clc

Hz2s= [120 144 160 180 240 288];

%% Make Stimulus
L0 = 100;
dt = 1/1440;
[data1, data3, data4] = MakeStimulus(L0, dt);

bi_LB = [0.001 0 0];
bi_UB1 = [2 1 4];
bi_UB2 = [5 1 4];
gau_LB = [1 0 0];
gau_UB = [100 2 4];

bi_test_color = linspace(bi_LB(1),bi_UB2(1),50);
bi_test_lum = linspace(bi_LB(1),bi_UB1(1),50);
gau_test = linspace(gau_LB(1),gau_UB(1),50); 

%% Fitting the Result: Experiment 1 and 2
load('Exp12.mat')

params0 = [120, 11, 10, 10]; % parameters for Gaussian filter (Nakajima & Sakaguthi, 2015)
params1 = [0.0027, 15.2459, 1.9814, 10.5 0.2]; % parameters for bi-phasic filter (fitted in TCSF at 8300 td in Kelly, 1961)
options = optimset('MaxIter', 1e+5,'MaxFunEvals', 1e+5);


for i = 1:size(conThresExp0,1)
    temp_total_reciprocal = [conThresExp0(i,:) conThresExp2(i,:)];
    data1.params = params1(1:3);
    data1.total_reciprocal = temp_total_reciprocal;
    data1.data = [data_Exp1(1:12,i); data_Exp2(1:12,i)];
    for l = 1:length(gau_test)
        bi_test_temp = [bi_test_lum(l) 0.5 0.1];
        gau_test_temp = [gau_test(l) 0.5 0.1];

        best_params_gau1_temp(l,:) = fminsearchbnd( @(params) work_vrr_gaussian(params, data1), gau_test_temp,gau_LB,gau_UB, options);
        mse0_gau_temp(l) = work_vrr_gaussian(best_params_gau1_temp(l,:), data1);
        
        best_params_bi1_temp(l,:) = fminsearchbnd( @(params) work_vrr_biphasic(params,data1), bi_test_temp, bi_LB, bi_UB1, options);
        mse0_bi_temp(l) = work_vrr_biphasic(best_params_bi1_temp(l,:), data1);
    end
    
    lowest_idx_gau = find(mse0_gau_temp == min(mse0_gau_temp),1,'first');
    best_params_gau1(i,:) = best_params_gau1_temp(lowest_idx_gau,:);
    [mse0_gau(i), conThresh_gaussian0(i,:), gau_irf1{i}] = work_vrr_gaussian(best_params_gau1(i,:), data1);

    lowest_idx_bi = find(mse0_bi_temp == min(mse0_bi_temp),1,'first');
    best_params_bi1(i,:) = best_params_bi1_temp(lowest_idx_bi,:);
    [mse0_bi(i), conThresh_biphasic0(i,:), bi_irf1(i,:)] = work_vrr_biphasic(best_params_bi1(i,:), data1);

end

conThresh_gaussian1 = conThresh_gaussian0(:,1:12);
conThresh_gaussian2 = conThresh_gaussian0(:,13:24);
conThresh_biphasic1 = conThresh_biphasic0(:,1:12);
conThresh_biphasic2 = conThresh_biphasic0(:,13:24);


%% Fitting the Results: Experiment 3

load('Exp3.mat')

for i = 1:11
    data3.params = params1(1:3);
    data3.total_reciprocal = thres_Exp3(i,:);    
    data3.data = data_Exp3(i,:)';

    for l = 1:length(gau_test)
        bi_test_temp = [bi_test_lum(l) 0.5 0.1];
        gau_test_temp = [gau_test(l) 0.5 0.1];

        best_params_gau2_temp(l,:) = fminsearchbnd( @(params) work_vrr_gaussian(params, data3),gau_test_temp,gau_LB,gau_UB, options);
        mse2_gau_temp(l) = work_vrr_gaussian(best_params_gau2_temp(l,:), data3);
        
        best_params_bi2_temp(l,:) = fminsearchbnd( @(params) work_vrr_biphasic(params,data3), bi_test_temp, bi_LB, bi_UB1, options);
        mse2_bi_temp(l) = work_vrr_biphasic(best_params_bi2_temp(l,:), data3);
    end
    lowest_idx_gau = find(mse2_gau_temp == min(mse2_gau_temp),1,'first');
    best_params_gau2(i,:) = best_params_gau2_temp(lowest_idx_gau,:);
    [mse2_gau(i), conThresh_gaussian3(i,:), gau_irf2{i}] = work_vrr_gaussian(best_params_gau2(i,:), data3);
    lowest_idx_bi = find(mse2_bi_temp == min(mse2_bi_temp),1,'first');
    best_params_bi2(i,:) = best_params_bi2_temp(lowest_idx_bi,:);
    [mse2_bi(i), conThresh_biphasic3(i,:), bi_irf2(i,:)] = work_vrr_biphasic(best_params_bi2(i,:), data3);

end

conThreshFreq3_gau = mean(conThresh_gaussian3);
conThreshFreq3_bi = mean(conThresh_biphasic3);


%% Fitting the results: Experiment 4

load('Exp4.mat')
% subs = [1:6 8:11];
% thres_Exp4 = thres_Exp4(subs,:);
% data_Exp4 = data_Exp4(subs,:);

for i = 1:size(thres_Exp4,1)
    data4.params = params1(1:3);    
    data4.total_reciprocal = thres_Exp4(i,:);    
    data4.data = data_Exp4(i,:)';

    for l = 1:length(gau_test)
        bi_test_temp = [bi_test_color(l) 0.5 0.1];
        gau_test_temp = [gau_test(l) 0.5 0.1];

        best_params_gau3_temp(l,:) = fminsearchbnd( @(params) work_vrr_gaussian(params, data4),gau_test_temp,gau_LB,gau_UB, options);
        mse3_gau_temp(l)= work_vrr_gaussian(best_params_gau3_temp(l,:), data4);
        
        best_params_bi3_temp(l,:) = fminsearchbnd( @(params) work_vrr_biphasic(params,data4), bi_test_temp, bi_LB, bi_UB2, options);
        mse3_bi_temp(l) = work_vrr_biphasic(best_params_bi3_temp(l,:), data4);
    end
    lowest_idx_gau = find(mse3_gau_temp == min(mse3_gau_temp),1,'first');
    best_params_gau3(i,:) = best_params_gau3_temp(lowest_idx_gau,:);
    [mse3_gau(i), conThresh_gaussian4(i,:), gau_irf3{i}] = work_vrr_gaussian(best_params_gau3(i,:), data4);

    lowest_idx_bi = find(mse3_bi_temp == min(mse3_bi_temp),1,'first');
    best_params_bi3(i,:) = best_params_bi3_temp(lowest_idx_bi,:);
    [mse3_bi(i), conThresh_biphasic4(i,:), bi_irf3(i,:)] = work_vrr_biphasic(best_params_bi3(i,:), data4);

end

conThreshFreq4_gau = mean(conThresh_gaussian4);
conThreshFreq4_bi = mean(conThresh_biphasic4);
