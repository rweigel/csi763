clear
load xray.mat

Ts   = datenum([Time_Start,repmat(0,size(Time_Start,1),1)]);
Y_o  = min(Time_Start(:,1));
Y_f  = max(Time_Start(:,1));
dn_o = datenum([Y_o,1,1]);
dn_f = datenum([Y_f,12,31]);

% Count the number of events in each day.
for dn = dn_o:dn_f
  i = dn-dn_o+1;
  I = find(floor(Ts) == dn);
  Npd(i) = length(I);
end

mn = 24*60*datenum(Time_Start(:,1:3))+60*Time_Start(:,4)+Time_Start(:,5);
mn = mn-mn(1)+1;
Npm = hist(mn,[1:mn(end)]);

for i=1:mn(end)
  Npm(i) = length(find(mn==i));
end

