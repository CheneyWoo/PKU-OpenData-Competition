clf 
%define the plot button 
plotbutton=uicontrol('style','pushbutton',...
'string','Run', ...
'fontsize',12, ... 
'position',[100,400,50,20], ... 
'callback', 'run=1;');
%define the stop button 
erasebutton=uicontrol('style','pushbutton',...
'string','Stop', ... 
'fontsize',12, ... 
'position',[200,400,50,20], ... 
'callback','freeze=1;');
%define the Quit button 
quitbutton=uicontrol('style','pushbutton',...
'string','Quit', ... 
'fontsize',12, ... 
'position',[300,400,50,20], ... 
'callback','stop=1;close;');
number = uicontrol('style','text', ... 
    'string','1', ...
'fontsize',12, ...
'position',[20,400,50,20]); 

n = 128;
z = zeros(n,n);
cell = z;
count = z;
cell = rand(n,n);
for i = 1:n;
    for j = 1:n;
        if cell(i,j) <= 0.9
            cell(i,j) = 0;
        else
            cell(i,j) = 1;
        end
    end
end

cell(23:28,1:80) = 1; 
cell(45:128,59:64) = 1;

%????????
imh = image(cat(3,cell,z,z)); 
set(imh, 'erasemode', 'none') 
axis equal
axis tight

num = 0;
X = [];
Y = [];
for x = 1:n
    for y = 1:n
        if ((23<=x&&x<=28&&1<=y&&y<=80) || (45<=x&&x<=128&&59<=y&&y<=64))
            continue;
        elseif cell(x,y)==1
            num = num + 1;
            X(num) = x;
            Y(num) = y;
        end
    end
end
r = [];
max = 1;
rmax = 1;
%=========== ?????? ===============
stop= 0; 
run = 0; 
freeze = 0;
while (stop == 0)
      while (run == 1)
% =========== ?????? ===============
          for i = 1:50
            for k = 1:num
                for d = 1:4
                    r(d) = Pr(X(k),Y(k),d,66,66);
                    if r(d)>rmax
                        rmax = r(d);
                        max = d;
                    end
                end
                switch(max)
                    case 1
                        if cell(X(k),Y(k)+1) == 1
                            cell(X(k),Y(k)) = 1;
                        elseif cell(X(k),Y(k)+1) == 0
                            cell(X(k),Y(k)) = 0;
                            cell(X(k),Y(k)+1) = 1;
                            Y(k) = Y(k)+1;
                        end
                    case 2
                        if cell(X(k)+1,Y(k)) == 1
                            cell(X(k),Y(k)) = 1;
                        elseif cell(X(k)+1,Y(k)) == 0
                            cell(X(k),Y(k)) = 0;
                            cell(X(k)+1,Y(k)) = 1;
                            X(k) = X(k)+1;
                        end    
                    case 3
                        if cell(X(k),Y(k)-1) == 1
                            cell(X(k),Y(k)) = 1;
                        elseif cell(X(k),Y(k)-1) == 0
                            cell(X(k),Y(k)) = 0;
                            cell(X(k),Y(k)-1) = 1;
                            Y(k) = Y(k)-1;
                        end
                    case 4
                        if cell(X(k)-1,Y(k)) == 1
                            cell(X(k),Y(k)) = 1;
                        elseif cell(X(k)-1,Y(k)) == 0
                            cell(X(k),Y(k)) = 0;
                            cell(X(k)-1,Y(k)) = 1;
                            X(k) = X(k)-1;
                        end
                end
            end
            for x = 1:n
                for y = 1:n
                    if cell(x,y)==1
                        if ((23<=x<=28&&1<=y<=80) || (45<=x<=128&&59<=y<=64))
                            continue;
                        end
                        count(x,y) = count(x,y) + 1;
                    end
                end
            end
            set(imh, 'cdata', cat(3,cell,z,z));
        end
        
% ============ ???? ===============
        for k = 1:num
            for d = 1:4
                r(d) = (Pr(X(k),Y(k),d,66,66) + Pc(X(k),Y(k),d,count))/2;
            end
            for d = 1:4
                if r(d)>rmax
                    rmax = r(d);
                    max = d;
                end
            end
            switch(max)
                case 1
                    if cell(X(k),Y(k)+1) == 1
                        cell(X(k),Y(k)) = 1;
                    elseif cell(X(k),Y(k)+1) == 0
                        cell(X(k),Y(k)) = 0;
                        cell(X(k),Y(k)+1) = 1;
                        Y(k) = Y(k)+1;
                    end
                case 2
                    if cell(X(k)+1,Y(k)) == 1
                        cell(X(k),Y(k)) = 1;
                    elseif cell(X(k)+1,Y(k)) == 0
                        cell(X(k),Y(k)) = 0;
                        cell(X(k)+1,Y(k)) = 1;
                        X(k) = X(k)+1;
                    end
                case 3
                    if cell(X(k),Y(k)-1) == 1
                        cell(X(k),Y(k)) = 1;
                    elseif cell(X(k),Y(k)-1) == 0
                        cell(X(k),Y(k)) = 0;
                        cell(X(k),Y(k)-1) = 1;
                        Y(k) = Y(k)-1;
                    end
                case 4
                    if cell(X(k)-1,Y(k)) == 1
                        cell(X(k),Y(k)) = 1;
                    elseif cell(X(k)-1,Y(k)) == 0
                        cell(X(k),Y(k)) = 0;
                        cell(X(k)-1,Y(k)) = 1;
                        X(k) = X(k)-1;
                    end
            end
        end
        for x = 1:n
            for y = 1:n
                if cell(x,y)==1
                    if ((23<=x&&x<=28&&1<=y&&y<=80) || (45<=x&&x<=128&&59<=y&&y<=64))
                        continue;
                    end
                    count(x,y) = count(x,y) + 1;
                end
            end
        end
        set(imh, 'cdata', cat(3,cell,z,z));
        %?????
        stepnumber = 1 + str2double(get(number,'string')); 
        set(number,'string',num2str(stepnumber));
    end
    if (freeze==1) 
        run = 0;
        freeze = 0; 
    end
    drawnow
end