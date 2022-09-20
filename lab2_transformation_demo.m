clear;
clc;
close all;

l = 3;
V = [0 0 0;
     l 0 0;
     l l 0;
     0 l 0;
     0 0 l;
     l 0 l;
     l l l;
     0 l l;];

F = [1 2 3 4;
     5 6 7 8;
     1 2 6 5;
     2 3 7 6;
     3 4 8 7;
     1 4 8 5];

C = [255 0 0;
     0 0 255;
     0 255 0;
     128 128 128;
     255 255 255;
     0 0 0;];

figure()
p_handle = patch('faces', F, 'vertices', V, 'facec', 'flat', ...
    'FaceVertexCData', C,'EdgeColor', 'black', 'LineWidth', 2);

axis([-5 5 -5 5 -5 5])
grid on

hold on
quiver3(0,0,0,1,0,0,4,'r')
quiver3(0,0,0,0,1,0,4,'g')
quiver3(0,0,0,0,0,1,4,'b')

T_wo = [rotsym('z',deg2rad(30)) [1 0 0]';
    0 0 0      1];

for i = 1:8;
    p_om = [V(i,:)';1];
    p_wm = T_wo*p_om;
    Vnew(i,:)=p_wm(1:3,:);
end

set(p_handle,'vertices',Vnew)

tf_handle_o(1)=quiver3(T_wo(1,4),T_wo(2,4),T_wo(3,4),T_wo(1,1),T_wo(2,1),T_wo(3,1),4,'r');
tf_handle_o(2)=quiver3(T_wo(1,4),T_wo(2,4),T_wo(3,4),T_wo(1,2),T_wo(2,2),T_wo(3,2),4,'g');
tf_handle_o(3)=quiver3(T_wo(1,4),T_wo(2,4),T_wo(3,4),T_wo(1,3),T_wo(2,3),T_wo(3,3),4,'b');

