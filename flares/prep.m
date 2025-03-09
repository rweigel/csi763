more off

% Data source:
% ftp://ftp.ngdc.noaa.gov/STP/SOLAR_DATA/SOLAR_FLARES/XRAY_FLARES/
% See ftp://ftp.ngdc.noaa.gov/STP/SOLAR_DATA/SOLAR_FLARES/XRAY_FLARES/xray.fmt.REVISED
% for information.

% This program extracts the start times of flares listed in these files
% (as determined from columns 14-17).
% The matrix Start_Times contains columns of [Year, Month, Day, Hour]

URLbase = '';
Class_Number = repmat(NaN,57288,1);
Class_Letter = repmat(NaN,57288,1);
YMD          = repmat(NaN,57288,3);
HM1          = repmat(NaN,57288,2);

i = 1;
for year = Year_o:Year_f

  file_name = sprintf('xray%d',year);
  URL = [URLbase,file_name];

  if (~exist(file_name))
    fprintf('prep: downloading %s\n',URL);
    urlcopy(URL);
  else
    fprintf('prep: found %s on disk.  No download performed.\n',URL);
  end
  
  fid = fopen(file_name,'r');
  line = '';
  endoffile = 0;
  % This while loop could be easily vectorized if files had a uniform number
  % of columns.  However, the number of spaces at the end of a file is
  % not always uniform (as, for example, in xray2000).
  fprintf('prep: Reading %s\n',file_name);
  while (endoffile == 0)
    line = fgetl(fid);
    % length(line) > 1 takes care of case when ^M is returned at end of file
    % (as in the file xray2003) and case when line == -1 (which means EOF).
    if (length(line) > 1)
      YMD(i,:) = [year,str2num(line(8:9)),str2num(line(10:11))];
      HM1(i,:) = [str2num(line(14:15)),str2num(line(16:17))];
      class2num(66) = 0; % ASCII code B is 66
      class2num(67) = 1; % ASCII code C is 67
      class2num(77) = 2; % ASCII code M is 77
      class2num(88) = 3; % ASCII code X is 88
      if (line(60) == ' ') 
	Class_Letter(i,1) = NaN;      
      else
	Class_Letter(i,1) = class2num(str2num(sprintf('%d',line(60))));
      end
      if all(line(61:63) == ' ')
	Class_Number(i,1) = NaN;
      else
	Class_Number(i,1) = str2num(line(61:63));
      end
	i = i+1;
    else
      endoffile = 1;
    end
  end
  fclose(fid);
  
end

Time_Start = [YMD,HM1];

Ts   = datenum([Time_Start,repmat(0,size(Time_Start,1),1)]);
Y_o  = min(Time_Start(:,1));
Y_f  = max(Time_Start(:,1));
dn_o = datenum([Y_o,1,1]);
dn_f = datenum([Y_f,12,31]);

csvwrite('xray.csv', [Time_Start,Class_Letter,Class_Number]);
save -V6 xray.mat Time_Start Class_Letter Class_Number
