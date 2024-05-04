%take a photo
vid = videoinput ("winvideo",1);
vid.ReturnedColorspace = 'rgb';
start (vid);
im=getsnapshot(vid);
stop(vid);
delete(vid);

%make the image into a 25x25 pixel image
lowResIm = imresize(im, [25, 25]);
%prep image for network by storing all the data in 1 row instead of a
%25x25x3 matrix
im_vector = reshape(lowResIm, [1, 25*25*3]);
input_matrix = zeros(1, 25*25*3);
input_matrix(1, 1:end) = im_vector;
input_matrix = input_matrix';

%run it through the network
output = net (input_matrix);

%read output to find what class it belongs to. this is done by getting the
%index of the highest in the output matrix and from there we can find out
%what class the image belongs to.
[maxval, indexMax] = max(output);

subplot(2,1,1);
imshow(im);
subplot(2,1,2);
imshow(lowResIm);

if (indexMax == 1)
    title("Garlic Herb Butter Roast Chicken");
elseif (indexMax == 2)
    title("Apple Cider-Braised Turkey Drumsticks");
elseif (indexMax == 3)
    title("Banana Split");
else
    title("default output, shouldn't happen");
end 


