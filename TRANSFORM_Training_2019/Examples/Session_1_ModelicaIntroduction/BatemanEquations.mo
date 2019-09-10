within TRANSFORM_Training_2019.Examples.Session_1_ModelicaIntroduction;
model BatemanEquations
  extends Modelica.Icons.Example;

  parameter Integer n = 4 "Number of isotopes in decay chain";

  parameter Real[n] lambdas(unit="1/s") = {0.01,0.05,0.05,0.01} "Decay constant for isotope i";
  parameter Real[n] sigmas(unit="m2") = {0.4,0.3,0.2,0.1} "Yield cross-section for isotope i generation";
  parameter Real phi = 1 "Flux";
  parameter Real[n] Ns_start = {500,100,300,200} "Initial number of atoms for isotope i";

  Real[n] Nbs "Sources and sinks for isotope i";
  Real[n] Ns(start=Ns_start) "Atoms of isotope i";

initial equation
  Ns = Ns_start;

equation
  der(Ns) = Nbs;
  Nbs[1] = phi*sigmas[1] - lambdas[1]*Ns[1];
  for i in 2:n loop
    Nbs[i] = phi*sigmas[i] - lambdas[i]*Ns[i] + lambdas[i-1]*Ns[i-1];
  end for;

  annotation (Documentation(info="<html>
<p>Model of a the decay of radioisotopes or Bateman equations.</p>
<p><br>This example will build on the &quot;LorenzSystem&quot; and &quot;NewtonCooling&quot; examples and introduce the user to:</p>
<ul>
<li>arrays/matrices,</li>
<li>&quot;for loops&quot;, and</li>
<li>alternative means to specify units</li>
</ul>
</html>"));
end BatemanEquations;
