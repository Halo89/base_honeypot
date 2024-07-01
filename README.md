El respositorio contiene código de despliegue relacionado a un modelo de honeypot de alta interacción para Windows

El entorno está basado en Windows Server 2016 y está en formato VHD para despliegue en entorno privado virtualizado.

Si se quisiera desplegar desde cero, se encuentra el archivo windows-configuration.ps1 que contiene rutinas de instalación de los paquetes de software:

* Sysmon
* Winlogbeat
* Filegrab

Sysmon permite la instalación de un driver que recoge de forma personalizada los eventos generados por el sistema operativo y componentes. Se utiliza la plantilla desarrollada en: https://github.com/SwiftOnSecurity/sysmon-config/ 
Winlogbeat se encargará de leer los eventos generados por Sysmon y enviarlos hacia un entorno ELK previamente desplegado por el usuario. Permite el envío a Logstsh, Beats o Elasticsearch de forma directa. La configuración predefinida en el script está realizada para el trabajo con Logstash
Filegrab se encarga de obtener muestras de archivos de formato predefinido que sean creados en la ruta del sistema operativo configurada. Tiene que ser configurado manualmente.

La plantilla de Azure despliega un entorno virtual, por defecto con WindowsDatacenter2016, de 2 interfaces de red, aisladas; 1 IP pública permitiendo conectividad entrante hacia el puerto TCP/3389

La plantilla puede editarse antes del despliegue.

Se utiliza ficheros de configuración de terceros, con algunas modificaciones requeridas por el entorno bajo estudio. 

Se configuran credenciales de usuarios ampliamente utilizados en internet, para atraer atacantes al entorno.
Se configura un entorno carente de seguridad para el estudio del comportamiento de atacantes.

1. Descargar los ficheros *.JSON de configuración del repositorio. 
2. Revisar y editar las configuraciones de usuario y contraseña de administración del entorno. !IMPORTANTE MODIFICAR, VM EXPUESTA A INTERNET!
3. Abrir PowerShell como admin y autenticarse en Azure. 
4. Ejecutar la siguiente línea en la consola

New-AzResourceGroupDeployment -Name honeypot -ResourceGroupName <NombreGrupoRecursos> -TemplateFile <azure_vm_template.json>

5. A través del portal de administración de Azure, se puede obtener la información relacionada con la IP pública
6. Conectarse a la VM utilizando RDP y las credenciales configuradas
7. Descargar el fichero windows-configuration.ps1
8. Abrir PowerShell y ejecutar script de configuración descargado anteriormente
9. Es necesario configurar los parámetros de Logstash del servidor de escucha
10. Es necesario configurar y ejecutar manualmente la aplicación Filegrab


