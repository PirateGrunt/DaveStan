data{
  // sample data
  int numClaims;
  real Severity[numClaims];

  // prior parameters
  real sevShape;
  real sevRate;
  
  // treaty structure
  real attachment;
  
  // generated quantities
  int newClaims;
  int proj_count;
}

parameters{
  real sevTheta;
}

model{
  sevTheta ~ gamma(sevShape, sevRate);
}

generated quantities{
  real agg_xs;
  
  proj_count = poisson_rng(newClaims);
  
  real proj_severity[proj_count];
  real xs_severity[proj_count];
  
  for (i in 1:proj_count){
    proj_severity[i] = exponential_rng(1 / sevTheta);
    xs_severity[i] = proj_severity[i] - attachment;
    if (xs_severity[i] < 0) xs_severity[i] = 0;
  }
  
  agg_xs = sum(xs_severity);
}
