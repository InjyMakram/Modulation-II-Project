clc
clear all
close all
 
%input binary info
N=100000;
Mt=randi([0,1],1,N);
E=1;
%St_OOK=zeros(1,N);
x_BPSK=Mt.*2-1;

%dividing bits to even and odd in QPSK
evenQPSK=Mt(1:2:end);
oddQPSK=Mt(2:2:end);  


for a=1:N/2
    if evenQPSK(a)==0
        if oddQPSK(a)==0
            x_QPSK(a)=1/sqrt(2)+1/sqrt(2)*i;
        else
            x_QPSK(a)=1/sqrt(2)-1/sqrt(2)*i;
        end
    else
        if oddQPSK(a)==0
            x_QPSK(a)=-1/sqrt(2)+1/sqrt(2)*i;
        else
            x_QPSK(a)=-1/sqrt(2)-1/sqrt(2)*i;
        end
    end
          
end



for SNR=1:20

y_OOK=awgn(Mt,SNR,'measured'); %signal after adding noise OOK
y_BPSK=awgn(x_BPSK,SNR,'measured'); %signal after adding noise BPSK
y_QPSK=awgn(x_QPSK,SNR,'measured'); %signal after adding noise QPSK

SNRlinear(SNR)=10.^(SNR/10);
SNR_Array(SNR)= SNR;


%for loop for detecting OOK & PSK
for i=1:N
    if y_OOK(i)>0.5
        St_OOK(i)=1;
    end
    if y_OOK(i)<0.5
        St_OOK(i)=0;
    end
    if y_BPSK(i)>0
        St_BPSK(i)=1;
    end
    if y_BPSK(i)<0
        St_BPSK(i)=0;
    end  
end

%for loop for detecting QPSK
j=1;
for k=1:2:N
 
    if real(y_QPSK(j))<0
        St_QPSK(k)=1;
     else
        St_QPSK(k)=0;
     end
     
     if imag(y_QPSK(j))<0
        St_QPSK(k+1)=1;
     else
        St_QPSK(k+1)=0;
     end
    j=j+1; 
     
end


Pe_practical_OOK(SNR)=(sum(xor(Mt,St_OOK)))/N; 
Pe_theoretical_OOK(SNR)=0.5*erfc(sqrt(SNRlinear(SNR)/4));

Pe_practical_BPSK(SNR)=(sum(xor(Mt,St_BPSK)))/N;
Pe_theoretical_BPSK(SNR)=0.5*erfc(sqrt(SNRlinear(SNR)/2));

Pe_practical_QPSK(SNR)=(sum(xor(Mt,St_QPSK)))/N;
Pe_theoretical_QPSK(SNR)=0.5*erfc(sqrt(SNRlinear(SNR)/2));






end

figure
semilogy(SNR_Array,Pe_theoretical_OOK);
grid on
title('Theoretical BER of OOK vs SNR ')
xlabel('SNR')
ylabel('Probability of Error')
figure
semilogy(SNR_Array,Pe_practical_OOK);
grid on
title('Practical BER of OOK vs SNR ')
xlabel('SNR')
ylabel('Probability of Error')


figure
semilogy(SNR_Array,Pe_theoretical_BPSK);
grid on
title('Theortical BER of BPSK vs SNR ')
xlabel('SNR')
ylabel('Probability of Error')
figure
semilogy(SNR_Array,Pe_practical_BPSK);
grid on
title('Practical BER of BPSK vs SNR ')
xlabel('SNR')
ylabel('Probability of Error')


figure
semilogy(SNR_Array,Pe_theoretical_QPSK);
grid on
title('Theortical BER of QPSK vs SNR ')
xlabel('SNR')
ylabel('Probability of Error')
figure
semilogy(SNR_Array,Pe_practical_QPSK);
grid on
title('Practical BER of QPSK vs SNR ')
xlabel('SNR')
ylabel('Probability of Error')


%three plots together practical
figure
semilogy(SNR_Array,Pe_practical_OOK);
grid on
hold on
semilogy(SNR_Array,Pe_practical_BPSK);
grid on
hold on
semilogy(SNR_Array,Pe_practical_QPSK);
grid on
legend('OOK' , 'BPSK' , 'QPSK');
xlabel('SNR [dB]')
ylabel ('BER')

%three plots together theoretical
figure
semilogy(SNR_Array,Pe_theoretical_OOK);
grid on
hold on
semilogy(SNR_Array,Pe_theoretical_BPSK);
grid on
hold on
semilogy(SNR_Array,Pe_theoretical_QPSK);
grid on
legend('OOK' , 'BPSK' , 'QPSK');
xlabel('SNR [dB]')
ylabel ('BER')







