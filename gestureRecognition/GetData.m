function [ Ax,Ay,Az,Gx,Gy,Gz ] = GetData( File, N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



% for i = 1:100
%     C(i,:) = textscan(File{1,1}, '>%f,%f,%f,%f,%f.');
%     Ax(i) = C{i,3};
%     Ay(i) = C{i,4};
%     Az(i) = C{i,5};
% end

    C = textscan(File, '.%f %f %f %f %f %f',N);
    Ax = C{1,1};
    Ay = C{1,2};
    Az = C{1,3};
    Gx = C{1,4};
    Gy = C{1,5};
    Gz = C{1,6};



end
