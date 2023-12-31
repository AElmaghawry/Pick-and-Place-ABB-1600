function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the axes1 to a new GUI or the axes1 to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 14-Sep-2023 10:48:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    axes1 to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    axes1 to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in fk.
function fk_Callback(hObject, eventdata, handles)
% hObject    axes1 to fk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Th1 = str2double(handles.j1.String)*pi/180 ; 
Th2 = str2double(handles.j2.String)*pi/180 ;
Th3 = str2double(handles.j3.String)*pi/180 ;
Th4 = str2double(handles.j4.String)*pi/180 ;
Th5 = str2double(handles.j5.String)*pi/180 ;
Th6 = str2double(handles.j6.String)*pi/180 ;

l1 = 486.5;
l2 = 0 ;
l3 = 0 ;
l4 = 600; 
l5 = 0;
l6 = 65;

L(1) = Link('revolute','d',l1,'a',150,'alpha',-pi/2);
L(2) = Link('revolute','d',l2,'a',475,'alpha',0,'offset',-pi/2);
L(3) = Link('revolute','d',l3,'a',475,'alpha',-pi/2);
L(4) = Link('revolute','d',l4,'a',0,'alpha',pi/2);
L(5) = Link('revolute','d',l5,'a',0,'alpha',pi/2,'offset',pi);
L(6) = Link('revolute','d',l6,'a',0,'alpha',0);

Robot = SerialLink(L); 
Robot.name = 'ABB' ; 
Robot.plot([Th1 Th2 Th3 Th4 Th5 Th6]); 


T = Robot.fkine([Th1 Th2 Th3 Th4 Th5 Th6]);
% disp(size(T))

handles.x.String = num2str(T.t(1));
handles.y.String = num2str(T.t(2));
handles.z.String = num2str(T.t(3)); 
   

% --- Executes on button press in ik.
function ik_Callback(hObject, eventdata, handles)

px = str2double(handles.x.String); 
py = str2double(handles.y.String);
pz = str2double(handles.z.String);

l1 = 486.5;
l2 = 0 ;
l3 = 0 ;
l4 = 600; 
l5 = 0;
l6 = 65;

L(1) = Link('revolute','d',l1,'a',150,'alpha',-pi/2);
L(2) = Link('revolute','d',l2,'a',475,'alpha',0,'offset',-pi/2);
L(3) = Link('revolute','d',l3,'a',475,'alpha',-pi/2);
L(4) = Link('revolute','d',l4,'a',0,'alpha',pi/2);
L(5) = Link('revolute','d',l5,'a',0,'alpha',pi/2,'offset',pi);
L(6) = Link('revolute','d',l6,'a',0,'alpha',0);

Robot = SerialLink(L); 
Robot.name = 'ABB' ; 

T = [ 1 0 0 px ;
      0 1 0 py ; 
      0 0 1 pz ; 
      0 0 0 1];

J = Robot.ikine(T, 'rdf')

handles.j1.String= J(1)* 180/pi; 
handles.j2.String= J(2)*180/pi;
handles.j3.String= J(3)*180/pi; 
handles.j4.String= J(4)*180/pi;
handles.j5.String= J(5)*180/pi; 
handles.j6.String= J(6)*180/pi;

Robot.plot(J);

% hObject    axes1 to ik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function j1_Callback(hObject, eventdata, handles)
% hObject    axes1 to j1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j1 as text
%        str2double(get(hObject,'String')) returns contents of j1 as a double


% --- Executes during object creation, after setting all properties.
function j1_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to j1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j2_Callback(hObject, eventdata, handles)
% hObject    axes1 to j2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j2 as text
%        str2double(get(hObject,'String')) returns contents of j2 as a double


% --- Executes during object creation, after setting all properties.
function j2_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to j2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j3_Callback(hObject, eventdata, handles)
% hObject    axes1 to j3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j3 as text
%        str2double(get(hObject,'String')) returns contents of j3 as a double


% --- Executes during object creation, after setting all properties.
function j3_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to j3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j4_Callback(hObject, eventdata, handles)
% hObject    axes1 to j4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j4 as text
%        str2double(get(hObject,'String')) returns contents of j4 as a double


% --- Executes during object creation, after setting all properties.
function j4_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to j4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j5_Callback(hObject, eventdata, handles)
% hObject    axes1 to j5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j5 as text
%        str2double(get(hObject,'String')) returns contents of j5 as a double


% --- Executes during object creation, after setting all properties.
function j5_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to j5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j6_Callback(hObject, eventdata, handles)
% hObject    axes1 to j6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j6 as text
%        str2double(get(hObject,'String')) returns contents of j6 as a double


% --- Executes during object creation, after setting all properties.
function j6_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to j6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_Callback(hObject, eventdata, handles)
% hObject    axes1 to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x as text
%        str2double(get(hObject,'String')) returns contents of x as a double


% --- Executes during object creation, after setting all properties.
function x_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_Callback(hObject, eventdata, handles)
% hObject    axes1 to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y as text
%        str2double(get(hObject,'String')) returns contents of y as a double


% --- Executes during object creation, after setting all properties.
function y_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_Callback(hObject, eventdata, handles)
% hObject    axes1 to z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z as text
%        str2double(get(hObject,'String')) returns contents of z as a double


% --- Executes during object creation, after setting all properties.
function z_CreateFcn(hObject, eventdata, handles)
% hObject    axes1 to z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
