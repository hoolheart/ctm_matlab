% This is a testinf script for ctm_matlab toolkit.
% A network including four intersections are modeled and simulated in this
% script.

% build the model
build_ctm_4int;

% initial the queue lengths of all normal and input lanes
% Note that the queue lengths of the output lanes need not be initialized.
ini_4int_queues([46;56;22;19;12;26;39;39;44;32;21;24;59;57;6;5]);

% other needed parameters
c = 90;
Q = -eye(16);
Q(2,5:8) = [0,0.72,0.09,0.18]; Q(3,9:12) = [0.09,0.09,0.63,0];
Q(5,1:4) = [0.72,0,0.18,0.09]; Q(7,13:16) = [0.09,0.09,0.63,0];
Q(10,13:16) = [0,0.72,0.09,0.18]; Q(12,1:4) = [0.09,0.09,0,0.63];
Q(13,9:12) = [0.72,0,0.18,0.09]; Q(16,5:8) = [0.09,0.09,0,0.63];
S = diag([0.6;0.6;0.4;0.4;0.6;0.6;0.4;0.4;0.6;0.6;0.4;0.4;0.6;0.6;0.4;0.4]);
G = zeros(16,4); phi = zeros(16,1);
for i=1:4
    G((i*4-3):i*4,i) = [1;1;-1;-1];
    phi((i*4-1):i*4) = [c;c];
end
B = Q*S*G; h = Q*S*phi;
u_n = [45;45;45;45];
q_n = -(B*u_n+h)/c;

% run the simulation for 20 cycles
n = 20;
x = zeros(16,n+1);
ug = zeros(4,n);
x(:,1) = [46;56;22;19;12;26;39;39;44;32;21;24;59;57;6;5];
w = zeros(16,n);
delay = zeros(1,n+1);
for i=1:n
    ug(:,i) = u_n;
    w(:,i) = 0.1*sin(i*pi/2.5)*q_n;
    x(:,i+1) = ctm_4int(q_n+w(:,i),c,ug(:,i));
    delay(i+1) = ctm_read_total_delay();
    ctm_reset_delay();
end

% draw queue lengths and delays
figure;
plot(0:n,x);
xlabel('cycle'); ylabel('queue length');
figure;
plot(0:n,delay);
xlabel('cycle'); ylabel('total cyclic delay');
