data{

// Comments are forwardslash in stan

// Define data and their dimensions

int<lower=0> n; // number of observations
vector[n] pw; // petal width measurements
vector[n] pl; // petal length measurements

}

// Define model parameters

parameters{

real B0; // Intercept
real B1; // Slope of petal length
real<lower=0> resid_sd; // residual standard deviation

}

// Regression equation in the transformed parameters block 

transformed parameters{

vector[n] mu; // Define dimensions of mu, the predicted value at each data point

mu = B0 + B1*pl;


}

model{

// Data likelihood
pw ~ normal(mu, resid_sd); //  pw ~ normal(B0+B1*pl, resid_sd)

// Priors
B0 ~ normal(0, 100); // Vague prior on intercept
B1 ~ normal(0, 100); // Vague prior on petal length effect (slope)

resid_sd ~ gamma(0.001, 0.001); // Vague prior on residual error

}


generated quantities{

vector[n] resid; // Residuals
resid = pw - mu; // Calculate resids 'by hand'

}