%ADAM COETZEE - 29982995
%REII 312 - PRACTICAL 1
%PHASE 3 CLIENT
numberOfBits=8;

% Client side - open and establish connection
INPUT_BUF = 3538944;
clientSocket = tcpip('localhost',30000,'NetworkRole','client')
disp('Creating a socket')
set(clientSocket, 'InputBufferSize', INPUT_BUF);
fopen(clientSocket);
disp('Socket is open')
disp('Connecting to server')
clientSocket.Status;
disp('Connected succesfully')

% To read data from the socket:
disp('Receiving data from socket')
while clientSocket.BytesAvailable == 0
    pause(1);
end
ARl = fread(clientSocket, 442368, 'double');
disp('Client: Data Received')
fprintf(clientSocket, 'Client: Data receieved!');

while clientSocket.BytesAvailable == 0
    pause(1);
end
AIm = fread(clientSocket, 442368, 'double');
disp('Client: Data Received');
fprintf(clientSocket, 'Client: Data receieved!');

while clientSocket.BytesAvailable == 0
    pause(1);
end
BRl = fread(clientSocket, 442368, 'double');
disp('Client: Data Received')
fprintf(clientSocket, 'Client: Data receieved!');

while clientSocket.BytesAvailable == 0
    pause(1);
end
BIm = fread(clientSocket, 442368, 'double');
disp('Client: Data Received');
fprintf(clientSocket, 'Client: Data receieved!');

fclose(clientSocket); %Close server socket

%Plot QAM signal with added noise from server
%Combine signals
AModulated = complex(ARl, AIm);
BModulated = complex(BRl, BIm);
%QAM parameters
c = [-5 -5i 5 5i -3 -3-3i -3i 3-3i 3 3+3i 3i -3+3i -1 -1i 1 1i];
M = length(c);

%Stream A
h = scatterplot(AModulated);
hold on
scatterplot(c,[],[],'r*',h)
title('16 - Noise Added QAM Constellation (Stream A)')
grid
hold off
%Stream B
h = scatterplot(BModulated);
hold on
scatterplot(c,[],[],'r*',h)
title('16 - Noise Added QAM Constellation (Stream B)')
grid
hold off

%QAM Demodulation and decoding to unsigned integers
demodAnib = uint8(genqamdemod(AModulated,c));
demodBnib = uint8(genqamdemod(BModulated,c));

demodADec = uint8(nibbleToDec(demodAnib));
demodBDec = uint8(nibbleToDec(demodBnib));

finalsound = audioplayer(demodBDec, 44100);
play(finalsound);

stereo_mtx = [demodADec(:), demodBDec(:)];
audiowrite('stereo_output.wav', stereo_mtx, 44100);