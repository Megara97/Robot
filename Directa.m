function Directa(handles)
coor=get(handles.Coordenadas, 'value');
gdl=get(handles.GDL, 'value');
m2=get(handles.Trayectoria, 'value');
m3=get(handles.Experto, 'value');
Aux=evalin('base','Aux');
R=evalin('base','R');
if coor==1 || m2==1 || R==0
    
%     car=evalin('base','car');
    if Aux==1
        q=evalin('base','qaux');
    else
        q=evalin('base','qi');
    end
    
    l1=10;
    l2=12;
    l3=12;
    l4=7;
    
    A1=dhg(q(1),l1,0,90);
    A2=dhg(q(2)+90,0,l2,180);
    A3=dhg(q(3), 0, 0, -90);
    A4=dhg(q(4),l3,0,-90);
    A5=dhg(q(5)-90,0,l4,-90);
    A6=dhg(q(6),0,0,0); 

    if gdl==1;
        T=A1*A2*A3*A4*A5*A6;
    else
        T=A1*A2*A3*A4*A5;
    end

    px=T(1,4);
    py=T(2,4);
    pz=T(3,4);
    
    R=T(1:3,1:3);

    s=q(2)-q(3)+q(5);
    h=q(1)+q(6);
    
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
        R=T(1:3,1:3); 
    end
    
    C=atan2d((R(3,2)),R(3,3));
    A=atan2d((R(2,1)),R(1,1));

%     if abs(A)==90 && (B>90 && B<270) || abs(A)==90 && (B<-90 && B>-270)
%         A=-A;
%     end
%     if abs(C)==90 && (B>90 && B<270) || abs(C)==90 && (B<-90 && B>-270)
%         C=-C;
%     end           
    
    if gdl==3;  
        T=A1*A2*A3;  
        T=T*[0;0;(l3+l4);1];
        px=T(1);
        py=T(2);
        pz=T(3);
    end
    
    car=[px py pz A B C];
    car=roundn(car,-4);
    
    if Aux==1
        assignin('base', 'caraux', car); 
    else
        assignin('base', 'car', car); 
    end
end
end
