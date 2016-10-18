data{
  // sample data
  int numClaims;
  real Severity[numClaims];

  // prior parameters
  real sevShape;
  real sevRate;

}

parameters{
  real sevTheta;
}

model{
  sevTheta ~ gamma(sevShape, sevRate);
}

generated quantities{
  real proj_severity;
  
  proj_severity = exponential_rng(1 / sevTheta);

}
