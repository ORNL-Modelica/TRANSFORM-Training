within TRANSFORM_Training_2019.Examples.Session_1_ModelicaIntroduction;
model SimpleSinesPlus

  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=1)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Math.Sum sum1(nin=3)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude=1, freqHz=1/10)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Sine sine2(amplitude=1, freqHz=1/100)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  LotkaVolterra lotkaVolterra
    annotation (Placement(transformation(extent={{56,-10},{76,10}})));
equation
  connect(sine2.y, sum1.u[1]) annotation (Line(points={{-19,-40},{-6,-40},{-6,
          -1.33333},{8,-1.33333}}, color={0,0,127}));
  connect(sine1.y, sum1.u[2])
    annotation (Line(points={{-19,0},{8,0}}, color={0,0,127}));
  connect(sine.y, sum1.u[3]) annotation (Line(points={{-19,40},{-6,40},{-6,
          1.33333},{8,1.33333}}, color={0,0,127}));
  connect(sum1.y, lotkaVolterra.u)
    annotation (Line(points={{31,0},{54,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100, __Dymola_NumberOfIntervals=10000));
end SimpleSinesPlus;
