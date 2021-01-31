%ADAM COETZEE - 29982995
%REII 312 - PRACTICAL 1
%PHASE 3 SERVER
numberOfBits = 8;

%matrix manipulation to extract nibble stream from encoded integers
decInA = out.encoded_data(:,1);
decInB = out.encoded_data(:,2);
nibbleInA = decToNibble(decInA);
nibbleInB = decToNibble(decInB);

%QAM Modulation and display const. diagram
c = [-5 -5i 5 5i -3 -3-3i -3i 3-3i 3 3+3i 3i -3+3i -1 -1i 1 1i]; % constellation points
M = length(c);
modInA = genqammod(nibbleInA, c);
modInB = genqammod(nibbleInB, c);

%Constellation Diagrams
%Stream A
h = scatterplot(modInA);
hold on
scatterplot(c,[],[],'r*',h)
title('16 - QAM Constellation (Stream A)')
grid
hold off

%Stream B
h = scatterplot(modInA);
hold on
scatterplot(c,[],[],'r*',h)
title('16 - QAM Constellation (Stream B)')
grid
hold off

%Add noise to the streams - 30dB
noiseA = awgn(modInA,30,'measured');
noiseARl = real(noiseA);
noiseAIm = imag(noiseA);

noiseB = awgn(modInB,30,'measured');
noiseBRl = real(noiseB);
noiseBIm = imag(noiseB);

%TCP SERVER
% Server side - open socket & establish connection
OUTPUT_BUF = 3538944;
disp('starting server, make sure client is running')
serverSocket = tcpip('localhost',30000,'NetworkRole','server')
disp('Creating a socket, listening for client.')
set(serverSocket, 'OutputBufferSize', OUTPUT_BUF);
fopen(serverSocket);
disp('Socket is open.')
disp('Waiting for connection from client on adress localhost.')
serverSocket.Status
disp('Connected succesfully')

% Write data out to the socket.
disp('Server: Sending A(real) to socket.');
fwrite(serverSocket, noiseARl, 'double');
ack = fscanf(serverSocket);
disp(ack);

disp('Server: Sending A(Im) to socket.');
fwrite(serverSocket,noiseAIm, 'double');
ack = fscanf(serverSocket);
disp(ack);

disp('Server: Sending A(real) to socket.');
fwrite(serverSocket, noiseBRl, 'double');
ack = fscanf(serverSocket);
disp(ack);

disp('Server: Sending A(Im) to socket.');
fwrite(serverSocket,noiseBIm, 'double');
ack = fscanf(serverSocket);
disp(ack);

fclose(serverSocket);