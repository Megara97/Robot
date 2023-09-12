function varargout = PTR_MTMM12(varargin)
% PTR_MTMM12 MATLAB code for PTR_MTMM12.fig
%      PTR_MTMM12, by itself, creates a new PTR_MTMM12 or raises the existing
%      singleton*.
%
%      H = PTR_MTMM12 returns the handle to a new PTR_MTMM12 or the handle to
%      the existing singleton*.
%
%      PTR_MTMM12('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PTR_MTMM12.M with the given input arguments.
%
%      PTR_MTMM12('Property','Value',...) creates a new PTR_MTMM12 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PTR_MTMM12_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PTR_MTMM12_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PTR_MTMM12

% Last Modified by GUIDE v2.5 28-Nov-2022 00:22:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PTR_MTMM12_OpeningFcn, ...
                   'gui_OutputFcn',  @PTR_MTMM12_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PTR_MTMM12 is made visible.
function PTR_MTMM12_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PTR_MTMM12 (see VARARGIN)

% Choose default command line output for PTR_MTMM12
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PTR_MTMM12 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PTR_MTMM12_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% set(handles.Gripper, 'visible', 'off');
g=120;
assignin('base', 'g', g); 
set(handles.Pgato,'visible','off');
Home_Callback(hObject, eventdata, handles);
Modo_SelectionChangeFcn(hObject, eventdata, handles);
%Parte opcional
set(handles.Vel, 'value', 50);
Vel_Callback(hObject, eventdata, handles);
set(handles.GDL, 'value', 2);
GDL_Callback(hObject, eventdata, handles);
%


% --- Executes on selection change in Coordenadas.
function Coordenadas_Callback(hObject, eventdata, handles)
% hObject    handle to Coordenadas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Coordenadas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Coordenadas
coor=get(hObject,'Value'); % 1 Articulares, 2 Cartesianas
qi=evalin('base','qi');
GDL_Callback(hObject, eventdata, handles);
if coor==1
    set(handles.text1,'string','q1');
    set(handles.text2,'string','q2');
    set(handles.text3,'string','q3');
    set(handles.text4,'string','q4');
    set(handles.text5,'string','q5');
    set(handles.text6,'string','q6');
    set(handles.text13,'string','q1');
    set(handles.text14,'string','q2');
    set(handles.text15,'string','q3');
    set(handles.text16,'string','q4');
    set(handles.text17,'string','q5');
    set(handles.text18,'string','q6');
    set(handles.text50,'string','q1');
    set(handles.text51,'string','q2');
    set(handles.text52,'string','q3');
    set(handles.text53,'string','q4');
    set(handles.text54,'string','q5');
    set(handles.text55,'string','q6');
    set(handles.edit1,'string',[num2str(qi(1)) '°']);
    set(handles.edit2,'string',[num2str(qi(2)) '°']);
    set(handles.edit3,'string',[num2str(qi(3)) '°']);
    set(handles.edit4,'string',[num2str(qi(4)) '°']);
    set(handles.edit5,'string',[num2str(qi(5)) '°']);
    set(handles.edit6,'string',[num2str(qi(6)) '°']);
    set(handles.DAE, 'visible', 'off');
elseif coor==2
    set(handles.text1,'string','x');
    set(handles.text2,'string','y');
    set(handles.text3,'string','z');
    set(handles.text4,'string','A');
    set(handles.text5,'string','B');
    set(handles.text6,'string','C');
    set(handles.text13,'string','x');
    set(handles.text14,'string','y');
    set(handles.text15,'string','z');
    set(handles.text16,'string','A');
    set(handles.text17,'string','B');
    set(handles.text18,'string','C');
    set(handles.text50,'string','x');
    set(handles.text51,'string','y');
    set(handles.text52,'string','z');
    set(handles.text53,'string','A');
    set(handles.text54,'string','B');
    set(handles.text55,'string','C');
    set(handles.DAE, 'visible', 'on');
end
DAE_Callback(hObject, eventdata, handles);
Plano_Callback(hObject, eventdata, handles)
datos(handles);
numaux(0,handles);

% --- Executes during object creation, after setting all properties.
function Coordenadas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Coordenadas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in GDL.
function GDL_Callback(hObject, eventdata, handles)
% hObject    handle to GDL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns GDL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from GDL
gdl=get(handles.GDL,'Value');
coor=get(handles.Coordenadas, 'value');
if gdl==1
    set(handles.text4, 'visible', 'on');
    set(handles.l4, 'visible', 'on');
    set(handles.m4, 'visible', 'on');
    set(handles.text10, 'visible', 'on');
    set(handles.text5, 'visible', 'on');
    set(handles.l5, 'visible', 'on');
    set(handles.m5, 'visible', 'on');
    set(handles.text11, 'visible', 'on');
    set(handles.text6, 'visible', 'on');
    set(handles.l6, 'visible', 'on');
    set(handles.m6, 'visible', 'on');
    set(handles.text12, 'visible', 'on');
    set(handles.text16, 'visible', 'on');
    set(handles.edit4, 'visible', 'on');
    set(handles.text17, 'visible', 'on');
    set(handles.edit5, 'visible', 'on');
    set(handles.text18, 'visible', 'on');
    set(handles.edit6, 'visible', 'on');    
    set(handles.text53, 'visible', 'on');
    set(handles.edit10, 'visible', 'on');
    set(handles.text54, 'visible', 'on');
    set(handles.edit11, 'visible', 'on');
    set(handles.text55, 'visible', 'on');
    set(handles.edit12, 'visible', 'on');  
elseif gdl==2
    set(handles.text4, 'visible', 'on');
    set(handles.l4, 'visible', 'on');
    set(handles.m4, 'visible', 'on');
    set(handles.text10, 'visible', 'on');
    set(handles.text5, 'visible', 'on');
    set(handles.l5, 'visible', 'on');
    set(handles.m5, 'visible', 'on');
    set(handles.text11, 'visible', 'on');
    if coor==1
        set(handles.text6, 'visible', 'off');
        set(handles.l6, 'visible', 'off');
        set(handles.m6, 'visible', 'off');
        set(handles.text12, 'visible', 'off');
        set(handles.text18, 'visible', 'off');
        set(handles.edit6, 'visible', 'off'); 
        set(handles.text55, 'visible', 'off');
        set(handles.edit12, 'visible', 'off'); 
    elseif coor==2
        set(handles.text6, 'visible', 'on');
        set(handles.l6, 'visible', 'on');
        set(handles.m6, 'visible', 'on');
        set(handles.text12, 'visible', 'on');
        set(handles.text18, 'visible', 'on');
        set(handles.edit6, 'visible', 'on'); 
        set(handles.text55, 'visible', 'on');
        set(handles.edit12, 'visible', 'on'); 
    end
    set(handles.text16, 'visible', 'on');
    set(handles.edit4, 'visible', 'on');
    set(handles.text17, 'visible', 'on');
    set(handles.edit5, 'visible', 'on');
    set(handles.text53, 'visible', 'on');
    set(handles.edit10, 'visible', 'on');
    set(handles.text54, 'visible', 'on');
    set(handles.edit11, 'visible', 'on'); 
elseif gdl==3
    set(handles.text4, 'visible', 'off');
    set(handles.l4, 'visible', 'off');
    set(handles.m4, 'visible', 'off');
    set(handles.text10, 'visible', 'off');
    set(handles.text5, 'visible', 'off');
    set(handles.l5, 'visible', 'off');
    set(handles.m5, 'visible', 'off');
    set(handles.text11, 'visible', 'off');
    set(handles.text6, 'visible', 'off');
    set(handles.l6, 'visible', 'off');
    set(handles.m6, 'visible', 'off');
    set(handles.text12, 'visible', 'off');
    set(handles.text16, 'visible', 'off');
    set(handles.edit4, 'visible', 'off');
    set(handles.text17, 'visible', 'off');
    set(handles.edit5, 'visible', 'off');
    set(handles.text18, 'visible', 'off');
    set(handles.edit6, 'visible', 'off'); 
    set(handles.text53, 'visible', 'off');
    set(handles.edit10, 'visible', 'off');
    set(handles.text54, 'visible', 'off');
    set(handles.edit11, 'visible', 'off');
    set(handles.text55, 'visible', 'off');
    set(handles.edit12, 'visible', 'off'); 
end
Directa(handles);
datos(handles);
Grafica(handles);

% --- Executes during object creation, after setting all properties.
function GDL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GDL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
num(1,handles);
datos(handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
num(2,handles);
datos(handles);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
num(3,handles);
datos(handles);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
num(4,handles);
datos(handles);

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, ~)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
num(5,handles);
datos(handles);

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
num(6,handles);
datos(handles);

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in l1.
function l1_Callback(hObject, eventdata, handles)
% hObject    handle to l1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menos(1,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);


% --- Executes on button press in m1.
function m1_Callback(hObject, eventdata, handles)
% hObject    handle to m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mas(1,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in l2.
function l2_Callback(hObject, eventdata, handles)
% hObject    handle to l2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menos(2,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in m2.
function m2_Callback(hObject, eventdata, handles)
% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mas(2,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in l3.
function l3_Callback(hObject, eventdata, handles)
% hObject    handle to l3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menos(3,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in m3.
function m3_Callback(hObject, eventdata, handles)
% hObject    handle to m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mas(3,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in l4.
function l4_Callback(hObject, eventdata, handles)
% hObject    handle to l4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menos(4,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in m4.
function m4_Callback(hObject, eventdata, handles)
% hObject    handle to m4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mas(4,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in l5.
function l5_Callback(hObject, eventdata, handles)
% hObject    handle to l5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menos(5,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in m5.
function m5_Callback(hObject, eventdata, handles)
% hObject    handle to m5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mas(5,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in l6.
function l6_Callback(hObject, eventdata, handles)
% hObject    handle to l6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menos(6,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on button press in m6.
function m6_Callback(hObject, eventdata, handles)
% hObject    handle to m6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mas(6,handles);
datos(handles);
Directa(handles);
Inversa(handles);
Grafica(handles);
datos(handles);
robot(handles);

% --- Executes on selection change in Tipo.
function Tipo_Callback(hObject, eventdata, handles)
% hObject    handle to Tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Tipo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Tipo
sim=get(hObject, 'value');
if sim==2
%     set(handles.Gripper, 'visible', 'on');
    set(handles.Estado, 'Visible', 'on');
    set(handles.Estado, 'String', 'POR FAVOR ESPERE A QUE SE REALICE LA CONEXIÓN CON ARDUINO');
    a=arduino('COM5');
    assignin('base', 'a', a); 
    robot(handles);
    set(handles.Estado, 'String', 'LISTO');
    pause(2);
    set(handles.Estado, 'String', '');
    set(handles.Estado, 'Visible', 'off');
end
if sim==1
    a=0;
    assignin('base', 'a', a); 
%     set(handles.Gripper, 'visible', 'off');
    set(handles.Estado, 'Visible', 'off');
end
robot(handles);
    

% --- Executes during object creation, after setting all properties.
function Tipo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Estado, 'String', '');  
qi=[0 0 0 0 0 0];
assignin('base', 'qi', qi);
qia=qi;
assignin('base', 'qia', qia);

car=[19 0 22 0 0 0];
assignin('base', 'car', car);
cara=car;
assignin('base', 'cara', cara);

Grafica(handles);
datos(handles);
robot(handles);

R=1;
assignin('base', 'R', R);
set(handles.Estado, 'Visible', 'off');

assignin('base', 'Aux', 0);

% --- Executes on button press in Paro.
function Paro_Callback(hObject, eventdata, handles)
% hObject    handle to Paro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Paro
paro=get(hObject,'Value');
assignin('base', 'paro', paro); 
sim=get(handles.Tipo, 'value');
gato=get(handles.Gato, 'value'); 
if paro==0
    set(handles.Paro,'Backgroundcolor',[0.4 0.8 0]);
    set(handles.Paro,'String','Paro OFF');
    set(handles.Home, 'visible', 'off');
    set(handles.Personalizacion, 'visible', 'off');
    set(handles.Modo, 'visible', 'off');
    set(handles.Pbasico, 'visible', 'off');
    set(handles.Ptrayectoria, 'visible', 'off');
    set(handles.PBotones, 'visible', 'off');
    set(handles.PAvanzado, 'visible', 'off');
    set(handles.UPBots, 'visible', 'off');
    set(handles.DAE, 'visible', 'off');
    set(handles.Estado, 'String', '');
    set(handles.Paux,'visible','off');
    set(handles.Pfin,'visible','off');
    set(handles.Rutina,'visible','off');
    set(handles.Velocidad,'visible','off');
    set(handles.Gato,'visible','off');
    set(handles.Pgato,'visible','off');
    if sim==2
        a=0;
        assignin('base', 'a', a);   
        set(handles.Estado, 'String', '');
        set(handles.Gripper, 'visible', 'off');
        set(handles.Estado, 'Visible', 'off');
    end
else
    set(handles.Paro,'Backgroundcolor',[0.8 0 0]);
    set(handles.Paro,'String','Paro ON');
    set(handles.Home, 'visible', 'on');
    set(handles.Personalizacion, 'visible', 'on');
    set(handles.Modo, 'visible', 'on');
    set(handles.UPBots,'visible','on');
    set(handles.Gato,'visible','on');
    if gato==1
    set(handles.Pgato,'visible','on');
    Gato_Callback(hObject, eventdata, handles)
    end
    Modo_SelectionChangeFcn(hObject, eventdata, handles)
    if sim==2     
        set(handles.Gripper, 'visible', 'on');
        set(handles.Estado, 'Visible', 'on');
        set(handles.Estado, 'String', 'POR FAVOR ESPERE A QUE SE REALICE LA CONEXIÓN CON ARDUINO');
        a=arduino('COM5');
        assignin('base', 'a', a); 
        robot(handles);
        set(handles.Estado, 'String', 'LISTO');
        pause(2);
        set(handles.Estado, 'String', '');
        set(handles.Estado, 'Visible', 'off');
    end
end


% --- Executes during object creation, after setting all properties.
function Paro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Paro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function PBotones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBotones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in Modo.
function Modo_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Modo 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
m1=get(handles.Basico, 'value');
m2=get(handles.Trayectoria, 'value');
m3=get(handles.Experto, 'value');
coor=get(handles.Coordenadas, 'value');
t3=get(handles.Circulo2D, 'value');
t4=get(handles.Circulo3D, 'value');
if coor==1
    set(handles.DAE, 'visible', 'off');
elseif coor==2
    set(handles.DAE, 'visible', 'on');
end
if m1==1
    set(handles.Pbasico, 'visible', 'on');
    set(handles.Ptrayectoria, 'visible', 'off');
    set(handles.Rutina, 'visible', 'off');
    set(handles.Paux,'visible','off')
    Pbasico_SelectionChangeFcn(hObject, eventdata, handles)
    set(handles.Paux,'visible','off');
    set(handles.Pfin,'visible','off');
    set(handles.Velocidad, 'visible', 'off');
end
if m2==1
    set(handles.Pbasico, 'visible', 'off');
    set(handles.Ptrayectoria, 'visible', 'on');
    set(handles.PBotones, 'visible', 'off');
    set(handles.PAvanzado, 'visible', 'on');
    set(handles.Rutina, 'visible', 'off');
    set(handles.Velocidad, 'visible', 'on');
    qi=evalin('base', 'qi');
    assignin('base', 'qia', qi);
    car=evalin('base', 'car');
    assignin('base', 'cara', car);
    if t3==1 || t4==1
        set(handles.Paux,'visible','on');
    else 
        set(handles.Paux,'visible','off');
    end
    set(handles.Pfin,'visible','on');
end
if m3==1
    set(handles.Pbasico, 'visible', 'off');
    set(handles.Ptrayectoria, 'visible', 'on');
    set(handles.PBotones, 'visible', 'on');
    set(handles.PAvanzado, 'visible', 'on');
    set(handles.Rutina, 'visible', 'on');
    set(handles.Velocidad, 'visible', 'on');
%     set(handles.Gripper, 'visible', 'on');
    A=[];
    assignin('base', 'A', A);
    if t3==1 || t4==1
        set(handles.Paux,'visible','on');
        if t3==1
            set(handles.Plano2D,'visible','on');
        end
        if t4==1 
            set(handles.Plano2D,'visible','off');
        end
    else 
        set(handles.Paux,'visible','off');
        set(handles.Plano2D,'visible','off');
    end
    set(handles.Pfin,'visible','on');
end
DAE_Callback(hObject, eventdata, handles)
Ptrayectoria_SelectionChangeFcn(hObject, eventdata, handles)

% --- Executes when selected object is changed in Pbasico.
function Pbasico_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Pbasico 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
b1=get(handles.Botones, 'value');
b2=get(handles.Numeros, 'value');
if b1==1
    set(handles.PBotones, 'visible', 'on');
    set(handles.PAvanzado, 'visible', 'off');
end
if b2==1
    set(handles.PBotones, 'visible', 'off');
    set(handles.PAvanzado, 'visible', 'on');
end
DAE_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Pbasico_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pbasico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%get(hObject,'SelectedObject','Numeros');

% --- Executes during object creation, after setting all properties.
function Modo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pbasico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%get(hObject,'SelectedObject','Numeros');


% --- Executes on button press in Sistemas.
function Sistemas_Callback(hObject, eventdata, handles)
% hObject    handle to Sistemas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Sistemas
Grafica(handles)


% --- Executes on button press in Ok.
function Ok_Callback(hObject, eventdata, handles)
% hObject    handle to Ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coor=get(handles.Coordenadas, 'value');
m1=get(handles.Basico, 'value');
m2=get(handles.Trayectoria, 'value');
t1=get(handles.PTP, 'value');
t2=get(handles.Linea, 'value');
t3=get(handles.Circulo2D, 'value');
t4=get(handles.Circulo3D, 'value');
m3=get(handles.Experto, 'value');
assignin('base', 'Aux', 0);
if m1==1
    op=0;
    Directa(handles);
    Inversa(handles);
    Grafica(handles);
    datos(handles);
    robot(handles);
    qi=evalin('base','qi');
    assignin('base', 'qia', qi);  
    car=evalin('base','car');
    assignin('base', 'cara', car);  
end
if m2==1
    if t1==1
    PTP(handles);
    end
    if t2==1
    Linea(handles);
    end
    if t3==1
    %set(handles.Paux,'visible','on')
    Circulo2D(handles);
    end
    if t4==1
    %set(handles.Paux,'visible','on')
    Circulo3D(handles);
    end
end
if m3==1;
    Directa(handles);
    Inversa(handles);
    Grafica(handles);
    datos(handles);
    %robot(handles);
    qi=evalin('base','qi');
    assignin('base', 'qia', qi);  
    car=evalin('base','car');
    assignin('base', 'cara', car); 
end


% --- Executes during object creation, after setting all properties.
function Ptrayectoria_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ptrayectoria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in gl.
function gl_Callback(hObject, eventdata, handles)
% hObject    handle to gl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g=evalin('base','g');
if  g>0
    g=g-10;
    assignin('base', 'g', g); 
end
datos(handles);
robot(handles);

% --- Executes on button press in gm.
function gm_Callback(hObject, eventdata, handles)
% hObject    handle to gm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g=evalin('base','g');
if  g<180
    g=g+10;
    assignin('base', 'g', g); 
end
datos(handles);
robot(handles);


% --- Executes on button press in UPBots.
function UPBots_Callback(hObject, eventdata, handles)
% hObject    handle to UPBots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.UPBots,'Backgroundcolor',[0 0.4 0.4]);
A=load('Egipto2.mat');
Rutina=A.A;
assignin('base', 'A', Rutina);
set(handles.Rutinat,'data',Rutina)
set(handles.Experto, 'value',1);
set(handles.Pbasico, 'visible', 'off');
set(handles.Ptrayectoria, 'visible', 'on');
set(handles.PBotones, 'visible', 'on');
set(handles.PAvanzado, 'visible', 'on');
set(handles.Rutina, 'visible', 'on');
set(handles.Velocidad, 'visible', 'on');
Ejecutar_Callback(hObject, eventdata, handles);
set(handles.UPBots,'Backgroundcolor',[0 0.6 0.6]);

% --- Executes on button press in Guardarp.
function Guardarp_Callback(hObject, eventdata, handles)
% hObject    handle to Guardarp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)}
Ok_Callback(hObject, eventdata, handles);
coor=get(handles.Coordenadas, 'value');
qi=evalin('base','qi');
car=evalin('base','car');
A=evalin('base','A');
g=evalin('base','g');
t1=get(handles.Linea, 'value');
t2=get(handles.PTP, 'value');
t3=get(handles.Circulo2D, 'value');
t4=get(handles.Circulo3D, 'value');
t5=get(handles.STrayectoria, 'value');
gr=get(handles.Rgripper,'Value');

if t1==1
    tipo=1;
    if t5==1
        tipo=4;
    end
end
if t2==1
    tipo=2;
    if t5==1
        tipo=5;
    end
end
if t3==1
   if coor==1
        assignin('base', 'R', 0);
        R=0
        assignin('base', 'Aux', 1);
        Directa(handles);
        assignin('base', 'Aux', 0);
        assignin('base', 'R', 1);
    end
    qaux=evalin('base','qaux');
    caraux=evalin('base','caraux');
    tipo=3;
end
if t4==1
    if coor==1
        assignin('base', 'R', 0);
        R=0
        assignin('base', 'Aux', 1);
        Directa(handles);
        assignin('base', 'Aux', 0);
        assignin('base', 'R', 1);
    end
    qaux=evalin('base','qaux');
    caraux=evalin('base','caraux');
    tipo=3;
end
if gr==1
    tipo=g;
end

if tipo==1 || tipo==2 || tipo==4 || tipo==5
    A=[A;
       tipo qi car];
end
if tipo==3
    A=[A;
       tipo qi car;
       31 qaux caraux];
end
if tipo>5
    if size(A)~=[0 0]
        A=[A;
           g A(end,2:13)];
    else
       A=[A;
          g 0 0 0 0 0 0 19 0 22 0 0 0]; 
    end
    
end
% if tipo==6
%     A=[A;
%        tipo g A(end,3:13)];
% end
assignin('base', 'A', A); 
set(handles.Rutinat,'data',A);

% --- Executes on button press in Ejecutar.
function Ejecutar_Callback(hObject, eventdata, handles)
% hObject    handle to Ejecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=evalin('base','A');
sz=size(A);
R=0;
assignin('base', 'R', R);
P=[];
assignin('base', 'P', P);
assignin('base', 't', 1);
for i=1:sz(1)  
   qi=A(i,2:7);
   assignin('base', 'qi', qi); 
   car=A(i,8:13);
   assignin('base', 'car', car); 
    if A(i,1)==1
        Linea(handles);
    elseif A(i,1)==2
        PTP(handles);
    elseif A(i,1)==3
        qaux=A(i+1,2:7);
        assignin('base', 'qaux', qaux); 
        caraux=A(i+1,8:13);
        assignin('base', 'caraux', caraux);
        Circulo3D(handles);
        i=i+1;
    elseif A(i,1)==4
        assignin('base', 't', 0);
        Linea(handles);
        assignin('base', 't', 1);
        Directa(handles);
        Inversa(handles);
        Grafica(handles);
        PT=evalin('base', 'P');
        if size(PT)==[0 0]
            PT=[car(1) car(2) car(3)];
        end
        plot3(PT(:,1),PT(:,2),PT(:,3),'LineStyle',':','Color','k', 'LineWidth', 1,'Marker','.','MarkerEdgeColor', 'k' ,'MarkerSize',10); hold on;
        datosg(handles);
        pause(1); 
%         robot(handles);
%         pause(1); 
        qi=evalin('base','qi');
        assignin('base', 'qia', qi);  
        car=evalin('base','car');
        assignin('base', 'cara', car); 
    elseif A(i,1)==5
        assignin('base', 't', 0);
        PTP(handles);
        assignin('base', 't', 1);
        Directa(handles);
        Inversa(handles);
        Grafica(handles);
        PT=evalin('base', 'P');
        if size(PT)==[0 0]
            PT=[car(1) car(2) car(3)];
        end
        plot3(PT(:,1),PT(:,2),PT(:,3),'LineStyle',':','Color','k', 'LineWidth', 1,'Marker','.','MarkerEdgeColor', 'k' ,'MarkerSize',10); hold on;
        datosg(handles);
        pause(1); 
%         robot(handles);
%         pause(1); 
        qi=evalin('base','qi');
        assignin('base', 'qia', qi);  
        car=evalin('base','car');
        assignin('base', 'cara', car); 
    elseif A(i,1)>5
        g=A(i,1);
        assignin('base', 'g', g); 
        datos(handles);
        robot(handles);
        pause(1); 
    end
end
R=1;
assignin('base', 'R', R);
P=[];
assignin('base', 'P', P);


% --- Executes on button press in Borrar.
function Borrar_Callback(hObject, eventdata, handles)
% hObject    handle to Borrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=[];
assignin('base', 'A', A); 
Grafica(handles);
set(handles.Rutinat,'data',A);


% --- Executes on button press in Guardarr.
function Guardarr_Callback(hObject, eventdata, handles)
% hObject    handle to Guardarr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Guardarr
%set(handles.Abrir, 'value',0);
[Nombre,PathName]=uiputfile('*.mat')
n=strcat(PathName,Nombre)
A=evalin('base','A');
save(n,'A');

% --- Executes on button press in Abrir.
function Abrir_Callback(hObject, eventdata, handles)
% hObject    handle to Abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Abrir
% set(handles.Guardarr, 'value',0);
[Nombre,PathName]=uigetfile('*.mat');
n=strcat(PathName,Nombre);
A=load(n);
Rutina=A.A;
assignin('base', 'A', Rutina);
set(handles.Rutinat,'data',Rutina);


 % --- Executes on button press in STrayectoria.
function STrayectoria_Callback(hObject, eventdata, handles)
% hObject    handle to STrayectoria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of STrayectoria


% --- Executes on button press in DAE.
function DAE_Callback(hObject, eventdata, handles)
% hObject    handle to DAE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DAE
b1=get(handles.Botones, 'value');
b2=get(handles.Numeros, 'value');
coor=get(handles.Coordenadas, 'value');
dae=get(handles.DAE, 'value');
if coor==1
    set(handles.l4, 'Enable', 'on');
    set(handles.m4, 'Enable', 'on');
    set(handles.l5, 'Enable', 'on');
    set(handles.m5, 'Enable', 'on');
    set(handles.l6, 'Enable', 'on');
    set(handles.m6, 'Enable', 'on');
    set(handles.edit4, 'Enable', 'on');
    set(handles.edit5, 'Enable', 'on');
    set(handles.edit6, 'Enable', 'on');
    set(handles.edit10, 'Enable', 'on');
    set(handles.edit11, 'Enable', 'on');
    set(handles.edit12, 'Enable', 'on');
elseif coor==2
    if dae==0
        set(handles.l4, 'Enable', 'off');
        set(handles.m4, 'Enable', 'off');
        set(handles.l5, 'Enable', 'off');
        set(handles.m5, 'Enable', 'off');
        set(handles.l6, 'Enable', 'off');
        set(handles.m6, 'Enable', 'off');
        set(handles.edit4, 'Enable', 'off');
        set(handles.edit5, 'Enable', 'off');
        set(handles.edit6, 'Enable', 'off');
        set(handles.edit10, 'Enable', 'off');
        set(handles.edit11, 'Enable', 'off');
        set(handles.edit12, 'Enable', 'off');
    elseif dae==1
        set(handles.l4, 'Enable', 'on');
        set(handles.m4, 'Enable', 'on');
        set(handles.l5, 'Enable', 'on');
        set(handles.m5, 'Enable', 'on');
        set(handles.l6, 'Enable', 'on');
        set(handles.m6, 'Enable', 'on');
        set(handles.edit4, 'Enable', 'on');
        set(handles.edit5, 'Enable', 'on');
        set(handles.edit6, 'Enable', 'on');
        set(handles.edit10, 'Enable', 'on');
        set(handles.edit11, 'Enable', 'on');
        set(handles.edit12, 'Enable', 'on');
    end
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
numaux(1,handles);

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
numaux(2,handles);

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
numaux(3,handles);

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double
numaux(4,handles);

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double
numaux(5,handles);

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double
numaux(6,handles);



% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in Ptrayectoria.
function Ptrayectoria_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Ptrayectoria 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
m1=get(handles.Basico, 'value');
t3=get(handles.Circulo2D, 'value');
t4=get(handles.Circulo3D, 'value');
%Grafica(handles);
if m1==0
    if t3==1
        set(handles.Paux,'visible','on');
        numaux(0,handles);
        set(handles.Plano2D,'visible','on');
    else 
        set(handles.Plano2D,'visible','off');
    end
    if t4==1
        set(handles.Paux,'visible','on');
        numaux(0,handles);
        set(handles.Plano2D,'visible','off');
    end
    if  t3==0 && t4==0
        set(handles.Paux,'visible','off');
    end
else
    set(handles.Paux,'visible','off');
end
num(1,handles);
Plano_Callback(hObject, eventdata, handles);


% --- Executes on slider movement.
function Vel_Callback(hObject, eventdata, handles)
% hObject    handle to Vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Velocidad=get(handles.Vel,'Value');
set(handles.Pvel,'string',[num2str(Velocidad) '%']);

% --- Executes during object creation, after setting all properties.
function Vel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in Plano.
function Plano_Callback(hObject, eventdata, handles)
% hObject    handle to Plano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Plano contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Plano
m1=get(handles.Basico, 'value');
coor=get(handles.Coordenadas, 'value');
t3=get(handles.Circulo2D, 'value');
Plano=get(handles.Plano,'Value');
if coor==2
    if m1==0
        if t3==1
            if Plano==1
                set(handles.edit1,'enable','on');
                set(handles.edit2,'enable','on');
                set(handles.edit3,'enable','off');
                set(handles.edit7,'enable','on');
                set(handles.edit8,'enable','on');
                set(handles.edit9,'enable','off');
            elseif Plano==2
                set(handles.edit1,'enable','on');
                set(handles.edit2,'enable','off');
                set(handles.edit3,'enable','on');
                set(handles.edit7,'enable','on');
                set(handles.edit8,'enable','off');
                set(handles.edit9,'enable','on');
             elseif Plano==3
                set(handles.edit1,'enable','off');
                set(handles.edit2,'enable','on');
                set(handles.edit3,'enable','on');
                set(handles.edit7,'enable','off');
                set(handles.edit8,'enable','on');
                set(handles.edit9,'enable','on');
            end
        else
            set(handles.edit1,'enable','on');
            set(handles.edit2,'enable','on');
            set(handles.edit3,'enable','on');
            set(handles.edit7,'enable','on');
            set(handles.edit8,'enable','on');
            set(handles.edit9,'enable','on');
        end
    else
        set(handles.edit1,'enable','on');
        set(handles.edit2,'enable','on');
        set(handles.edit3,'enable','on');
        set(handles.edit7,'enable','on');
        set(handles.edit8,'enable','on');
        set(handles.edit9,'enable','on');
    end
else
    set(handles.edit1,'enable','on');
    set(handles.edit2,'enable','on');
    set(handles.edit3,'enable','on');
    set(handles.edit7,'enable','on');
    set(handles.edit8,'enable','on');
    set(handles.edit9,'enable','on');
end

% --- Executes during object creation, after setting all properties.
function Plano_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function PTP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PTP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Gato.
function Gato_Callback(hObject, eventdata, handles)
% hObject    handle to Gato (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Gato
Gato=get(hObject,'Value');
sim=get(handles.Tipo, 'value');
if Gato==1
    set(handles.Gato,'Backgroundcolor',[0 0.4 0.4]);
    set(handles.Home, 'visible', 'off');
    set(handles.Personalizacion, 'visible', 'off');
    set(handles.Modo, 'visible', 'off');
    set(handles.Pbasico, 'visible', 'off');
    set(handles.Ptrayectoria, 'visible', 'off');
    set(handles.PBotones, 'visible', 'off');
    set(handles.PAvanzado, 'visible', 'off');
    set(handles.UPBots, 'visible', 'off');
    set(handles.DAE, 'visible', 'off');
    set(handles.Estado, 'String', '');
    set(handles.Paux,'visible','off');
    set(handles.Pfin,'visible','off');
    set(handles.Velocidad,'visible','off');
    set(handles.Rutina,'visible','on');
    set(handles.Botonesrutina, 'visible', 'off');
    set(handles.G11,'string',' '); 
    set(handles.G21,'string',' '); 
    set(handles.G31,'string',' ');
    set(handles.G12,'string',' ');
    set(handles.G22,'string',' ');
    set(handles.G32,'string',' ');
    set(handles.G13,'string',' ');
    set(handles.G23,'string',' ');
    set(handles.G33,'string',' ');
    set(handles.Resultado,'string',' ');
    set(handles.Pgato,'visible','on');
    cam = videoinput('winvideo', 2, 'MJPG_640x480');
    cam.LoggingMode='memory';
    cam.TriggerFrameDelay = 25;
    cam.FramesPerTrigger = 1;
    camRes = get(cam, 'VideoResolution');
    imWidth = camRes(1);
    imHeight = camRes(2);
    nBands = get(cam, 'NumberOfBands');
    hImage = image(zeros(imHeight, imWidth, nBands),'Parent',handles.axes2 );
    preview(cam,hImage);
    start(cam);
    assignin('base', 'cam', cam);  
    set(handles.Tipo, 'value',2);  
    set(handles.Estado, 'Visible', 'on');
    set(handles.Estado, 'String', 'POR FAVOR ESPERE A QUE SE REALICE LA CONEXIÓN CON ARDUINO');
    a=arduino('COM5');
    assignin('base', 'a', a); 
    robot(handles);
    set(handles.Estado, 'String', 'LISTO');
    pause(2);
    set(handles.Estado, 'String', '');
    set(handles.Estado, 'Visible', 'off');  
    set(handles.Experto, 'value',1);
    A=load('Inicio.mat');
    Rutina=A.A;
    assignin('base', 'A', Rutina);
    set(handles.Rutinat,'data',Rutina)
    Ejecutar_Callback(hObject, eventdata, handles);
    Grafica(handles);
else
    set(handles.Gato,'Backgroundcolor',[0 0.6 0.6]);
    set(handles.Home, 'visible', 'on');
    set(handles.Personalizacion, 'visible', 'on');
    set(handles.Modo, 'visible', 'on');
    set(handles.UPBots,'visible','on');
    set(handles.Pgato,'visible','off');  
    set(handles.Botonesrutina, 'visible', 'on');
    Modo_SelectionChangeFcn(hObject, eventdata, handles)
    set(handles.Tipo, 'value',1);  
    a=0;
    assignin('base', 'a', a); 
    set(handles.Estado, 'Visible', 'off');
%     assignin('base', 'cam', cam);
    cam=evalin('base','cam');
    stoppreview(cam);
    closepreview(cam);
    delete(cam);
    axes(handles.axes1);
end


% --- Executes on button press in Turno.
function Turno_Callback(hObject, eventdata, handles)
TGato(handles);
Ejecutar_Callback(handles.Ejecutar, eventdata, handles);

% --- Executes on button press in Rgripper.
function Rgripper_Callback(hObject, eventdata, handles)
% hObject    handle to Rgripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Rgripper


% --- Executes on button press in Eleccion.
function Eleccion_Callback(hObject, eventdata, handles)
% hObject    handle to Eleccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.G11,'string',' '); 
set(handles.G21,'string',' '); 
set(handles.G31,'string',' ');
set(handles.G12,'string',' ');
set(handles.G22,'string',' ');
set(handles.G32,'string',' ');
set(handles.G13,'string',' ');
set(handles.G23,'string',' ');
set(handles.G33,'string',' ');
set(handles.Resultado,'string',' ');
color=randi([1 2]);
inicio=randi([1 2]);
set(handles.Resultado,'FontSize',8);
if color==1 
    set(handles.ResEle,'string','Mi color es azul X');
    set(handles.ResEle,'Foregroundcolor',[0 0 1]);
    set(handles.Azul,'value',1);
else
    set(handles.ResEle,'string','Mi color es rojo O');
    set(handles.ResEle,'Foregroundcolor',[1 0 0]);
    set(handles.Rojo,'value',1);
end
if inicio==1 
    set(handles.Resultado,'string','Contrincante inicia');
else
    set(handles.Resultado,'string','Yo inicio');
    pause(3);
    Turno_Callback(hObject, eventdata, handles);
end
pause(5);
set(handles.ResEle,'string',' ');
set(handles.Resultado,'string',' ');
set(handles.Resultado,'FontSize',15);
