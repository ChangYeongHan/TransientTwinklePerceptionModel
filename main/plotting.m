%% Plotting

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
