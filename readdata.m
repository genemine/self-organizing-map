function [data,header,id,gene]=readdata(file,delimiter)
%+++ file: data file with the first line being headers
%+++ delimiter: default is '\t'.
if nargin<2  delimiter='\t'; end


fid=fopen(file,'r');
tline = fgetl(fid);
header=regexp(tline,delimiter,'split')';
header(1:2)=[];
iter=1;
X=[];
id=[];
gene={};
while 1
  tline = fgetl(fid);
  if ~ischar(tline), break, end 
  array=regexp(tline,delimiter,'split');
  id(iter,1)=str2num(array{1});
  gene{iter,1}=array(2);
  array(1:2)=[];
  for j=1:length(array)
     data(iter,j)=str2num(array{j}); 
  end
  iter=iter+1;
end
fclose(fid);





