% File: Motor_plot.m
% Reminder: The data file folder (HEV-HW00 Vehicle Data) needs to be in the path

clear

% load motor data
motor_case = 1;
switch motor_case
    case 1; mc_UQM_PowerPhase100;
    otherwise; mc_westinghouse_110;
end

% scaling data
scale_case = 0; % 1 = yes
switch scale_case
    case 1; 
        trq_factor = 2;
        mc.trq_cont_map = mc.trq_cont_map*trq_factor;
        mc.trq_max_map = mc.trq_max_map*trq_factor;
        mc.trq_eff_index = mc.trq_eff_index*trq_factor;
        mc.trq_cont_map_gen = mc.trq_cont_map_gen*trq_factor;
        mc.trq_max_map_gen = mc.trq_max_map_gen*trq_factor;
        mc.trq_eff_index_gen = mc.trq_eff_index_gen*trq_factor;
        mc.trq_eff_index_2Q = mc.trq_eff_index_2Q*trq_factor;    
    otherwise; 
       trq_factor = 1;
end


%% plots

plot_case = 1; %  1 = 1 quadarant, 2 = 2 quandrant,
switch plot_case
    case 1
       load sch_fuds1.mat; %for City cycle
        t = sch_cycle(:,1);
        V = sch_cycle(:,2);
        open('proj7_city_prt3');
        sim('proj7_city_prt3');
        set_param('proj7_city_prt3','Solver','ode4','Stoptime','1370');
                h1 = figure('Name','Motor Plot - One Quad'); 
        set(h1,'Units','inches','Position',[1.5   1.5  7   5]);
        plot(mc.rpm_cont_index,mc.trq_cont_map,mc.rpm_max_index,mc.trq_max_map,'LineWidth',2)
        hold on
        v=[0.70 0.75 0.80 0.85 0.90 0.92 0.93];
 %       v = [0.70:0.05:ceil(max(max(mc.eff_trq_map))/.05)*.05];
        [c,h]=contour(mc.rpm_eff_index,mc.trq_eff_index,mc.eff_trq_map',v);
        clabel(c);
        title(['Motor: ' mc.motor_name]);
        xlabel('Motor Speed (rpm)');ylabel('Motor Torque (Nm)');grid on
        hold on
        plot(rpm,trq,'o')
        hold off
    otherwise
        HF1 = figure('Name','Motor Plot - Two Quad'); 
        set(HF1,'Units','inches','Position',[1.5   1.5   7   8]);
        plot(mc.rpm_cont_index,mc.trq_cont_map,mc.rpm_max_index,mc.trq_max_map)
        hold on
        v=[0.70 0.75 0.80 0.85 0.875 0.905];
        [c,h]=contour(mc.rpm_eff_index_2Q,mc.trq_eff_index_2Q,mc.eff_trq_map_2Q',v);
        clabel(c);
        plot(mc.rpm_cont_index_gen,mc.trq_cont_map_gen,mc.rpm_max_index_gen,mc.trq_max_map_gen)
        title(['Motor: ' mc.motor_name]);
        xlabel('Motor Speed (rpm)');ylabel('Motor Torque (Nm)');grid on
        hold off
end



