% Course OR
% Álvaro García Cerezo
% 2026
% Lecture 3
% Function to export data from MATLAB to a GMS file.
% This function only works for parameters with one index.
% Input data:
% - set1: First index of the parameter. 
%   For example: set1 = 'd'.
% - description: Description of the parameter included in GAMS. 
%   For example: description = 'Parameter Rho(d) Weight of representative day d [days]'.
% - inputMatrix: Matrix that will be exported to a GAMS file.
%   For example: inputMatrix = [33,48,65,52,26,42,24,19,49,7].
% - outputFileName: Name of the resulting GAMS file.
function M2G1set(set1,description,inputMatrix,outputFileName)

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
[nRows] = length(inputMatrix);
for i = 1:nRows
    fprintf(fid, ['  ',set1,'%d %g\n'],i,inputMatrix(i));
end
fprintf(fid,'/;\n');

% Close the file.
fclose(fid);

% Show that everything went well.
disp('GMS file was created correctly.');
