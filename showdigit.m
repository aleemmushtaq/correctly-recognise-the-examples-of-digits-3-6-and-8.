%%
% SHOWDIGIT( digdata )
%
% Arguments: 'digdata' should be a matrix with 256 elements,
%  either as 16x16, or 1x256.
%
% Returns: Nothing.
%
% Displays the image of the supplied digit.
%
function showdigit( digdata )

figure
imagesc( reshape(digdata,16,16) );

set( gcf, 'Position', [500 500 256 256]);
colormap gray;
axis off;
axis square;
