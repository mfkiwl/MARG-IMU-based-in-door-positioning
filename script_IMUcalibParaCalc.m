%% accelerometer
% ##################### data loading #####################
% d/u means the positive axis is facing downwards/upwards vertically on the ground
fileindex = {'xu','xd','yu','yd','zu','zd'};
% ---------------- VN100 ----------------
for i = 1:6
    eval(['filename = ''D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\VN100\calibration\acc_',fileindex{i},'\VNYMR.csv'';']);
    data = xlsread(filename,1);
    eval(['acc_',fileindex{i},' = data(1:1724,7:9);']);
    eval(['gyros_',fileindex{i},' = data(1:1724,10:12);']);
end

% ---------------- Xsens raw ----------------
for i = 1:6
    eval(['filename = ''D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\Xsens\calibration\A',fileindex{i},'.csv'';']);
    data = xlsread(filename,1);
    eval(['acc_',fileindex{i},' = data(1:1065,3:5);']);
    eval(['gyros_',fileindex{i},' = data(1:1065,6:8)*glv.rad;']);
end

% ---------------- plot ----------------
figure
plot(acc_xu);hold on;plot(acc_xd);
plot(acc_yu);plot(acc_yd);
plot(acc_zu);plot(acc_zd);

figure
plot(gyros_xu);hold on;plot(gyros_xd);
plot(gyros_yu);plot(gyros_yd);
plot(gyros_zu);plot(gyros_zd);

% ##################### calculate the mean of each axis #####################
axdm = mean(acc_xd);axum = mean(acc_xu);
aydm = mean(acc_yd);ayum = mean(acc_yu);
azdm = mean(acc_zd);azum = mean(acc_zu);
% 
% std(acc_yu,0,1)
% std(gyros_xu,0,1)

% wxpm = mean(gyro_xu);wxnm = mean(gyro_xd);
% wypm = mean(gyroyp);wynm = mean(gyroyn);
% wzpm = mean(gyrozp);wznm = mean(gyrozn);
% 
% figure;plot([1,2,3],[wxpm;wxnm;wypm;wynm;wzpm;wznm])

% ##################### Six Point Method #####################
% ### S = [K b], f_calib = K^(-1)*(f_raw-b); 
Ao = [axum' axdm' ayum' aydm' azum' azdm'];
Ai = [[[glv.g0;0;0],[-glv.g0;0;0],[0;glv.g0;0],[0;-glv.g0;0],[0;0;glv.g0],[0;0;-glv.g0]];[1 1 1 1 1 1]];
S = Ao*Ai'*inv(Ai*Ai');

% % ##################### Two Point Method #####################
% % ??? calculated bias differs from the bias calculated by the six point method
% kx = (axum(1)-axdm(1))/2/glv.g0;
% ky = (ayum(2)-aydm(2))/2/glv.g0;
% kz = (azum(3)-azdm(3))/2/glv.g0;
% bx = (axum(1)+axdm(1))/2/glv.g0;
% by = (ayum(2)+aydm(2))/2/glv.g0;
% bz = (azum(3)+azdm(3))/2/glv.g0;

%% magnetometer
figure;hold on
sensor_type = 'Xsens';
for trial = 1:5
% ##################### data loading #####################
if strcmp(sensor_type,'VN100')
    filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\calibration\ellip start ',num2str(trial),'\VNYMR.csv'];
%     filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\calibration\mag_fit_out\VNYMR.csv'];
%     filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\calibration\mag_fit_indoor1\VNYMR.csv'];
%     filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\calibration\mag_fit_indoor2\VNYMR.csv'];
    foot = xlsread(filename,1);
    foot_imu = dataFormat(foot,'VN100');
elseif strcmp(sensor_type,'Xsens')
    filename = ['D:\MXFcodes\MATLAB\MARG-IMU-based-in-door-positioning\data\Xsens\calibration\A_ellip_',num2str(trial),'.csv'];
    foot = xlsread(filename,1);
    foot_imu = dataFormat(foot,'Xsens_raw');
else,error('choose sensor');
    end

    mag = foot_imu.mag; 

% ##################### ellipsoid fitting #####################
    [A,b,expmfs] = magcal(mag) % calibration coefficients
    expmfs % Dipaly expected  magnetic field strength in nT
    
    C = (mag-b)*A; % calibrated data

%     plot(vecnorm(mag,2,2))
%     plot(mag)
%     plot(vecnorm(C,2,2))
%     plot(C)

figure
plot3(mag(:,1),mag(:,2),mag(:,3),'LineStyle','none','Marker','X','MarkerSize',5)
hold on
grid(gca,'on')
plot3(C(:,1),C(:,2),C(:,3),'LineStyle','none','Marker', ...
            'o','MarkerSize',5,'MarkerFaceColor','r') 
axis equal
xlabel('nT')
ylabel('nT')
zlabel('nT')
legend('Uncalibrated Samples', 'Calibrated Samples','Location', 'southoutside')
title("Uncalibrated vs Calibrated" + newline + "Magnetometer Measurements")
hold off
end