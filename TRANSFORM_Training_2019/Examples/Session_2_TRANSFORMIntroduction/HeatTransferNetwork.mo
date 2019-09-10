within TRANSFORM_Training_2019.Examples.Session_2_TRANSFORMIntroduction;
model HeatTransferNetwork "Based on Todreas & Kazimi Problem 8-4"
  extends Modelica.Icons.Example;

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic centerLine
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D fuel(
    redeclare package Material = TRANSFORM.Media.Solids.UO2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=973.15,
    exposeState_b1=true,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_1D_r
        (
        nR=20,
        r_inner=0,
        r_outer=cladding.geometry.r_inner - 230e-6,
        length_z=3),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
        (q_ppp=44e3*fuel.geometry.length_z/fuel.geometry.V_total))
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder gap(
    L=fuel.geometry.length_z,
    r_in=fuel.geometry.r_outer,
    r_out=cladding.geometry.r_inner,
    lambda=4300*(gap.r_out - gap.r_in))
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D cladding(
    redeclare package Material = TRANSFORM.Media.Solids.ZrNb_E125,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=573.15,
    exposeState_b1=true,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_1D_r
        (
        nR=8,
        r_inner=cladding.geometry.r_outer - 0.00086,
        r_outer=0.00626,
        length_z=fuel.geometry.length_z))
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(
      surfaceArea=cladding.geometry.crossAreas_1[end], alpha=20000)
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(T=512.217)
                annotation (Placement(transformation(extent={{80,-20},{60,0}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow  centerLine1(Q_flow=
        44e3*3)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder       fuel1(
    L=fuel.geometry.length_z,
    r_in=fuel.geometry.r_inner,
    r_out=fuel.geometry.r_outer,
    lambda=2.7*0.88/(1 + 0.5*(1 - 0.88))*(1 + 0.5*(1 - 0.95))/0.95)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder gap1(
    L=gap.L,
    r_in=gap.r_in,
    r_out=gap.r_out,
    lambda=gap.lambda)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder       cladding1(
    L=cladding.geometry.length_z,
    r_in=cladding.geometry.r_inner,
    r_out=cladding.geometry.r_outer,
    lambda=17)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1(
      surfaceArea=convection.surfaceArea, alpha=convection.alpha)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary1(T=
        boundary.T)
                annotation (Placement(transformation(extent={{80,30},{60,50}})));
equation
  connect(fuel.port_a1, centerLine.port)
    annotation (Line(points={{-60,-10},{-70,-10}}, color={191,0,0}));
  connect(cladding.port_b1, convection.port_a)
    annotation (Line(points={{20,-10},{33,-10}}, color={191,0,0}));
  connect(convection.port_b, boundary.port)
    annotation (Line(points={{47,-10},{60,-10}}, color={191,0,0}));
  connect(gap.port_b, cladding.port_a1)
    annotation (Line(points={{-13,-10},{0,-10}}, color={191,0,0}));
  connect(fuel.port_b1, gap.port_a)
    annotation (Line(points={{-40,-10},{-27,-10}}, color={191,0,0}));
  connect(convection1.port_b, boundary1.port)
    annotation (Line(points={{47,40},{60,40}}, color={191,0,0}));
  connect(centerLine1.port, fuel1.port_a)
    annotation (Line(points={{-70,40},{-57,40}}, color={191,0,0}));
  connect(fuel1.port_b, gap1.port_a)
    annotation (Line(points={{-43,40},{-27,40}}, color={191,0,0}));
  connect(gap1.port_b, cladding1.port_a)
    annotation (Line(points={{-13,40},{3,40}}, color={191,0,0}));
  connect(cladding1.port_b, convection1.port_a)
    annotation (Line(points={{17,40},{33,40}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5000, __Dymola_NumberOfIntervals=5000));
end HeatTransferNetwork;
