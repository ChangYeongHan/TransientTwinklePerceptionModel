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
stem(1:10, AIC_Diff_sort2(1:10), 'Color',Color_Yellow,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
stem(11, AIC_Diff_sort2(11), 'Color',Color_SkyBlue,'MarkerSize',10,'LineWidth',2,'Marker','o','MarkerFaceColor','auto'); hold on
xlim([0 12]);
xticks([0 5 10]);
ylabel([{'AIC Difference'}; {'(Gaussian - Bi-phaisc)'}],'fontsize',fs_label)
xlabel('Subject ID')
set(0,'DefaultAxesFontName', 'Arial');
set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 10, 10], 'PaperUnits', 'centimeters', 'PaperSize', [10, 10]);
set(gca,'FontSize',20,'LineWidth',1.5)
set(gca,'box','off')
print(gcf,'AIC_Exp4.png','-dpng','-r300')
print(gcf,'AIC_Exp4.svg','-dsvg','-r300')


% Statistics Test of AIC
[h12, pv12, ci12, stat12] = ttest(AIC_Diff0,0)
[h3, pv3, ci3, stat3] = ttest(AIC_Diff,0)
[h4, pv4, ci4, stat4] = ttest(AIC_Diff2,0)
