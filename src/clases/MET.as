package clases{
	
	public class MET{
		public var rut:String;
		public var fecha:String;
		public var nombres:String;
		public var apellidos:String;
		public var direccion:String;
		public var fono_particular:String;
		public var fono_cel:String;
		public var profesion:String;
		public var banco:String;
		public var cuenta_cte:int;
		public var contacto_emerg:String;
		public var relacion_emerg:String;
		public var direccion_emerg:String;
		public var fono_emerg:String;
		public var grupo_sangre:String;
		public var alergias:String;
		public var permiso:String;
		public var contrasena:String;
		public var programable:int;
		public var email:String;
		public var fecha_nacimiento:String;
		public var estado_civil:String;
		public var fecha_ingreso:String;
		public var post_grado:String;
		public var isapre:String;
		public var afp:String;
		public var factor_rh:String;
		public var contraindicaciones:String;
		public var problemas_salud:String;
		public var problemas_legales:String;
		public var conflicto_intereses:String;
		public var observaciones:String;
		public var profesion_casa:String;
		public var post_grado_casa:String;
		public var tipo:String;
		public var archivo:String;
		
		public function MET(rut:String){
			this.rut = rut;
			var temp:Date = new Date;
			this.fecha = temp.getFullYear()+"-"+(temp.getMonth()+1)+"-"+temp.getDate();
			this.archivo="nofile.png";
		}

	}
}