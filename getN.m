% Face Recognition using Independent Component Analysis (ICA)
% Created on Mar 2015
% Authors: Sid Ali Rezetane, Sina M. Baharlou, Harold Agudelo

function n = getN(x, thresh)
    total_length = sum(x);
    s = length(x);
    for i = 1 : s
        if ((sum(x(1: s - i)) / total_length) < thresh)
            break
        end
    end
    n = s - i + 1;
end
