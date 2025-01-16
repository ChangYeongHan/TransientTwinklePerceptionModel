%% Plotting
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


figure('Color',[1 1 1])
% Experiment 1 (72Hz)
% Observation
plot(Hz2s/2,conThresExp0(:,1:6)','Color', Color_Gray*1.5,'LineStyle','-.','LineWidth',0.8); hold on
% Errorbar
e1 = errorbar(Hz2s/2,mean(conThresExp0(:,1:6)),std(conThresExp0(:,1:6))./sqrt(6),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
% Mean Point
obs1 = plot(Hz2s/2,mean(conThresExp0(:,1:6)),'Color',Color_Darkgray,'Marker','o','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Darkgray,'MarkerSize',10); hold on
% Estimation - Gaussian
est1_gaus = shadedErrorbar_edited(Hz2s/2,mean(conThresh_Moving1(:,1:6)),std(conThresh_Moving1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est1_bi = shadedErrorbar_edited(Hz2s/2,mean(conThresh_UNIST1(:,1:6)),std(conThresh_UNIST1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on


% Experiment 2 (72 Hz)
% Observation
plot(Hz2s(4:6)/2,conThresExp2(:,4:6)','Color', Color_Gray*1.5,'LineStyle','--','LineWidth',0.8); hold on
% Errorbar
e2 = errorbar(Hz2s(4:6)/2,mean(conThresExp2(:,4:6)),std(conThresExp2(:,4:6))./sqrt(6),'LineWidth',2,'Color',Color_Gray,'LineStyle','none','CapSize',0); hold on
% Mean Point
obs2 = plot(Hz2s(4:6)/2,mean(conThresExp2(:,4:6)),'Color',Color_Gray,'Marker','s','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Gray,'MarkerSize',10); hold on
% Estimation - Gaussian
est2_gaus = shadedErrorbar_edited(Hz2s(4:6)/2,mean(conThresh_Moving2(:,4:6)),std(conThresh_Moving2(:,4:6))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est2_bi = shadedErrorbar_edited(Hz2s(4:6)/2,mean(conThresh_UNIST2(:,4:6)),std(conThresh_UNIST2(:,4:6))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on
ylim([0 1])
xlim([50 150]);
ax = gca;
ax.XTick = Hz2s/2;
ax.XTickLabel = '';
ax.LineWidth = 2;
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
% Estimation - Gaussian
est1_gaus = shadedErrorbar_edited(Hz2s/2,mean(conThresh_Moving1(:,7:12)),std(conThresh_Moving1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est1_bi = shadedErrorbar_edited(Hz2s/2,mean(conThresh_UNIST1(:,7:12)),std(conThresh_UNIST1(:,1:6))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on

% Experiment 2 (120 Hz)
% Observation
plot(Hz2s(1:3)/2,conThresExp2(:,7:9)','Color', Color_Gray*1.5,'LineStyle','--','LineWidth',0.8); hold on
% Errorbar
e2 = errorbar(Hz2s(1:3)/2,mean(conThresExp2(:,7:9)),std(conThresExp2(:,7:9))./sqrt(6),'LineWidth',2,'Color',Color_Gray,'LineStyle','none','CapSize',0); hold on
% Mean Point
obs2 = plot(Hz2s(1:3)/2,mean(conThresExp2(:,7:9)),'Color',Color_Gray,'Marker','s','LineWidth',2,'markeredgecolor','none','MarkerFaceColor',Color_Gray,'MarkerSize',10); hold on

% Estimation - Gaussian
est2_gaus = shadedErrorbar_edited(Hz2s(1:3)/2,mean(conThresh_Moving2(:,7:9)),std(conThresh_Moving2(:,7:9))/sqrt(6),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
% Estimation - Biphasic
est2_bi = shadedErrorbar_edited(Hz2s(1:3)/2,mean(conThresh_UNIST2(:,7:9)),std(conThresh_UNIST2(:,7:9))/sqrt(6),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on

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
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 15, 15], 'PaperUnits', 'centimeters', 'PaperSize', [15, 15]);

print(gcf,'VRR120_comp_filter.png','-dpng','-r300')
print(gcf,'VRR120_comp_filter.svg','-dsvg','-r300')

% Draw the Experiment 3

index = [0 1 2 3 4 5 6 7 8 9 10 11 12 13];
Color3_trans = [170 170 170]/255;
figure('Color',[1 1 1])
plot(index, thres_Exp3,'Color',Color3_trans,'LineWidth',0.8,'LineStyle','--'); hold on;
errorbar(index,mean(thres_Exp3), std(thres_Exp3)./sqrt(10),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
pp2 = plot(index, mean(thres_Exp3),'Color',Color_Darkgray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6);
ests = shadedErrorBar_edited(index,mean(conThresh_Moving3),std(conThresh_Moving3)/sqrt(10),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
estss = shadedErrorBar_edited(index,mean(conThresh_UNIST3),std(conThresh_UNIST3)/sqrt(10),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on
ylim([0 1])
xticks(index);
xlim([0 14]);
set(gca,'FontSize',fs_tick_small,'ytick',0:0.2:1,'LineWidth',1.5)
legend([pp2 ests.mainLine estss.mainLine],{'Exp3 Obs','Exp3 Pred (Gaussian)','Exp3 Pred (Bi-phasic)'},'Location','southeast','FontSize',fs_legend)
legend box off

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
plot(index, thres_Exp4','Color',Color3_trans,'LineWidth',0.8,'LineStyle','--'); hold on;
errorbar(index,mean(thres_Exp4), std(thres_Exp4)./sqrt(size(thres_Exp4,1)-1),'LineWidth',2,'Color',Color_Darkgray,'LineStyle','none','CapSize',0); hold on
pp2 = plot(index, mean(thres_Exp4),'Color',Color_Darkgray,'Marker','o','LineWidth',1.5,'MarkerFaceColor',Color_Darkgray,'MarkerSize',6); hold on;
pp0 = shadedErrorbar_edited(index,mean(conThresh_Moving4),std(conThresh_Moving4)/sqrt(size(thres_Exp4,1)-1),'lineProps',{'-', 'color', Color_Yellow},'transparent',1); hold on
pp1 = shadedErrorbar_edited(index,mean(conThresh_UNIST4),std(conThresh_UNIST4)/sqrt(size(thres_Exp4,1)-1),'lineProps',{'-', 'color', Color_SkyBlue},'transparent',1); hold on
box off
ylim([0 1])
xticks(index);
xlim([0 9]);
set(gca,'FontSize',fs_tick_small,'ytick',0:0.2:1,'LineWidth',1.5)
legend([pp2 pp0.mainLine pp1.mainLine],{'Exp4 Obs','Exp4 Pred (Gaussian)','Exp4 Pred (Bi-phasic)'},'Location','southeast','FontSize',fs_legend)
legend box off
xlabel('Length of ''in between'' frequency epochs (frame/epoch)','fontsize',fs_label)
ylabel('Contrast Threshold','fontsize',fs_label)
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 20, 10], 'PaperUnits', 'centimeters', 'PaperSize', [20, 10]);

print(gcf,'Exp4_all.png','-dpng','-r300')
print(gcf,'Exp4_all.svg','-dsvg','-r300')

%% Supplementary Plot
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
        legend([exp1_obs, exp1_estGaus, exp1_estBi, exp2_obs, exp2_estGaus, exp2_estBi],{'Exp1 Obs','Exp1 Pred(G)','Exp1 Pred(Bi)','Exp2 Obs','Exp2 Pred(G)','Exp2 Pred(Bi)'},'Location','southeast','FontSize',8)
        legend box off
    end
 end
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 40, 50], 'PaperUnits', 'centimeters', 'PaperSize', [40, 50]);
set(0,'DefaultAxesFontName', 'Arial');
print(gcf,'Subject_Exp12.png','-dpng','-r300')



% Experiment 3
figure('Color',[1 1 1])
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
    box off
    set(gca,'FontSize',15,'LineWidth',1.5)
end
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 40, 30], 'PaperUnits', 'centimeters', 'PaperSize', [40, 30]);
print(gcf,'Subject_Exp3.png','-dpng','-r300')


% Experiment 4
figure('Color',[1 1 1])
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
    if mod(i,3) == 1
        ylabel('Contrast Threshold')
    end
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
p4 = plot(x_gau3, gau3,'Color', Color3, 'LineWidth', 2);
yticks([0]);
ylim([0 max(gau3)*1.5])
legend([p1 p4],{'Burr & Morrone, 1993','Exp 4'},'Location','northeast');
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
legend([p1 p2 p3],{'Kelly, 1961, 8500 td', 'Exp 1 + 2', 'Exp 3'});
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
