% Face Recognition using Independent Component Analysis (ICA)
% Created on Mar 2015
% Authors: Sid Ali Rezetane, Sina M. Baharlou, Harold Agudelo
% calculate demixing matrix using infoMax algorithm
% x = input signal
% bs = block size
% epochs
% lr = learning rate
% wh = whittening the data
% ----
% W = demixing matrix
% A = mixing matrix
% U = independent signals

function [U, A, W] = infomax(x, blockSize, epochs, lr, wh)
 
    % get the size of input matrix
    [N, P] = size(x);
 
    if (wh == true)
        fprintf('Whitening input data...\n');
          [x, wz] = whiten(x);
    end
    fprintf('Performing infoMax...\n');
    
    % initialize W with random numbers near zero
    W = randn(N) * 0.01;
 
    % divide input signal to blocks of size 'blockSize'
    blockCount = floor(P / blockSize);
 
    % start the iteration
    for i = 1:epochs
        % update W for each block
        for j = 1:blockSize:blockCount * blockSize
            % calculate u
            u = W * x(:, j:j + blockSize - 1);
            % sigmoid activation function
            y = 1 ./ (1 + exp(- u));
            % update W
            W = W + lr * ((eye(N) + (1 - 2 * y) * u')*W);
        end
        fprintf('.')
    end
    fprintf('\n');
 
    U = W * x;
    if (wh == true)
        W = W * wz;
    end
    A = inv(W);
end
