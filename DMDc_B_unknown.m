function sysmodel_DMDc = DMDc_B_unknown(StateData,InputData)
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

Omega = [X;Ups];

[U,Sig,V] = svd(Omega,'econ');

% thresh = 1e-10;
rtil = 16;%length(find(diag(Sig)>thresh));

Util    = U(:,1:rtil); 
Sigtil  = Sig(1:rtil,1:rtil);
Vtil    = V(:,1:rtil); 

[U,Sig,V] = svd(Xp,'econ');

% thresh = 1e-10;
r = 16;%length(find(diag(Sig)>thresh));

Uhat    = U(:,1:r); 
Sighat  = Sig(1:r,1:r);
Vbar    = V(:,1:r); 

n = size(X,1); 
q = size(Ups,1);
U_1 = Util(1:n,:);
U_2 = Util(n+1:n+q,:);

approxA = (Xp)*Vtil*inv(Sigtil)*U_1';
approxB = (Xp)*Vtil*inv(Sigtil)*U_2';

% [W,D,zeroInd] = eig(approxA);
% plot(real(D),imag(D),'o');
% Phi = Xp * Vtil * inv(Sigtil) * U_1'*Uhat * W;
% figure
% lambda = diag(D);
% dt = 1; omega = log(lambda)/dt;
% x1 = X(:,1);
% b = Phi\x1;
% t = 0:1:length(X);
% time_dynamics = zeros(r,length(t));
% for iter = 1:length(t)
%     time_dynamics(:,iter) = (b.*exp(omega*t(iter)));
% end
% if ~isempty(zeroInd)
%     disp('zero eigenvalue');
%     Phi(:, end) = Util'*Util*Uhat(:, 1:r)*W(:, end);
% end
% X_dmd = Phi*time_dynamics;
% figure 
% plot(real(X_dmd))
C = eye(16); 
sysmodel_DMDc = ss(approxA,approxB,C,zeros(16,16));
end