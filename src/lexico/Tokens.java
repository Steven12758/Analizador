package lexico;

/**
 *
 * @author root
 */
public enum Tokens {

    /*Identificador*/
    IDENTIFICADOR("Identificador"),
    Comillas("Comillas"),
    Linea("linea"),
    
    /*Palabras Reservadas*/
    P_RESERVADA("Palabra reservada"),
    Void("Palabra Reservada"),
    Main("Palabra Reservada"),
    Op_ACCESO("Operado de acceso"),
    
    /*Operaciones Arimeticas*/
    Suma("Operador de adición"),
    Resta("Operador de sustracción"),
    Multiplicacion("Operador de multiplicación"),
    Division("Operador de división"),
    ASIGNACION("Operador de signo igual"),
    Op_incremento("Operador de increment unario"),
    Op_disminucion("Operador de disminución unario"),
    Op_atribucion("Operador de atribucion"),
    
    /*Sentencias*/
    If("If"),
    Else("Else"),
    Do("Do"),
    While("While"),
    For("For"),
    
    /*Puntos y Terminador*/
    PUNTO("Operador punto"),
    Op_DOS_PUNTOS("Operador dos puntos"),
    P_TERMINADOR("Operadors punto y coma"),
    COMA("Operador coma"),
    
    /*Tipo Datos*/
    T_dato("Tipo Dato"),
    Numero("Numero"),
    Cadena("Cadena"),
    
    /*Operadores logicos*/
    Op_logico("Operador logico"),
    Op_booleano("Operador Booleano"),
    Op_relacional("Operador relacional"),
    
    /*Llaves, Corchetes, Parentesis*/
    Parentesis_a("Operador parentesis abierto"),
    Parentesis_c("Operador parentesis cerrado"),
    Corchete_a("Operador corchete abierto"),
    Corchete_c("Operador corchete cerrado"),
    Llave_a("Operador llave abierta"),
    Llave_c("Operador llave cerrada"),
    
    /*Error*/
    ERROR("Error");

    String nombre;

    Tokens(String pNombre) {
        nombre = pNombre;
    }

    public String getNombre() {
        return nombre;
    }
}
