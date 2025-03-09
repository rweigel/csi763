function [psd_ave,N_z,psd_all,X_resh] = psd_welch(X,N,FLAG,COND)
%PSD_WELCH Average power spectral density over subsegemts of full vector.
%
%    [psd] = PSD_WELCH(X) If X is a vector gives same result as
%    fft(X).*fft(conj(X)).  psd_ave does _not_ include the dc component.
%
%    [psd_ave,N_z] = PSD_WELCH(X,N) N is the number of elements for each
%    subsegement. 
%
%    N_z is the number of subsegments that were not included in psd_ave
%    because they had a zero power spectrum for all non-dc frequencies.
%    (These subsegments can be eliminated through chunking.  See CHUNK,
%    and QQCHUNK.)
%
%    [psd_ave,N_z,psd_all,X_reshaped] = PSD_WELCH(X,N) returns a matrix of
%    the subsegment PSDs used to compute psd_ave in psd_all, which has
%    floor(length(X)/N) columns and N-1 rows.  Columns not used because the of
%    a flag condition or because they had a zero power spectrum for all
%    non-dc frequencies are filled with NaNs. X_reshaped contains columns of
%    the subsegments of X used to compute the PSD.  It is the same number
%    of columns as as psd_all and N rows.
%
%    PSD_WELCH(X,N,FLAG,COND) Ignores subsegments with flagged data.
%
%    See also FFT, IS_FLAG, PSD_WELCH_DEMO.

% R.S. Weigel 02/01/2001

if (nargin < 4)
  COND = -1;
end

if (nargin < 2)
  FLAG = NaN;
end

if (size(X,2) > 1)
  if (size(X,1) > 1) | (prod(size(X))>max(size(X)))
    error('X must be a row or column vector');
  end
  X = X';
end
  
if (nargin == 1)
  N = size(X,1);
end
  
S = size(X,1);

if (N > S)
  N = S;
end

N_p = floor(S/N);                    % Number of full subsegments possible
X_t = reshape(X(1:N*N_p,:),N,N_p);   % X_t is matrix with columns of subsegments

if (nargout > 2)
  psd_all = NaN*ones(size(X_t,1)-1,size(X_t,2));
  if (nargout > 3)
    X_resh = X_t;
  end
end


if (nargin > 2) % If flag value specified
  Igood = find(sum(is_flag(X_t,FLAG,COND)) == 0);
  if (isempty(Igood))
    warning('No non-flagged subsegments. Returning empty array for PSD.');
    psd_ave = [];
    psd_all = [];
    Np = 0;
    Nz = size(X_t,2);
    return;
  end
  X_t   = X_t(:,Igood); % Keep columns with no flagged elements
end

X_t = X_t - repmat(mean(X_t,1),N,1); % Subtract off average

temp = fft(X_t);
X_t  = temp.*conj(temp);

% Look for subsegments that had PSD of zero.
I   = find(sum(X_t(2:N,:),1) ~= 0);       

Den      = repmat(sum(X_t(2:N,I'),1),N-1,1); % Denominator
temp     = X_t(2:N,I')./Den;
psd_ave  = mean(temp,2);

if (nargout > 2)
  if (nargin > 2)
    psd_all(:,Igood(I)) = temp;
  else
    psd_all(:,I) = temp;
  end
end

N_z = size(X_t,2) - length(I); % Number of subsegments with PSD of zero

if (size(X,2) > 1)
  psd_ave = psd_ave';
end
