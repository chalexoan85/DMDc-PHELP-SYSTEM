close all; clear; clc;

%%
% DMDc WITH B UNKNOWN

% OBTAIN HOT SYSTEM
load("Data_Heat_1.mat");
u = double(squeeze(input(1,:,:)))/4000;
ym = (output(:,1:16)-output(:,17))';
sysmodel_DMDc = DMDc_B_unknown(ym,u);
sys_heat = sysmodel_DMDc;

% VALIDATE HOT SYSTEM
load("Data_Heat_2.mat");
u = double(squeeze(input(1,:,:)))/4000;
y = output(:,1:16)-output(:,17);
t = (0:length(u)-1)';
y_heat = lsim(sys_heat,u',t);

figure(1)
subplot(311); plot(t,y);
ylim([0 30]); set(gca, 'XLimSpec', 'Tight');
title("Validation Data");
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
set(gca,'FontSize',12);

subplot(312); plot(t,y_heat)
ylim([0 30]); set(gca, 'XLimSpec', 'Tight');
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
set(gca,'FontSize',12);

error = y-y_heat;
subplot(313); plot(t,error); hold on; plot(t,mean(rms(error))+0*error,'--k','LineWidth',1.5);
ylabel('$T ~(^{\circ}C)$','Interpreter','latex');
title("Error"); xlabel("time [sec]");
ylim([min(min(error)) max(max(error))]); set(gca, 'XLimSpec', 'Tight');
set(gca,'FontSize',12);

FIT=100*(1-(norm(y-y_heat)./norm(y-mean(y))));
subplot(312);
name = sprintf('Model Output (%.2f%%)',FIT);
title(name);
save model_heat_bunknown.mat sys_heat
saveas(gca,'model_heat_bunknown.png');

% OBTAIN COOL SYSTEM
load("Data_Cool_2.mat");
u = double(squeeze(input(1,:,:)))/4000;
ym = (output(:,1:16)-output(:,17))';
sysmodel_DMDc = DMDc_B_unknown(ym,u);
sys_cool = sysmodel_DMDc;

% VALIDATE COOL MODEL
load("Data_Cool_1.mat");
u = double(squeeze(input(1,:,:)))/4000;
y = output(:,1:16)-output(:,17);
t = (0:length(u)-1)';
y_cool = lsim(sys_cool,u,t);

figure(2)
subplot(311); plot(t,y);
ylim([-15 0]); set(gca, 'XLimSpec', 'Tight');
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
title("Validation Data")
set(gca,'FontSize',12);

subplot(312); plot(t,y_cool)
ylim([-15 0]); set(gca, 'XLimSpec', 'Tight');
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
set(gca,'FontSize',12);

error = y-y_cool;
subplot(313); plot(t,error); hold on; plot(t,mean(rms(error))+0*error,'--k','LineWidth',1.5);
ylabel('$T ~(^{\circ}C)$','Interpreter','latex');
title("Error"); xlabel("time [sec]");
ylim([min(min(error)) max(max(error))]); set(gca, 'XLimSpec', 'Tight');
set(gca,'FontSize',12);

FIT=100*(1-(norm(y-y_cool)./norm(y-mean(y))));
subplot(312);
name = sprintf('Model Output (%.2f%%)',FIT);
title(name);
save model_cool_bunknown.mat sys_cool
saveas(gca,'model_cool_bunknown.png');

%%
% DMDc WITH B KNOWN

% OBTAIN HOT SYSTEM
clear; clc;
load("Data_Heat_1.mat");
u = double(squeeze(input(1,:,:)))/4000;
ym = (output(:,1:16)-output(:,17))';
B = 0.52*eye(16);
sysmodel_DMDc = DMDc_B_known(ym,u,B);
sys_heat = sysmodel_DMDc;

% VALIDATE HOT SYSTEM
load("Data_Heat_2.mat");
u = double(squeeze(input(1,:,:)))/4000;
y = output(:,1:16)-output(:,17);
t = (0:length(u)-1)';
y_heat = lsim(sys_heat,u',t);

figure(3)
subplot(311); plot(t,y);
ylim([0 30]); set(gca, 'XLimSpec', 'Tight');
title("Validation Data");
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
set(gca,'FontSize',12);

subplot(312); plot(t,y_heat)
ylim([0 30]); set(gca, 'XLimSpec', 'Tight');
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
set(gca,'FontSize',12);

error = y-y_heat;
subplot(313); plot(t,error); hold on; plot(t,mean(rms(error))+0*error,'--k','LineWidth',1.5);
ylabel('$T ~(^{\circ}C)$','Interpreter','latex');
title("Error"); xlabel("time [sec]");
ylim([min(min(error)) max(max(error))]); set(gca, 'XLimSpec', 'Tight');
set(gca,'FontSize',12);

FIT=100*(1-(norm(y-y_heat)./norm(y-mean(y))));
subplot(312);
name = sprintf('Model Output (%.2f%%)',FIT);
title(name);
save model_heat_bknown.mat sys_heat
saveas(gca,'model_heat_bknown.png');

% OBTAIN COOL SYSTEM
load("Data_Cool_2.mat");
u = double(squeeze(input(1,:,:)))/4000;
ym = (output(:,1:16)-output(:,17))';
B = 0.27*eye(16);
sysmodel_DMDc = DMDc_B_known(ym,u,B);
sys_cool = sysmodel_DMDc;

% VALIDATE COOL MODEL
load("Data_Cool_1.mat");
u = double(squeeze(input(1,:,:)))/4000;
y = output(:,1:16)-output(:,17);
t = (0:length(u)-1)';
y_cool = lsim(sys_cool,u,t);

figure(4)
subplot(311); plot(t,y);
ylim([-15 0]); set(gca, 'XLimSpec', 'Tight');
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
title("Validation Data")
set(gca,'FontSize',12);

subplot(312); plot(t,y_cool)
ylim([-15 0]); set(gca, 'XLimSpec', 'Tight');
ylabel('$\Delta T ~(^{\circ}C)$','Interpreter','latex');
set(gca,'FontSize',12);

error = y-y_cool;
subplot(313); plot(t,error); hold on; plot(t,mean(rms(error))+0*error,'--k','LineWidth',1.5);
ylabel('$T ~(^{\circ}C)$','Interpreter','latex');
title("Error"); xlabel("time [sec]");
ylim([min(min(error)) max(max(error))]); set(gca, 'XLimSpec', 'Tight');
set(gca,'FontSize',12);

FIT=100*(1-(norm(y-y_cool)./norm(y-mean(y))));
cost_func = 'NRMSE';
fit = mean(1-goodnessOfFit(y_cool,y,cost_func))*100;
subplot(312);
name = sprintf('Model Output (%.2f%%)',FIT);
title(name);
save model_cool_bknown.mat sys_cool
saveas(gca,'model_cool_bknown.png');
