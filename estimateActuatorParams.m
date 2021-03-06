%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimate actuator model parameters (second order model assumed with no
% noise).
%
% Perform a test with suitable input data and record output data. Feed this
% as udata and ydata to estimate parameters of model.
%
% MEJ 28/2/11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Aest = estimateActuatorParams(ydata, udata)

    % start with inital guess
    Ainit = [1 1 1 1];
    Aest = fminsearch(@estimateCost,Ainit,[],ydata,udata);
    
    
    
    
    function cost = estimateCost(Acurrent, ydata, udata)
        ycurrent = zeros(size(ydata));
        for k = 1:1:length(udata)
            if k < 3
                ycurrent(k) = 0;
            else
                ycurrent(k) = Acurrent*[udata(k-1); udata(k-2); ydata(k-1); ydata(k-2)];
            end
        end
        
        % least squares
        cost = sum((ydata - ycurrent).^2);