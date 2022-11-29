function write_file(file_path,data)
    fileID = fopen(file_path,'wt');
    fprintf('write_file: writing to %s\n',file_path);
    for i=1:length(data)
        d = data(i);
        fprintf(fileID,'%10.2f,  %10.2f\n\r',real(d),imag(d));
    end
    fclose(fileID);
end