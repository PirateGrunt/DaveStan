data{
  // sample data
  int numYears;
  int Frequency[numYears];
  int numClaims;
  real Severity[numClaims];

  // prior parameters
  real freqShape;
  real freqRate;
  real sevShape;
  real sevRate;
  
  // treaty structure
  real attachment;

}

parameters{
  real sevTheta;
  real lambda;
}

model{
  lambda ~ gamma(freqShape, freqRate);
  sevTheta ~ gamma(sevShape, sevRate);
}

generated quantities{
  real agg_xs;
  int proj_count;
  real proj_severity[proj_count];
  real xs_severity[proj_count];
  
  proj_count = poisson_rng(lambda);
  
  for (i in 1:proj_count){
    proj_severity[i] = exponential_rng(1 / sevTheta);
    xs_severity[i] = proj_severity[i] - attachment;
    xs_severity[i] = fmax(xs_severity[i], 0);
  }
  
  agg_xs = sum(xs_severity);
}
