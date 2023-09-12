function robot(handles)
sim=get(handles.Tipo, 'value');
if sim==2
    q=evalin('base','qi');
    g=evalin('base','g');
    q=round(q); %Checar
    a=evalin('base', 'a');
    a.servoAttach(10);
    a.servoWrite(10,q(5)+90);
    a.servoAttach(9);
    a.servoWrite(9,q(4)+90);
    a.servoAttach(6);
    a.servoWrite(6,q(3)+90);
    a.servoAttach(5);
    a.servoWrite(5,q(2)+90);
    a.servoAttach(3);
    a.servoWrite(3,q(1)+90);
    a.servoAttach(11);
    a.servoWrite(11,g);
end
end