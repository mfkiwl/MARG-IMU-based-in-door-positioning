function [z_pre,z_obs,H] = h_meas(state_type,X,obs_type,obs,para)
q0 = X(1); q1 = X(2); q2 = X(3); q3 = X(4);
z_obs = obs;
if strcmp(obs_type,'gn')
    % ### The output of accelerometers should be equal to the grivaty
    % ### expressed in the b frame.
    g = para(3);
    switch state_type
        case 'q'       
            % ### fb = Gbn*[0;0;g];
            z_pre = qua2dcm(X(1:4),'Cbn')*para;
            H = [-2*g*q2,  2*g*q3, -2*g*q0, 2*g*q1;
                 2*g*q1,  2*g*q0,  2*g*q3, 2*g*q2;
                 2*g*q0, -2*g*q1, -2*g*q2, 2*g*q3];
        case 'q bG'
            z_pre = qua2dcm(X(1:4),'Cbn')*para;
            H = [-2*g*q2,  2*g*q3, -2*g*q0, 2*g*q1, 0, 0, 0;
                 2*g*q1,  2*g*q0,  2*g*q3, 2*g*q2, 0, 0, 0;
                 2*g*q0, -2*g*q1, -2*g*q2, 2*g*q3, 0, 0, 0];
        case 'q bG bA'
            z_pre = qua2dcm(X(1:4),'Cbn')*para + X(8:10);
            H = [-2*g*q2,  2*g*q3, -2*g*q0, 2*g*q1, 0, 0, 0, 1, 0, 0;
                 2*g*q1,  2*g*q0,  2*g*q3, 2*g*q2, 0, 0, 0, 0, 1, 0;
                 2*g*q0, -2*g*q1, -2*g*q2, 2*g*q3, 0, 0, 0, 0, 0, 1];
                 
        otherwise
            error('wrong');
    end
elseif strcmp(obs_type,'hnx')
    % not finished
     mn = qua2dcm(X(1:4),'Cnb')*para;
     z_pre = mn(1,:);
elseif strcmp(obs_type,'fb')
    % ### [0;0;g] = Gnb*fb;
            z_pre = qua2dcm(X(1:4),'Cnb')*para;
            H = [2*fbx*q0 - 2*fby*q3 + 2*fbz*q2, 2*fbx*q1 + 2*fby*q2 + 2*fbz*q3, 2*fby*q1 - 2*fbx*q2 + 2*fbz*q0, 2*fbz*q1 - 2*fby*q0 - 2*fbx*q3;
                2*fbx*q3 + 2*fby*q0 - 2*fbz*q1, 2*fbx*q2 - 2*fby*q1 - 2*fbz*q0, 2*fbx*q1 + 2*fby*q2 + 2*fbz*q3, 2*fbx*q0 - 2*fby*q3 + 2*fbz*q2;
                2*fby*q1 - 2*fbx*q2 + 2*fbz*q0, 2*fbx*q3 + 2*fby*q0 - 2*fbz*q1, 2*fby*q3 - 2*fbx*q0 - 2*fbz*q2, 2*fbx*q1 + 2*fby*q2 + 2*fbz*q3];
        
end

 
end