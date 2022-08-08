function [m,P,Q,R] = filterInitial(state_type,obs_type,imu_product,m0)
m = m0;

% % ### allan variance of WIT901
global glv;
% mg=glv.g0*0.001;
% ARW=[0.356269993661301;0.399565098420031;0.322625636319760];%deg/sqrt(h)
% VRW = [0.0678972113063788;0.0684746098011766;0.0846659351618287];    
% BIg = [31.5227989474692;22.3369625303739;30.6826396871611];
% BIa = [3.27530955305814;6.61103955408311;15.4628670415549];
% SigmaG = diag((ARW/60*pi/180).^2);
% SigmaA=diag((VRW/60).^2); %
% BIg = BIg*pi/180/3600;
% BIa = BIa/3600;
% dph=4.8481e-6;dphpsh=8.0802e-8;


if strcmp(imu_product,'VN100')
    % ### IMU specifications of VN100
bGstab = 1e-12*0.02;%10/3600*glv.rad;
bAstab = 0.04e-3;
    switch state_type
        case 'q'      
            P = diag([0.01;0.01;0.01;0.01]);
            Q = diag([0;0;0;0]);        
        case 'q bG'
            P = diag([0.01;0.01;0.01;0.01;0;0;0]);
            Q = diag([0;0;0;0;bGstab;bGstab;bGstab]);
        case 'q bG bA'
            P = diag([0.01;0.01;0.01;0.01;0;0;0;0;0;0]);
            Q = diag([0;0;0;0;bGstab;bGstab;bGstab;bAstab;bAstab;bAstab]);
        otherwise
    end
    if strcmp(obs_type,'gn')
%         R = diag([0.03;0.03;0.03]*0.001*glv.g0);
% R = diag([0.04;0.04;0.04]*0.001*glv.g0);
        R = diag([0.04;0.04;0.04]);
%     R = diag([0.4;0.4;0.4]);
    elseif strcmp(obs_type,'hnx')
        R = 0.2;
    end
elseif strcmp(imu_product,'Xsens')
    % -------- not finished -----------
else
    P = diag(P0);
    Q = diag(Q0);




end

end
