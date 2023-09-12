function Inversa(handles)
% try
set(handles.Estado, 'Visible', 'off');
coor=get(handles.Coordenadas, 'value');
gdl=get(handles.GDL, 'value');
m2=get(handles.Trayectoria, 'value');
m3=get(handles.Experto, 'value');
dae=get(handles.DAE, 'value');
E=evalin('base','R');
if coor==2 || m2==1 || E==0
    q=evalin('base','qi');
    car=evalin('base','car'); %car guarda la posici�n X Y Z A B C deseada ingresada por el usuario
    l1=10;
    l2=12;
    l3=12;
    l4=7;
    
    P=[car(1);car(2);car(3)];
    if dae==1
        A=car(4);
        B=car(5);
        C=car(6);

        Rz=[cosd(A) -sind(A) 0;
            sind(A) cosd(A) 0;
            0 0 1];
        Ry=[cosd(B) 0 sind(B);
            0 1 0
            -sind(B) 0 cosd(B)];
        Rx=[1 0 0;
            0 cosd(C) -sind(C);
            0 sind(C) cosd(C)];
        R=(Rz*Ry*Rx);

        n = R(:,1);
        o = R(:,2);
        a = R(:,3);

%         Pm = P -(l4*n)
        Pm = P -([l4 0 0]*R).' ;
        pmx = Pm(1);
        pmy = Pm(2);
        pmz = Pm(3);              
    elseif dae==0
        syms x y;
        Px=P(1);
        Py=P(2);
        Pz=P(3);

        if Px==0 && Py~=0
            Ec1=-x;
        elseif Px==0 && Py==0
            Ec1=y;
        else
            m=Py/Px;
            Ec1=y-m*x;
        end
        Ec2=(Px-x)^2+(Py-y)^2-l4^2;
        xy=solve(Ec1,Ec2);
        pmxs=double(xy.x);
        pmys=double(xy.y);
        for i=1:2
            if abs(pmxs(1))>abs(Px) && abs(pmxs(2))>abs(Px)
                if pmxs(i)<=abs(Px)
                    pmx=pmxs(i);
                end
            else
                if abs(pmxs(i))<=abs(Px)
                    pmx=pmxs(i);
                end
            end
            if abs(pmys(i))<=abs(Py)
                pmy=pmys(i);
            end
        end
        pmz=Pz;
        R=1;
        if Px==0 && Py==0 && Pz>=31
            pmx=Px;
            pmy=Py;
            if Pz>10
                pmz=Pz-l4;
            else
                pmz=Pz+l4;
            end   
        R=[0 0 -1;
           0 1 0;
           1 0 0];
        end
        Pm=[pmx;pmy;pmz];
    end
    
    q1_1=roundn(atan2d(pmy,pmx),-4);    
    q1_2=roundn(180+atan2d(pmy,pmx),-4);

    r2=pmx^2+pmy^2;
    R2=r2+(pmz-l1)^2;
    if sqrt(r2)== 0                                                                                         
        beta1=90;
        beta2=90;
    else
        beta1=atan2d(pmz-l1,sqrt(r2));
        beta2=atan2d(pmz-l1,-sqrt(r2));
    end
    if sqrt(R2)== 0
        alfa1=90;
        alfa2=-90;
    else
        calfa=((l3^2-l2^2-R2)/(-2*l2*sqrt(R2)));
        if calfa>1
            set(handles.Estado, 'Visible', 'on');
            set(handles.Estado, 'String', 'No se puede alcanzar ese punto');
            OP=0.5
        else
            set(handles.Estado, 'Visible', 'off');
            set(handles.Estado, 'String', '');  
        end
        salfa=sqrt(1-calfa^2);
        alfa1=atan2d(salfa,calfa);
        alfa2=atan2d(-salfa,calfa);
    end
    q2_1=roundn((beta1+alfa1)-(90),-4);
    q2_2=roundn((beta1+alfa2)-(90),-4);
    q2_3=roundn((beta2+alfa1)-(90),-4);
    q2_4=roundn((beta2+alfa2)-(90),-4);

    sq3=(R2-l2^2-l3^2)/(-2*l2*l3);
    cq3=sqrt(1-sq3^2);
    q3_1=roundn(atan2d(sq3,cq3),-4);
    q3_2=roundn(atan2d(sq3,-cq3),-4);


    %Opci�n 1
    OP=1;
    q1=q1_1;
    q2=q2_1;
    q3=q3_1;
    
    %Opci�n 2
    if(q2>90 || q2<-90 || q3>90  || q3<-90)
        OP=2;
        q1=q1_1;
        q2=q2_2;
        q3=q3_2;
    end

    %Opci�n 3
    if(q1>90|| q1<-90 || q2>90 || q2<-90 || q3>90 || q3<-90) 
        OP=3;
        q1=q1_2;
        if (q1 > 180)
            q1=q1-360;
        end
        q2=q2_3;
        q3=q3_1;
    end

    %Opci�n 4
    if(q2>90 || q2<-90 || q3>90 || q3<-90)
        OP=4;
        q1=q1_2;
        if (q1 > 180)
            q1=q1-360;
        end
        q2=q2_4;
        q3=q3_2;
    end
    A01=dhg(q1,l1,0,90);
    A12=dhg(90+q2,0,l2,180);
    A23=dhg(q3,0,0,-90);
    A03=(A01*A12*A23);
    R03=(A03(1:3,1:3));
     
    if gdl==1
        R36=(inv(R03)*R);
        Com=R36*R03;
        q4=roundn(atan2d((R36(2,3)),R36(1,3)),-4);
        cosq5=sqrt(R36(2,3)^2+R36(1,3)^2);
        q5=roundn(atan2d(-(R36(3,3)),cosq5),-4);
        q6=roundn(atan2d(-(R36(3,2)),R36(3,1)),-4);
    elseif gdl==2
        R35=(inv(R03)*R);
        Com=R35*R03;
        q4=roundn(atan2d((R35(2,3)),R35(1,3)),-4);
        %q4=roundn(atan2d(R35(1,2),-(R35(2,2))),-4);
        q5=roundn(atan2d(-(R35(3,3)),R35(3,1)),-4);
        q6=0;
    elseif gdl==3
        q4=0;
        q5=0;
        q6=0;
    end
    
    if(q1>90 || q1<-90 || q2>90 || q2<-90 || q3>90 || q3<-90 || q4>90 || q4<-90 || q5>90 || q5<-90 || q6>90 || q6<=-90)
          set(handles.Estado, 'String', 'No se puede alcanzar ese punto');
          OP=5;
    else
        set(handles.Estado, 'String', '');  
    end 

    q=[q1 q2 q3 q4 q5 q6];
    q=roundn(q,-4);
