M = imread('lena256.jpg');
fid = fopen('lena.in','wt');  % Note the 'wt' for writing in text mode
fprintf(fid, '{ ');
for i = 1:64
    fprintf(fid, '{');
    for j = 1:255
        fprintf(fid,'%d, ', M(i,j));  % The format string is applied to each element of a
       end
    fprintf(fid,'%d },\n', M(i,256));  % The format string is applied to each element of 
end
fclose(fid);
