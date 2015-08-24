function [idx,idx_sym,idx_rw] = spectralClustering(W,A,D,k)
%	EEL6935 Network Science
%   Fall 2014
%       Perform the following cluster methods
%       to detect communities in the weighted graph specified by provided data:
%           - unnormalized spectral clustering
%           - normalized spectral clustering according to Shi and Malik (normalized cuts)
%           - normalized spectral clustering according to Ng, Jordan, and Weiss
%
%   Written by:   Dick Al-Bayaty (ralbayaty@ufl.edu)
%   Created:      11/17/2014


% A = W;
% A(A~=0) = 1;
% D = diag(sum(A,2));

% Unnormalized Spectral Clustering
L = D-W;
[u,v] = eig(L);
U = u(:,1:k);
[idx] = kmeans(U,k);

% Normalized Spectral Clustering: Ng, Jordan, and Weiss (2002)
L_sym = D^(-1/2)*L*D^(-1/2);
[u_sym,v_sym] = eig(L_sym);
U_sym = u_sym(:,1:k);
T_sym = normr(abs(U_sym));
[idx_sym] = kmeans(T_sym,k);

% Normalized Spectral Clustering: Shi and Malik (2000)
L_rw = D^(-1)*L;
[u_rw,v_rw] = eig(L_rw);
U_rw = u_rw(:,1:k);
[idx_rw] = kmeans(U_rw,k);

