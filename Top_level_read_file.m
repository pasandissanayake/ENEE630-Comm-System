function [] = Top_level_read_file(path)
%TOP_LEVEL_READ_FILE Summary of this function goes here
%Detailed explanation goes here
FREQ_ID=10;
fid = fopen(path, 'rb');
%# Get file size.
fseek(fid, 0, 'eof');
fileSize = ftell(fid);
frewind(fid);
%# Read the whole file.
data = fread(fid, fileSize, 'uint8');
%# Count number of line-feeds and increase by one.
numLines = sum(data == 10) + 1;
fclose(fid);
max_block_num=floor(numLines/1152);

for i=1:max_block_num
    [id_sig,data_sig]=read_file(path,i,0);
    [freq_sign,freq_offset]=detector(id_sig);
    if freq_sign==FREQ_ID
        x=sprintf('%d  is a block assigned to our Freq_ID ',i);
        disp(x)
    else
        x=sprintf('%d  is not a block assigned to our Freq_ID ',i);
        disp(x)
    end

end

