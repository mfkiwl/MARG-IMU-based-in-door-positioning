function [q,att]=yawbyMag(attxy, Mag, order, declination)
% Compute yaw given horizontal angles and mag^b
% Inputs:
%        attxy - horizontal angles, [pitch roll] in rad
%        Mag - outputs of magnetometers
%        order - order of rotation of  DCM construction
%        declination - magnetic declination given by user
% Output: 
%        att - Eular attitude, in rad
%        q - quarternion
% Notes: 
% The three axes of the IMU point up to the right, front, and up of the carrier. 

% by Xiaofeng Ma

pitch = attxy(1); roll = attxy(2);
if ~exist('declination','var')
%     phi=-6.95*pi/180;
    declination = 9.83*pi/180; % @ otaniemi (60.188515N, 24.832481E), Finland.
end

mx=mean(Mag(:,1));
my=mean(Mag(:,2));
mz=mean(Mag(:,3));
    
switch order
    case 'zyx'
        hy = my*cos(pitch) - mz*sin(pitch);
        hx = mx*cos(roll) + my*sin(pitch)*sin(roll) + mz*cos(pitch)*sin(roll);   
    case 'zxy'
        hx = mx*cos(roll) + mz*sin(roll);
        hy = mx*sin(roll)*sin(pitch) + my*cos(pitch) - mz*cos(roll)*sin(pitch);    
    otherwise
        error('undefined order');
end

yaw = atan2(hx,hy) + declination;

att=[pitch,roll,yaw]';
q=att2qua([pitch roll yaw], order);

end