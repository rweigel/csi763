function plotcmds(tmp)

set(0,'defaultaxesfontsize',16); 
set(0,'defaulttextfontsize',16);
 
fprintf('plotcmds: plotting %s.png and .eps\n',tmp);
eval(sprintf('print -zbuffer -depsc %s.eps',tmp));
 
if system('which convert')
    eval(sprintf('print -dpng %s.png',tmp));
else
    system(sprintf('convert -quality 100 -density 100 %s.eps %s.png',tmp,tmp));
end