%     assignin('base', 'qi', q); 
    
    %comprobaci�n   
    A1=dhg(q(1),l1,0,90);
    A2=dhg(q(2)+90,0,l2,180);
    A3=dhg(q(3),0,0,-90);
    A4=dhg(q(4),l3,0,-90);
    A5=dhg(q(5)-90,0,l4,-90);
    A6=dhg(q(6),0,0,0); 
    
    A04=A1*A2*A3*A4;
    Pm=A04(1:3,4);
    
    if gdl==1;
        T=A1*A2*A3*A4*A5*A6;
    else
        T=A1*A2*A3*A4*A5;
    end

    px=T(1,4);
    py=T(2,4);
    pz=T(3,4);
    R=T(1:3,1:3);
   
    cosB=sqrt(R(1,1)^2+R(2,1)^2);
    B=atan2d(-(R(3,1)),cosB);
  
    if abs(B)==90
        if B==90
            q(2)=q(2)+1;
        elseif B==-90
            q(2)=q(2)-1;
        end    
        A2=dhg(q(2)+90,0,l2,180);
        if gdl==1;
            T=A1*A2*A3*A4*A5*A6;
        else
            T=A1*A2*A3*A4*A5;
        end
        px=T(1,4);
        py=T(2,4);
        pz=T(3,4); 
        R=T(1:3,1:3); 
    end
    
    C=atan2d((R(3,2)),R(3,3));
    A=atan2d((R(2,1)),R(1,1));
    
    if gdl==3;  
        T=A1*A2*A3;  
        T=T*[0;0;(l3+l4);1];
        px=T(1);
        py=T(2);
        pz=T(3);
    end
OP;
    cor=[px py pz A B C];
    cor=roundn(cor,-4);
    tol=1.5; %Tolerancia en el movimiento del robot
    if dae==1
        if (car <= cor+tol)  
            if (car >= cor-tol) 
            set(handles.Estado, 'Visible', 'off');
            set(handles.Estado, 'String', '');
            assignin('base', 'qi', q); 
            else
            set(handles.Estado, 'Visible', 'on');
            set(handles.Estado, 'String', 'No se puede alcanzar ese punto exacto');
            OP=6;
            end
        else
            set(handles.Estado, 'Visible', 'on');
            set(handles.Estado, 'String', 'No se puede alcanzar ese punto exacto');
            OP=6;
        end
    elseif dae==0
        if (car(1:3) <= cor(1:3)+tol)  
            if (car(1:3) >= cor(1:3)-tol) 
            set(handles.Estado, 'Visible', 'off');
            set(handles.Estado, 'String', '');
            assignin('base', 'qi', q); 
            car(4:6)=cor(4:6);
            assignin('base', 'car', car);
            else
            set(handles.Estado, 'Visible', 'on');
            set(handles.Estado, 'String', 'No se puede alcanzar ese punto exacto');
            cor
            car
            OP=6;
            end
        else
            set(handles.Estado, 'Visible', 'on');
            set(handles.Estado, 'String', 'No se puede alcanzar ese punto exacto');
            cor
            car
            OP=6;
        end
    end
end
% catch
%       set(handles.Estado, 'Visible', 'on');
%       set(handles.Estado, 'String', 'No se puede alcanzar ese punto exacto');
%     OP=0
% end
end
