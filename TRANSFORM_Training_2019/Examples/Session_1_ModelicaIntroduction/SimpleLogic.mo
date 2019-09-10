within TRANSFORM_Training_2019.Examples.Session_1_ModelicaIntroduction;
model SimpleLogic

  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.BooleanTable table1(table={2,4,6,8,10}) annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Modelica.Blocks.Sources.BooleanTable table2(table={3,6,9,12}) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Logical.Pre pre1 annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
equation
  connect(and1.y, or1.u2) annotation (Line(points={{31,0},{40,0},{40,22},{48,22}}, color={255,0,255}));
  connect(table1.y, or1.u1) annotation (Line(points={{-49,30},{48,30}}, color={255,0,255}));
  connect(not1.y, and1.u1) annotation (Line(points={{-9,0},{8,0}}, color={255,0,255}));
  connect(pre1.y, and1.u2) annotation (Line(points={{-9,-30},{0,-30},{0,-8},{8,-8}}, color={255,0,255}));
  connect(or1.y, pre1.u) annotation (Line(points={{71,30},{80,30},{80,-50},{-40,-50},{-40,-30},{-32,-30}}, color={255,0,255}));
  connect(table2.y, not1.u) annotation (Line(points={{-49,0},{-32,0}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=12, __Dymola_NumberOfIntervals=100));
end SimpleLogic;
