% Course OR
% Álvaro García Cerezo
% 2026
% Lecture 3
% Function to export data from MATLAB to a GMS file.
% This function only works for parameters with two indexes.
% Input data:
% - set1: First index of the parameter. 
%   For example: set1 = 'd'.
% - set2: Second index of the parameter. 
%   For example: set2 = 'h'.
% - description: Description of the parameter included in GAMS. 
%   For example: description = 'Parameter PD(d,h) Power demanded in RD d
%   and hour h [MW]'.
% - inputMatrix: Matrix that will be exported to a GAMS file.
%   For example: inputMatrix = [1:24;25:48].
% - outputFileName: Name of the resulting GAMS file.
function M2G2sets(set1,set2,description,inputMatrix,outputFileName)

% Open (or create, if it does not exist) the file where the results will be
% stored.
fid = fopen([outputFileName,'.gms'],'w');

% Check whether the file has been opened successfully or not.
if fid == -1
    error('The GMS file could not be created.');
end

% Write the line that defines the parameter in GAMS.
fprintf(fid,[description,' \n']);
fprintf(fid,'/\n');
% Identify the number of rows and columns in the input matrix.
[nRows,nColumns] = size(inputMatrix);
for i = 1:nRows
    for j = 1:nColumns
        fprintf(fid, ['  ',set1,'%d.',set2,'%d %g\n'],i,j,inputMatrix(i,j));
    end
end
fprintf(fid,'/;\n');

% Close the file.
fclose(fid);

% Show that everything went well.
disp('GMS file was created correctly.');
