within TRANSFORM_Training_2019.Examples.Session_1_ModelicaIntroduction;
model LotkaVolterra

  extends Modelica.Icons.Example;

  parameter Real alpha = 0.1 "Rate of prey population growth";
  parameter Real beta =  0.02 "Rate of predation";
  parameter Real delta = 0.02 "Rate of predator population growth";
  parameter Real gamma = 0.4 "Rate of predator loss";

  parameter Real x_start = 10 "Initial number of prey";
  parameter Real y_start = 10 "Initial number of predators";

  Real x(start=x_start) "Number of prey";
  Real y(start=y_start) "Number of predators";

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-16},{-100,24}}), iconTransformation(extent={{-140,
            -20},{-100,20}})));
equation
  der(x) = alpha*x-beta*x*y + u;
  der(y) = delta*x*y-gamma*y;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=140, __Dymola_NumberOfIntervals=100),
    Documentation(info="<html>
<p>Classic time-dependent problem modeling the comparison between prey and predator population.</p>
<p>Source:</p>
<p>1. <a href=\"https://en.wikipedia.org/wiki/Competitive_Lotka%E2%80%93Volterra_equations\">https://en.wikipedia.org/wiki/Competitive_Lotka&percnt;E2&percnt;80&percnt;93Volterra_equations</a></p>
<p>2. <a href=\"https://mbe.modelica.university/behavior/equations/population/\">https://mbe.modelica.university/behavior/equations/population/</a></p>
</html>"));
end LotkaVolterra;
