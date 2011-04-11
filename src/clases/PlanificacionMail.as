package clases
{
	public class PlanificacionMail
	{
		public var email:String;
		public var num_semana:int;
		public var mensaje:String;
		public function PlanificacionMail(semana:String)
		{
			this.mensaje = "Se ha modificado su planificación en la "+semana+
			"\nFavor revisar calendario de actividades";
		}

	}
}