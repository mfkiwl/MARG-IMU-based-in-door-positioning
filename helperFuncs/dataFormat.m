function imu = dataFormat(file,product,Ts)
% format the data in a structure
% 
%     imu.acc - specific force, in m/s^2
%     imu.gyros - angular velocity, in rad/s
%     imu.mag - magnetic field strength, in nT
%     imu.qua - Quaternions calculated by the product algorithm
%     imu.ts - sampling time, in s, inverse of sampling frequency
%     imu.sT - Sampling Timestamp
% 
% by Xiaofeng Ma


global glv;

switch product
    case 'VN100'
        imu.acc = (sSys2rfu('frd')*file(:,7:9)')'; % m/s^2 converted to m/s^2
        imu.gyros = (sSys2rfu('frd')*file(:,10:12)')'; % rad/s converted to rad/s
        imu.mag = (sSys2rfu('frd')*file(:,4:6)')'*100000; % Gauss converted to nT
        imu.ts = 1/50;
    case 'Xsens_raw' % Inertial Data mode, rate quantities 
        imu.sT = file(:,2);
        imu.acc = (sSys2rfu('flu')*file(:,3:5)')'; % m/s^2 converted to m/s^2
        imu.gyros = (sSys2rfu('flu')*file(:,6:8)')' * glv.rad; % deg/s converted to rad/s
        imu.mag = (sSys2rfu('flu')*file(:,9:11)')'*49*1000; % a.u. converted to nT 
        % for mag, 49 (at XSens factory) should be changed to local EMF at
        % where the new MFM was done, but the unit is irrelevant when
        % calculating the yaw
        imu.ts = 1/60;
    case 'Xsens_custom4' % Custome mode 4 
        imu.sT = file(:,2);
        imu.qua = file(:,3:6);
        imu.acc = (sSys2rfu('flu')*file(:,11:13)')'; % m/s^2 converted to m/s^2
        imu.gyros = (sSys2rfu('flu')*qua2attV(file(:,7:10),order)')'; % 
        imu.mag = (sSys2rfu('flu')*file(:,14:16)')'*49*1000; % a.u. converted to nT
        imu.ts = 1/60;
    case 'Wit'
        imu.acc = (sSys2rfu('rfu')*file(:,1:3)')' * glv.g0; % g converted to m/s^2
        imu.gyros = (sSys2rfu('rfu')*file(:,4:6)')' * glv.rad; % deg/s converted to rad/s
        imu.mag = (sSys2rfu('rfu')*file(:,11:13)')'; % ?
        imu.ts = 1/100;
    otherwise,error('undefined');
end

if exist('Ts',"var")
    imu.ts = Ts;
end

end
