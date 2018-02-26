%ECSE 436, Lab 2 
%Group 7: Amanda Bianco and Luis Gallet

%Problem 2, part a)

clear;

%Generating the codebook for (8,4,4) code:
P = [1 1 1 0; 1 1 0 1; 1 0 1 1; 0 1 1 1];
message_bits =  de2bi((0:15) , 'left-msb');
parity_bits = mod(message_bits * P, 2);
codebook = horzcat(message_bits, parity_bits);

%Received  vector:
r = [0.54 -0.12 1.32 0.41 0.63 1.25 0.37 -0.02]';

%Using exhaustive decoding to determine codeword that is closest to r in
%terms of minimum square Euclidean distance:

%For each codeword in codebook, we need to swap m4 with P1
for i = 16
    temp = codebook(i,4);
    codebook(i,4) = codebook(i,5);
    codebook(i,5) = temp;
end
%Also, need to swap r5 and r4 in received vector
temp = r(4);
r(4) = r(5);
r(5) = temp;

for i = 1:16
    euclideanDistance(i) = (r-codebook(i,:)')'*(r-codebook(i,:)');
end

[~, index] = min(euclideanDistance);
codeword = codebook(index, :)