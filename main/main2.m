%%
clear
close all
clc

set(0,'DefaultAxesFontName','Arial');

fs_label = 20;
fs_tick_small = 15;
fs_tick_medium = 18;
fs_legend = 15;
fs_title = 22; 

%% Plotting for all Results

% Draw the result at Experiment 1 & 2
Color_Darkgray = [25 25 25]/255;
Color_Gray = [100 100 100]/255;

Color_Yellow = [245 213 71]/255; %% yellow
Color_Orange = [237 125 49]/255; %% orange

Color_Navy = [20 70 160]/255; %% navy
Color_SkyBlue = [90 180 220]/255; %% sky blue

color_yb = [44, 102, 107; 101, 173, 178; 215, 149, 79; 236, 186, 101; 240, 214, 98]/255;
Hz2s= [120 144 160 180 240 288];

%% Make Stimulus
L0 = 100;
dt = 1/1440;
[data1, data3, data4] = MakeStimulus(L0, dt);

bi_LB = [0.001 0 0];
bi_UB1 = [2 1 4];
bi_UB2 = [6 0.1 5];
gau_LB = [1 0 0];
gau_UB1 = [60 1 4];
gau_UB2 = [60 0.1 5];

% for param_idx = 1:3
%     if param_idx >= 4
%        bi_test(param_idx,:) = linspace(bi_LB(param_idx),bi_UB(param_idx),20);
%     else
%         bi_test(param_idx,:) = linspace(bi_LB(param_idx),bi_UB(param_idx),100);
%         gau_test(param_idx,:) = linspace(gau_LB(param_idx),gau_UB(param_idx),100); 
%     end
% end

bi_test_color = linspace(bi_LB(1),bi_UB2(1),50);
bi_test_lum = linspace(bi_LB(1),bi_UB1(1),50);
gau_test_color = linspace(gau_LB(1),gau_UB2(1),50); 
gau_test_lum = linspace(gau_LB(1),gau_UB1(1),50); 

%% Fitting the Result: Experiment 1 and 2
load('Exp12.mat')

params0 = [120, 11, 10, 10];
params1 = [0.0027, 15.2459, 1.9814, 10.5 0.2];
options = optimset('MaxIter', 1e+5,'MaxFunEvals', 1e+5);

% bi_LB = [0 10 1 0 0];
% bi_UB = [0.005 20 5 20 20];
% gau_LB = [0 0 0 0 0];
% gau_UB = [400 20 1 1 0.5];

for i = 1:size(conThresExp0,1)
    temp_total_reciprocal = [conThresExp0(i,:) conThresExp2(i,:)];
    data1.params = params1(1:3);
    data1.total_reciprocal = temp_total_reciprocal;
    data1.data = [data_Exp1(1:12,i); data_Exp2(1:12,i)];
    for l = 1:length(gau_test_lum)
        bi_test_temp = [bi_test_lum(l) 0.5 0.1];
        gau_test_temp = [gau_test_lum(l) 0.5 0.1];

        best_params_gau1_temp(l,:) = fminsearchbnd( @(params) work_vrr_moving_average(params, data1), gau_test_temp,gau_LB,gau_UB1, options);
        mse0_gau_temp(l) = work_vrr_moving_average(best_params_gau1_temp(l,:), data1);
        
        best_params_bi1_temp(l,:) = fminsearchbnd( @(params) work_vrr_biphasic(params,data1), bi_test_temp, bi_LB, bi_UB1, options);
        mse0_bi_temp(l) = work_vrr_biphasic(best_params_bi1_temp(l,:), data1);
    end
    
    lowest_idx_gau = find(mse0_gau_temp == min(mse0_gau_temp),1,'first');
    best_params_gau1(i,:) = best_params_gau1_temp(lowest_idx_gau,:);
    [mse0_gau(i), conThresh_Moving0(i,:), gau_irf1{i}] = work_vrr_moving_average(best_params_gau1(i,:), data1);

    lowest_idx_bi = find(mse0_bi_temp == min(mse0_bi_temp),1,'first');
    best_params_bi1(i,:) = best_params_bi1_temp(lowest_idx_bi,:);
    [mse0_bi(i), conThresh_UNIST0(i,:), bi_irf1(i,:)] = work_vrr_biphasic(best_params_bi1(i,:), data1);

end

conThresh_Moving1 = conThresh_Moving0(:,1:12);
conThresh_Moving2 = conThresh_Moving0(:,13:24);
conThresh_UNIST1 = conThresh_UNIST0(:,1:12);
conThresh_UNIST2 = conThresh_UNIST0(:,13:24);


%% Fitting the Results: Experiment 3

load('Exp3.mat')
sub = 1:11;
thres_Exp3 = thres_Exp3(sub,:);

for i = 1:11
    data3.params = params1(1:3);
    data3.total_reciprocal = thres_Exp3(i,:);    
    data3.data = data_Exp3(i,:)';

    for l = 1:length(gau_test_lum)
        bi_test_temp = [bi_test_lum(l) 0.5 0.1];
        gau_test_temp = [gau_test_lum(l) 0.5 0.1];

        best_params_gau2_temp(l,:) = fminsearchbnd( @(params) work_vrr_moving_average(params, data3),gau_test_temp,gau_LB,gau_UB1, options);
        mse2_gau_temp(l) = work_vrr_moving_average(best_params_gau2_temp(l,:), data3);
        
        best_params_bi2_temp(l,:) = fminsearchbnd( @(params) work_vrr_biphasic(params,data3), bi_test_temp, bi_LB, bi_UB1, options);
        mse2_bi_temp(l) = work_vrr_biphasic(best_params_bi2_temp(l,:), data3);
    end
    lowest_idx_gau = find(mse2_gau_temp == min(mse2_gau_temp),1,'first');
    best_params_gau2(i,:) = best_params_gau2_temp(lowest_idx_gau,:);
    [mse2_gau(i), conThresh_Moving3(i,:), gau_irf2{i}] = work_vrr_moving_average(best_params_gau2(i,:), data3);
    lowest_idx_bi = find(mse2_bi_temp == min(mse2_bi_temp),1,'first');
    best_params_bi2(i,:) = best_params_bi2_temp(lowest_idx_bi,:);
    [mse2_bi(i), conThresh_UNIST3(i,:), bi_irf2(i,:)] = work_vrr_biphasic(best_params_bi2(i,:), data3);

