
class Usuario {
  final String id;
  final String name;
  final String email;
  final String imagen;
  final String createdAt;
  final String celular;

  Usuario({
    this.id, 
    this.name, 
    this.email, 
    this.imagen, 
    this.createdAt, 
    this.celular,
  });

  static Usuario fromJson(Map<String,dynamic> json){
    return Usuario(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      celular: json['celular'],
      createdAt: json['createdAt'],
      imagen: json['imagen']
    );

  }

  Map<String, dynamic> toJson(){
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'imagen': this.imagen,
      'createdAt': this.createdAt,
      'celular': this.celular,
    };
  }

  
        
}