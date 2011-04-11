package remoting.services
{
	import components.SubirArchivo;
	import components.administracion.mets.editarSeleccionado;
	
	import mx.core.Application;
	import mx.rpc.events.ResultEvent;
	
	import remoting.events.RemoteResultEvent;
	import remoting.vo.FileVO;
	/**
     * Class that extends the RemoteService class, therefore it makes use of the default error handling for
     * remote calls.
     */
	public class RemoteFileService extends  RemoteService {
		private static var phpServiceClass:String = "RemoteFile";
		private var objeto:SubirArchivo;
		
		public function RemoteFileService(amfChannelId:String, amfChannelEndpoint:String) {
			super("remotefileService","amfphp", amfChannelId, amfChannelEndpoint);
		}
        
        public function upload(file:FileVO, folder:String, object:SubirArchivo):void {
        	this.objeto = object;
        	//Alert.show("subiendo");
        	remoteObject.source = phpServiceClass;
        	remoteObject.upload.addEventListener(
                    ResultEvent.RESULT,handleRemoteMethod);
            remoteObject.upload(file, folder);
        }
        /*
        public function download(rut:String):void {
        	remoteObject.source = phpServiceClass;
        	remoteObject.download.addEventListener(
                    ResultEvent.RESULT,handleDownload);
            remoteObject.download(rut);
        }
        */
        protected function handleRemoteMethod(event:ResultEvent):void {
        	var uploadStatus:String;
        	uploadStatus = event.result.toString();
        	//Alert.show("Mensaje: "+uploadStatus);
        	
        	this.objeto.dispatchEvent(new RemoteResultEvent(RemoteResultEvent.UPLOAD_STATUS, uploadStatus));
        	//Application.application.administracion.tabVerTodosMET.getChildAt(0).dispatchEvent( new RemoteResultEvent(RemoteResultEvent.UPLOAD_STATUS, uploadStatus));
        }
        /*
        protected function handleDownload(event:ResultEvent):void {
        	this.objeto.dispatchEvent(event);
        }
        */
	}
}