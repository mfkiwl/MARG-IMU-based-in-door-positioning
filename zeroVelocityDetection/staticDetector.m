function [arr_gait_time,static_start_index,static_end_index,si] = staticDetector(imu,plotflag)
% detect static period using difference of angular velocity
% Xiaofeng Ma @ Aalto University


d = diff(imu.gyros(:,1));

for i = 1:length(imu.gyros)-1
    if abs(d(i))<0.005
        si(i,1) = 1;
    else
        si(i,1) = 0;
    end
end

static_start_index = find([0; diff(si)] == 1); % 0 to 1, i.e. move to static
static_end_index = find([0; diff(si)] == -1); % 1 to 0, i.e. static to move
% The ith start follows the ith end


n=length(static_start_index);
for i=2:n
    % ### If an stance phase is too short, it is classified as a swing phase
    if (static_end_index(i,1) - static_start_index(i-1,1)) < 15
        si(static_start_index(i-1,1):static_end_index(i,1)-1,1)=0;
    end
end

static_start_index = find([0; diff(si)] == 1);
static_end_index = find([0; diff(si)] == -1);

arr_gait_time=[static_end_index,static_start_index]';

if strcmp(plotflag,'fig')
figure;plot(imu.gyros(:,1));hold on;plot(si)
end

end