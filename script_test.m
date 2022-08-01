clear all
close all
glvs;
%% data lodaing
load( 'C:\04 MyCodes\MyCodes\data\20200906\静止用于allan\mat\footstatic.mat');
foot = footstatic;
foot_imu.acc = foot(:,1:3); %转为m/s^2
foot_imu.gyros = foot(:,4:6); %转为rad/s
foot_imu.ts = 1/100;

filename = 'D:\04 MyCodes\MyCodes\data\新主楼\BayesProj.xlsx';
foot = xlsread(filename,1);

filename = 'C:\04 MyCodes\MyCodes\data\20220518\mystream_5_18_19_11_4.csv';
foot = xlsread(filename,1);

filename = 'C:\04 MyCodes\MyCodes\data\mxf_imu.csv';
foot = xlsread(filename,1);

filename = 'C:\04 MyCodes\MyCodes\data\aalto\IMU1r.csv';
foot = xlsread(filename,1);

filename = 'C:\04 MyCodes\MyCodes\data\aalto\IMU5r.csv';
foot = xlsread(filename,1);
foot_imu.ts = 0.05;

figure;hold on
plot(foot(:,1:3));
plot(foot(:,4:6));
plot(foot(:,11:13));

foot_imu.acc = (sSys2rfu('rfu')*foot(:,1:3)')' * glv.g0; %转为m/s^2
foot_imu.gyros = (sSys2rfu('rfu')*foot(:,4:6)')' * glv.rad; %转为rad/s
foot_imu.mag = (sSys2rfu('rfu')*foot(:,11:13)')'; %转为rad/s
foot_imu.ts = 1/100;
%% positon
figure(1005);hold on;xlabel('X (m)');ylabel('Y (m)');box on
trial=1;
for trial=1:10
% ########### data loading ########### 
    filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\Human movement\Xiaofeng stairs ',num2str(trial),'\VNYMR.csv'];
    % filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\calibration\mag_fit_out\VNYMR.csv'];

    foot = xlsread(filename,1);
    % VN100 Gauss m^2/s  rad/s; Xsens a.u. m/s^2  deg/s
    foot_imu.acc = (sSys2rfu('frd')*foot(:,7:9)')'; % m/s^2 converted to m/s^2
    foot_imu.gyros = (sSys2rfu('frd')*foot(:,10:12)')'; % rad/s converted to rad/s
    foot_imu.mag = (sSys2rfu('frd')*foot(:,4:6)')'*100000; % Gauss converted to nT
    foot_imu.ts = 1/50;

    order = 'zxy';

% ########### calibration ########### 
    % ------- magnetometer ----------
    % VN100, outdoor, in uT
    scale_mag = [1.00015623443763,-0.000614594088256676,0.000333198817722424;-0.000614594088256676,0.999453137781562,6.08730669949403e-05;0.000333198817722424,6.08730669949403e-05,1.00039135869403];
    bias0_mag = [14.0676852349577,17.2363910019548,67.2280986430766];
    % VN100, indoor, in uT
    scale_mag = [0.999619166050673,-0.00391470300493826,-0.000575781949698663;-0.00391470300493826,0.999487640990844,-0.000503493864538733;-0.000575781949698663,-0.000503493864538733,1.00090973610266];
    bias0_mag = [14.9651802624178,16.9365731636440,66.4614207597364];

    foot_imu.mag = (foot_imu.mag-bias0_mag)*scale_mag; 

    % ------- accelerometer ----------
    % VN100
    scale_acc = [1.0007    0.0186   -0.0031;
       -0.0058    1.0009   -0.0005;    
        0.0179   -0.0015    1.0010];    
    bias0_acc = [-0.0498;0.0129;0.4891];

    foot_imu.acc = (inv(scale_acc)*(foot_imu.acc'-bias0_acc))'; 

    % ------- gyroscope ----------
    % gyro
    still_time =10; 
    bias0_gyro = mean(foot_imu.gyros(1:still_time,:));

    %-----------------------------
    foot_imu1 = foot_imu;

% ########### initial alignment ########### 
    [foot_q0,foot_att0] = alignbyAccMagatStatic(foot_imu1.acc(1:still_time,:),[],order);
    disp(['-----  initial attitude（deg/s）：',num2str((foot_att0*glv.deg)'),'  -----']);
    if abs(foot_att0(1))>0.1 || abs(foot_att0(2))>0.1 %0727
        foot_imu1.acc = (sSys2rfu(foot_att0,order)*foot_imu1.acc')'; %转为m/s^2
        foot_imu1.gyros = (sSys2rfu(foot_att0,order)*foot_imu1.gyros')'; %转为rad/s
    %     foot_imu1.ratt = (sSys2rfu(foot_att0,order)*foot_imu1.ratt')'; %保持°
        [foot_q0,foot_att0] = alignbyAccMagatStatic(foot_imu1.acc(1:still_time,:),[],order); %根据严静止判断出的动前静止区间选取
        disp(['-----  initial attitude（deg/s）：',num2str((foot_att0*glv.deg)'),'  -----']);
    end

    foot_imu1.acc = foot_imu1.acc(still_time+1:end,:);%更新起点
    foot_imu1.gyros = foot_imu1.gyros(still_time+1:end,:);
    foot_imu1.mag = foot_imu1.mag(still_time+1:end,:);

% ########### attitude and pos estimating ########### 

    % ------- initial setting ----------
    imu = foot_imu1;
    qua0 = foot_q0;

    X_type = 'q bG'; %  bA
    obs_type = 'gn'; obs = imu.acc; para = [0;0;glv.g0];
    [m,P,Q,R] = filterInitial(X_type,[qua0;bias0_gyro'],[],[],obs_type,[]);% [;0;0;0]

    % ------- zero velociy detection ----------
    % [zvd,~] = zeroVelocityDetector(imu,config);
    [gait_time,~,~,zvd,~] = gaitDivide(imu,glv.g0);

    % ------- filtering / numerical integrating for quaternion ----------
    EKFq
    % BayesEKF
    % numIntegraQua

    % % ------- Replace yaw_gyro with yaw_mag ----------
    % q_am = zeros(N,4); att_am = zeros(N,3);
    % for i = 1:N
    % [qq,aa] = alignbyAccMagatStatic(imu.acc(i,:),imu.mag(i,:),order);
    % q_am(i,:) = qq';
    % att_am(i,:) = aa';
    % end
    % figure;plot(att_am(:,3)*glv.deg);hold on;plot(att_EKF(:,3)*glv.deg)
    % att = [att_EKF(:,1:2),att_am(:,3)];

    % ------- convert specific force to acc^n ----------
    N = length(q);
    accn = zeros(N,3);
    for i = 1:N
        if strcmp(X_type,'q bG bA')
            accn(i,:) = (qua2dcm(q(i,:),'Cnb')*imu.acc(i,:)' - [0;0;glv.g0])';
        else
            accn(i,:) = (qua2dcm(q(i,:),'Cnb')*imu.acc(i,:)' - [0;0;glv.g0])';
%             accn(i,:) = (att2dcm(att(i,:),order)*imu.acc(i,:)' - [0;0;glv.g0])';
        end
    end

    % ------- calculating position using acc^n ----------
%     pos = posCalculateWithGait(imu,accn');
    [pos,~]=posCalculateWithGait(accn',gait_time,imu.ts,0.5);

    figure(1005);hold on;
    plot(pos(:,1),pos(:,2),'r-')

% ########### plot magnetic field ########### 
    magn = zeros(N,3);
        for i = 1:N
            magn(i,:) = (qua2dcm(q(i,:),'Cnb')*imu.mag(i,:)')';
        end    
    figure;hold on;
    plot(magn);
    plot(vecnorm(magn,2,2));
    legend({'mag_x^n','mag_y^n','mag_z^n','mag_{norm}'});
    xlabel('Time')
    ylabel('Magnetic field strength (nT)')

    figure;hold on;
    plot(imu.mag);
    plot(vecnorm(imu.mag,2,2));
    legend({'mag_x^b','mag_y^b','mag_z^b','mag_{norm}'});
    xlabel('Time')
    ylabel('Magnetic field strength (nT)')

    figure
    scatter(pos(:,1),pos(:,2),10,vecnorm(imu.mag,2,2),'filled')
    h = colorbar;
    set(get(h,'label'),'string','magnetic field strength (nT)');
    axis equal

    figure
    scatter3(pos(:,1),pos(:,2),pos(:,3),10,vecnorm(imu.mag,2,2),'filled')
    h = colorbar;
    set(get(h,'label'),'string','magnetic field strength (nT)');
    axis equal
    
end 
% [pose,~,~,~,~,arr_gait_time,stationaryStart,stationaryEnd,stationary,~]=positionCalculate(imu,accne','foot');
% figure;plot(pose(:,1),pose(:,2))
% [pose]=posCalculate(imu,MM_e');
% figure;plot(pose(:,1),pose(:,2))

figure
plot3(pos(:,1),pos(:,2),pos(:,3))

%% yaw calculated by magnetometer
yaw = zeros(N,1);
for k=1:N
    [foot_q0,foot_att0] = alignbyAccMagatStatic(foot_imu1.acc(k,:),foot_imu1.mag(k,:),order);
    yaw(k,1) = foot_att0(3);
end
figure
plot(1:N,yaw)

att_EKF(:,3) = yaw;
accne = zeros(N,3);
for i = 5:N
    accne(i,:) = (att2dcm(MM_e(:,i)',order)*imu.acc(i,:)' - [0;0;glv.g0])';
end
    
 pose = posCalculateWithGait(imu,accne');
 figure(1000)
 plot(pose(:,1),pose(:,2),'g-')

%% magnetic field mapping
figure(500);hold on;
figure(501);hold on;
figure(502);hold on;

for trial=1:10
filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\mag_fixed point\mg FP ',num2str(trial),'\VNYMR.csv'];
filename = 'D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\calibration\mg fp floorlevel\VNYMR.csv';

foot = xlsread(filename,1);
for i=4:12
    foot(:,i) = smooth(foot(:,i));
end
foot_imu.acc = (sSys2rfu('frd')*foot(:,7:9)')'; % m/s^2 converted to m/s^2
foot_imu.gyros = (sSys2rfu('frd')*foot(:,10:12)')'; % rad/s converted to rad/s
foot_imu.mag = (sSys2rfu('frd')*foot(:,4:6)')'*100000; % Gauss converted to nT
foot_imu.ts = 1/50;




magx = smooth(foot_imu.mag(:,1));
magy = smooth(foot_imu.mag(:,2));
magz = smooth(foot_imu.mag(:,3));
figure;
plot(magx);
figure;
plot(magy);

imu.acc = smooth(foot_imu.acc);
imu.gyros = smooth3(foot_imu.gyros);
imu.mag = smooth3(foot_imu.mag);

config.detector_type = 'GLRT';%'MAG';% 'MV','GLRT'
config.window_size = 3;
config.testStaThreshold =2000;%1.5e5;
config.g = glv.g0;
config.sigma_a = 0.01;
config.sigma_g = 0.1/180*pi;
[stationary,sta] = zeroVelocityDetector(foot_imu,config);
figure
plot(foot_imu.mag(:,1));hold on
plot(stationary'*100000)

k = 1;
index = 0;
for j = 1:length(foot_imu.mag)-10
    if abs(magx(j+10,1)-magx(j,1))<0.005
%         eval('index_',num2str(trial),'(k) = j;');
        index(k,1) = j;
        k = k+1;
    end
end

figure(500);
plot(magx);
plot(index,magx(index),'*');
figure(501);
plot(magy);
plot(index,magy(index),'*');
figure(502);
plot(magz);
plot(index,magz(index),'*');

end

%% plot
N=length(imu.gyros);
t = 0:0.01:0.01*(N-1);
Ref = zeros(5,N) + [180;90;0;-90;-180];

xlabel('Time (min)');
ylabel('Angle (°)')
 set(gca,'FontSize',10,'FontName','Times New Roman');
 
 
figure
plot(t/60,att_EKF(:,1)*glv.deg,'-g','Linewidth',2);
hold on
plot(t/60,att_UKF(:,1)*glv.deg,'--c','Linewidth',1.5);
plot(t/60,att_GHKF(:,1)*glv.deg,'-.m','Linewidth',1);
plot(t/60,att_CKF(:,1)*glv.deg,':b','Linewidth',1);

figure
plot(t/60,att_EKF(:,2)*glv.deg,'-g','Linewidth',2);
hold on
plot(t/60,att_UKF(:,2)*glv.deg,'--c','Linewidth',1.5);
plot(t/60,att_GHKF(:,2)*glv.deg,'-.m','Linewidth',1);
plot(t/60,att_CKF(:,2)*glv.deg,':b','Linewidth',1);

figure
plot(t/60,att_EKF(:,3)*glv.deg,'-g','Linewidth',2);
hold on
plot(t/60,att_UKF(:,3)*glv.deg,'--c','Linewidth',1.5);
plot(t/60,att_GHKF(:,3)*glv.deg,'-.m','Linewidth',1);
plot(t/60,att_CKF(:,3)*glv.deg,':b','Linewidth',1);
plot(t/60,Ref,'r:','Linewidth',1.5,'color',[0.9,0.3,0.3])

legend({'EKF','UKF','GHKF','CKF','Reference'});

figure;hold on;box on;
plot(pos_corner(:,1),pos_corner(:,2),'-r','linewidth',1.5,'color',[0.9,0.3,0.3]);
plot(pose(:,1),pose(:,2),'-g','Linewidth',2);
plot(posu(:,1),posu(:,2),'--c','Linewidth',1.5);
plot(posgh(:,1),posgh(:,2),'-.m','Linewidth',1);
plot(posc(:,1),posc(:,2),':b','Linewidth',1);

legend({'Reference','EKF','UKF','GHKF','CKF'});
box on
xlabel('X (m)');
ylabel('Y (m)')
 set(gca,'FontSize',10,'FontName','Times New Roman');
 ref_pos = [0,0;0,1.2*8;-1.2*2,1.2*8;-1.2*2,0;0,0];
 plot(ref_pos(:,1),ref_pos(:,2),'g')