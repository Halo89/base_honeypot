El respositorio contiene código de despliegue relacionado a un modelo de honeypot de alta interacción para Windows

El entorno está basado en Windows Server 2016 y está en formato VHD para despliegue en entorno privado virtualizado.

SI se quisiera desplegar desde cero, se encuentra el archivo windows-configuration.ps1 que contiene rutinas de instalación de los paquetes de software:

Sysmon
Winlogbeat
Filegrab

Sysmon permite la instalación de un driver que recoge de forma personalizada los eventos generados por el sistema operativo y componentes. Se utiliza la plantilla desarrollada en: https://github.com/SwiftOnSecurity/sysmon-config/ 
Winlogbeat se encargará de leer los eventos generados por Sysmon y enviarlos hacia un entorno ELK previamente desplegado por el usuario. Permite el envío a Logstsh, Beats o Elasticsearch de forma directa. La configuración predefinida en el script está realizada para el trabajo con Logstash
Filegrab se encarga de obtener muestras de archivos de formato predefinido que sean creados en la ruta del sistema operativo configurada. Tiene que ser configurado manualmente.
