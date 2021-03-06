function values = InverseCDF(cdf, percentiles)
    % values = InverseCDF(cdf, percentiles)
    % Given cumulative distribution function cdf and a row vector of 
    % percentiles, this function finds the position of the first element 
    % in cdf whose value is larger than the element in the row vector. 
    % values(j) = k where cdf(k) is the first element in cdf that is 
    % not smaller than percentiles(j). 
    % ----------
    % Input:
    %   cdf:            row array of non-decreasing values
    %   percentiles:    row array of fractional percentiles
    % ----------
    % Output: 
    %   values:         row array of size of percentiles, identifies
    %                       index into CDF which marks the first element
    %                       whose value is not smaller than the
    %                       corresponding value of percentiles
    % ----------
    
    for j=1:size(percentiles,2)
        %   Binary search for first value of CDF not smaller than 
        %   percentile(j). 
        upper=size(cdf,2);
        lower=1;
        guess = 1;
        while upper > lower + 1
            guess = ceil((upper+lower)/2);
            if percentiles(j) < cdf(guess)
                upper = guess;
            elseif percentiles(j) == cdf(guess)
                upper = guess;
                lower = guess;
            else
                lower = guess;
            end
        end
        % In the very rare case that we get exactly the percentile
        % we want to check that a lower value is also not at that 
        % percentile. 
        if percentiles(j) == cdf(guess)
            while percentiles(j) == cdf(upper)
                upper = upper-1;
            end
                upper=upper+1;
        end
        values(j) = upper;
    end       
end

