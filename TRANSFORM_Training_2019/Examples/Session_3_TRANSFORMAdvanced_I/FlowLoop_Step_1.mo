within TRANSFORM_Training_2019.Examples.Session_3_TRANSFORMAdvanced_I;
model FlowLoop_Step_1 "Add base components"
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface hotLeg annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface coldLeg annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={40,0})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank
    annotation (Placement(transformation(extent={{-10,36},{10,56}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
equation

  connect(hotLeg.port_b, tank.port_a)
    annotation (Line(points={{-40,10},{-40,40},{-7,40}}, color={0,127,255}));
  connect(pump.port_b, hotLeg.port_a)
    annotation (Line(points={{-10,-40},{-40,-40},{-40,-10}}, color={0,127,255}));
  connect(pump.port_a, coldLeg.port_b)
    annotation (Line(points={{10,-40},{40,-40},{40,-10}}, color={0,127,255}));
  connect(coldLeg.port_a, tank.port_b)
    annotation (Line(points={{40,10},{40,40},{7,40}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end FlowLoop_Step_1;
