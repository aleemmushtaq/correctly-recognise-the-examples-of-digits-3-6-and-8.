%%
% GETONEDIGIT( n, instance, data )
%
% Arguments: 'n' and 'instance' are integer, 'data' should
% be the 3-d matrix loaded up from the USPS .mat files.
%
% Returns:  2d matrix of instance 'instance' for digit 'n',
% pulling it out of the supplied data matrix.
%
function digdata = getonedigit( n, instance, data )

if ~exist('data', 'var')
    error('Three arguments required. Format is: getdigitdata( n, instance, data )');
end

if n > size(data,3)
    error('INCORRECT ARGUMENTS: First argument is the digit (1-9) you want (use 10 get get digit zero), second argument is which instance you want.');
end

if instance > size(data,2)
    error( [ 'INCORRECT ARGUMENT: The instance argument must be in the range 1-' num2str(size(data,2)) '.' ] );
end

%reshape it into a square matrix
digdata = reshape( data( : ,instance, n ) , 16 , 16);

%cast to doubles
digdata = double(digdata);
