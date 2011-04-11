package{
	import clases.Cliente;
	import clases.Consultoria;
	import clases.capacitaciones.Alumno;
	import clases.capacitaciones.Curso;
	import clases.capacitaciones.DD;
	import clases.capacitaciones.DesarrolloDD;
	import clases.capacitaciones.PlanificacionDD;
	import clases.inventario.Despacho;
	import clases.inventario.Producto;
	
	
	public class Conexion{
    	import clases.RemotingConnection;
        import mx.collections.ArrayCollection;
        import mx.controls.Alert;
        import flash.net.Responder;
        import clases.MET;
        import remoting.vo.FileVO;
        
        public var gateway : RemotingConnection;
        [Bindable]
        public var listaMET:ArrayCollection;
        public var listaPlanificaciones:ArrayCollection;
		public var listaDespacho:ArrayCollection;
		public var listaIngreso:ArrayCollection;
		public var listaProducto:ArrayCollection;
		[Bindable]
		public var listaDD:ArrayCollection;
		public var listaCliente:ArrayCollection
		private var respuesta:int;//0 correcta, 1 incorrecta
		private var flag:int;
		[Bindable]
		public var object:Object = new Object;
		[Bindable]
		public var lista:ArrayCollection;
		public var listaCursos:ArrayCollection;
		public var listaAlumno:ArrayCollection;
		public var listaAlumnoFinal:ArrayCollection
		public var listaAlumnoCurso:ArrayCollection
		
		public function Conexion(){
			gateway = new RemotingConnection( "http://www.kimen.cl/amfphp/gateway.php" );
			listaCursos = new ArrayCollection;
			lista = new ArrayCollection;
			listaMET = new ArrayCollection;
			listaPlanificaciones = new ArrayCollection;
			listaDespacho = new ArrayCollection;
			listaIngreso = new ArrayCollection;
			listaProducto = new ArrayCollection;
			listaDD = new ArrayCollection;
			listaCliente = new ArrayCollection;
			listaAlumno = new ArrayCollection;
			listaAlumnoFinal = new ArrayCollection;
			listaAlumnoCurso = new ArrayCollection;
			respuesta=1;
		}
		//MENSAJES POR DEFECTO
		public function onUpdateFault( fault : Object ) : void{
			Alert.show("Error al actualizar el registro!.");
		}
		public function onUpdateResult(result:String):void{
			respuesta=0;
			Alert.show("Actualización realizada exitosamente!.");
		}
		public function onInsertResult(result:String):void{
			Alert.show("Registro ingresado exitosamente!.");
		}
		public function onDeleteFault( fault : Object ) : void{
			Alert.show("Error al eliminar el registro!.");
		}
		public function onDeleteResult( fault : Object ) : void{
			Alert.show("Registro eliminado exitosamente!.");
		}
		public function noMessageResult(result:String):void{
			
		}
		//FUNCIONES Y SUS MENSAJES
		
		
        //ADMINISTRACION
		public function getAllMets():ArrayCollection{
			gateway.call( "administracion.getAllMet", new Responder(onGetAllMetResult, onGetAllMetFault));
			
			return listaMET;
		} 
		public function onGetAllMetResult( result : Array ) : void{
			var i:int;			
           	for(i=0;i<result.length;i++){
				listaMET.addItemAt(result[i],i);
			}
		}
		public function onGetAllMetFault( fault : Object ) : void{
			Alert.show("Error al obtener METs de la base de datos.");
		}
		
		public function insertMet(met:MET):void{
			//Alert.show("fecha: "+met.fecha);
			gateway.call("administracion.insertMET",new Responder(onInsertMetResult, onInsertMetFault), met.rut.toUpperCase(), 
			met.nombres, met.apellidos, met.direccion, met.fono_particular, met.fono_cel, met.profesion, 
			met.banco, met.cuenta_cte, met.contacto_emerg, met.relacion_emerg, met.direccion_emerg, 
			met.fono_emerg, met.grupo_sangre, met.alergias, met.permiso, met.fecha, met.contrasena,met.programable,
			met.email, met.fecha_nacimiento, met.estado_civil, met.fecha_ingreso, met.post_grado, met.isapre, met.afp, 
			met.factor_rh, met.contraindicaciones, met.problemas_salud, met.problemas_legales, 
			met.conflicto_intereses, met.observaciones, met.profesion_casa, met.post_grado_casa, met.tipo, met.archivo);
		}
		public function onInsertMetResult(result:String):void{
			Alert.show("Registro ingresado exitosamente!. El usario y contraseña es el Rut, se recomienda que se cambie la contraseña la próxima vez que se ingrese.");
		}
		public function onInsertMetFault( fault : Object ) : void{
			Alert.show("Error al registrar nuevo MET.");
		}
		
		public function insertConsultoria(consultoria:Consultoria):void{
			//Alert.show("fecha: "+met.fecha);
			gateway.call("administracion.insertConsultoria",new Responder(noMessageResult, onInsertConsultFault), 
			consultoria.jornada, consultoria.met, consultoria.fecha, consultoria.actividad);
		}
		public function onInsertConsultFault( fault : Object ) : void{
			Alert.show("Error al registrar!, consultoría ya registrada.");
		}
		public function updateMET(rutAntiguo:String, met:MET):int{
			//Alert.show("fecha: "+met.fecha);
			gateway.call("administracion.updateMET",new Responder(onUpdateResult, onUpdateMetFault), rutAntiguo, 
			met.rut.toUpperCase(), met.nombres, met.apellidos, met.direccion, met.fono_particular, met.fono_cel, met.profesion, 
			met.banco, met.cuenta_cte, met.contacto_emerg, met.relacion_emerg, met.direccion_emerg, 
			met.fono_emerg, met.grupo_sangre, met.alergias, met.permiso, met.fecha, met.contrasena,met.programable, 
			met.email, met.fecha_nacimiento, met.estado_civil, met.fecha_ingreso, met.post_grado, met.isapre, met.afp, 
			met.factor_rh, met.contraindicaciones, met.problemas_salud, met.problemas_legales, 
			met.conflicto_intereses, met.observaciones, met.profesion_casa, met.post_grado_casa, met.tipo, met.archivo);
			return respuesta;
		}
		public function updateContrasena(rut:String, contrasena:String):void{
			gateway.call("administracion.updateContrasena",new Responder(onUpdateResult, onUpdateFault),
			rut,contrasena);
		}
		public function onUpdateMetFault( fault : Object ) : void{
			respuesta=1;
			Alert.show("Error al actualizar MET.");
		}
		public function deleteMET(rut:String):void{
			//Alert.show("fecha: "+met.fecha);
			gateway.call("administracion.deleteMET",new Responder(onDeleteResult, onDeleteFault), rut);
		}
		public function getAllConsultoria():ArrayCollection{
			//Alert.show("fecha: "+met.fecha);
			gateway.call("administracion.getAllConsultoria",new Responder(onGetAllConsultoriaResult, onGetAllConsultoriaFault));
			return listaPlanificaciones;			
		}
		public function onGetAllConsultoriaFault( fault : Object ) : void{
			Alert.show("Error al obtener las consultorías.");
		}
		public function onGetAllConsultoriaResult(result:Array):void{
			var i:int;
           	for(i=0;i<result.length;i++){
				listaPlanificaciones.addItemAt(result[i],i);
			}
			
		}
		public function updateConsult(consultoria:Consultoria):void{
			gateway.call("administracion.updateConsultoria",new Responder(function nada():void{}),
			consultoria.jornada, consultoria.met, consultoria.fecha, consultoria.actividad);
		}
		public function deleteConsult(consultoria:Consultoria):void{
			gateway.call("administracion.deleteConsultoria",new Responder(function nada():void{}),
			consultoria.jornada, consultoria.met, consultoria.fecha);
		}
		public function getAllDespacho():ArrayCollection{
			gateway.call("inventario.getAllDespacho",new Responder(onGetAllDespachoResult, onGetAllDespachoFault));
			return listaDespacho;
		}
		public function onGetAllDespachoResult(result:Array):void{
			var i:int;
           	for(i=0;i<result.length;i++){
				listaDespacho.addItemAt(result[i],i);
			}
		}
		public function onGetAllDespachoFault( fault : Object ) : void{
			Alert.show("Error al obtener los despachos de productos.");
		}
		public function getAllIngreso():ArrayCollection{
			gateway.call("inventario.getAllDespacho",new Responder(onGetAllIngresoResult, onGetAllIngresoFault));
			return listaIngreso;
		}
		public function onGetAllIngresoResult(result:Array):void{
			var i:int;
           	for(i=0;i<result.length;i++){
				listaIngreso.addItemAt(result[i],i);
			}
		}
		public function onGetAllIngresoFault( fault : Object ) : void{
			Alert.show("Error al obtener los ingresos de productos.");
		}
		public function getAllProducto():ArrayCollection{
			gateway.call("inventario.getAllProducto",new Responder(onGetAllProductoResult, onGetAllProductoFault));
			
			return listaProducto;
		}
		public function onGetAllProductoResult(result:Array):void{
			var i:int;
           	for(i=0;i<result.length;i++){
				listaProducto.addItemAt(result[i],i);
			}
		}
		public function onGetAllProductoFault( fault : Object ) : void{
			Alert.show("Error al obtener los productos del inventario.");
		}
		public function insertDespacho(despacho:Despacho):void{
			gateway.call("inventario.insertDespacho",new Responder(onInsertResult, onInsertDespachoFault), 
			despacho.cantidad, despacho.responsable, despacho.destino, despacho.producto_codigo, despacho.producto_nombre);
		}
		public function onInsertDespachoFault( fault : Object ) : void{
			Alert.show("Error al registrar!, despacho ya registrado.");
		}
		public function insertProducto(producto:Producto):void{
			gateway.call("inventario.insertProducto",new Responder(onInsertResult, onInsertProductoFault), 
			producto.nombre, producto.descripcion, producto.unidad, producto.stock_seguridad);
		}
		public function onInsertProductoFault( fault : Object ) : void{
			Alert.show("Error al registrar!, producto ya registrado.");
		}
		public function deleteDespacho(transaccion:int):void{
			gateway.call("inventario.deleteDespacho",new Responder(onDeleteResult, onDeleteFault),
			transaccion);
		}
		public function uploadFile(file:FileVO, rut:String):void {
			gateway.call("RemoteFile.upload",new Responder(onUploadResult, onUploadFault),
			file,rut);
        }
        public function onUploadResult( fault : Object ) : void{
			Alert.show("Archivo subido exitosamente");
		}
		public function onUploadFault( fault : Object ) : void{
			Alert.show("Error al subir el archivo");
		}
		public function downloadFile(rut:String):void{
			gateway.call("RemoteFile.download",new Responder(onDownloadResult, onDownloadFault),
			rut);
		}
		public function onDownloadResult( obj : Object ):void{
			this.object = obj;
		}
		public function onDownloadFault( fault : Object ) : void{
			Alert.show("Error al descargar archivo, posiblemente no existe");
		}
		
		
		/////////////////	CAPACITACIONES //////////////////
		
		
		public function getAllDD():ArrayCollection{
			gateway.call( "capacitaciones.getAllDD", new Responder(onGetAllDDResult, onGetAllDDFault));
			
			return listaDD;
		}
		public function onGetAllDDResult( result : Array ) : void{
			var i:int;			
           	for(i=0;i<result.length;i++){
				listaDD.addItemAt(result[i],i);
			}
		}
		public function onGetAllDDFault( fault : Object ) : void{
			Alert.show("Error al obtener los Diseños y Desarrollos de la base de datos.");
		} 
		
		
		public function insertDD(dd:DD):void{
			gateway.call("capacitaciones.insertDD",new Responder(onInsertDDFault, onInsertDDFault), 
			dd.codigo_interno, dd.fecha, dd.responsable_rut, dd.estado, dd.nombre, dd.descripcion, 
			dd.codigo_sence, dd.fecha_validacion, dd.fecha_autorizacion, dd.version);
		}
		public function onInsertDDFault( fault : Object ) : void{
			//LOS MENSAJES LOS MUESTRA insertPlanifDD
			//Alert.show("Error al registrar el Diseño y Desarrollo.");
		} 
		public function insertDesarroDD(planif:DesarrolloDD):void{
			gateway.call("capacitaciones.insertDesarrollo_dd",new Responder(onInsertDesarroFault, onInsertDesarroFault), 
			planif.id_dd, planif.responsable_rut0, planif.responsable_rut1, planif.responsable_rut2, 
			planif.responsable_rut3, planif.responsable_rut4, planif.fecha0, planif.fecha1, planif.fecha2, 
			planif.fecha3, planif.fecha4);
		}
		public function onInsertDesarroFault( fault : Object ) : void{
			//LOS MENSAJES LOS MUESTRA insertPlanifDD
			//Alert.show("Error al registrar el Diseño y Desarrollo.");
		}
		public function updateDD(codigo_interno:String, nombre:String, estado:String):void{
			gateway.call("capacitaciones.updateDD",new Responder(onInsertDDFault, onInsertDDFault), 
			codigo_interno, nombre, estado);
		}
		
		public function getMaxDD(tipo:String):ArrayCollection{
			gateway.call("capacitaciones.getMaxDD",new Responder(onGetMaxDDResult, onGetMaxDDFault), tipo);
			return lista;
		}
		public function onGetMaxDDResult( result : Array  ) : void{
			var i:int;
           	for(i=0;i<result.length;i++){
				lista.addItemAt(result[i],i);
			}
		} 
		public function onGetMaxDDFault( fault : Object ) : void{
			Alert.show("Fallo en obtener datos, revise su conexión a internet");
		} 
		
		
		public function insertPlanifDD(planif:PlanificacionDD):void{
			gateway.call("capacitaciones.insertPlanificacion_dd",new Responder(onInsertResult, onInsertPlanifFault), 
			planif.id_dd, planif.responsable_rut0, planif.responsable_rut1, planif.responsable_rut2, 
			planif.responsable_rut3, planif.responsable_rut4, planif.fecha0, planif.fecha1, planif.fecha2, 
			planif.fecha3, planif.fecha4);
		}
		public function onInsertPlanifFault( fault : Object ) : void{
			Alert.show("Error al Registrar el Diseño y Desarrollo.");
		}
		
		public function updateDesarroDD(planif:DesarrolloDD):void{
			gateway.call("capacitaciones.updateDesarrollo_dd",new Responder(onUpdateResult, onUpdateDesarroFault), 
			planif.id_dd, planif.responsable_rut0, planif.responsable_rut1, planif.responsable_rut2, 
			planif.responsable_rut3, planif.responsable_rut4, planif.fecha0, planif.fecha1, planif.fecha2, 
			planif.fecha3, planif.fecha4, planif.observaciones);
		}
		public function onUpdateDesarroFault( fault : Object ) : void{
			Alert.show("Error al Actualizar el Diseño y Desarrollo.");
		}
		public function deleteDD(codigo_interno:String):void{
			gateway.call("capacitaciones.deleteDD", new Responder(onDeleteResult, onDeleteFault), codigo_interno);
		}
		public function inscribirSENCE(codigoDD:String, responsbleRut:String, fecha:String, codigoSENCE:String):void{
			gateway.call("capacitaciones.inscribirSENCE", new Responder(onInscSENCEResult, onInscSENCEFault), 
			codigoDD, responsbleRut, fecha, codigoSENCE);
		}
		public function onInscSENCEResult( fault : Object ) : void{
			Alert.show("Inscripción SENCE realizada exitosamente!");
		}
		public function onInscSENCEFault( fault : Object ) : void{
			Alert.show("Error en la inscripción SENCE, revise su conexión.");
		}
		
		
		////////////////////---CURSOS---////////////////////////
		
		
		public function insertCurso(c:Curso):void{
			gateway.call("capacitaciones.insertCurso", new Responder(onInsertResult, onInsertCursoFault), 
			c.codigo_interno, c.nombre, c.num_participantes, c.fecha_ejecucion, c.fecha_termino, 
			c.lugar, c.direccion, c.horario_manana_ini, c.horario_manana_fin, c.horario_tarde_ini, 
			c.horario_tarde_fin, c.relator_rut, c.relator_nombre, c.observaciones, c.nota_minima, 
			c.asistencia_minima,c.estado);			
		}
		public function onInsertCursoFault( fault : Object ) : void{
			Alert.show("Error al registrar el Curso.");
		}
		
		public function getAllCurso():ArrayCollection{
			gateway.call( "capacitaciones.getAllCurso", new Responder(onGetAllCursoResult, onGetAllCursoFault));
			
			return listaCursos;
		}
		public function onGetAllCursoResult( result : Array ) : void{
			var i:int;			
           	for(i=0;i<result.length;i++){
				listaCursos.addItemAt(result[i],i);
			}
		}
		public function onGetAllCursoFault( fault : Object ) : void{
			Alert.show("Error al obtener los Cursos de la base de datos.");
		} 
		public function getAllCodigoDD():ArrayCollection{
			gateway.call("capacitaciones.getAllCodigoDD",new Responder(getAllCodigoDDResult,getAllCodigoDDFault));
			return listaDD;
			
		}
		public function getAllCodigoDDResult( result : Array  ) : void{
			var i:int;
			listaDD.addItem("--seleccione--");
           	for(i=0;i<result.length;i++){
				listaDD.addItemAt(result[i],i+1);
			}
		} 
		public function getAllCodigoDDFault( fault : Object ) : void{
			Alert.show("Fallo en obtener datos, revise su conexión a internet");
		} 
		public function getMaxCurso(tipo:String):ArrayCollection{
			gateway.call("capacitaciones.getMaxCurso",new Responder(getMaxCursoResult, getMaxCursoFault), tipo);
			return lista;
		}
		public function getMaxCursoResult( result : Array  ) : void{
			var i:int;
           	for(i=0;i<result.length;i++){
				lista.addItemAt(result[i],i);
			}
		} 
		public function getMaxCursoFault( fault : Object ) : void{
			Alert.show("Fallo en obtener datos, revise su conexión a internet");
		} 
		public function updateCurso(codigo_interno:String, nombre:String, observaciones:String):void{
			gateway.call("capacitaciones.updateCurso",new Responder(onUpdateResult, onUpdateCursoFault), 
			codigo_interno, nombre, observaciones);
			
		}
		public function onUpdateCursoFault( fault : Object ) : void{
			Alert.show("Error al actualizar los datos del Curso: "+fault.message);
		} 
		public function updateEstadoCurso(codigo_interno:String, nuevoEstado:String, 
		nombre:String, observaciones:String):void{
			gateway.call("capacitaciones.updateEstadoCurso",new Responder(onUpdateResult, onUpdateCursoFault), 
			codigo_interno, nuevoEstado, nombre, observaciones);
		}
		public function deleteCurso(codigo:String):void{
			gateway.call("capacitaciones.deleteCurso",new Responder(onDeleteResult, onDeleteFault),codigo);
		}
		
		
		////////////////////---ALUMNOS---/////////////////////
		public function insertAlumnoCurso(rut_alumno:String, id_curso:String, nombres:String, 
		apellidos:String, porc_asistencia:String, nota:String):void
		{
			gateway.call("capacitaciones.insertAlumnoCurso", new Responder(noMessageResult, noMessageResult),
			rut_alumno, id_curso, nombres, apellidos, porc_asistencia, nota);
		}
		public function getAllAlumnosCurso(id_curso:String):ArrayCollection
		{
			gateway.call("capacitaciones.getAllAlumnosCurso", new Responder(onGetAllAlumnosCursoResult, noMessageResult),
			id_curso);
			return listaAlumnoCurso;
		}
		private function onGetAllAlumnosCursoResult( result : Array ) : void{
			var i:int;	
			listaAlumno = new ArrayCollection();	
           	for(i=0;i<result.length;i++){
				listaAlumnoCurso.addItemAt(result[i],i);
			}
		}
		public function deleteAlumnoCurso(rut_alumno:String, id_curso:String):void
		{
			gateway.call("capacitaciones.deleteAlumnoCurso", new Responder(noMessageResult, noMessageResult), 
			rut_alumno, id_curso);
		}
		public function updateAlumnoCurso(rut_alumno:String, id_curso:String, 
		porc_asistencia:String, nota:String):void
		{
			gateway.call("capacitaciones.updateAlumnoCurso", new Responder(noMessageResult, noMessageResult), 
			rut_alumno, id_curso, porc_asistencia, nota);		
		
		}
		public function insertAlumno(a:Alumno):void{
			gateway.call("capacitaciones.insertAlumno", new Responder(onInsertResult, onInsertAlumnoFault), 
			a.rut, a.nombres, a.apellidos, a.nivel_educacional, a.rut_empresa, a.porc_sence);			
		}
		public function onInsertAlumnoFault( fault : Object ) : void{
			Alert.show("Error al registrar al Alumno.");
		}
		//obtiene todos los alumnos existentes
		public function getAllAlumno():ArrayCollection{
			gateway.call( "capacitaciones.getAllAlumno", new Responder(onGetAllAlumnoResult, onGetAllAlumnoFault));
			
			return listaAlumno;
		}
		public function onGetAllAlumnoResult( result : Array ) : void{
			var i:int;	
					
           	for(i=0;i<result.length;i++){
				listaAlumno.addItemAt(result[i],i);
			}
		}
		public function onGetAllAlumnoFault( fault : Object ) : void{
			Alert.show("Error al obtener los Alumnos de la base de datos.");
		} 
		public function deleteAlumno(rut:String):void{
			gateway.call("capacitaciones.deleteAlumno", new Responder(noMessageResult, noMessageResult), rut);			
		}
		public function onDeleteAlumnoFault( fault : Object ) : void{
			Alert.show("Error al eliminar el Alumno.");
		}
		public function updateAlumno(a:Alumno):void{
			gateway.call("capacitaciones.updateAlumno", new Responder(onUpdateResult, onUpdateAlumnoFault), 
			a.rut, a.nombres, a.apellidos, a.nivel_educacional, a.rut_empresa, a.porc_sence, 
			a.porc_asistencia, a.nota);	
		}
		public function updateAlumnoSinMensaje(a:Alumno):void{
			gateway.call("capacitaciones.updateAlumno", new Responder(noMessageResult, noMessageResult), 
			a.rut, a.nombres, a.apellidos, a.nivel_educacional, a.rut_empresa, a.porc_sence, 
			a.porc_asistencia, a.nota);	
		}
		public function onUpdateAlumnoFault( fault : Object ) : void{
			Alert.show("Error al actualizar el Alumno.\nDetalle: "+fault.message);
		}
		//Obtiene los todos los alumnos dado el codigo del curso ingresado
		public function getAllAlumnoFinal(codigo_curso:String):ArrayCollection{
			gateway.call( "capacitaciones.getAllAlumnoFinal", new Responder(onGetAllAlumnoFinalResult, 
			onGetAllAlumnoFault),codigo_curso);
			
			return listaAlumnoFinal;
		}
		public function onGetAllAlumnoFinalResult( result : Array ) : void{
			var i:int;					 	
           	for(i=0;i<result.length;i++){
				listaAlumnoFinal.addItemAt(result[i],i);
			}
		}
			
		///////////////////---CLIENTES---/////////////////
		
		
		public function getAllCliente(flag:int):ArrayCollection{
			this.flag = flag;
			gateway.call( "administracion.getAllCliente", new Responder(onGetAllClienteResult, onGetAllClienteFault));
			
			return listaCliente;
		}
		public function onGetAllClienteResult( result : Array ) : void{
			var i:int;			
			if(flag==1)
				listaCliente.addItem("--seleccione--");
           	for(i=0;i<result.length;i++){
				listaCliente.addItem(result[i]);
			}
		}
		public function onGetAllClienteFault( fault : Object ) : void{
			Alert.show("Error al obtener los Clientes.");
		} 
		public function insertCliente(c:Cliente):void{
			gateway.call("administracion.insertCliente",new Responder(onInsertResult, onInsertClienteFault), 
			c.nombre, c.rut, c.direccion, c.giro, c.producto, c.nombre_contacto, c.cargo, c.email, 
			c.fono, c.observaciones, c.facturacion, c.empleados, c.sector, c.mercado, c.competencia, c.sucursales, c.como_supo, 
			c.check0, c.check1, c.check2, c.check3, c.check4, c.check5, c.check6, c.check7, c.requerimientos);
		}
		public function onInsertClienteFault( fault : Object ) : void{
			Alert.show("Error al registrar, posiblemente el Rut ya fue asignado a otro Cliente.");
		} 
		public function updateCliente(c:Cliente, rutAntiguo:String):void{
			gateway.call("administracion.updateCliente",new Responder(onUpdateResult, onUpdateClienteFault), 
			rutAntiguo, c.nombre, c.rut, c.direccion, c.giro, c.producto, c.nombre_contacto, c.cargo, c.email, 
			c.fono, c.observaciones, c.facturacion, c.empleados, c.sector, c.mercado, c.competencia, c.sucursales, c.como_supo, 
			c.check0, c.check1, c.check2, c.check3, c.check4, c.check5, c.check6, c.check7, c.requerimientos);
		}
		public function onUpdateClienteFault( fault : Object ) : void{
			Alert.show("Error al actualizar el Cliente.");
		}
		public function deleteCliente(rut:String):void{
			//Alert.show("fecha: "+met.fecha);
			gateway.call("administracion.deleteCliente",new Responder(onDeleteResult, onDeleteFault), rut);
		}
		
		
		
		
		
		
		
		
		
		
		
	}
}