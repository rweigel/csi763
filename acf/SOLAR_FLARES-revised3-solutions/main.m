clear;
Year_o = 2000;
Year_f = 2003;

file = 'xray.mat';
if ~exist(file)
  prep();
else
  load(file);
end

compute; % Analysis of times in xray.mat
