function TGato(handles)
cam=evalin('base','cam');
x=0;
while x<1
    GR=[0 0 0; 0 0 0; 0 0 0];
    GB=[0 0 0; 0 0 0; 0 0 0];
    x=x+1;
    marR=0;
    marB=0;
    cla(handles.axes2);  % hold off;
    img0=getsnapshot(cam);
    axes(handles.axes2),imshow(img0);
    
    imgW=rgb2gray(img0);
    bwW=im2bw(imgW, 0.13);               %Binarizacion de imagen    
    bwW=medfilt2(bwW);                     %Aplicacion de filtro
    bwW=imopen(bwW,strel('disk',10));          %Apertura de la imagen     
    bwW=bwareaopen(bwW,35000);              %elimina area menor a 3500px
    bwW=imfill(bwW,'holes');
    [L, N]=bwlabel(bwW);
    prop=regionprops(L, 'all');
 
    for n=1:N
        rectangle('Position',prop(n).BoundingBox,'EdgeColor','w','LineWidth',2); 
        x1=prop(n).BoundingBox(1);
        y1=prop(n).BoundingBox(2);
        dx=prop(n).BoundingBox(3);
        dy=prop(n).BoundingBox(4);
        x2=dx+x1;
        y2=dy+y1;
        lim1=(dx/3)+x1;
        lim2=((2*dx)/3)+x1;
        lim3=(dy/3)+y1;
        lim4=((2*dy)/3)+y1;
        line([lim1 lim1], [y1 y2],'Color','green','LineWidth',2);
        line([lim2 lim2], [y1 y2],'Color','green','LineWidth',2);
        line([x1 x2], [lim3 lim3],'Color','green','LineWidth',2);
        line([x1 x2], [lim4 lim4],'Color','green','LineWidth',2);
        hold on;
    end
    
    imgR=imsubtract(img0(:,:,1),rgb2gray(img0));
    bwR=im2bw(imgR, 0.13);                          %Binarizacion de imagen
    bwR=medfilt2(bwR);                              %Aplicacion de filtro
    bwR=imopen(bwR,strel('disk',10));               %Apertura de la imagen
    bwR=bwareaopen(bwR,200);                        %elimina area menor a 200px
    bwR=imfill(bwR,'holes');
    [L, NR]=bwlabel(bwR);
    prop=regionprops(L, 'all');
 
    for n=1:NR
        cR=round(prop(n).Centroid); 
        if cR(1)>x1 && cR(1)<lim1
            if cR(2)>y1 && cR(2)<lim3
                GR(1,1)=1;
                 set(handles.G11,'string','O'); 
                 set(handles.G11,'Foregroundcolor',[1 0 0]);
            elseif cR(2)>lim3 && cR(2)<lim4
                GR(2,1)=1;
                set(handles.G21,'string','O'); 
                set(handles.G21,'Foregroundcolor',[1 0 0]);
            elseif cR(2)>lim4 && cR(2)<y2
                GR(3,1)=1;
                set(handles.G31,'string','O'); 
                set(handles.G31,'Foregroundcolor',[1 0 0]);
            end
            marR=1;
        elseif cR(1)>lim1 && cR(1)<lim2
            if cR(2)>y1 && cR(2)<lim3
                GR(1,2)=1;
                set(handles.G12,'string','O'); 
                set(handles.G12,'Foregroundcolor',[1 0 0]);
            elseif cR(2)>lim3 && cR(2)<lim4
                GR(2,2)=1;
                set(handles.G22,'string','O'); 
                set(handles.G22,'Foregroundcolor',[1 0 0]);
            elseif cR(2)>lim4 && cR(2)<y2
                GR(3,2)=1;
                set(handles.G32,'string','O'); 
                set(handles.G32,'Foregroundcolor',[1 0 0]);
            end
            marR=1;
         elseif cR(1)>lim2 && cR(1)<x2
            if cR(2)>y1 && cR(2)<lim3
                GR(1,3)=1;
                set(handles.G13,'string','O'); 
                set(handles.G13,'Foregroundcolor',[1 0 0]);
            elseif cR(2)>lim3 && cR(2)<lim4
                GR(2,3)=1;
                set(handles.G23,'string','O'); 
                set(handles.G23,'Foregroundcolor',[1 0 0]);
            elseif cR(2)>lim4 && cR(2)<y2
                GR(3,3)=1;
                set(handles.G33,'string','O'); 
                set(handles.G33,'Foregroundcolor',[1 0 0]);
            end
            marR=1;
        end
        if marR==1
            rectangle('Position',prop(n).BoundingBox,'EdgeColor','r','LineWidth',2); 
            text(cR(1)-20,cR(2),strcat('O'),'Color','red','Fontsize',40); 
            hold on;
        end
    end
    
    imgB=imsubtract(img0(:,:,3),rgb2gray(img0));
    bwB=im2bw(imgB, 0.13);                           %Binarizacion de imagen
    bwB=medfilt2(bwB);                                 %Aplicacion de filtro
    bwB=imopen(bwB,strel('disk',10));                   %Apertura de la imagen
    bwB=bwareaopen(bwB,200);                            %elimina area menor a 200px
    bwB=imfill(bwB,'holes');
    [L, NB]=bwlabel(bwB);
    prop=regionprops(L, 'all');
   
    for n=1:NB
        cB=round(prop(n).Centroid); 
        if cB(1)>x1 && cB(1)<lim1
            if cB(2)>y1 && cB(2)<lim3
                GB(1,1)=1;
                set(handles.G11,'string','X'); 
                set(handles.G11,'Foregroundcolor',[0 0 1]);
            elseif cB(2)>lim3 && cB(2)<lim4
                GB(2,1)=1;
                set(handles.G21,'string','X'); 
                set(handles.G21,'Foregroundcolor',[0 0 1]);
            elseif cB(2)>lim4 && cB(2)<y2
                GB(3,1)=1;
                set(handles.G31,'string','X'); 
                set(handles.G31,'Foregroundcolor',[0 0 1]);
            end
            marB=1;
        elseif cB(1)>lim1 && cB(1)<lim2
            if cB(2)>y1 && cB(2)<lim3
                GB(1,2)=1;
                set(handles.G12,'string','X'); 
                set(handles.G12,'Foregroundcolor',[0 0 1]);
            elseif cB(2)>lim3 && cB(2)<lim4
                GB(2,2)=1;
                set(handles.G22,'string','X'); 
                set(handles.G22,'Foregroundcolor',[0 0 1]);
            elseif cB(2)>lim4 && cB(2)<y2
                GB(3,2)=1;
                set(handles.G32,'string','X'); 
                set(handles.G32,'Foregroundcolor',[0 0 1]);
            end
            marB=1;
         elseif cB(1)>lim2 && cB(1)<x2
            if cB(2)>y1 && cB(2)<lim3
                GB(1,3)=1;
                set(handles.G13,'string','X'); 
                set(handles.G13,'Foregroundcolor',[0 0 1]);
            elseif cB(2)>lim3 && cB(2)<lim4
                GB(2,3)=1;
                set(handles.G23,'string','X'); 
                set(handles.G23,'Foregroundcolor',[0 0 1]);
            elseif cB(2)>lim4 && cB(2)<y2
                GB(3,3)=1;
                set(handles.G33,'string','X'); 
                set(handles.G33,'Foregroundcolor',[0 0 1]);
            end
            marB=1;
        end   
        if marB==1
            rectangle('Position',prop(n).BoundingBox,'EdgeColor','b','LineWidth',2); 
            text(cB(1)-15,cB(2),'X','Color','blue','Fontsize',40);
            hold on;
        end
    end  
    
   G=GR+GB
   GR
   GB
   
   pause(0.001);
