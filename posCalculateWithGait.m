function  [pos,V_correct]=posCalculateWithGait(a,arr_gait_time,Ts,type)
% Inputs: 
%     a: Motion acceleration under n-frame
%     arr_gait_time: gait time index, 1st row is end of ZVI, 2nd row is start
%     of ZVI
%     Ts: sampling time of the IMU
%     type: 0.5 - use average values to calculate velocity and position;
%           1 - directly use measurements to calculate velocity and position
% Outputs:
%     pos: corrected position
%     V_correct: corrected velocity
%
% by Xiaofeng Ma

%%
% [arr_gait_time,~,~,~,~] = gaitDivide(imu,glv.g0);

N=length(a);
n=length(arr_gait_time);
t = 0:Ts:Ts*(length(a)-1);

%% Variable space allocation
% ############## velocity ##############
% semi-corrected velocity
Vx = zeros(1,N); Vy = zeros(1,N); Vz = zeros(1,N);
% uncorrected velocity
V = zeros(3,N);
% corrected velocity
Error_x = zeros(1,n); Error_y = zeros(1,n); Error_z = zeros(1,n);
Vx_RemoveErr = zeros(1,N); Vy_RemoveErr = zeros(1,N); Vz_RemoveErr = zeros(1,N);

% ############## position ##############
% position calculated through corrected velocity (Vi_RemoveErr, i=x,y,z)
position_x= zeros(1,N); position_y= zeros(1,N); position_z= zeros(1,N);
% position calculated through swing phase (Vx Vy Vz)
position0_x= zeros(1,N); position0_y= zeros(1,N); position0_z= zeros(1,N);
% position calculated through uncorrected velocity (V)
position1_x= zeros(1,N); position1_y= zeros(1,N); position1_z= zeros(1,N);

switch type
    case 1
%% velocity calculationg
% ########## integrating over all data ##########
for i=1:1:N-1
    V(:,i+1)= V(:,i)+a(:,i)*Ts;   
