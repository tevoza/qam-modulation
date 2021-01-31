function nibbles = decToNibble(decimals)
%decToNibble
%   breaks up 8-bit integer array to array of nibbles, ie max val of 15....
L = length(decimals);
nibbles2 = zeros(L,2);
LSN = 15;   %LSN, ie 0000 1111
for n = 1 : L
    nibbles2(n,1) = bitshift(decimals(n),-4);    
    nibbles2(n,2) = bitand(decimals(n),LSN);
end
nibbles = reshape(nibbles2.', [], 1);
end

