M = load('output.out');
imshow(M,[])
imwrite(mat2gray(M), 'lena256sharpen.jpg')
