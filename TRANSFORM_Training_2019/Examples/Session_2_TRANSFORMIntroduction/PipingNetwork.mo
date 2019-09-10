within TRANSFORM_Training_2019.Examples.Session_2_TRANSFORMIntroduction;
model PipingNetwork "Based on "
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Water.StandardWater;

  TRANSFORM.Fluid.Volumes.ExpansionTank_1Port waterMonster(
    redeclare package Medium = Medium,
    A=0.475,
    p_surface=100000,
    p_start=100000,
    level_start=1,
    use_T_start=true,
    T_start=293.15,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{10,30},{30,50}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT containers(
    redeclare package Medium = Medium,
    p=100000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-40})));
  TRANSFORM.Fluid.Valves.ValveLinear spigots(
    redeclare package Medium = Medium,
    dp_nominal(displayUnit="Pa") = 100,
    m_flow_nominal=0.01) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,0})));
  TRANSFORM.Blocks.Noise.PRTS sequencerPRTS(
    amplitude=0.25,
    freqHz=0.1,
    offset=0.5,
    nBits=5) annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.5)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  TRANSFORM.Blocks.Noise.PRBS sequencerPRBS(
    amplitude=0.5,
    freqHz=sequencerPRTS.freqHz,
    bias=-0.5,
    nBits=8)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(spigots.port_a, waterMonster.port)
    annotation (Line(points={{20,10},{20,31.6}},
                                               color={0,127,255}));
  connect(spigots.port_b, containers.ports[1])
    annotation (Line(points={{20,-10},{20,-30}},
                                               color={0,127,255}));
  connect(firstOrder.y, spigots.opening)
    annotation (Line(points={{1,0},{12,0}}, color={0,0,127}));
  connect(sequencerPRTS.y, add.u1) annotation (Line(points={{-69,20},{-62,20},{
          -62,6},{-52,6}}, color={0,0,127}));
  connect(sequencerPRBS.y, add.u2) annotation (Line(points={{-69,-20},{-62,-20},
          {-62,-6},{-52,-6}}, color={0,0,127}));
  connect(add.y, firstOrder.u)
    annotation (Line(points={{-29,0},{-22,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3600, __Dymola_NumberOfIntervals=3600));
end PipingNetwork;
