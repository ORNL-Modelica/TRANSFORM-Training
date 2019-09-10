within TRANSFORM_Training_2019.Examples.Session_3_TRANSFORMAdvanced_I;
model FlowLoop_Step_5 "Add trace component"

  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Water.StandardWater(extraPropertiesNames={"Tritium"});

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface hotLeg(
    redeclare package Medium = Medium,
    p_a_start=100000,
    T_a_start=323.15,
    m_flow_a_start=1,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=2*0.0254, nV=4),
    redeclare model InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
        (Q_gen=kinetics.Q_total/4),
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gen={1e-4*kinetics.Q_total}))
                                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface coldLeg(
    redeclare package Medium = Medium,
    p_a_start=100000,
    T_a_start=323.15,
    m_flow_a_start=1,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=2*0.0254, nV=4),
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    use_TraceMassTransfer=true,
    redeclare model TraceMassTransfer =
        TRANSFORM.Fluid.ClosureRelations.MassTransfer.Models.DistributedPipe_TraceMass_1D_MultiTransferSurface.AlphasM
        (redeclare model DiffusionCoeff =
            TRANSFORM.Media.ClosureModels.MassDiffusionCoefficient.Models.GenericCoefficient
            (                                                                                 D_ab0=1),
          alphaM0={1000}),
    exposeState_a=false,
    exposeState_b=true) annotation (Placement(transformation(
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
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium = Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
    boundary(nPorts=coldLeg.geometry.nV, T=fill(15 + 273.15, boundary.nPorts))
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  TRANSFORM.Nuclear.ReactorKinetics.PointKinetics_L1_powerBased kinetics(
    Q_nominal=4*10e3,
    nFeedback=1,
    alphas_feedback={-2.5e-5},
    vals_feedback={if time < 5000 then kinetics.vals_feedback_reference[1]
         else hotLeg.summary.T_effective},
    vals_feedback_reference={92.67 + 273.15})
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Mass.Concentration_multi boundary1(nPorts=coldLeg.geometry.nV)
    annotation (Placement(transformation(extent={{82,18},{62,38}})));
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
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000, __Dymola_NumberOfIntervals=10000),
    __Dymola_Commands(file="Resources/modelica/plot_FlowLoop.mos"
        "plot_FlowLoop"));
end FlowLoop_Step_5;
