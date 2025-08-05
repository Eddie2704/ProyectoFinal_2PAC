class Cancha {
  final int id;
  final String nombre;
  final String tipo;
  final String ubicacion;
  final String imagen;

  const Cancha({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.ubicacion,
    required this.imagen,
  });

  factory Cancha.fromJson(Map<String, dynamic> json) {
    return Cancha(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      ubicacion: json['ubicación'],
      imagen: json['imagen_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'tipo': tipo,
    'ubicación': ubicacion,
    'imagen_url': imagen,
  };
}

final List<Cancha> canchasDisponibles = [
  Cancha(
    id: 1,
    nombre: 'Sportmania',
    tipo: 'Fútbol',
    ubicacion: ' Bo. Las acacias, San Pedro Sula ',
    imagen: 'https://ejemplo.com/sportmania.jpg',
  ),
  Cancha(
    id: 2,
    nombre: 'Cancha La Fuente',
    tipo: 'Fútbol',
    ubicacion: 'Bo. La Fuente, San Pedro Sula',
    imagen: 'https://ejemplo.com/lafuente.jpg',
  ),
  Cancha(
    id: 3,
    nombre: 'Galaxy Fútbol',
    tipo: 'Fútbol',
    ubicacion: 'Colonia Trejo, San Pedro Sula',
    imagen: 'https://ejemplo.com/galaxy.jpg',
  ),
  Cancha(
    id: 4,
    nombre: 'Las Palmas',
    tipo: 'Vóleibol',
    ubicacion: 'Bo. Las Palmas, San Pedro Sula',
    imagen: 'https://ejemplo.com/palmas.jpg',
  ),
  Cancha(
    id: 5,
    nombre: 'Sportmania',
    tipo: 'Basquetball',
    ubicacion: 'Bo. Las acacias, San Pedro Sula ',
    imagen: 'https://ejemplo.com/arenanorte.jpg',
  ),
  Cancha(
    id: 6,
    nombre: 'Complejo Emil Martínez',
    tipo: 'Fútbol',
    ubicacion: '21 Avenida N.O, San Pedro Sula',
    imagen: 'https://ejemplo.com/emil.jpg',
  ),
  Cancha(
    id: 7,
    nombre: 'Zona Deportiva SPS',
    tipo: 'Fútbol',
    ubicacion: 'Col. Moderna, San Pedro Sula',
    imagen: 'https://ejemplo.com/zonasps.jpg',
  ),
  Cancha(
    id: 8,
    nombre: 'Soccer City',
    tipo: 'Fútbol rápido',
    ubicacion: 'Col. Los Álamos, San Pedro Sula',
    imagen: 'https://ejemplo.com/alamos.jpg',
  ),

];
