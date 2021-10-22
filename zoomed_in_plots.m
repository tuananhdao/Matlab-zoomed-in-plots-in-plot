%%%%%%%%%%%
% Tuan Anh Dao <dta.hust@gmail.com>
% TDB, IT Department, Uppsala University
% Created: October 2021
% Tested on: Matlab R2019a
%%%%%%%%%%%

close all
set(0, 'DefaultLineLineWidth', 1);

%%%%%%%%%%%
% Data exported from paraview
M0 = readtable('example_data/athena_10000.csv'); % From Athena MHD solver
M1 = readtable('example_data/first_order_monolithic_rho_160.csv'); % From Paraview > Export to CSV
M3 = readtable('example_data/first_order_monolithic_rho_320.csv'); % From Paraview > Export to CSV
M4 = readtable('example_data/first_order_monolithic_rho_640.csv'); % From Paraview > Export to CSV
M1 = M1{:,:};M1_x = M1(:,6);M1_den = M1(:,1);
M3 = M3{:,:};M3_x = M3(:,6);M3_den = M3(:,1);
M4 = M4{:,:};M4_x = M4(:,6);M4_den = M4(:,1);
M0 = M0{:,:};M0_x = linspace(0,1,size(M0,1));M0_idx = 1:1:size(M0,1);
M0_x = M0_x(M0_idx);M0_den = M0(M0_idx,1);
%%%%%%%%%%%

%%%%%%%%%%%
% CONFIG MAIN FIGURE
mainfig = figure('Renderer', 'painters', 'Position', [300 300 600 500]);
AxesH = axes;
plot(M1_x,M1_den,'b','DisplayName','_density1_');hold on;
plot(M3_x,M3_den,'r','DisplayName','_density2_');hold on;
plot(M4_x,M4_den,'color',[0 0.5 0],'DisplayName','_density3_');hold on;
plot(M0_x,M0_den,'k','DisplayName','_reference_density_');
%xticks([0,0.5,1]);yticks([0.1,0.5,1]);
xlim([0 1]);ylim([0.09,1.01]);
xlim_ = xlim;ylim_ = ylim;xlim_length = xlim_(2)-xlim_(1);ylim_length = ylim_(2)-ylim_(1);
set(gca,'FontSize',13)
title("_title_"); xlabel("_xx_"); ylabel("_yy_");
leg1=legend('Location','northeast');set(leg1,'Box','off');
% Expand axes to fill figures
InSet = get(AxesH, 'TightInset');
set(AxesH, 'Position', [InSet(1:2), 1-InSet(1)-InSet(3), 1-InSet(2)-InSet(4)])
%%%%%%%%%%%

%%%%%%%%%%%
% CONFIG SUBFIGURES
zoomed_in_region_1 = [0.4 0.66 0.06 0.10]; % x_min y_min x_length y_length
zoomed_in_region_2 = [0.5 0.45 0.07 0.23]; % x_min y_min x_length y_length
zoomed_in_region_3 = [0.558 0.19 0.032 0.15]; % x_min y_min x_length y_length
position_subfig_1 = [0.16 .51 .25 .25]; % x_min y_min x_length y_length
position_subfig_2 = [.26 .16 .25 .25]; % x_min y_min x_length y_length
position_subfig_3 = [.69 .33 .25 .25]; % x_min y_min x_length y_length
%%%%%%%%%%%

% The small rectangles
rectangle('Position',zoomed_in_region_1,'EdgeColor',[0.5 0.5 0.5]); hold on;% box 1
rectangle('Position',zoomed_in_region_2,'EdgeColor',[0.5 0.5 0.5]); hold on;% box 2
rectangle('Position',zoomed_in_region_3,'EdgeColor',[0.5 0.5 0.5]); hold on;% box 3

% Zoomed in figure 1
axes('position',position_subfig_1);
box on
plot(M0_x,M0_den,'k'); hold on;
plot(M1_x,M1_den,'b'); hold on;
plot(M3_x,M3_den,'r'); hold on;
plot(M4_x,M4_den,'color',[0 0.5 0]); hold on;
xlim([zoomed_in_region_1(1) (zoomed_in_region_1(1)+zoomed_in_region_1(3))]);
ylim([zoomed_in_region_1(2) (zoomed_in_region_1(2)+zoomed_in_region_1(4))]);
set(gca,'fontweight','bold');grid on

% Zoomed in figure 2
axes('position',position_subfig_2);
box on
plot(M0_x,M0_den,'k'); hold on;
plot(M1_x,M1_den,'b'); hold on;
plot(M3_x,M3_den,'r'); hold on;
plot(M4_x,M4_den,'color',[0 0.5 0]); hold on;
xlim([zoomed_in_region_2(1) (zoomed_in_region_2(1)+zoomed_in_region_2(3))]);
ylim([zoomed_in_region_2(2) (zoomed_in_region_2(2)+zoomed_in_region_2(4))]);
set(gca,'fontweight','bold');grid on

% Zoomed in figure 3
axes('position',position_subfig_3);
box on
plot(M0_x,M0_den,'k'); hold on;
plot(M1_x,M1_den,'b'); hold on;
plot(M3_x,M3_den,'r'); hold on;
plot(M4_x,M4_den,'color',[0 0.5 0]); hold on;
xlim([zoomed_in_region_3(1) (zoomed_in_region_3(1)+zoomed_in_region_3(3))]);
ylim([zoomed_in_region_3(2) (zoomed_in_region_3(2)+zoomed_in_region_3(4))]);
set(gca,'fontweight','bold');grid on

% draw the lines connecting the boxes with zoomed in figures
box_offset_left = AxesH.Position(1);
box_width = AxesH.Position(3);
box_offset_bottom = AxesH.Position(2);
box_height = AxesH.Position(4);
line_start_position_x = box_offset_left+box_width*([zoomed_in_region_1(1);zoomed_in_region_2(1);zoomed_in_region_3(1)]-xlim_(1))/xlim_length;
line_start_position_y = box_offset_bottom+box_height*([zoomed_in_region_1(2);zoomed_in_region_2(2);zoomed_in_region_3(2)]-ylim_(1))/ylim_length;
annotation(mainfig,'line',[line_start_position_x(1) position_subfig_1(1)],[line_start_position_y(1) position_subfig_1(2)],'LineStyle','--','Color',[0.5 0.5 0.5]); hold on;
annotation(mainfig,'line',[line_start_position_x(2) position_subfig_2(1)],[line_start_position_y(2) position_subfig_2(2)],'LineStyle','--','Color',[0.5 0.5 0.5]); hold on;
annotation(mainfig,'line',[line_start_position_x(3) position_subfig_3(1)],[line_start_position_y(3) position_subfig_3(2)],'LineStyle','--','Color',[0.5 0.5 0.5]);
hold off

saveas(gcf,'example_plot','epsc')
