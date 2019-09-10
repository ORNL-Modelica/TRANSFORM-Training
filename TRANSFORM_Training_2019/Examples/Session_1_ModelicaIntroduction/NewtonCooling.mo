within TRANSFORM_Training_2019.Examples.Session_1_ModelicaIntroduction;
model NewtonCooling "Lumped cooling"
  extends Modelica.Icons.Example;

  import SI = Modelica.SIunits;

  parameter Boolean toggleNoise=true "=true to add noise to T_ambient";
  parameter SI.Temperature T_start=SI.Conversions.from_degC(90) "Initial temperature";
  parameter SI.CoefficientOfHeatTransfer alpha=0.1 "Convection coefficient";
  parameter SI.Area surfaceArea=0.1 "Surface area";
  parameter SI.Mass m=100.0 "Thermal mass";
  parameter SI.SpecificHeatCapacity cp=1.2 "Specific heat capacity";

  SI.Temperature T_ambient=SI.Conversions.from_degC(25) + 10*Modelica.Math.sin(time/(24*60*60)*2*Modelica.Constants.pi) "Ambient temperature";
  SI.Temperature T "Temperature";
  SI.Temperature T_effective "Temperature with noise";

  Modelica.Blocks.Noise.UniformNoise uniformNoise(
    samplePeriod=24*60,
    y_min=0,
    y_max=20) "Noise added to T_ambient"
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

initial equation
  T = T_start "Specify initial value for T";

equation

  m*cp*der(T) = alpha*surfaceArea*(T_effective - T) "Newton's law of cooling";

  if toggleNoise then
    T_effective = T_ambient + uniformNoise.y;
  else
    T_effective = T_ambient;
  end if;

  annotation (Documentation(info="<html>
<p>Model of a simple newton cooling of a lumped thermal mass.</p>
<p><br>This example will build on the &quot;LorenzSystem&quot; example and introduce the user to:</p>
<ul>
<li>specifying units (i.e., importing),</li>
<li>using custom function (i.e., for unit conversions),</li>
<li>providing comments to parameters and variables,</li>
<li>booleans,</li>
<li>adding components to models, and</li>
<li>using &quot;if&quot; logic</li>
</ul>
</html>"), experiment(StopTime=172800, NumberOfIntervals=2880));
end NewtonCooling;
