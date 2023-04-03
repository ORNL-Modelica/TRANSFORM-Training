within TRANSFORM_Training_2019.Examples.Session_3_TRANSFORMAdvanced_I;
model FlowLoop_Step_11 "Add unit test"

  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Water.StandardWater(extraPropertiesNames={"Tritium"});

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface hotLeg(
    redeclare package Medium = Medium,
    p_a_start=100000,
    T_a_start=323.15,
    m_flow_a_start=1,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe (
         dimension=2*0.0254, nV=4),
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration (
         mC_gen={1e-4*kinetics.Q_total}),
    showColors=true,
    val_min=40 + 273.15,
    val_max=100 + 273.15)           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface coldLeg(
    redeclare package Medium = Medium,
    p_a_start=100000,
    T_a_start=323.15,
    m_flow_a_start=1,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe (
         dimension=2*0.0254, nV=4),
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    use_TraceMassTransfer=true,
    redeclare model TraceMassTransfer =
        TRANSFORM.Fluid.ClosureRelations.MassTransfer.Models.DistributedPipe_TraceMass_1D_MultiTransferSurface.AlphasM (
         redeclare model DiffusionCoeff =
            TRANSFORM.Media.ClosureModels.MassDiffusionCoefficient.Models.GenericCoefficient (D_ab0=1),
          alphaM0={1000}),
    exposeState_a=false,
    exposeState_b=true,
    showColors=true,
    val_min=40 + 273.15,
    val_max=100 + 273.15)
                        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={40,0})));

  TRANSFORM.Fluid.Volumes.ExpansionTank tank(
    redeclare package Medium = Medium,
    A=Modelica.Constants.pi*(6*0.0254)^2,
    p_start=100000,
    level_start=1,
    h_start=tank.Medium.specificEnthalpy_pT(tank.p_start, 50 + 273.15))
    annotation (Placement(transformation(extent={{-10,36},{10,56}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Medium,
    p_a_start=100000,
    p_b_start=110000,
    T_a_start=323.15,
    m_flow_start=1,
    m_flow_nominal=1) annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
    boundary(nPorts=coldLeg.geometry.nV, T=fill(15 + 273.15, boundary.nPorts))
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  TRANSFORM.Nuclear.ReactorKinetics.PointKinetics_L1_powerBased kinetics(
    Q_nominal=4*10e3,
    rho_input=PID.y + numericInputIO.Value,
    nFeedback=1,
    alphas_feedback={-2.5e-5},
    vals_feedback={hotLeg.summary.T_effective},
    vals_feedback_reference={92.67 + 273.15})
    "if time < 5000 then kinetics.vals_feedback_reference[1] else"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Mass.Concentration_multi boundary1(nPorts=coldLeg.geometry.nV)
    annotation (Placement(transformation(extent={{82,18},{62,38}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.00001,
    k_s=1/kinetics.Q_nominal,
    k_m=1/kinetics.Q_nominal) annotation (Placement(transformation(extent={{-50,-74},{-30,-54}})));
  Modelica.Blocks.Sources.RealExpression k_s(y=kinetics.Q_nominal)
    annotation (Placement(transformation(extent={{-92,-74},{-72,-54}})));
  Modelica.Blocks.Sources.RealExpression k_m(y=kinetics.Q_total)
    annotation (Placement(transformation(extent={{-92,-102},{-72,-82}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D conduction(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_a1_start=323.15,
    T_a2_start=323.15,
    exposeState_b1=true,
    exposeState_b2=true,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D (
        nX=3,
        nY=hotLeg.geometry.nV,
        length_x=0.5*0.0254,
        length_y=hotLeg.geometry.length,
        length_z=0.0254),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration (
         Q_gen=kinetics.Q_total/(conduction.geometry.nX*conduction.geometry.nY)))
    annotation (Placement(transformation(extent={{-82,34},{-62,54}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic(nPorts=conduction.geometry.nY)
    annotation (Placement(transformation(extent={{-110,34},{-90,54}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic1(nPorts=conduction.geometry.nX)
    annotation (Placement(transformation(extent={{-110,56},{-90,76}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic2(nPorts=conduction.geometry.nX)
    annotation (Placement(transformation(extent={{-110,12},{-90,32}})));
  TRANSFORM.Utilities.Visualizers.DynamicGraph graph(
    use_port=true,
    y_name="Power [MW]",
    y_max=100,
    t_end=10000)
    annotation (Placement(transformation(extent={{36,-100},{100,-40}})));
  TRANSFORM.Utilities.Visualizers.displayReal display(use_port=true, precision=
        1) annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  SIadd.Conversions.Models.Conversion conversion(redeclare function convert =
        SIadd.Conversions.Functions.PrefixMultipliers.to_kilo)
    annotation (Placement(transformation(extent={{-32,-102},{-12,-82}})));
  TRANSFORM.Utilities.Visualizers.Inputs.NumericInputIO numericInputIO
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  TRANSFORM.Utilities.ErrorAnalysis.UnitTests unitTests(x={kinetics.Q_total})
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
equation

  connect(hotLeg.port_b, tank.port_a)
    annotation (Line(points={{-40,10},{-40,40},{-7,40}}, color={0,127,255}));
  connect(pump.port_b, hotLeg.port_a)
    annotation (Line(points={{-10,-40},{-40,-40},{-40,-10}}, color={0,127,255}));
  connect(pump.port_a, coldLeg.port_b)
    annotation (Line(points={{10,-40},{40,-40},{40,-10}}, color={0,127,255}));
  connect(coldLeg.port_a, tank.port_b)
    annotation (Line(points={{40,10},{40,40},{7,40}}, color={0,127,255}));
  connect(boundary.port, coldLeg.heatPorts[:, 1])
    annotation (Line(points={{62,0},{45,0}}, color={191,0,0}));
  connect(boundary1.port, coldLeg.massPorts[:, 1])
    annotation (Line(points={{62,28},{54,28},{54,4},{45,4}}, color={0,140,72}));
  connect(k_s.y, PID.u_s) annotation (Line(points={{-71,-64},{-52,-64}}, color={0,0,127}));
  connect(k_m.y, PID.u_m) annotation (Line(points={{-71,-92},{-40,-92},{-40,-76}}, color={0,0,127}));
  connect(adiabatic.port, conduction.port_a1)
    annotation (Line(points={{-90,44},{-82,44}}, color={191,0,0}));
  connect(adiabatic1.port, conduction.port_b2)
    annotation (Line(points={{-90,66},{-72,66},{-72,54}}, color={191,0,0}));
  connect(adiabatic2.port, conduction.port_a2)
    annotation (Line(points={{-90,22},{-72,22},{-72,34}}, color={191,0,0}));
  connect(conduction.port_b1, hotLeg.heatPorts[:, 1]) annotation (Line(points={
          {-62,44},{-54,44},{-54,0},{-45,0}}, color={191,0,0}));
  connect(k_m.y, conversion.u)
    annotation (Line(points={{-71,-92},{-34,-92}}, color={0,0,127}));
  connect(conversion.y, display.u) annotation (Line(points={{-10,-92},{-6,-92},
          {-6,-80},{-1.5,-80}}, color={0,0,127}));
  connect(conversion.y, graph.u) annotation (Line(points={{-10,-92},{-6,-92},{
          -6,-72.3077},{33.2571,-72.3077}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{120,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{
            120,100}})),
    experiment(StopTime=10000, __Dymola_NumberOfIntervals=10000),
    __Dymola_Commands(file="Resources/modelica/plot_FlowLoop.mos"
        "plot_FlowLoop"));
end FlowLoop_Step_11;
