% Visualizes the supplied 2-d training matrix.
%%
% SHOWDATA( traindata, truelabels, [predictions] )
%
% Arguments: 'traindata' should be a 2d matrix of N examples (N rows)
%  and M dimensions (M columns).
% 
% Returns: Nothing.
% 
% MUST be the original pixels (i.e. 256 columns in the data matrix)
%
% Supply an optional argument 'predictions' to visualise your mistakes
% against the true labels.
%
function showdata( data, labels, guess )

%first sort the digits so they're in order
[labels, sortorder] = sort(labels);
data = data(sortorder,:);

%check to see whether this includes predictions
testing = true;
if exist('guess','var')
    guess = guess(sortorder);
else
    guess = labels;
    testing = false;
end

%find out how many there are and restrict accordingly
numexamples = size(data,1);
if numexamples > 300
    error('Too big!');
end

%only display proper digits
if size(data,2) ~= 256
    error('Sorry - can only display digits as the original pixels.');
end



%decide how many digits to put in the square
for side=1:17
    if side^2 >= (numexamples)
        break;
    end
end

%set up the border parameters
border = 3;
framewidth = 16+(2*border);

%and the main matrix to display
m = zeros(side*framewidth,side*framewidth);

n=1;
mistakes = 0;
for row = 1:framewidth:(side*framewidth)-1
    for col = 1:framewidth:(side*framewidth)-1
       
        %retrieve the digit pixels
        digit = reshape(data(n,:), 16,16);
        
        %put a black border around it
        frame = zeros(framewidth);
        frame(border:(border+15), border:(border+15)) = digit;
        digit = frame;        
        
        %draw a further white border around the digit, if we've made an error
        if labels(n)~=guess(n)
            digit( border,                     border:(framewidth-border) ) = 255; %top of white 'mistake' box
            digit( framewidth-border,          border:(framewidth-border) ) = 255; %bottom
            digit( border:(framewidth-border), border                     ) = 255; %left
            digit( border:(framewidth-border), framewidth-border          ) = 255; %right
            mistakes = mistakes + 1;
        end
               
        %put it in the main matrix
        m(row:(row+(framewidth-1)), col:(col+(framewidth-1))) = digit;
        
        %increment which example we're dealing with
        n=n+1;

        %break if we reached the end
        if n > size(data,1)
            break;
        end;
    end
    
    %break if we reached the end
    if n > size(data,1)
        break;
    end;
end

%display it
imagesc( m );
colormap gray;
axis off;
axis square;

%put a title on it
if testing==true
    rate = mistakes / numexamples;
    rate = ceil(rate*10000)/100;
    title([ num2str(mistakes) ' errors from ' num2str(numexamples) '   (' num2str(rate) '%)'], 'FontSize', 16);
end