end

conThreshFreq3_gau = mean(conThresh_Moving3);
conThreshFreq3_bi = mean(conThresh_UNIST3);


%% Fitting the results: Experiment 4

load('Exp4.mat')
% subs = [1:6 8:11];
% thres_Exp4 = thres_Exp4(subs,:);
% data_Exp4 = data_Exp4(subs,:);

for i = 1:size(thres_Exp4,1)
    data4.params = params1(1:3);    
    data4.total_reciprocal = thres_Exp4(i,:);    
    data4.data = data_Exp4(i,:)';

    for l = 1:length(gau_test_color)
        bi_test_temp = [bi_test_color(l) 0.05 1];
        gau_test_temp = [gau_test_color(l) 0.05 1];

        best_params_gau3_temp(l,:) = fminsearchbnd( @(params) work_vrr_moving_average(params, data4),gau_test_temp,gau_LB,gau_UB2, options);
        mse3_gau_temp(l)= work_vrr_moving_average(best_params_gau3_temp(l,:), data4);
        
        best_params_bi3_temp(l,:) = fminsearchbnd( @(params) work_vrr_biphasic(params,data4), bi_test_temp, bi_LB, bi_UB2, options);
        mse3_bi_temp(l) = work_vrr_biphasic(best_params_bi3_temp(l,:), data4);
    end
    lowest_idx_gau = find(mse3_gau_temp == min(mse3_gau_temp),1,'first');
    best_params_gau3(i,:) = best_params_gau3_temp(lowest_idx_gau,:);
    [mse3_gau(i), conThresh_Moving4(i,:), gau_irf3{i}] = work_vrr_moving_average(best_params_gau3(i,:), data4);

    lowest_idx_bi = find(mse3_bi_temp == min(mse3_bi_temp),1,'first');
    best_params_bi3(i,:) = best_params_bi3_temp(lowest_idx_bi,:);
    [mse3_bi(i), conThresh_UNIST4(i,:), bi_irf3(i,:)] = work_vrr_biphasic(best_params_bi3(i,:), data4);

end

conThreshFreq4_gau = mean(conThresh_Moving4);
conThreshFreq4_bi = mean(conThresh_UNIST4);

%% Plotting

