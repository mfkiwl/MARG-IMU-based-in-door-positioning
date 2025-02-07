% ######################################
% ### orientation tracking using EKF ###
% ######################################
% by Xiaofeng Ma @ Aalto University
%%
global glv;
N=length(imu.gyros);

%% initial
% ########### done in the main test file ###########

%% Filter   
MM = zeros(size(m,1),N);
PP = zeros(size(P,1),size(P,2),N); 
 
for k=1:N
    
    % ########### prediction via dynamics ###########
    [f,F] = f_qua(X_type,m,[imu.gyros(k,:),imu.ts],'exp');

    m = f;
    G = imu.ts/2*[-m(2), -m(3) -m(4);m(1) -m(4) m(3);m(4) m(1) -m(2);-m(3) m(2) m(1)];
    Q = diag([10;10;10]*glv.rad/3600);
    P = F*P*F' + G*Q*G';
%     P = F*P*F'+Q;
%     m(1:4) = m(1:4)/norm(m(1:4));
    
    % ########### measuremnet update ###########
    if zvd(k)==1 
        [z_pre,z_obs,H] = h_meas(X_type,m,obs_type,obs(k,:)',para);
        S = H*P*H' + R;
        K = P*H'/S;
        m = m+ K*(z_obs - z_pre);
        P = P - K*S*K';
% att_g = qua2att(m,order);
% [~,att_m] = alignbyAccMagatStatic(imu.acc(k,:),imu.mag(k,:),order);
% m = att2qua([att_g(1:2),att_m(3)],order);
    end  

    m(1:4) = m(1:4)/norm(m(1:4));

    P = (P + P')/2;    
    
    MM(:,k) = m;
    PP(:,:,k) = P;
end

t = 0:imu.ts:imu.ts*(N-1);
Ref = zeros(5,N) + [180;90;0;-90;-180];
    
% figure
% plot(t,MM,'Linewidth',1);
% title('EKF estimate');

att_EKF = qua2attV(MM', 'zxy');
% figure
% plot(t/60,att_EKF*glv.deg,'Linewidth',1);
% hold on;
% plot(t/60,Ref,'r:','Linewidth',1.5)
% legend('pitch','roll','yaw','reference');
% title('EKF attitude estimates');

q = MM(1:4,:)';

if strcmp(X_type,'q bG')
    bG = MM(5:7,:)';
    figure
    plot(t/60,bG*glv.deg)
    title('Gyroscope bias');
end
if strcmp(X_type,'q bG bA')
        bG = MM(5:7,:)';
        figure
        plot(t/60,bG*glv.deg)
        title('Gyroscope bias');
        
        bA = MM(8:10,:)';
        figure
        plot(t/60,bA)
        title('Accelerometer bias');
end
