function decimals = nibbleToDec(nibbles)
%NIBBLETODEC Summary of this function goes here
%   Detailed explanation goes here
tran = (reshape(nibbles, 2, [])).';
L = length(tran);
decimals = zeros(L,1);

for i = 1 : L
    MSB = tran(i,1)*2^4;
    decimals(i) = MSB+tran(i,2);
end
end

