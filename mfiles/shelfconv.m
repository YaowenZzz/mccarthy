% SHELFCONV  show convergence study of SSA solver
% calls: TESTSHELF

J = [25 50 100 200 500 1000 2000];

dxkm = 200.0 ./ J;
maxerr = ones(size(dxkm));  % allocate
for j=1:length(J)
  fprintf('J = %4d:\n',J(j))
  [av,maxerr(j)] = testshelf(J(j));
  maxerr(j) = 3.1556926e7 * maxerr(j);
  fprintf('  max error = %.5f m/a\n',maxerr(j))
end

figure(1)  % show convergence plot
loglog(dxkm,maxerr,'o-','markersize',16)
pf = polyfit(log(dxkm),log(maxerr),1);
hold on, loglog(dxkm,exp(pf(1)*log(dxkm)+pf(2)),'r:'), hold off
grid on, xlabel('dx  (km)','fontsize',16)
ylabel('maximum error  (m a-1)','fontsize',16)
result = sprintf('convergence rate O(dx^{%.5f})\n',pf(1));
disp(result)
text(2.0*dxkm(end-1),2.0*maxerr(end-1),result,'fontsize',18,'interpreter','latex')
grid minor off
set(gca,'xtick',[100 200 400 1000 2000 4000 8000]/1000)
set(gca,'xticklabel',{'0.1','0.2','0.4','1','2','4','8'})

