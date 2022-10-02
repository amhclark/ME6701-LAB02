clear
clc
close all

filename = "gear_wheel.STL";
[F, V]=stl_read(filename);


figure()
p_handle = patch('faces',F,'vertices',V,'facec','b','EdgeColor','none');
light
daspect([1 1 1])
view(3)

hold on
p_handle_tf1(1)=quiver3(0,0,0,1,0,0,4,'r');
p_handle_tf1(2)=quiver3(0,0,0,0,1,0,4,'g');
p_handle_tf1(3)=quiver3(0,0,0,0,0,1,4,'b');

T_wo=[rotsym('z',deg2rad(0)) [-23.5 -23.5 0]';
        0 0 0        1];

for i=1:size(V,1)
    p_om=[V(i,:)';1];
    p_wm=T_wo*p_om;
    Vnew(i,:)=p_wm(1:3,:)';
end

V=Vnew;
set(p_handle,'vertices',Vnew)
grid on
view(0,90)

dt=0.1;
omega=1;
theta=0;

for t=0:dt:10
    theta=theta+omega*dt;
    T_wo=[rotsym('z',theta) [0 0 0]'
        0 0 0 1];
    for i=1:size(V,1)
        p_om=[V(i,:)';1];
        p_wm=T_wo*p_om;
        Vnew(i,:)=p_wm(1:3,:)';
    end

    set(p_handle,'vertices',Vnew)
    pause(0.1)
    drawnow
end




