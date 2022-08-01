function decimalValue=RGB(in)
% Convert hexadecimal RGB values (strings) to decimal unit arrays
% by Fangzhou Hu
decimalValue=zeros(1,3);
decimalValue(1)=hex2dec(in(1:2))/255;
decimalValue(2)=hex2dec(in(3:4))/255;
decimalValue(3)=hex2dec(in(5:6))/255;
end