end
figure;
subplot(311);plot(t',V(1,:)',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(312);plot(t',V(2,:)',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(313);plot(t',V(3,:)',':','linewidth',1.5,'color',RGB('#333333'));hold on;
sgtitle('Velocity obtained by integrating over all data')

% ########## integrating over the swing phase only ##########
for i=1:1:n
    for j=arr_gait_time(1,i):arr_gait_time(2,i) % swing phase
        Vx(1,j+1) =Vx(1,j)+ a(1,j)*Ts;
        Vy(1,j+1) =Vy(1,j)+ a(2,j)*Ts;
        Vz(1,j+1) =Vz(1,j)+ a(3,j)*Ts;
    end
end
figure;
subplot(311);plot(t',Vx',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(312);plot(t',Vy',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(313);plot(t',Vz',':','linewidth',1.5,'color',RGB('#333333'));hold on;
sgtitle('Velocity obtained by integrating over the swing phase only')

% ########## velocity with drift removing ##########
% ------------ drift calculating ----------
for i=1:1:n % drift at each end of swing phase
    Error_x(1,i) = Vx(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
    Error_y(1,i) = Vy(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
    Error_z(1,i) = Vz(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
end
figure;
subplot(311);plot(Error_x',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(312);plot(Error_y',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(313);plot(Error_z',':','linewidth',1.5,'color',RGB('#333333'));hold on;
sgtitle('Velocity error calculated at ZVI')

% ------------ removing the drift linearly ------------
for i=1:1:n
    for j=arr_gait_time(1,i):arr_gait_time(2,i)
        Vx_RemoveErr(1,j) = Vx(1,j) -Error_x(1,i) * Ts *(j-arr_gait_time(1,i));
        Vy_RemoveErr(1,j) = Vy(1,j) -Error_y(1,i) * Ts *(j-arr_gait_time(1,i));
        Vz_RemoveErr(1,j) = Vz(1,j) -Error_z(1,i) * Ts *(j-arr_gait_time(1,i));
     end
end
figure;
subplot(311);plot(t',Vx_RemoveErr','-','linewidth',1,'color',RGB('#FF6666'));
subplot(312);plot(t',Vy_RemoveErr','-','linewidth',1,'color',RGB('#99CC66'));
subplot(313);plot(t',Vz_RemoveErr','-','linewidth',1,'color',RGB('#0099FF'));
sgtitle('Velocity obtained by eliminating errors throug linear method')

%% position calculating
for i=1:1:N-1

     position_x(1,i+1) = position_x(1,i) + Vx_RemoveErr(1,i) * Ts;
     position_y(1,i+1) = position_y(1,i) + Vy_RemoveErr(1,i) * Ts;
     position_z(1,i+1) = position_z(1,i) + Vz_RemoveErr(1,i) * Ts;
     
     position0_x(1,i+1) = position0_x(1,i) + Vx(1,i) * Ts;
     position0_y(1,i+1) = position0_y(1,i) + Vy(1,i) * Ts;
     position0_z(1,i+1) = position0_z(1,i) + Vz(1,i) * Ts;
     
     position1_x(1,i+1) = position1_x(1,i) + V(1,i) * Ts;
     position1_y(1,i+1) = position1_y(1,i) + V(2,i) * Ts;
     position1_z(1,i+1) = position1_z(1,i) + V(3,i) * Ts;
    
end

% % correcting height on a floor
% PError_z = zeros(1,n);
% for i=1:1:n
%      PError_z(1,i) = position_z(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
% end
% Pz_RemoveErr = zeros(1,N);
% for i=1:1:n
%     for j=arr_gait_time(1,i):arr_gait_time(2,i)
%           Pz_RemoveErr(1,j) = position_z(1,j) -PError_z(1,i) * Ts *(j-arr_gait_time(1,i));
%      end
% end
% figure;hold on;plot(position_z,':k');plot(Pz_RemoveErr,'b');

    case 0.5
%% velocity calculationg
% ########## integrating over all data ##########
for i=1:1:N-1
    V(:,i+1)= V(:,i)+(a(:,i)+a(:,i+1))*Ts/2;   
end
figure;
subplot(311);plot(t',V(1,:)',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(312);plot(t',V(2,:)',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(313);plot(t',V(3,:)',':','linewidth',1.5,'color',RGB('#333333'));hold on;
sgtitle('Velocity obtained by integrating over all data')

% ########## integrating over the swing phase only ##########
for i=1:1:n
    for j=arr_gait_time(1,i):arr_gait_time(2,i) % swing phase
        Vx(1,j+1) =Vx(1,j)+ (a(1,j) + a(1,j+1))*Ts/2;
        Vy(1,j+1) =Vy(1,j)+ (a(2,j) + a(2,j+1))*Ts/2;
        Vz(1,j+1) =Vz(1,j)+ (a(3,j) + a(3,j+1))*Ts/2;
    end
end
figure;
subplot(311);plot(t',Vx',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(312);plot(t',Vy',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(313);plot(t',Vz',':','linewidth',1.5,'color',RGB('#333333'));hold on;
sgtitle('Velocity obtained by integrating over the swing phase only')

% ########## velocity with drift removing ##########
% ------------ drift calculating ----------
for i=1:1:n % drift at each end of swing phase
    Error_x(1,i) = Vx(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
    Error_y(1,i) = Vy(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
    Error_z(1,i) = Vz(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
end
figure;
subplot(311);plot(Error_x',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(312);plot(Error_y',':','linewidth',1.5,'color',RGB('#333333'));hold on;
subplot(313);plot(Error_z',':','linewidth',1.5,'color',RGB('#333333'));hold on;
sgtitle('Velocity error calculated at ZVI')

% ------------ removing the drift linearly ------------
for i=1:1:n
    for j=arr_gait_time(1,i):arr_gait_time(2,i)
        Vx_RemoveErr(1,j) = Vx(1,j) -Error_x(1,i) * Ts *(j-arr_gait_time(1,i));
        Vy_RemoveErr(1,j) = Vy(1,j) -Error_y(1,i) * Ts *(j-arr_gait_time(1,i));
        Vz_RemoveErr(1,j) = Vz(1,j) -Error_z(1,i) * Ts *(j-arr_gait_time(1,i));
     end
end
figure;
subplot(311);plot(t',Vx_RemoveErr','-','linewidth',1,'color',RGB('#FF6666'));
subplot(312);plot(t',Vy_RemoveErr','-','linewidth',1,'color',RGB('#99CC66'));
subplot(313);plot(t',Vz_RemoveErr','-','linewidth',1,'color',RGB('#0099FF'));
sgtitle('Velocity obtained by eliminating errors throug linear method')

%% position calculating
for i=1:1:N-1

     position_x(1,i+1) = position_x(1,i) +   (Vx_RemoveErr(1,i)+ Vx_RemoveErr(1,i+1))* Ts/2;
     position_y(1,i+1) = position_y(1,i) +   (Vy_RemoveErr(1,i)+ Vy_RemoveErr(1,i+1))* Ts/2;
     position_z(1,i+1) = position_z(1,i) +   (Vz_RemoveErr(1,i)+ Vz_RemoveErr(1,i+1))* Ts/2;
     
     position0_x(1,i+1) = position0_x(1,i) +   (Vx(1,i)+ Vx(1,i+1))* Ts/2;
     position0_y(1,i+1) = position0_y(1,i) +   (Vy(1,i)+ Vy(1,i+1))* Ts/2;
     position0_z(1,i+1) = position0_z(1,i) +   (Vz(1,i)+ Vz(1,i+1))* Ts/2;
     
     position1_x(1,i+1) = position1_x(1,i) +   (V(1,i)+ V(1,i+1))* Ts/2;
     position1_y(1,i+1) = position1_y(1,i) +   (V(2,i)+ V(2,i+1))* Ts/2;
     position1_z(1,i+1) = position1_z(1,i) +   (V(3,i)+ V(3,i+1))* Ts/2;
    
end

% % correcting height on a floor
% PError_z = zeros(1,n);
% for i=1:1:n
%      PError_z(1,i) = position_z(1,arr_gait_time(2,i)+1)/((arr_gait_time(2,i)-arr_gait_time(1,i)+1)*Ts);
% end
% Pz_RemoveErr = zeros(1,N);
% for i=1:1:n
%     for j=arr_gait_time(1,i):arr_gait_time(2,i)
%           Pz_RemoveErr(1,j) = position_z(1,j) -PError_z(1,i) * Ts *(j-arr_gait_time(1,i));
%      end
% end
% figure;hold on;plot(position_z,':k');plot(Pz_RemoveErr,'b');



    otherwise
end
%% plotting
figure
plot(position_x,position_y);hold on;
plot(position0_x,position0_y);
legend({'corrected','semi-corrected'});
figure
plot(position1_x,position1_y);
legend({'uncorrected'});

V_correct = [Vx_RemoveErr;Vy_RemoveErr;Vz_RemoveErr]';

pos = ([position_x;position_y;position_z]');
e=(pos(2:end,:)-pos(1:end-1,:));
sum(sqrt(e(:,1).^2+e(:,2).^2))
% figure;plot(pos(:,1),pos(:,2))


end