end



camRes = get(cam, 'VideoResolution');
imWidth = camRes(1);
imHeight = camRes(2);
nBands = get(cam, 'NumberOfBands');
hImage = image(zeros(imHeight, imWidth, nBands),'Parent',handles.axes2 ); hold on;
preview(cam,hImage);
start(cam);
axes(handles.axes1);

az=get(handles.Azul, 'value');
ro=get(handles.Rojo, 'value');
modo1=get(handles.Azar, 'value');
modo2=get(handles.Estrategia, 'value');
e=0;
dis=[];
Gn=reshape(G.',[1,9]);
for i=1:9
    if Gn(i)==0
        dis=[dis i];
    end
end
dis;

%Modo azar
if modo1==1
    r=randi([1 numel(dis)]);
    e=dis(r);
end

%Modo estrategia
if modo2==1
    GRn=reshape(GR.',[1,9]);
    GBn=reshape(GB.',[1,9]);
    if az==1
        GC=GRn;
        GY=GBn;
    end
    if ro==1
        GC=GBn;
        GY=GRn;
    end
    ele=numel(dis);
    
    switch ele
        case 9 %Empiezo yo con G5 (Contrincante:0 Yo:0)
            e=5;
        case 8 %No empece yo (Contrincante:1 Yo:0)
           if ismember(5,dis)==1 %Si esta disponible el G5 lo elijo
              e=5;
           else %Si no esta disponible el G5 escojo una esquina al azar
               r=randi([1 4]);
               op=[1,3,7,9];
               e=op(r);
           end
        case 7 %Empece yo (Contrincante:1 Yo:1:en el G5)
            %Elijo mi lugar bloqueando futuros movimientos del contrincante
            %y posicionandome en esquina
            if (GC(1)==1 || GC(9)==1)
               op=[3,7];
            elseif GC(2)==1
                op=[1,3];
            elseif (GC(3)==1 || GC(7)==1)
                op=[1,9];
            elseif GC(4)==1
                op=[1,7]; 
            elseif GC(6)==1
                op=[3,9]; 
            elseif GC(8)==1
                op=[7,9];             
            end
            r=randi([1 2]);
            e=op(r);
        case 6 %No empece (Contrincante:2 Yo:1: en el G5 o en una esquina)
           %Primero defensa, Si estoy en G5 busco posibilidad de gane del contrincante en extremos (en una misma fila o columna):
           if GY(5)==1
               if GC(1)==1 
                    if GC(2)==1
                        e=3;                      
                    elseif GC(3)==1
                        e=2;
                    elseif GC(4)==1
                        e=7;
                    elseif GC(7)==1
                        e=4;
                    end
                elseif GC(9)==1 
                    if GC(3)==1
                        e=6;
                    elseif GC(6)==1
                        e=3;
                    elseif GC(7)==1
                        e=8;
                    elseif GC(8)==1
                        e=7;
                    end
                elseif GC(3)==1 
                    if GC(2)==1
                        e=1;
                    elseif GC(6)==1
                        e=9;
                    end
                elseif GC(7)==1 
                    if GC(4)==1
                        e=1;
                    elseif GC(8)==1
                        e=9;
                    end
               end
           end
           % Si no estoy en G5 (es porque el contrincante está) y yo en una esquina entonces
           %busco posibilidad de gane del contrincante que involucre G5 y lo tapo si no está tapado:
           if GY(5)==0 
                if GC(1)==1
                    if ismember(9,dis)==1 %esta disponible el 9
                        e=9;
                    end                   
                elseif GC(2)==1
                    e=8;
                elseif GC(3)==1
                    if ismember(7,dis)==1 %esta disponible el 7
                        e=7;
                    end  
                elseif GC(4)==1
                    e=6;
                elseif GC(6)==1
                    e=4;
                elseif GC(7)==1
                    if ismember(3,dis)==1 %esta disponible el 3
                        e=3;
                    end  
                elseif GC(8)==1
                    e=2;
                elseif GC(9)==1
                    if ismember(1,dis)==1 %esta disponible el 1
                        e=1;
                    end
                end
           end
            %Si no habia posibilidad de gane del contrincante hago estrategia de ataque
            if e==0
                if GY(5)==0 %Si el contrincante está en G5 y yo en una esquina y se puso donde le tapaba un gane me pongo en una de las esquinas disponibles
                    op=[1,3,7,9];
                    ED = intersect(dis,op);
                    r=randi([1 numel(ED)]);
                    e=ED(r);
                else %Si yo estoy en G5 y no tiene ganes posibles (no tiene dos en una misma fila o columna libre), me pongo en una esquina que tape 1 o 2 de sus piezas
                     if (GC(2)==1||GC(3)==1)
                        if (GC(4)==1||GC(7)==1)
                            e=1;
                        end
                     end
                     if (GC(1)==1||GC(2)==1)
                        if (GC(6)==1||GC(9)==1)
                            e=3;
                        end
                     end
                    if (GC(1)==1||GC(4)==1)
                        if (GC(8)==1||GC(9)==1)
                            e=7;
                        end
                    end
                    if (GC(3)==1||GC(6)==1)
                        if (GC(7)==1||GC(8)==1)
                            e=9;
                        end
                    end
                    if (GC(4)==1 && GC(6)==1) %tiene sus 2 piezas aqui y mi pieza está en el centro por lo tanto todas las esquinas estan disponibles
                        r=randi([1 4]);
                        op=[1,3,7,9];
                        e=op(r);
                    end
                    if (GC(2)==1 && GC(8)==1)
                        r=randi([1 4]);
                        op=[1,3,7,9];
                        e=op(r);
                    end
                                         if (GC(1)==1)
                        if (GC(9)==1)
                            r=randi([1 4]);
                            op=[2,4,6,8];
                            e=op(r);
                        end
                     end
                     if (GC(3)==1)
                        if (GC(7)==1)
                            r=randi([1 4]);
                            op=[2,4,6,8];
                            e=op(r);
                        end
                     end
                end
            end
        case 5 %Empece yo (Contrincante:2 Yo:2:en el G5 y en alguna esquina)
            %Busco gane si hay posibilidad (En realidad yo no estaria en
            %medios pero lo dejo por si sirve para otros casos)
            if GY(1)==1
              if ismember(9,dis)==1 %esta disponible el 9
                e=9;
              end
            elseif GY(2)==1 
              if ismember(8,dis)==1 %esta disponible el 8
                e=8;
              end
            elseif GY(3)==1
              if ismember(7,dis)==1 %esta disponible el 7
                e=7;
              end
            elseif GY(4)==1
              if ismember(6,dis)==1 %esta disponible el 6
                e=6;
              end
            elseif GY(6)==1
              if ismember(4,dis)==1 %esta disponible el 4
                e=4;
              end          
            elseif GY(7)==1
              if ismember(3,dis)==1 %esta disponible el 3
                e=3;
              end          
            elseif GY(8)==1
              if ismember(2,dis)==1 %esta disponible el 2
                e=2;
              end          
            elseif GY(9)==1
              if ismember(1,dis)==1 %esta disponible el 1
                e=1;
              end
            end
            if e==0 %Si no hay posibilidad de gane 
            % busco si el otro tiene posibilidad de gane (en los extremos) para taparlo
            % si llegamos a este punto es porque me tapo el gane (en diagonal) y por lo tanto si tuviera opc de gane es estando en dos extremos 
               if GC(1)==1 
                    if GC(3)==1
                        e=2;
                    elseif GC(7)==1
                        e=4;
                    end
                elseif GC(9)==1 
                    if GC(3)==1
                        e=6;
                    elseif GC(7)==1
                        e=8;
                    end
               end
            % si no tiene posibilidad de gane inmediata escojo mi lugar con
            % un poco de estrategia (lugar más optimo)
                if GC(2)==1
                    if GY(1)==1
                        e=7;
                    elseif GY(3)==1
                        e=9;
                    end
                elseif GC(4)==1
                    if GY(1)==1
                        e=3;
                    elseif GY(7)==1
                        e=9;
                    end
                elseif GC(6)==1
                    if GY(3)==1
                        e=1;
                    elseif GY(9)==1
                        e=7;
                    end
                elseif GC(8)==1
                    if GY(7)==1
                        e=1;
                    elseif GY(9)==1
                        e=3;
                    end
                end
            else %Si hubo posibilidad de gane muestro mensaje
                set(handles.Resultado,'string','¡Gane!');
            end
        case 4 %No empece (Contrincante:3 Yo:2: en el G5 o en una esquina y en una esquina o medios) AAAAAAAAAA
            %Si estoy en G5 busco un gane mio que lo involucre
            if GY(5)==1
                if GY(1)==1
                  if ismember(9,dis)==1 %esta disponible el 9
                    e=9;
                  end
                end
                if GY(2)==1
                  if ismember(8,dis)==1 %esta disponible el 8
                    e=8;
                  end
                end
                if GY(3)==1
                  if ismember(7,dis)==1 %esta disponible el 7
                    e=7;
                  end
                end
                if GY(4)==1
                  if ismember(6,dis)==1 %esta disponible el 6
                    e=6;
                  end
                end
                if GY(6)==1
                  if ismember(4,dis)==1 %esta disponible el 4
                    e=4;
                  end       
                end
                if GY(7)==1
                  if ismember(3,dis)==1 %esta disponible el 3
                    e=3;
                  end  
                end
                if GY(8)==1
                  if ismember(2,dis)==1 %esta disponible el 2
                    e=2;
                  end   
                end
                if GY(9)==1
                  if ismember(1,dis)==1 %esta disponible el 1
                    e=1;
                  end
                end
            end
            %Si no estoy en G5 busco gane en extremos
            if GY(5)==0
                if GY(1)==1 
                    if GY(2)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end
                    elseif GY(3)==1
                        if ismember(2,dis)==1 %esta disponible el 2
                            e=2;
                        end
                    elseif GY(4)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end
                    elseif GY(7)==1
                        if ismember(4,dis)==1 %esta disponible el 4
                            e=4;
                        end
                    end
                elseif GY(9)==1 
                    if GY(3)==1
                        if ismember(6,dis)==1 %esta disponible el 6
                            e=6;
                        end
                    elseif GY(6)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end
                    elseif GY(7)==1
                        if ismember(8,dis)==1 %esta disponible el 8
                            e=8;
                        end
                    elseif GY(8)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end
                    end
                elseif GY(3)==1 
                    if GY(2)==1
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end
                    elseif GY(6)==1
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end
                    end
                elseif GY(7)==1 
                    if GY(4)==1
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end
                    elseif GY(8)==1
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end
                    end
                end
            end
            if e==0 %Si no hay posibilidad de gane mia, intento bloquear gane del contrincante
            %Si estoy en G5 busco posibilidad de gane del contrincante en extremos (en una misma fila o columna) y lo bloqueo:
               if GY(5)==1
                   if GC(1)==1 
                        if GC(2)==1
                            if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                            end
                        end
                        if GC(3)==1
                            if ismember(2,dis)==1 %esta disponible el 2
                            e=2;
                            end
                        end
                        if GC(4)==1
                            if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                            end
                        end
                        if GC(7)==1
                            if ismember(4,dis)==1 %esta disponible el 4
                            e=4;
                            end
                        end
                    end
                    if GC(9)==1 
                        if GC(3)==1
                            if ismember(6,dis)==1 %esta disponible el 6
                            e=6;
                            end
                        end
                        if GC(6)==1
                            if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                            end
                        end
                        if GC(7)==1
                            if ismember(8,dis)==1 %esta disponible el 8
                            e=8;
                            end
                        end
                        if GC(8)==1
                            if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                            end
                        end
                    end
                    if GC(3)==1 
                        if GC(2)==1
                            if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                            end
                        end
                        if GC(6)==1
                            if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                            end
                        end
                    end
                    if GC(7)==1 
                        if GC(4)==1
                            if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                            end
                        end
                        if GC(8)==1
                            if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                            end
                        end
                   end
               end
               % Si el contrincante está en G5 busco posibilidad de gane del contrincante que involucre G5 y lo tapo si no está tapado:
               if GY(5)==0 
                    if GC(1)==1
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end    
                    end
                    if GC(2)==1
                        if ismember(8,dis)==1 %esta disponible el 8
                            e=8;
                        end  
                    end
                    if GC(3)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end  
                    end
                    if GC(4)==1
                        if ismember(6,dis)==1 %esta disponible el 6
                            e=6;
                        end  
                    end
                    if GC(6)==1
                        if ismember(4,dis)==1 %esta disponible el 4
                            e=4;
                        end  
                    end
                    if GC(7)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end  
                    end
                    if GC(8)==1
                        if ismember(2,dis)==1 %esta disponible el 2
                            e=2;
                        end  
                    end
                    if GC(9)==1
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end
                    end
               end
            else %Si hubo posibilidad de gane mia escribo
                set(handles.Resultado,'string','¡Gane!');     
            end
            if e==0 %Si no hubo posibilidad de gane mia ni de el escojo lugar con algo de estrategia
               %Elijo una esquina
               op=[1,3,7,9];
               ED = intersect(dis,op);
               if numel(ED)>0
                    r=randi([1 numel(ED)]);
                    e=ED(r);
                else %Si no esta disponible ninguna esquina
                    r=randi([1 numel(dis)]);
                    e=dis(r);
                end
            end              
        case 3 %Empece yo (Contrincante:3 Yo:3:en el G5, en esquina y en esquina o medio)
            %Busco gane si hay posibilidad (involucrando G5)
            if GY(1)==1 
              if ismember(9,dis)==1 %esta disponible el 9
                e=9;
              end
            end
            if GY(2)==1
              if ismember(8,dis)==1 %esta disponible el 8
                e=8;
              end
            end
            if GY(3)==1
              if ismember(7,dis)==1 %esta disponible el 7
                e=7;
              end
            end
            if GY(4)==1
              if ismember(6,dis)==1 %esta disponible el 6
                e=6;
              end
            end
            if GY(6)==1
              if ismember(4,dis)==1 %esta disponible el 4
                e=4;
              end     
            end
            if GY(7)==1
              if ismember(3,dis)==1 %esta disponible el 3
                e=3;
              end  
            end
            if GY(8)==1
              if ismember(2,dis)==1 %esta disponible el 2
                e=2;
              end 
            end
            if GY(9)==1
              if ismember(1,dis)==1 %esta disponible el 1
                e=1;
              end
            end
            if e==0  %Si no hay posibilidad de gane involucrando G5 busco en extremos
                if GY(1)==1 
                    if GY(2)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end
                    elseif GY(3)==1
                        if ismember(2,dis)==1 %esta disponible el 2
                            e=2;
                        end
                    elseif GY(4)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end
                    elseif GY(7)==1
                        if ismember(4,dis)==1 %esta disponible el 4
                            e=4;
                        end
                    end
                elseif GY(9)==1 
                    if GY(3)==1 
                        if ismember(6,dis)==1 %esta disponible el 6
                            e=6;
                        end
                    elseif GY(6)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end                   
                    elseif GY(7)==1                       
                        if ismember(8,dis)==1 %esta disponible el 8
                            e=8;
                        end
                    elseif GY(8)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end                       
                    end
                elseif GY(3)==1 
                    if GY(2)==1                        
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end                        
                    elseif GY(6)==1                        
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end      
                    end
                elseif GY(7)==1 
                    if GY(4)==1                        
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end      
                    elseif GY(8)==1                     
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end      
                    end
                end
            else %Si hubo gane involucrando G5 muestro mensaje
                set(handles.Resultado,'string','¡Gane!');
            end
            if e==0 %Si no hubo gane en extremos escojo posición al azar pues me parece que igual ya nadie gana
                r=randi([1 numel(dis)]);
                e=dis(r);
            else %Si hubo gane en extremos muestro mensaje
                set(handles.Resultado,'string','¡Gane!');
            end
        case 2 %No empece (Contrincante:4 Yo:3: en el G5 o en una esquina, en una esquina o medios y en una esquina o medios)
            %Si estoy en G5 busco un gane mio que lo involucre
            if GY(5)==1
                if GY(1)==1
                  if ismember(9,dis)==1 %esta disponible el 9
                    e=9;
                  end
                end
                if GY(2)==1
                  if ismember(8,dis)==1 %esta disponible el 8
                    e=8;
                  end
                end
                if GY(3)==1
                  if ismember(7,dis)==1 %esta disponible el 7
                    e=7;
                  end
                end
                if GY(4)==1
                  if ismember(6,dis)==1 %esta disponible el 6
                    e=6;
                  end
                end
                if GY(6)==1
                  if ismember(4,dis)==1 %esta disponible el 4
                    e=4;
                  end  
                end
                if GY(7)==1
                  if ismember(3,dis)==1 %esta disponible el 3
                    e=3;
                  end   
                end
                if GY(8)==1
                  if ismember(2,dis)==1 %esta disponible el 2
                    e=2;
                  end  
                end
                if GY(9)==1
                  if ismember(1,dis)==1 %esta disponible el 1
                    e=1;
                  end
                end
            end
            %Si no estoy en G5 busco gane en extremos
            if GY(5)==0
                if GY(1)==1 
                    if GY(2)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end
                    end
                    if GY(3)==1
                        if ismember(2,dis)==1 %esta disponible el 2
                            e=2;
                        end
                    end
                    if GY(4)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end
                    end
                    if GY(7)==1
                        if ismember(4,dis)==1 %esta disponible el 4
                            e=4;
                        end
                    end
                end
                if GY(9)==1 
                    if GY(3)==1
                        if ismember(6,dis)==1 %esta disponible el 6
                            e=6;
                        end
                    end
                    if GY(6)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end
                    end
                    if GY(7)==1
                        if ismember(8,dis)==1 %esta disponible el 8
                            e=8;
                        end
                    end
                    if GY(8)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end
                    end
                end
                if GY(3)==1 
                    if GY(2)==1
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end
                    end
                    if GY(6)==1
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end
                    end
                end
                if GY(7)==1 
                    if GY(4)==1
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end
                    end
                    if GY(8)==1
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end
                    end
                end
            end
            if e==0 %Si no hay posibilidad de gane mia, intento bloquear gane del contrincante
            %Si estoy en G5 busco posibilidad de gane del contrincante en extremos (en una misma fila o columna) y lo bloqueo:
               if GY(5)==1
                   if GC(1)==1 
                        if GC(2)==1
                            if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                            end
                        end
                        if GC(3)==1
                            if ismember(2,dis)==1 %esta disponible el 2
                            e=2;
                            end
                        end
                        if GC(4)==1
                            if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                            end
                        end
                        if GC(7)==1
                            if ismember(4,dis)==1 %esta disponible el 4
                            e=4;
                            end
                        end
                   end
                   if GC(9)==1 
                        if GC(3)==1
                            if ismember(6,dis)==1 %esta disponible el 6
                            e=6;
                            end
                        end
                        if GC(6)==1
                            if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                            end
                        end
                        if GC(7)==1
                            if ismember(8,dis)==1 %esta disponible el 8
                            e=8;
                            end
                        end
                        if GC(8)==1
                            if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                            end
                        end
                   end
                   if GC(3)==1 
                        if GC(2)==1
                            if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                            end
                        end
                        if GC(6)==1
                            if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                            end
                        end
                   end
                   if GC(7)==1 
                        if GC(4)==1
                            if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                            end
                        end
                        if GC(8)==1
                            if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                            end
                        end
                   end
               end
               % Si el contrincante está en G5 busco posibilidad de gane del contrincante que involucre G5 y lo tapo si no está tapado:
               if GY(5)==0 
                    if GC(1)==1
                        if ismember(9,dis)==1 %esta disponible el 9
                            e=9;
                        end      
                    end
                    if GC(2)==1
                        if ismember(8,dis)==1 %esta disponible el 8
                            e=8;
                        end  
                    end
                    if GC(3)==1
                        if ismember(7,dis)==1 %esta disponible el 7
                            e=7;
                        end  
                    end
                    if GC(4)==1
                        if ismember(6,dis)==1 %esta disponible el 6
                            e=6;
                        end  
                    end
                    if GC(6)==1
                        if ismember(4,dis)==1 %esta disponible el 4
                            e=4;
                        end  
                    end
                    if GC(7)==1
                        if ismember(3,dis)==1 %esta disponible el 3
                            e=3;
                        end  
                    end
                    if GC(8)==1
                        if ismember(2,dis)==1 %esta disponible el 2
                            e=2;
                        end  
                    end
                    if GC(9)==1
                        if ismember(1,dis)==1 %esta disponible el 1
                            e=1;
                        end
                    end
               end
            else %Si hubo posibilidad de gane mia escribo
                set(handles.Resultado,'string','¡Gane!');     
            end
            if e==0 %Si no hubo posibilidad de gane mia ni de el escojo lugar al azar pues me parece que ya nadie gana
                r=randi([1 numel(dis)]);
                e=dis(r);
            end
        case 1 %Empece yo (Contrincante:4 Yo:4:en el G5, en esquina, en esquina o medio y en esquina o medio)
            %Escojo al azar, ya nadie gana
            r=randi([1 numel(dis)]);
            e=dis(r);
            set(handles.Resultado,'string','Nadie gana');
    end
end

if az==1
    Tomar=load('TomarAzul.mat');
    cr='X';
    cl=[0 0 1];
end
if ro==1
   Tomar=load('TomarRojo.mat');
   cr='O';
   cl=[1 0 0];
end
Tomar=Tomar.A;

switch e
    case 1
        Dejar=load('G11.mat'); %G1
        set(handles.G11,'string',cr); 
        set(handles.G11,'Foregroundcolor',cl);
    case 2
        Dejar=load('G12.mat'); %G2
        set(handles.G12,'string',cr); 
        set(handles.G12,'Foregroundcolor',cl);
    case 3
        Dejar=load('G13.mat'); %G3
        set(handles.G13,'string',cr); 
        set(handles.G13,'Foregroundcolor',cl);
    case 4
        Dejar=load('G21.mat'); %G4
        set(handles.G21,'string',cr); 
        set(handles.G21,'Foregroundcolor',cl);
    case 5
        Dejar=load('G22.mat'); %G5
        set(handles.G22,'string',cr); 
        set(handles.G22,'Foregroundcolor',cl);
    case 6
        Dejar=load('G23.mat'); %G6
        set(handles.G23,'string',cr); 
        set(handles.G23,'Foregroundcolor',cl);
    case 7
        Dejar=load('G31.mat'); %G7
        set(handles.G31,'string',cr); 
        set(handles.G31,'Foregroundcolor',cl);
    case 8
        Dejar=load('G32.mat'); %G8
        set(handles.G32,'string',cr); 
        set(handles.G32,'Foregroundcolor',cl);
    case 9
        Dejar=load('G33.mat'); %G9
        set(handles.G33,'string',cr); 
        set(handles.G33,'Foregroundcolor',cl);
    otherwise
        A=[];
end
Dejar=Dejar.A;
Rutina=[Tomar;Dejar];

% if az==1
%     switch e
%         case 1
%             A=load('G11A.mat'); %G1
%             set(handles.G11,'string',cr); 
%             set(handles.G11,'Foregroundcolor',cl);
%         case 2
%             A=load('G12A.mat'); %G2
%             set(handles.G12,'string',cr); 
%             set(handles.G12,'Foregroundcolor',cl);
%         case 3
%             A=load('G13A.mat'); %G3
%             set(handles.G13,'string',cr); 
%             set(handles.G13,'Foregroundcolor',cl);
%         case 4
%             A=load('G21A.mat'); %G4
%             set(handles.G21,'string',cr); 
%             set(handles.G21,'Foregroundcolor',cl);
%         case 5
%             A=load('G22A.mat'); %G5
%             set(handles.G22,'string',cr); 
%             set(handles.G22,'Foregroundcolor',cl);
%         case 6
%             A=load('G23A.mat'); %G6
%             set(handles.G23,'string',cr); 
%             set(handles.G23,'Foregroundcolor',cl);
%         case 7
%             A=load('G31A.mat'); %G7
%             set(handles.G31,'string',cr); 
%             set(handles.G31,'Foregroundcolor',cl);
%         case 8
%             A=load('G32A.mat'); %G8
%             set(handles.G32,'string',cr); 
%             set(handles.G32,'Foregroundcolor',cl);
%         case 9
%             A=load('G33A.mat'); %G9
%             set(handles.G33,'string',cr); 
%             set(handles.G33,'Foregroundcolor',cl);
%         otherwise
%             A=[];
%     end
% end
% if ro==1
%         switch e
%         case 1
%             A=load('G11R.mat'); %G1
%             set(handles.G11,'string',cr); 
%             set(handles.G11,'Foregroundcolor',cl);
%         case 2
%             A=load('G12R.mat'); %G2
%             set(handles.G12,'string',cr); 
%             set(handles.G12,'Foregroundcolor',cl);
%         case 3
%             A=load('G13R.mat'); %G3
%             set(handles.G13,'string',cr); 
%             set(handles.G13,'Foregroundcolor',cl);
%         case 4
%             A=load('G21R.mat'); %G4
%             set(handles.G21,'string',cr); 
%             set(handles.G21,'Foregroundcolor',cl);
%         case 5
%             A=load('G22R.mat'); %G5
%             set(handles.G22,'string',cr); 
%             set(handles.G22,'Foregroundcolor',cl);
%         case 6
%             A=load('G23R.mat'); %G6
%             set(handles.G23,'string',cr); 
%             set(handles.G23,'Foregroundcolor',cl);
%         case 7
%             A=load('G31R.mat'); %G7
%             set(handles.G31,'string',cr); 
%             set(handles.G31,'Foregroundcolor',cl);
%         case 8
%             A=load('G32R.mat'); %G8
%             set(handles.G32,'string',cr); 
%             set(handles.G32,'Foregroundcolor',cl);
%         case 9
%             A=load('G33R.mat'); %G9
%             set(handles.G33,'string',cr); 
%             set(handles.G33,'Foregroundcolor',cl);
%         otherwise
%             A=[];
%     end
% end

% Rutina=A.A;
assignin('base', 'A', Rutina);
set(handles.Rutinat,'data',Rutina)
end