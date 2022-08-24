package semantico;
import java_cup.runtime.Symbol;
import java.util.LinkedList;
%% 
%class Lexer
%public 
%line 
%char 
%cup 
%unicode
%ignorecase

%{
    /*Errores Lexicos*/
    public static LinkedList<String> ErroresLexicos=new LinkedList<String>();
%}
	
%init{ 
    yyline = 1; 
    yychar = 1; 
%init} 
 
// LENGUAGE: JAVA
BLANCOS=[ \r\t]+
CADENACOMILLASDOBLES = [\"]([^\"\n]|(\\\"))*[\"]
espacio=[ ,\t,\r,\n]+
D=[0-9]+
DD=[0-9]+("."[  |0-9]+)?
ID=[A-Za-z]+["_"0-9A-Za-z]*
SIMBOLO = [#!$%&?¡_]
ACENTO = [ñÑáéíóúÁÉÍÓÚ]
COMENTUNILINEA =("//".*\r\n)|("//".*\n)|("//".*\r)
COMENTMULTILINEA ="/*""/"*([^*/]|[^*]"/"|"*"[^/])*"*"*"*/"
%%

{COMENTUNILINEA} {} 

{COMENTMULTILINEA} {}  

{CADENACOMILLASDOBLES} {return new Symbol(sym.cadena, yyline,yychar, (yytext()).substring(1,yytext().length()-1));} 

/* Espacios en blanco */
{espacio} {/*Ignore*/}

/* Comentarios */
( "//"(.)* ) {/*Ignore*/}

/* Salto de linea */
( "\n" ) {return Linea;}

/* Comillas */
( "\"" ) {return new Symbol(sym.Comillas, yychar, yyline, yytext());}

/* Tipos de datos numericos */
( Byte | Char | Long | Float | Double | Int ) {return new Symbol(sym.T_Dato, yychar, yyline, yytext());}

/* Tipo de dato String */
( String ) {return new Symbol(sym.Cadena, yychar, yyline, yytext());}

( Boolean ) {return new Symbol(sym.Bool, yychar, yyline, yytext());}

/* Palabra reservada If */
( if ) {return new Symbol(sym.If, yychar, yyline, yytext());}

/* Palabra reservada Else */
( else ) {return new Symbol(sym.Else, yychar, yyline, yytext());}

/* Palabra reservada Do */
( do ) {return new Symbol(sym.Do, yychar, yyline, yytext());}

/* Palabra reservada While */
( while ) {return new Symbol(sym.While, yychar, yyline, yytext());}

/* Palabra reservada For */
( for ) {return new Symbol(sym.For, yychar, yyline, yytext());}

/* Operador Igual */
( "=" ) {return new Symbol(sym.Igual, yychar, yyline, yytext());}

/* Operador Suma */
( "+" ) {return new Symbol(sym.Suma, yychar, yyline, yytext());}

/* Operador Resta */
( "-" ) {return new Symbol(sym.Resta, yychar, yyline, yytext());}

/* Operador Multiplicacion */
( "*" ) {return new Symbol(sym.Multiplicacion, yychar, yyline, yytext());}

/* Operador Division */
( "/" ) {return new Symbol(sym.Division, yychar, yyline, yytext());}

/* Operadores logicos */
( "&&" | "||" | "!" | "&" | "|" ) {return new Symbol(sym.Op_Logico, yychar, yyline, yytext());}

/*Operadores Relacionales */
( ">" | "<" | "==" | "!=" | ">=" | "<=" | "<<" | ">>" ) {return new Symbol(sym.Op_Relacional, yychar, yyline, yytext());}

/* Operadores Atribucion */
( "+=" | "-="  | "*=" | "/=" | "%=" | "=" ) {return new Symbol(sym.Op_Atribucion, yychar, yyline, yytext());}

/* Operadores Incremento y decremento */
( "++" ) {return new Symbol(sym.Op_Incremento, yyline, yycolumn, yytext());}
( "--" ) {return new Symbol(sym.Op_Disminucion, yyline, yycolumn, yytext());}

/*Operadores Booleanos*/
( true | false ) {return new Symbol(sym.Op_Booleano, yychar, yyline, yytext());}

/* Parentesis de apertura */
( "(" ) {return new Symbol(sym.Parentesis_a, yychar, yyline, yytext());}

/* Parentesis de cierre */
( ")" ) {return new Symbol(sym.Parentesis_c, yychar, yyline, yytext());}

/* Llave de apertura */
( "{" ) {return new Symbol(sym.Llave_a, yychar, yyline, yytext());}

/* Llave de cierre */
( "}" ) {return new Symbol(sym.Llave_c, yychar, yyline, yytext());}

/* Corchete de apertura */
( "[" ) {return new Symbol(sym.Corchete_a, yychar, yyline, yytext());}

/* Corchete de cierre */
( "]" ) {return new Symbol(sym.Corchete_c, yychar, yyline, yytext());}

/* Marcador de inicio de algoritmo */
( "main" ) {return new Symbol(sym.Main, yychar, yyline, yytext());}

/* Palabra reservada void*/
( "void" ) {return new Symbol(sym.Void, yychar, yyline, yytext());}

/* Operadores Acceso*/
( "static" | "protected" | "private" | "public" ) {return new Symbol(sym.Op_Acceso, yychar, yyline, yytext());}

/* Punto y coma */
( ";" ) {return new Symbol(sym.P_coma, yychar, yyline, yytext());}

/* Coma */
( "," ) {return new Symbol(sym.Coma, yyline, yycolumn, yytext());}

/* Punto */
( "." ) {return new Symbol(sym.Punto, yyline, yycolumn, yytext());}

/* Dos Puntos */
( ":" ) {return new Symbol(sym.DosPuntos, yyline, yycolumn, yytext());}

\n {yychar=1;}

/* --------------------EXPRESIONES-------------------- */
{BLANCOS} {} 

{ID} {return new Symbol(sym.Identificador, yyline,yychar, yytext());} 

{D} {return new Symbol(sym.entero, yyline,yychar, yytext());} 

{DD} {return new Symbol(sym.decimal, yyline,yychar, yytext());} 

// |-------------------- RECONOCER ERRORES --------------------| //
//identificador mayor a 127 caracteres
{ID}(({ID}|{D}){127})({ID}|{D})* {
    System.err.println("Este es un error lexico identificador: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico identificador: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());
}

//identificador no comienza con digito
(({D}+)({ID}ACENTO}))(({ID}|{D}|{SIMBOLO}|{ACENTO}))* {
    System.err.println("Este es un error lexico identificador: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico identificador: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());
}

//identificador no lleva simbolos
({ID}|{ACENTO}|{SIMBOLO})(({ID}|{D}|{SIMBOLO}|{ACENTO}))+ {
    System.err.println("Este es un error lexico identificador: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico identificador: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());
}

/*Error Enteros*/
// 12.12.12...
{D}+"."{D}+("."{D}*)+ {
    System.err.println("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// .12e12 / .12e / .12  | 12.23e-23.12
("."{D}+([eE][-]?{D}*)?) | ({D}+"."{D}+([eE][-]?)({D}*"."{D}*))* {
    System.err.println("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// 12ab.12 | ab12.12
({D}+{ID}+"."{D}+) | ({ID}+{D}+"."{D}+) {
    System.err.println("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// 12.12ab | 12.ab12
({D}+"."{D}+{ID}+) | ({D}+"."{ID}+{D}+) {
    System.err.println("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// ab.12ab | ab.ab12
({ID}+"."{D}+{ID}+) | ({ID}+"."{ID}+{D}+) {
    System.err.println("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// 12. | 12e.
({D}+{ID}*".") {
    System.err.println("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// 3,14
{D}+","{D}+ {
    System.err.println("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico numerico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// Literales
"#"{ID}+ {
    System.err.println("Este es un error lexico: " + "Simb + ID" + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico: " + "Simb + ID" + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}
'[^'] ~' {
    System.err.println("Este es un error lexico literal: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico literal: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

/* Error de analisis */
. { 
    System.err.println("Este es un error lexico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar);
    ErroresLexicos.add("Este es un error lexico: " + yytext() + ", en la linea: " + yyline + ", en la columna: " + yychar + " con el caracter:\n " + yytext() + "\n");
}