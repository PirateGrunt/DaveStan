data{
  // sample data
  int numClaims;
  real Severity[numClaims];

  // prior parameters
  real sevShape;
  real sevRate;
  
  // treaty structure
  real attachment;

}

parameters{
  real sevTheta;
}

model{
  sevTheta ~ gamma(sevShape, sevRate);
}

generated quantities{
  real proj_severity;
  real xs_severity;
  
  proj_severity = exponential_rng(1 / sevTheta);
  
  xs_severity = proj_severity - attachment;
  xs_severity = fmax(xs_severity, 0);
}
