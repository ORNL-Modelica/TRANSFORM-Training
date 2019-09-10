within TRANSFORM_Training_2019.Examples.Session_1_ModelicaIntroduction;
model LorenzSystem
  extends Modelica.Icons.Example;

  parameter Real sigma = 10;
  parameter Real rho = 28;
  parameter Real beta = 8/3;

  parameter Real x_start = 1 "Initial x-coordinate" annotation(Dialog(tab="Initialization"));
  parameter Real y_start = 1 "Initial y-coordinate" annotation(Dialog(tab="Initialization"));
  parameter Real z_start = 1 "Initial z-coordinate" annotation(Dialog(tab="Initialization"));

  Real x "x-coordinate";
  Real y "y-coordinate";
  Real z "z-coordinate";

initial equation
  x = x_start;
  y = y_start;
  z = z_start;

equation
  der(x) = sigma*(y-x);
  der(y) = rho*x - y - x*z;
  der(z) = x*y - beta*z;

  annotation (Documentation(info="<html>
<p>Model of a Lorenz system or atractor.</p>
<p><br>This example will introduce the user to:</p>
<ul>
<li>extending models,</li>
<li>defining parameters and variables,</li>
<li>intialzing state variables,</li>
<li>writing ODEs,</li>
<li>specifying annotations, and</li>
<li>controlling simulation length</li>
</ul>
</html>"), experiment(StopTime=100, __Dymola_NumberOfIntervals=1000));
end LorenzSystem;
