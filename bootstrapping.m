%% Let's work with the  DGP : y = 2 + 0.5x+epsilon, epsilon ~ N(0,1) ; N=50

% Set the sample size and generate the independent variable
N = 50;
x = (20)*rand(N,1);

% Construct the design matrix and generate the dependent variable
X = [ones(N,1) x];
beta = [2 0.5]';
epsilon = randn(N,1);
y = X*beta + epsilon;


% Until here I have defined my DGP and taken a sample of size N

% Now let's do a regression 

% Fit a linear regression model and obtain the residuals
[beta_hat, ~, e] = regress(y, X);

% Set the number of bootstrap samples
num_bootstraps = 1000;

% Pre-allocate a vector to store the bootstrapped coefficient estimates
beta_bootstraps = zeros(num_bootstraps, 2);

% Perform the bootstrap
for i = 1:num_bootstraps
    % Resample with replacement from the (OLS) residuals: IMPORTANT!! REPLACEMENT
    e_resampled = randsample(e, N, true);

    % Add the resampled residuals to the original fitted values
    % key: I DONT TOUCH MY X!! I want to simulate what is the variability
    % on the y leaving X fixed. The uncertainty here comes from the
    % randomness in y and therefore in the error. 

    % If I were to resample X, i would be treating the regressors as
    % random, not fixed. This already assumes that 1) my functional form is
    % correct and 2) residuals are iid. 

    

    y_star = X*beta_hat + e_resampled;

    % Fit a linear regression model to the bootstrapped sample
    beta_star = regress(y_star, X);

    % Store the coefficient estimates
    beta_bootstraps(i, :) = beta_star';
end

% Compute the bootstrap standard errors and confidence intervals
se_bootstraps = std(beta_bootstraps);
ci_bootstraps = prctile(beta_bootstraps, [2.5, 97.5]);

% Print the results
fprintf('Bootstrap standard errors:\n')
fprintf('Intercept: %f\n', se_bootstraps(1))
fprintf('Slope: %f\n', se_bootstraps(2))
fprintf('\nBootstrap confidence intervals (95%%):\n')
fprintf('Intercept: [%f, %f]\n', ci_bootstraps(1, 1), ci_bootstraps(2, 1))
fprintf('Slope: [%f, %f]\n', ci_bootstraps(1, 2), ci_bootstraps(2, 2))


%%


% Set the confidence level
alpha = 0.05;

% Compute the lower and upper percentiles of the bootstrapped coefficient estimates
lower_percentile = 100 * alpha/2;
upper_percentile = 100 * (1 - alpha/2);
CI = prctile(beta_bootstraps, [lower_percentile, upper_percentile]);

% Plot the histogram of the bootstrapped coefficient estimates
figure;
histogram(beta_bootstraps(:, 2), 'Normalization', 'pdf');
hold on;

% Plot the confidence intervals as vertical lines
line([CI(1, 2) CI(1, 2)], ylim, 'LineWidth', 2, 'Color', 'r');
line([CI(2, 2) CI(2, 2)], ylim, 'LineWidth', 2, 'Color', 'r');

% Label the axes and add a title
xlabel('Bootstrap estimates of \beta_1');
ylabel('Density');
title(sprintf('Histogram of Bootstrap Estimates of \\beta_1 (CI: [%0.2f, %0.2f])', CI(1, 2), CI(2, 2)));
