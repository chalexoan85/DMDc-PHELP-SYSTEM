function sysmodel_DMDc = DMDc_B_known(StateData,InputData,B)
%% Total Variation Regularized Differentiation
Xp = zeros(length(StateData)-5,16);
% Xp = zeros(length(StateData)-3,16);
X = StateData';
for i=3:length(X)-3
    for k=1:size(X,2)
        Xp(i-2,k) = (1/(12))*(-X(i+2,k)+8*X(i+1,k)-8*X(i-1,k)+X(i-2,k));
%         Xp(i-1,k) = (1/2)*(-X(i-1,k)+X(i+1,k));
    end
end
Xp = Xp';
X   = StateData(:,1:length(Xp));
Ups = InputData(:,1:length(Xp));

Omega = X;

[U,Sig,V] = svd(Omega,'econ');

% thresh = 1e-10;
rtil = 16;%length(find(diag(Sig)>thresh));

Util    = U(:,1:rtil); 
Sigtil  = Sig(1:rtil,1:rtil);
Vtil    = V(:,1:rtil); 

% B = h*eye(16,16);
Xp = Xp-B*Ups;
[U,Sig,V] = svd(Xp,'econ');

% thresh = 1e-10;
r = 16;%length(find(diag(Sig)>thresh));

Uhat    = U(:,1:r); 
Sighat  = Sig(1:r,1:r);
Vbar    = V(:,1:r); 

n = size(X,1); 
q = size(Ups,1);
U_1 = Util(1:n,:);

approxA = (Xp)*Vtil*inv(Sigtil)*U_1';
approxB = B;

C = eye(16); 
sysmodel_DMDc = ss(approxA,approxB,C,zeros(16,16));
end
