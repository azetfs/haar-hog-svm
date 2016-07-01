clearvars ;
cellSize=4;
%%using vlfeat http://www.vlfeat.org/
run('C:\\Users\\ANASS\\Downloads\\vlfeat-0.9.20-bin.tar\\vlfeat-0.9.20\\toolbox\\vl_setup')
srcFiles = dir('D:\happy\neg\*.png');  % the folder in which your negatif images exists
az=length(srcFiles);
for i = 1 : length(srcFiles)
    filename = strcat('D:\happy\neg\',srcFiles(i).name);
    I = imread(filename);
        newmap = rgb2gray(I);
    hog = vl_hog(single(I), cellSize, 'verbose');
    mat(i,:)=hog(:);
end
srcFiles = dir('D:\happy\pos\*.png');  % the folder in which your  positif images exists
art=length(srcFiles);
for i = 1 : length(srcFiles)
    filename = strcat('D:\happy\pos\',srcFiles(i).name);
    I = imread(filename);
    newmap = rgb2gray(I);
    hog = vl_hog(single(I), cellSize, 'verbose');
    neu(i,:)=hog(:);
end
for i = 1 :az
  ae(i)= 0;
end
for i = az+1 :az+art
  ae(i)= 1;
end
b=cat (1,mat, neu);
svmStruct = svmtrain(b,ae);
save('happy.mat','svmStruct')
