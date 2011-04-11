package clases
{
	
	public class PlanificacionInformeMensual
	{
		public var numDia:int;
		public var actividadMet1:String;
		public var actividadMet2:String;
		public var actividadMet3:String;
		public var actividadMet4:String;
		public var actividadMet5:String;
		
		public function PlanificacionInformeMensual(dia:int)
		{
			this.numDia=dia;
			this.actividadMet1 = "";
			this.actividadMet2 = "";
			this.actividadMet3 = "";
			this.actividadMet4 = "";
			this.actividadMet5 = "";
		}

	}
}