figure('Color',[1 1 1])
% Experiment 1 (72Hz)
% Observation
plot(Hz2s/2,conThresExp0(:,1:6)','Color', Color_Gray*1.5,'LineStyle','-.','LineWidth',0.8); hold on
% Errorbar
e1 = errorbar(Hz2s/2,mean(conThresExp0(:,1:6)),std(conThresExp0(:,1:6))./sqrt(6),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
% Mean Point
obs1 = plot(Hz2s/2,mean(conThresExp0(:,1:6)),'Color',Color_Darkgray,'Marker','o','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Darkgray,'MarkerSize',10); hold on

% e1 = errorbar(Hz2s/2,mean(conThresExp0(:,1:6)),std(conThresExp0(:,1:6))./sqrt(6),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
% obs1 = plot(Hz2s/2,mean(conThresExp0(:,1:6)),'Color',Color_Darkgray,'Marker','o','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Darkgray,'MarkerSize',10); hold on

% Estimation - Gaussian
est1_gaus = shadedErrorBar_SC(Hz2s/2,mean(conThresh_Moving1(:,1:6)),std(conThresh_Moving1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est1_bi = shadedErrorBar_SC(Hz2s/2,mean(conThresh_UNIST1(:,1:6)),std(conThresh_UNIST1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on


% Experiment 2 (72 Hz)
% Observation
plot(Hz2s(4:6)/2,conThresExp2(:,4:6)','Color', Color_Gray*1.5,'LineStyle','--','LineWidth',0.8); hold on
% Errorbar
e2 = errorbar(Hz2s(4:6)/2,mean(conThresExp2(:,4:6)),std(conThresExp2(:,4:6))./sqrt(6),'LineWidth',2,'Color',Color_Gray,'LineStyle','none','CapSize',0); hold on
% Mean Point
obs2 = plot(Hz2s(4:6)/2,mean(conThresExp2(:,4:6)),'Color',Color_Gray,'Marker','s','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Gray,'MarkerSize',10); hold on

% e2 = errorbar(Hz2s(4:6)/2,mean(conThresExp2(:,4:6)),std(conThresExp2(:,4:6))./sqrt(6),'LineWidth',2,'Color',Color_Gray,'LineStyle','none','CapSize',0); hold on
% obs2 = plot(Hz2s(4:6)/2,mean(conThresExp2(:,4:6)),'Color',Color_Gray,'Marker','s','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Gray,'MarkerSize',10); hold on

% Estimation - Gaussian
est2_gaus = shadedErrorBar_SC(Hz2s(4:6)/2,mean(conThresh_Moving2(:,4:6)),std(conThresh_Moving2(:,4:6))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est2_bi = shadedErrorBar_SC(Hz2s(4:6)/2,mean(conThresh_UNIST2(:,4:6)),std(conThresh_UNIST2(:,4:6))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on

% legend([p0 pp01 pp00 p1 pp12 pp11],{'Exp 1 Obs.','Exp 1 Pred. (Gau)','Exp 1 Pred. (Bi)','Exp 2 Obs.','Exp 2 Pred. (Gau)','Exp 2 Pred. (Bi)'},'NumColumns',2,'Location','southwest','FontSize',15)
% legend boxoff
ylim([0 1])
xlim([50 150]);
ax = gca;
ax.XTick = Hz2s/2;
ax.XTickLabel = '';
ax.LineWidth = 2;
% ax.TickDir = 'out';
myLabels = { '72', '72', '72', '72', '72','72'; 
    '\downarrow', '\downarrow', '\downarrow', '\downarrow','\downarrow','\downarrow';
    '60', '72', '80','90','120','144'};
for i = 1:length(myLabels)
    text(Hz2s(i)/2, ax.YLim(1), sprintf('%s\n%s\n%s', myLabels{:,i}), ...
        'horizontalalignment', 'center', 'verticalalignment', 'top','Fontsize',fs_tick_small);    
end
set(gca,'FontSize',fs_tick_small,'ytick',0:0.2:1,'LineWidth',1.5)

ax.XLabel.String = sprintf('\n\n%s', 'First epoch \rightarrow Second Epoch (Hz)');
ax.XLabel.FontSize = fs_label;
box off
ylabel('Contrast Threshold','fontsize',fs_label)
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 15, 15], 'PaperUnits', 'centimeters', 'PaperSize', [15, 15]);
% set(0,'DefaultAxesFontName', 'Arial');

print(gcf,'Exp12_72.png','-dpng','-r300')
print(gcf,'Exp12_72.svg','-dsvg','-r300')

figure('Color',[1 1 1])
% Experiment 1 (120 Hz)
% Observation
plot(Hz2s/2,conThresExp0(:,7:12)','Color', Color_Gray*1.5,'LineStyle','-.','LineWidth',0.8); hold on
% Errorbar
e1 = errorbar(Hz2s/2,mean(conThresExp0(:,7:12)),std(conThresExp0(:,7:12))./sqrt(6),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
% Mean Point
obs1 = plot(Hz2s/2,mean(conThresExp0(:,7:12)),'Color',Color_Darkgray,'Marker','o','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Darkgray,'MarkerSize',10); hold on

% e1 = errorbar(Hz2s/2,mean(conThresExp0(:,7:12)),std(conThresExp0(:,7:12))./sqrt(6),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
% obs1 = plot(Hz2s/2,mean(conThresExp0(:,7:12)),'Color',Color_Darkgray,'Marker','o','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Darkgray,'MarkerSize',10); hold on

% Estimation - Gaussian
est1_gaus = shadedErrorBar_SC(Hz2s/2,mean(conThresh_Moving1(:,7:12)),std(conThresh_Moving1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est1_bi = shadedErrorBar_SC(Hz2s/2,mean(conThresh_UNIST1(:,7:12)),std(conThresh_UNIST1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on


% Experiment 2 (120 Hz)
% Observation
plot(Hz2s(1:3)/2,conThresExp2(:,7:9)','Color', Color_Gray*1.5,'LineStyle','--','LineWidth',0.8); hold on
% Errorbar
e2 = errorbar(Hz2s(1:3)/2,mean(conThresExp2(:,7:9)),std(conThresExp2(:,7:9))./sqrt(6),'LineWidth',2,'Color',Color_Gray,'LineStyle','none','CapSize',0); hold on
% Mean Point
obs2 = plot(Hz2s(1:3)/2,mean(conThresExp2(:,7:9)),'Color',Color_Gray,'Marker','s','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Gray,'MarkerSize',10); hold on

% e2 = errorbar(Hz2s(1:3)/2,mean(conThresExp2(:,7:9)),std(conThresExp2(:,7:9))./sqrt(6),'LineWidth',2,'Color',Color_Gray,'LineStyle','none','CapSize',0); hold on
% obs2 = plot(Hz2s(1:3)/2,mean(conThresExp2(:,7:9)),'Color',Color_Gray,'Marker','s','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Gray,'MarkerSize',10); hold on

% Estimation - Gaussian
est2_gaus = shadedErrorBar_SC(Hz2s(1:3)/2,mean(conThresh_Moving2(:,7:9)),std(conThresh_Moving2(:,7:9))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est2_bi = shadedErrorBar_SC(Hz2s(1:3)/2,mean(conThresh_UNIST2(:,7:9)),std(conThresh_UNIST2(:,7:9))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on

legend([obs1, est1_gaus.mainLine, est1_bi.mainLine, obs2, est2_gaus.mainLine, est2_bi.mainLine],{'Exp1 Obs','Exp1 Pred (Gaussian)', 'Exp1 Pred (Bi-phasic)','Exp2 Obs', 'Exp2 Pred (Gaussian)','Exp2 Pred (Bi-phasic)'},'NumColumns',1,'Location','southeast','FontSize',fs_legend)
legend boxoff
ylim([0 1])
xlim([50 150]);
ax = gca;
ax.XTick = Hz2s/2;
ax.XTickLabel = '';
myLabels = { '120', '120', '120', '120', '120','120'; 
    '\downarrow', '\downarrow', '\downarrow', '\downarrow','\downarrow','\downarrow';
    '60', '72', '80','90','120','144'};
for i = 1:length(myLabels)
    text(Hz2s(i)/2, ax.YLim(1), sprintf('%s\n%s\n%s', myLabels{:,i}), ...
        'horizontalalignment', 'center', 'verticalalignment', 'top','Fontsize',fs_tick_small);    
end
set(gca,'FontSize',fs_tick_small,'ytick',0:0.2:1,'LineWidth',1.5)

ax.XLabel.String = sprintf('\n\n%s', 'First epoch \rightarrow Second Epoch (Hz)');
ax.XLabel.FontSize = fs_label;
box off
% ylabel('Contrast Sensitivity')
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 15, 15], 'PaperUnits', 'centimeters', 'PaperSize', [15, 15]);

print(gcf,'VRR120_comp_filter.png','-dpng','-r300')
print(gcf,'VRR120_comp_filter.svg','-dsvg','-r300')

% Draw the Experiment 3

index = [0 1 2 3 4 5 6 7 8 9 10 11 12 13];
Color3_trans = [170 170 170]/255;

figure('Color',[1 1 1])
plot(index, thres_Exp3,'Color',Color3_trans,'LineWidth',0.8,'LineStyle','--'); hold on;
% plot(idx(1:7),intermix_thres','Color', Color1,'LineStyle','none','Marker','o','MarkerFaceColor',Color1, 'MarkerSize',3); hold on
errorbar(index,mean(thres_Exp3), std(thres_Exp3)./sqrt(10),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
pp2 = plot(index, mean(thres_Exp3),'Color',Color_Darkgray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6);
% plot(idx(8:14),intermix_thres2','Color', Color1,'LineStyle','none','Marker','o','MarkerFaceColor',Color1, 'MarkerSize',3); hold on
ests = shadedErrorBar_SC(index,mean(conThresh_Moving3),std(conThresh_Moving3)/sqrt(10),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
estss = shadedErrorBar_SC(index,mean(conThresh_UNIST3),std(conThresh_UNIST3)/sqrt(10),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on
% pp0 = plot(idx,conThreshFreq22,'Color',Color_Navy,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Navy,'MarkerSize',6); hold on
% pp1 = plot(idx,conThreshFreq1,'Color',Color_Orange,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Orange,'MarkerSize',6); hold on
ylim([0 1])
xticks(index);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'fontsize',13)
xlim([0 14]);
set(gca,'FontSize',fs_tick_small,'ytick',0:0.2:1,'LineWidth',1.5)
legend([pp2 ests.mainLine estss.mainLine],{'Exp3 Obs','Exp3 Pred (Gaussian)','Exp3 Pred (Bi-phasic)'},'Location','southeast','FontSize',fs_legend)
legend box off
% box off
% ylabel('Contrast Threshold','fontsize',fs_label);
% xlabel([{'Length of ''in-between'' frequency'}; {'epochs (frame/epoch)'}],'fontsize',fs_label);
% set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 18.5, 10], 'PaperUnits', 'centimeters', 'PaperSize', [18.5, 10]);

ylabel('Contrast Threshold','fontsize',fs_label);
xlabel('Length of ''in between'' frequency epochs (frame/epoch)','fontsize',fs_label)
% title('72 \rightarrow 144 Hz with Frequency Modulation')
box off
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 20, 10], 'PaperUnits', 'centimeters', 'PaperSize', [20, 10]);
% set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 25, 15], 'PaperUnits', 'centimeters', 'PaperSize', [25, 15]);
print(gcf,'Exp3_all.png','-dpng','-r300')
print(gcf,'Exp3_all.svg','-dsvg','-r300')

% Draw the Experiment 4
index = 0:8;
figure('Color',[1 1 1])
% plot(index,threshold','Color', Color1,'LineStyle','none','Marker','o','MarkerFaceColor',Color1, 'MarkerSize',3); hold on
plot(index, thres_Exp4','Color',Color3_trans,'LineWidth',0.8,'LineStyle','--'); hold on;
errorbar(index,mean(thres_Exp4), std(thres_Exp4)./sqrt(size(thres_Exp4,1)-1),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
pp2 = plot(index, mean(thres_Exp4),'Color',Color_Darkgray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6); hold on;

pp0 = shadedErrorBar_SC(index,mean(conThresh_Moving4),std(conThresh_Moving4)/sqrt(size(thres_Exp4,1)-1),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
pp1 = shadedErrorBar_SC(index,mean(conThresh_UNIST4),std(conThresh_UNIST4)/sqrt(size(thres_Exp4,1)-1),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on

% pp1 = plot(index,conThreshFreq4,'Color',Color_Orange,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Orange,'MarkerSize',6); hold on
% pp0 = plot(index,conThreshFreq44,'Color',Color_Navy,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Navy,'MarkerSize',6); hold on

box off
ylim([0 1])
xticks(index);
xlim([0 9]);
% ylabel('Contrast Threshold')
set(gca,'FontSize',fs_tick_small,'ytick',0:0.2:1,'LineWidth',1.5)

legend([pp2 pp0.mainLine pp1.mainLine],{'Exp4 Obs','Exp4 Pred (Gaussian)','Exp4 Pred (Bi-phasic)'},'Location','southeast','FontSize',fs_legend)
legend box off
% ylabel('Contrast Threshold','fontsize',fs_label);
% xlabel([{'Length of ''in-between'' frequency'}; {'epochs (frame/epoch)'}],'fontsize',fs_label);
% set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 18.5, 10], 'PaperUnits', 'centimeters', 'PaperSize', [18.5, 10]);


xlabel('Length of ''in between'' frequency epochs (frame/epoch)','fontsize',fs_label)
ylabel('Contrast Threshold','fontsize',fs_label)
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 20, 10], 'PaperUnits', 'centimeters', 'PaperSize', [20, 10]);

print(gcf,'Exp4_all.png','-dpng','-r300')
print(gcf,'Exp4_all.svg','-dsvg','-r300')

%% Consistency (AIC)
% Experiment 1 & 2
AIC_MA0 = 2 * mse0_gau + 6;
AIC_BI0 = 2 * mse0_bi + 6;
AIC_Diff0 = AIC_MA0 - AIC_BI0;
[AIC_Diff_sort0,I0] = sort(AIC_Diff0);

figure('Color',[1 1 1])
stem(1:3, AIC_Diff_sort0(1:3), 'Color',Color_Yellow,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
stem(4:7, AIC_Diff_sort0(4:7), 'Color',Color_SkyBlue,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
set(gca,'FontSize',fs_tick_small,'LineWidth',1.5); box off;
ylabel([{'AIC Difference'}; {'(Gaussian - Bi-phaisc)'}],'fontsize',fs_label)
xlabel('Subject ID','fontsize',fs_label)
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 10, 10], 'PaperUnits', 'centimeters', 'PaperSize', [10, 10]);
set(gca,'FontSize',20,'LineWidth',1.5)
set(gca,'box','off')
print(gcf,'AIC_Exp12.png','-dpng','-r300')
print(gcf,'AIC_Exp12.svg','-dsvg','-r300')

% Experiment 3
AIC_MA = 2 * mse2_gau + 6;
AIC_BI = 2 * mse2_bi + 6;
AIC_Diff = AIC_MA - AIC_BI;
[AIC_Diff_sort,I1] = sort(AIC_Diff);

figure('Color',[1 1 1])
stem(1:3, AIC_Diff_sort(1:3), 'Color',Color_Yellow,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
stem(4:11, AIC_Diff_sort(4:11), 'Color',Color_SkyBlue,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
ylabel([{'AIC Difference'}; {'(Gaussian - Bi-phaisc)'}],'fontsize',fs_label)
xlabel('Subject ID')
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 10, 10], 'PaperUnits', 'centimeters', 'PaperSize', [10, 10]);
set(gca,'FontSize',20,'LineWidth',1.5)
set(gca,'box','off')
print(gcf,'AIC_Exp3.png','-dpng','-r300')
print(gcf,'AIC_Exp3.svg','-dsvg','-r300')

% Experiment 4
AIC_MA2 = 2 * mse3_gau + 6;
AIC_BI2 = 2 * mse3_bi + 6;
AIC_Diff2 = AIC_MA2 - AIC_BI2;
[AIC_Diff_sort2,I2] = sort(AIC_Diff2);

figure('Color',[1 1 1])
stem(1:9, AIC_Diff_sort2(1:9), 'Color',Color_Yellow,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
stem(10:11, AIC_Diff_sort2(10:11), 'Color',Color_SkyBlue,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
xlim([0 12]);
xticks([0 5 10]);
ylabel([{'AIC Difference'}; {'(Gaussian - Bi-phaisc)'}],'fontsize',fs_label)
xlabel('Subject ID')
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 10, 10], 'PaperUnits', 'centimeters', 'PaperSize', [10, 10]);
% title('')
set(gca,'FontSize',20,'LineWidth',1.5)
set(gca,'box','off')
print(gcf,'AIC_Exp4.png','-dpng','-r300')
print(gcf,'AIC_Exp4.svg','-dsvg','-r300')


% Statistics Test
[h12, pv12, ci12, stat12] = ttest(AIC_Diff0,0)
[h3, pv3, ci3, stat3] = ttest(AIC_Diff,0)
[h4, pv4, ci4, stat4] = ttest(AIC_Diff2,0)

AIC_all0 = [AIC_MA0' AIC_BI0'];
sort_AIC_all0 = AIC_all0(I0,:);

AIC_all1 = [AIC_MA' AIC_BI'];
sort_AIC_all1 = AIC_all1(I1,:);

AIC_all2 = [AIC_MA2' AIC_BI2'];
sort_AIC_all2 = AIC_all2(I2,:);

%% See the details in Prediction
% Experiment 1,2

figure('Color',[1 1 1])
for i = 1:7
    subplot(4,4,2*i-1)
    plot(Hz2s/2,conThresExp0(i,1:6),'Color',Color_Darkgray,'Marker','s','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6); hold on
    plot(Hz2s/2,conThresh_Moving1(i,1:6),'Color',Color_Yellow,'LineWidth',3,'MarkerFaceColor',Color_Yellow); hold on
    plot(Hz2s/2,conThresh_UNIST1(i,1:6),'Color',Color_SkyBlue,'LineWidth',3,'MarkerFaceColor',Color_SkyBlue); hold on

    plot(Hz2s(4:6)/2,conThresExp2(i,4:6),'Color',Color_Gray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Gray,'MarkerSize',6); hold on
    plot(Hz2s(4:6)/2,conThresh_Moving2(i,4:6),'Color',Color_Yellow,'LineWidth',3,'MarkerFaceColor',Color_Yellow); hold on
    plot(Hz2s(4:6)/2,conThresh_UNIST2(i,4:6),'Color',Color_SkyBlue,'LineWidth',3,'MarkerFaceColor',Color_SkyBlue); hold on

    ylim([0 1])
    xlim([50 150]);
    xticks([]);
    box off
    set(gca,'FontSize',15,'LineWidth',1.5)
    if mod(i,2) == 1
        ylabel('Contrast threshold')
    end
    if i == 7
        ax = gca;
        ax.XTick = Hz2s/2;
        ax.XTickLabel = '';
        myLabels = { '72', '72', '72', '72', '72','72'; 
            '\downarrow', '\downarrow', '\downarrow', '\downarrow','\downarrow','\downarrow';
            '60', '72', '80','90','120','144'};
        for idx = 1:length(myLabels)
            text(Hz2s(idx)/2, ax.YLim(1), sprintf('%s\n%s\n%s', myLabels{:,idx}), ...
                'horizontalalignment', 'center', 'verticalalignment', 'top','Fontsize',10);    
        end
        ax.XLabel.String = sprintf('\n\n%s', 'First epoch \rightarrow Second Epoch (Hz)');
%         box off
        % legend([exp1_obs, exp1_estGaus, exp1_estBi, exp2_obs, exp2_estGaus, exp2_estBi],{'Exp1 Obs','Exp1 Pred(G)','Exp1 Pred(Bi)','Exp2 Obs','Exp2 Pred(G)','Exp2 Pred(Bi)'},'Location','southeast','FontSize',8, 'location','best')
        % legend box off
    end

    subplot(4,4,2*i)
    exp1_obs = plot(Hz2s(1:3)/2,conThresExp2(i,7:9),'Color',Color_Gray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Gray,'MarkerSize',6); hold on
    exp2_obs = plot(Hz2s/2,conThresExp0(i,7:12),'Color',Color_Darkgray,'Marker','s','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6); hold on
    exp1_estGaus =plot(Hz2s/2,conThresh_Moving1(i,7:12),'Color',Color_Yellow,'LineWidth',3,'MarkerFaceColor',Color_Yellow); hold on
    exp2_estGaus = plot(Hz2s(1:3)/2,conThresh_Moving2(i,7:9),'Color',Color_Yellow,'LineWidth',3,'MarkerFaceColor',Color_Yellow); hold on
    exp1_estBi = plot(Hz2s/2,conThresh_UNIST1(i,7:12),'Color',Color_SkyBlue,'LineWidth',3,'MarkerFaceColor',Color_SkyBlue); hold on
    exp2_estBi = plot(Hz2s(1:3)/2,conThresh_UNIST2(i,7:9),'Color',Color_SkyBlue,'LineWidth',3,'MarkerFaceColor',Color_SkyBlue); hold on
    ylim([0 1])
    xlim([50 150]);
    xticks([]);
    box off
    set(gca,'FontSize',15,'LineWidth',1.5)
    if i == 7
        ax = gca;
        ax.XTick = Hz2s/2;
        ax.XTickLabel = '';
        myLabels = { '120', '120', '120', '120', '120','120'; 
            '\downarrow', '\downarrow', '\downarrow', '\downarrow','\downarrow','\downarrow';
            '60', '72', '80','90','120','144'};
        for idx = 1:length(myLabels)
            text(Hz2s(idx)/2, ax.YLim(1), sprintf('%s\n%s\n%s', myLabels{:,idx}), ...
                'horizontalalignment', 'center', 'verticalalignment', 'top','Fontsize',10);    
        end
%         ax.XLabel.String = sprintf('\n\n%s', 'First epoch \rightarrow Second Epoch (Hz)');
% xlable('\n\n%s', 'First epoch \rightarrow Second Epoch (Hz)','fontsize',5)
        legend([exp1_obs, exp1_estGaus, exp1_estBi, exp2_obs, exp2_estGaus, exp2_estBi],{'Exp1 Obs','Exp1 Pred(G)','Exp1 Pred(Bi)','Exp2 Obs','Exp2 Pred(G)','Exp2 Pred(Bi)'},'Location','southeast','FontSize',8)
        legend box off
    end
 end
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 40, 50], 'PaperUnits', 'centimeters', 'PaperSize', [40, 50]);
set(0,'DefaultAxesFontName', 'Arial');
print(gcf,'Subject_Exp12.png','-dpng','-r300')



% Experiment 3
figure('Color',[1 1 1])
% AIC_Diff_origin = AIC_MA - AIC_BI;
% [~, Diff_I] = sortrows(AIC_MA - AIC_BI);
idx = 0:13;
for i = 1:11
    subplot(3,4,i)
    sort_i = I1(12-i);
    plot(idx, thres_Exp3(sort_i,:),'Color',Color_Darkgray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6); hold on
    plot(idx,conThresh_Moving3(sort_i,:),'Color',Color_Yellow,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Yellow,'MarkerSize',6); hold on
    plot(idx,conThresh_UNIST3(sort_i,:),'Color',Color_SkyBlue,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_SkyBlue,'MarkerSize',6); hold on
    ylim([0 1])
    xlim([0 14]);
    xticks(idx);
    if mod(i,4) == 1
        ylabel('Contrast Threshold')
    end
    % title('72 \rightarrow 144 Hz with Frequency Modulation')
    box off
    set(gca,'FontSize',15,'LineWidth',1.5)
end
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 40, 30], 'PaperUnits', 'centimeters', 'PaperSize', [40, 30]);
print(gcf,'Subject_Exp3.png','-dpng','-r300')


% Experiment 4
figure('Color',[1 1 1])
% AIC_Diff_origin = AIC_MA - AIC_BI;
% [~, Diff_I] = sortrows(AIC_MA2 - AIC_BI2);

idx = 0:8;
for i = 1:11
    subplot(3,4,i)
    sort_i = I2(i);
    plot(idx, thres_Exp4(sort_i,:),'Color',Color_Darkgray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6); hold on
    plot(idx,conThresh_Moving4(sort_i,:),'Color',Color_Yellow,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Yellow,'MarkerSize',6); hold on
    plot(idx,conThresh_UNIST4(sort_i,:),'Color',Color_SkyBlue,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_SkyBlue,'MarkerSize',6); hold on
    ylim([0 1])
    xlim([0 9]);
    xticks(idx);
    if mod(i,4) == 1
        ylabel('Contrast Threshold')
    end
    % title('72 \rightarrow 144 Hz with Frequency Modulation')
    box off
    set(gca,'FontSize',15,'LineWidth',1.5)
end
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 40, 30], 'PaperUnits', 'centimeters', 'PaperSize', [40, 30]);
print(gcf,'Subject_Exp4.png','-dpng','-r300')


%% Plotting the iRF

% From Burr's Studies
params_burr = [1 5.67 4.99 17.9];
xt = dt:dt:0.5;
burr_irf = params_burr(1).*xt.*sin(2*pi.*(params_burr(2).*xt.*((xt+1).^(-params_burr(3))))).*exp(-xt.*params_burr(4));
burr_irf = burr_irf/sum(abs(burr_irf));

% From our model
mean_bi1 = mean(best_params_bi1);
mean_bi2 = mean(best_params_bi2);
mean_bi3 = mean(best_params_bi3);
mean_gau1 = mean(best_params_gau1);
mean_gau2 = mean(best_params_gau2);
mean_gau3 = mean(best_params_gau3);

% Draw the filters
origin_gau = draw_irf(params0,2);
gau1 = draw_irf(mean_gau1,1);
gau2 = draw_irf(mean_gau2,1);
gau3 = draw_irf(mean_gau3,1);

% Fit the Size
% max_length_gau = length(gau3);
origin_gau = nonzeros(round(origin_gau,5));
gau1 = nonzeros(round(gau1,5));
gau2 = nonzeros(round(gau2,5));
gau3 = nonzeros(round(gau3,5));

x_gau0 = dt:dt:dt*length(origin_gau);
x_gau1 = dt:dt:dt*length(gau1);
x_gau2 = dt:dt:dt*length(gau2);
x_gau3 = dt:dt:dt*length(gau3);

origin_bi = draw_irf([1 1 1],3);
bi1 = draw_irf(mean_bi1,3);
bi2 = draw_irf(mean_bi2,3);
bi3 = draw_irf(mean_bi3,3);

origin_bi = nonzeros(round(origin_bi,5));
bi1 = nonzeros(round(bi1,5));
bi2 = nonzeros(round(bi2,5));
bi3 = nonzeros(round(bi3,5));

x_bi0 = dt:dt:dt*length(origin_bi);
x_bi1 = dt:dt:dt*length(bi1);
x_bi2 = dt:dt:dt*length(bi2);
x_bi3 = dt:dt:dt*length(bi3);

Color1 = [128 58 21]/255;
Color2 =  [68 171 73]/255;
Color3 = [109 59 171]/255;

% Plotting the filters
figure('Color',[1 1 1])
subplot(121)
p1 = plot(xt, burr_irf,'k','LineWidth', 2); hold on
p2 = plot(x_gau1, gau1,'Color', Color1, 'LineWidth', 2); hold on
p3 = plot(x_gau2, gau2,'Color', Color2, 'LineWidth', 2); hold on
p4 = plot(x_gau3, gau3,'Color', Color3, 'LineWidth', 2);
% xlim([0 0.5])
yticks([0]);
ylim([0 max(gau2)*1.2])
legend([p1 p2 p3 p4],{'Burr & Morrone, 1993','Exp 1 + 2', 'Exp 3', 'Exp 4'},'Location','northeast');
legend box off
box off
xlabel('Time (Sec)')
ylabel('Response (AU)')
set(gca,'FontSize',15,'LineWidth',1.5)


% x_bi = dt:dt:1;
subplot(122)
yline(0,'k','LineWidth',2); hold on
p1 = plot(x_bi0,origin_bi,'k','LineWidth', 2); hold on
p2 = plot(x_bi1,bi1,'Color', Color1, 'LineWidth', 2); hold on
p3 = plot(x_bi2, bi2,'Color', Color2, 'LineWidth', 2); hold on
p4 = plot(x_bi3, bi3,'Color', Color3, 'LineWidth', 2); hold on
legend([p1 p2 p3 p4],{'Kelly, 1961, 8500 td', 'Exp 1 + 2', 'Exp 3','Exp 4'});
legend box off
xlim([0 0.5])
yticks([0]);
box off
xlabel('Time (Sec)')
ylabel('Response (AU)')

set(gca,'FontSize',15,'LineWidth',1.5)
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 30, 15], 'PaperUnits', 'centimeters', 'PaperSize', [30, 15]);

print(gcf,'Filter.png','-dpng','-r300')


% Test the difference of filter shape
[fg_h12, fg_pv12, fg_ci12, fg_stat12] = ttest(best_params_gau1(:,1),params0(2))
[fg_h3, fg_pv3, fg_ci3, fg_stat3] = ttest(best_params_gau2(:,1),params0(2))
[fg_h4, fg_pv4, fg_ci4, fg_stat4] = ttest(best_params_gau3(:,1),params0(2))

[fb_h12, fb_pv12, fb_ci12, fb_stat12] = ttest(best_params_bi1(:,1),1)
[fb_h3, fb_pv3, fb_ci3, fb_stat3] = ttest(best_params_bi2(:,1),1)
[fb_h4, fb_pv4, fb_ci4, fb_stat4] = ttest(best_params_bi3(:,1),1)


%%

i = I1(11);
data3.total_reciprocal = thres_Exp3(i,:);    
one_bi_param = best_params_bi2(i,:);
one_gau_param = best_params_gau2(i,:);

frame_idx = 0:13;
[mse(1), conThresh_bi,bi_irf,bi_Resp] = work_vrr_biphasic_Resp(one_bi_param, data3);
[mse(2), conThresh_gau,gau_irf,gau_Resp] = work_vrr_moving_average_Resp(one_gau_param, data3);

frame_idx2 = 3;

figure('Color',[1 1 1])
p0 = plot(frame_idx, thres_Exp3(i,:),'Color',Color_Gray,'LineWidth',3); hold on
p1 = plot(frame_idx,conThresh_bi,'Color',Color_SkyBlue,'LineWidth',3); hold on
p2 = plot(frame_idx,conThresh_gau,'Color',Color_Yellow,'LineWidth',3); hold on
bb = bar(frame_idx2 + 2.5,1,'FaceColor',[120 120 120]/255,'Facealpha',0.2,'BarWidth',4,'EdgeColor','none');
legend([p0 p1 p2],{'Exp 3 (Sub 1)','Bi-phasic','Gaussian'},'fontsize',fs_legend,'Location','southeast','Orientation','vertical','NumColumns',1)
legend box off
xlim([0 13]);
xticks(0:1:13);
% yticks([]);

set(gca,'FontSize',fs_tick_small,'ytick',0:0.2:1,'LineWidth',1.5)
set(gca,'box','off')

xlabel('Length of ''in between'' frequency epochs (frame/epoch)','fontsize',fs_label)
ylabel('Contrast Threshold','fontsize',fs_label)

set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 30, 10], 'PaperUnits', 'centimeters', 'PaperSize', [30, 10]);
print(gcf,'Model_filter_BAU.png','-dpng','-r300')
print(gcf,'Model_filter_BAU.svg','-dsvg','-r300')

figure('Color',[1 1 1])
for i = 1:4
subplot(2,4,i)
% yline(0,'Color','k'); hold on;
plot(abs(gau_Resp{frame_idx2 + 1 + i})/max(abs(gau_Resp{1,1})),'Color',Color_Yellow,'LineWidth',2);
xlim([1300 2800]);
ylim([-0.1 0.5]);
xticks([]);
yticks(0);
set(gca,'FontSize',fs_tick_small,'LineWidth',1.5);
box off;
if i == 1
ylabel('|R(t)|','fontsize',fs_label)
end
title(['Frame/epoch = ',num2str(3+i)],'fontsize',fs_label-3,'fontweight','normal');
end
for i = 1:4
subplot(2,4,4 + i)
% yline(0,'Color','k'); hold on
plot(abs(bi_Resp{frame_idx2 + 1 + i})/max(abs(bi_Resp{1,1})),'Color',Color_SkyBlue,'LineWidth',2);
xlim([250 1500]);
ylim([- 0.1 0.5]);
xticks([]);
yticks(0);
set(gca,'FontSize',fs_tick_small,'LineWidth',1.5)
box off;
if i == 1
ylabel('|R(t)|','fontsize',fs_label)
end
% ylabel('Response')
xlabel('Time (ms)','fontsize',fs_label);

end
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 30, 10], 'PaperUnits', 'centimeters', 'PaperSize', [30, 10]);
print(gcf,'Model_filter_BAU3.png','-dpng','-r300')
print(gcf,'Model_filter_BAU3.svg','-dsvg','-r300')


save('TTP_Model1.mat')


% % Quarantine the Sub 9 & 10 in Experiment 4
% dataq = data4;
% data_Exp_q = data_Exp4(7,:);
% thres_q = thres_Exp4(7,:);
% save('QuarantineResults.mat','dataq','data_Exp_q','thres_q');

function [log_likeli, m_reciprocal_model,moving_fil, Response] = work_vrr_moving_average_Resp(params, data)

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
        Response{ifreq,1} = abs(moving_out);
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

function [log_likeli, m_reciprocal_model, irf, Response] = work_vrr_biphasic_Resp(params, data)


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
        Response{ifreq,1} = abs(conv_sine);
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
% mse = mean(diff);
end

function [mse, m_reciprocal_model,irf,Response] = work_vrr_biphasic_cri(params, data,cri)


tau1 = params(1);
gamma_shape = params(2);
gamma_neg_tauScale = params(3);
% tau1 = data.filters(1);
% gamma_shape = data.filters(2);
% gamma_neg_tauScale = data.filters(3);

dt = 1/1440;
t_irf = dt:dt:0.5;
criterion = cri;

irf_pos = gampdf(t_irf, gamma_shape, tau1);
irf_neg = gampdf(t_irf, gamma_shape, tau1*gamma_neg_tauScale);

irf     = irf_pos - irf_neg;
irf     = irf/( sum( abs(irf) ));

irf = irf/max(irf);

stim_sine = data.stim_sine;
% power = data.power;
Cont_list = exp( linspace(log(0.0001), log(1), 1000) );
Cont_list = Cont_list';

maxGivenHzCont = zeros( length(Cont_list), length(stim_sine) );
conThreshFreq = zeros( 1, length(stim_sine) );
m_reciprocal_model = [];

for i = 1:size(stim_sine,2)    
    for ifreq = 1:(length(stim_sine))
        
        stim = stim_sine{ifreq,i};
        conv_sine = conv( stim, irf, 'valid' );
        
        linrsp = Cont_list.*conv_sine;
        Response{i,ifreq} = linrsp(end,:);
        numrsp = abs( linrsp ) ;
    
        Resp = numrsp;
        
        maxGivenHzCont(:,ifreq) = max( Resp, [], 2 );
        [conThresh] = find( maxGivenHzCont(:,ifreq) > criterion, 1, 'first' );
        if isempty(conThresh) 
            conThresh = 1000;
        end
    
        conThreshFreq(ifreq) = Cont_list(conThresh);
            
    end
    m_reciprocal_model = cat(2,m_reciprocal_model, conThreshFreq);
end
% diff = sqrt(abs(m_reciprocal_model.^2 - data.total_reciprocal.^2));
log_diff = log( m_reciprocal_model) - log( data.total_reciprocal);
mse = log_diff*log_diff';
% mse = mean(diff);
end



