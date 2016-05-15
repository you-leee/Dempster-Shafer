
o=pwd;
cd('D:\Suli\Diploma\Matlab kód\Dempster-Shafer\Banknote recognizer\Test\TestPictures_2');
files = dir('*.png');
%index = [1,3,5:8,10:14, 16:18,20:22,24,26:36,38:41,43:46,52:53,61:72,74:90,93:95,99:103,105:107,111:113,115:117,124:127,131:133,143:146,151:156,158:166,170:182,184:210,212:257,262:265,267:277,284:288,291:299];

fileNames = {files.name};     %# Create a cell array of file names
for iFile = 1:numel(fileNames)  %# Loop over the file names
    temp_filename = fileNames{iFile};
    newNuma = sprintf('%s',temp_filename(28:end-4),temp_filename(18:22));
    newName = sprintf('%s.png',newNuma)  %# Make the new name
    movefile(fileNames{iFile},newName);        %# Rename the file
end

for id = 1:length(files)
    % Get the file name (minus the extension)
    [pathstr,name,ext] = fileparts(files(id).name);
%     if(find(id==index))
%         %files(id).name
%         %delete(files(id).name);
%     end;
end
cd(o);


