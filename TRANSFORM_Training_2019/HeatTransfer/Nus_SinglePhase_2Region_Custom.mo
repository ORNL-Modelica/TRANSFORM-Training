within TRANSFORM_Training_2019.HeatTransfer;
model Nus_SinglePhase_2Region_Custom "Specify Nus | Single Phase | Custom"
  extends
    TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialSinglePhase;
  input Modelica.SIunits.NusseltNumber[nHT,nSurfaces] Nus_lam={{4.36 for j in 1:
      nSurfaces} for i in 1:nHT} "Laminar Nusselt number"
    annotation (Dialog(group="Inputs"));
  input Modelica.SIunits.NusseltNumber[nHT,nSurfaces] Nus_turb={{
      TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.SinglePhase.InternalFlow.Nu_SiederTate(
       Res[i], Prs[i], 0.9) for j in 1:nSurfaces} for i in 1:nHT}
    "Turbulent Nusselt number" annotation (Dialog(group="Inputs"));
  input Modelica.SIunits.Length[nHT,nSurfaces] L_char=transpose({dimensions
      for i in 1:nSurfaces})
    "Characteristic dimension for calculation of alpha"
    annotation (Dialog(group="Inputs"));
  input Modelica.SIunits.ThermalConductivity[nHT,nSurfaces] lambda=transpose({
      mediaProps.lambda for i in 1:nSurfaces})
    "Thermal conductivity for calculation of alpha"
    annotation (Dialog(group="Inputs"));
equation
  for i in 1:nHT loop
    for j in 1:nSurfaces loop
      Nus[i, j] = TRANSFORM.Math.spliceTanh(
        Nus_turb[i,j],
        Nus_lam[i,j],
        Res[i] - Re_center,
        Re_width);
    end for;
  end for;
  alphas = Nus.*lambda./L_char;
  annotation (defaultComponentName="heatTransfer",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Nus_SinglePhase_2Region_Custom;
