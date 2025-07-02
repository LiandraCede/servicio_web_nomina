# servicio_web_nomina

Un proyecto Flutter que implementa un formulario para capturar información de nómina y enviarla a un servicio web simulado, siguiendo el layout de integración definido entre UNAPEC y APAP.

## Descripción

Esta aplicación permite ingresar los datos de nómina de empleados (encabezado, detalles y sumario) a través de un formulario interactivo en Flutter. Al enviar el formulario, la app construye un JSON siguiendo el layout posicional establecido y lo envía vía HTTP POST a un endpoint REST.

Este proyecto es parte de una tarea académica para demostrar la integración de sistemas mediante servicios web, simulando el proceso de pago de nómina de una institución educativa (UNAPEC) con una entidad bancaria (APAP).

## Características

- Captura de datos de encabezado (empresa, fechas).
- Captura de información de un empleado (cédula, cuenta, monto, etc.).
- Construcción del JSON según el layout de nómina.
- Envío de la nómina mediante HTTP POST a un servicio web.
- Manejo de respuestas del servidor con diálogos de éxito o error.

## Recursos útiles

- [Documentación oficial de Flutter](https://docs.flutter.dev/)
- [HTTP package](https://pub.dev/packages/http) para llamadas REST en Flutter.

---
