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
  
}

parameters{
  real sevTheta;
}

model{
  sevTheta ~ gamma(sevShape, sevRate);
}

generated quantities{
  
  real proj_severity[newClaims];
  real xs_severity[newClaims];
  real agg_xs;
  
  for (i in 1:newClaims){
    proj_severity[i] = exponential_rng(1 / sevTheta);
    xs_severity[i] = proj_severity[i] - attachment;
    xs_severity[i] = fmax(xs_severity[i], 0);
  }
  
  agg_xs = sum(xs_severity);
}
