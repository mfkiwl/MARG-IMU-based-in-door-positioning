function [q,att]=alignbyAccMagatStatic(Acc, Mag, order, declination)
% Calulate horizontal angles from accelerometers
% and initial yaw angle from magnetometers.
% s-frame pointed to rfu.
% Inputs:  Acc - outputs of accelerometers (under s-frame)
%          Mag - outputs of magnetometers  (under s-frame)
%          order - order of rotation of  DCM construction
%          declination - magnetic declination given by user
% Output: att - Eular attitude
%               q - quarternion
% Notes: 
% The three axes of the IMU point up to the right, front, and up of the carrier. 

% by Xiaofeng Ma


fx=mean(Acc(:,1));
fy=mean(Acc(:,2));
fz=mean(Acc(:,3));

yaw=0;

switch order
    case 'zyx'
        pitch=atan2(fy,fz); 
        roll=asin(-fx/norm([fx,fy,fz])); 
    case 'zxy'
        pitch=asin(fy/norm([fx,fy,fz])); 
        roll=atan2(-fx,fz); 
    otherwise
        error('undefined order');
end


if ~isempty(Mag)
%     phi=-6.95*pi/180;
    if ~exist('declination','var')
        declination = 9.83*pi/180; % @ otaniemi (60.188515N, 24.832481E), Finland.
    end
    mx=mean(Mag(:,1));
    my=mean(Mag(:,2));
    mz=mean(Mag(:,3));
    
    switch order
        case 'zyx'
            hy = my*cos(pitch)-mz*sin(pitch);
            hx = mx*cos(roll)+my*sin(pitch)*sin(roll)+mz*cos(pitch)*sin(roll);   
        case 'zxy'
            hx = mx*cos(roll)+mz*sin(roll);
            hy = mx*sin(roll)*sin(pitch)+my*cos(pitch)-mz*cos(roll)*sin(pitch);    
        otherwise
            error('undefined order');
    end
    
    yaw = atan2(hx,hy) + declination;

end

att=[pitch,roll,yaw]';
q=att2qua([pitch roll yaw], order);

end