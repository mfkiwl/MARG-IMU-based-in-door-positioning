function [arr_gait_time,static_start_index,static_end_index,zvi,Test_statistics]=gaitDivide(imu,g)

% ############ zero velocity interval detecting ############
config.detector_type = 'GLRT';%'MAG';% 'MV','GLRT'
config.window_size = 3;
config.testStaThreshold =1.5e5;
config.g = g;
config.sigma_a = 0.01;
config.sigma_g = 0.1/180*pi;

[zvi,Test_statistics] = zeroVelocityDetector(imu,config); zvi = zvi';

% ############ stance phase and swing phase dividing ############
static_start_index = find([0; diff(zvi)] == 1); % 0 to 1, i.e. move to static
static_end_index = find([0; diff(zvi)] == -1); % 1 to 0, i.e. static to move
% The ith start follows the ith end

% ############ Removing very short opposite intervals ############
% If an swing phase is too short, it is classified as a stance phase
n=length(static_start_index);
% for i=2:n
%     if(stationaryEnd(i,1) -stationaryStart(i-1,1)< 5)
%         stationary(stationaryStart(i-1,1):stationaryEnd(i,1),1)=0;
%     end
% end
for i=1:n 
    if(static_start_index(i,1)-static_end_index(i,1) < 5)
        zvi(static_end_index(i,1):static_start_index(i,1),1)=1;
    end
end

static_start_index = find([0; diff(zvi)] == 1);
static_end_index = find([0; diff(zvi)] == -1);

arr_gait_time=[static_end_index,static_start_index]';

end