package{
	
	import mx.collections.ArrayCollection;
	import mx.controls.DateField;
	
	public class Scripts{
		public function Scripts(){
		}
		/**
		 *Crt+Shift+D 
		 * @param rut rut a validar ejemplo:11222333
		 * @param validador digito validador del rut, ejemplo: ,1,...,10\n
		 * K: 10
		 * 0: 11
		 * @return si es válido retorna true, de lo contrario false
		 * 
		 */		
		public static  function checkRut(rut:String, validador:int):Boolean{
			var lista:ArrayCollection = new ArrayCollection;
			lista.addItem("3");
			lista.addItem("2");
			lista.addItem("7");
			lista.addItem("6");
			lista.addItem("5");
			lista.addItem("4");
			lista.addItem("3");
			lista.addItem("2");
			// ("4","3","2","7","6","5","4","3","2");
			var i:int, suma:int=0, flag:int =0, j:int=7;
			
			for (i=rut.length-1; flag==0; i--){
				if(i>=0)
					suma+=parseInt(rut.charAt(i))*parseInt(lista.getItemAt(j) as String);
				else{
					flag=-1;
				}
				j--;				
			}
			var resto:int= suma%11;
			var calc:int = 11 - resto;
			if(validador==calc)
				return true;
			return false;
		}
		/**
		 * formatea los datefield al formato dd/mm/aaaa
		 * @param date fecha a modificar
		 * @return fecha formateada a dd/mm/aaaa y ademas con los dias de la semana y meses en español
		 * 
		 */		
		
		public static function dateFieldInit(date:DateField):DateField{
       		date.dayNames=['Dom', 'Lun', 'Mar', 
       		'Mie', 'Jue', 'Vie', 'Sab'];
       		date.monthNames=['Enero','Febrero','Marzo','Abril',
            'Mayo','Junio','Julio','Agosto','Septiembre',
            'Octubre','Noviembre','Diciembre'];
              	
            date.firstDayOfWeek = 1;
            date.selectedDate = (new Date());
            date.formatString="DD/MM/YYYY" ;
            return date;
               
  		}
  		/**
  		 * 
  		 * @param bool String que puede ser 't' bool 'f'
  		 * @return true si bool==t, false en otro caso
  		 * 
  		 */  		
  		public static function getBoolean(bool:String):Boolean{
			if(bool=="t")
				return true;
			return false;
		}

	}
}