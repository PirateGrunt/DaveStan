data{
  // sample data
  int numYears;
  int Frequency[numYears];

  // prior parameters
  real freqShape;
  real freqRate;
}

parameters{
  real lambda;
}

model{
  lambda ~ gamma(freqShape, freqRate);
}

generated quantities{
  int proj_count;
  proj_count = poisson_rng(lambda);
}