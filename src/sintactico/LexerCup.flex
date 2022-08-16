package sintactico;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
// LENGUAGE: JAVA
LETRA = [a-zA-Z_]
DIGITO = [0-9]
ESPACIO = [ ,\t,\r,\n]+
SIMBOLO = [#!$%&?¡_]
OPERADOR = ","|";"|"++"|"--"|">="|">"|"<="|"<"|"<>"|"="|"+"|"-"|"*"|"/"|"("|")"|"["|"]"|":="|"."|":"|"+="|"-="|"*="|"/="|">>"|"<<"|"<<="|">>="
ACENTO = [ñÑáéíóúÁÉÍÓÚ]
%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }

    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

{ESPACIO} {/*No se procesa*/} // espacio en blanco
"//".* {/*No se procesa*/} // dos slash de comentario
("\(\*" ~"\*\)" | "\(\*" "\*"+ "\)") {/*No se procesa*/} // comentario multilínea
("{" ~"}" | "{" "}") {/*No se procesa*/} // comentario multilínea


"," {return new Symbol(sym.OPERADOR_COMA, yyline, yycolumn, yytext());}
";" {return new Symbol(sym.TERMINADOR, yyline, yycolumn, yytext());}
"++" {return new Symbol(sym.OPERADOR_INCREMENTO, yyline, yycolumn, yytext());}
"--" {return new Symbol(sym.OPERADOR_DISMINUCION, yyline, yycolumn, yytext());}
">=" {return new Symbol(sym.OPERADOR_MAYOR_IGUAL_QUE, yyline, yycolumn, yytext());}
">" {return new Symbol(sym.OPERADOR_MAYOR_QUE, yyline, yycolumn, yytext());}
"<=" {return new Symbol(sym.OPERADOR_MENOR_IGUAL_QUE, yyline, yycolumn, yytext());}
"<" {return new Symbol(sym.OPERADOR_MENOR_QUE, yyline, yycolumn, yytext());}
"<>" {return new Symbol(sym.OPERADOR_DIFERENTE_DE, yyline, yycolumn, yytext());}
"=" {return new Symbol(sym.OPERADOR_ASIGNACION, yyline, yycolumn, yytext());}
"+" {return new Symbol(sym.OPERADOR_ADICION, yyline, yycolumn, yytext());}
"-" {return new Symbol(sym.OPERADOR_SUSTRACCION, yyline, yycolumn, yytext());}
"*" {return new Symbol(sym.OPERADOR_MULTIPLICACION, yyline, yycolumn, yytext());}
"/" {return new Symbol(sym.OPERADOR_DIVISION, yyline, yycolumn, yytext());}
"(" {return new Symbol(sym.OPERADOR_PARENTESIS_ABRIR, yyline, yycolumn, yytext());}
")" {return new Symbol(sym.OPERADOR_PARENTESIS_CERRAR, yyline, yycolumn, yytext());}
"[" {return new Symbol(sym.OPERADOR_CORCHETE_ABRIR, yyline, yycolumn, yytext());}
"]" {return new Symbol(sym.OPERADOR_CORCHETE_CERRAR, yyline, yycolumn, yytext());}
"." {return new Symbol(sym.OPERADOR, yyline, yycolumn, yytext());}
":" {return new Symbol(sym.OPERADOR_DOS_PUNTOS, yyline, yycolumn, yytext());}
"+=" {return new Symbol(sym.OPERADOR_ASIGNACION_ADICION, yyline, yycolumn, yytext());}
"-=" {return new Symbol(sym.OPERADOR_ASIGNACION_SUSTRACCION, yyline, yycolumn, yytext());}
"*=" {return new Symbol(sym.OPERADOR_ASIGNACION_MULTIPLICACION, yyline, yycolumn, yytext());}
"/=" {return new Symbol(sym.OPERADOR_ASIGNACION_DIVISION, yyline, yycolumn, yytext());}
( byte | char | long | float | double ) {return new Symbol(sym.TIPO_DATO, yychar, yyline, yytext());}
/* Tipo de dato Int (Para el main) */
( "int" ) {return new Symbol(sym.INT, yychar, yyline, yytext());}
/* Tipo de dato String */
( String ) {return new Symbol(sym.CADENA, yychar, yyline, yytext());}
/* Comillas */
( "\"" ) {return new Symbol(sym.COMILLAS, yychar, yyline, yytext());}
/* Llave de apertura */
( "{" ) {return new Symbol(sym.OPERADOR_LLAVE_ABRIR, yychar, yyline, yytext());}
/* Llave de cierre */
( "}" ) {return new Symbol(sym.OPERADOR_LLAVE_CERRAR, yychar, yyline, yytext());}
/*Operadores Booleanos*/
( true | false ) {return new Symbol(sym.OPERADOR_BOOLEANO, yychar, yyline, yytext());}

/*Operadores Relacionales */
( ">" | "<" | "==" | "!=" | ">=" | "<=" | "<<" | ">>" ) {return new Symbol(sym.OPERADOR_RELACIONAL, yychar, yyline, yytext());}

abstract | 
assert | 
boolean |  
case | 
catch |  
class | 
continue | 
default | 
do | 
else | 
exports | 
extends | 
final | 
finally | 
for | 
if | 
implements | 
import | 
instanceof | 
interface | 
module | 
native | 
new | 
package | 
private | 
protected | 
public | 
requires | 
return | 
static | 
super | 
switch | 
syncronized | 
this | 
throw | 
throws | 
transient | 
try | 
void | 
volatile | 
while | 
null | 
String |
while {return new Symbol(sym.PALABRA, yyline, yycolumn, yytext());}

// |-------------------- RECONOCER EXPRESIONES --------------------| // {return new Symbol(sym.OPERADOR, yyline, yychar, yytext());}
// Identificadores
{LETRA}({LETRA}|{DIGITO})* {return new Symbol(sym.IDENTIFICADOR, yyline, yycolumn, yytext());}

// Flotantes
(({DIGITO}+"."{DIGITO}+)) |
    (({DIGITO}"."{DIGITO}+)([eE][-]?{DIGITO}+)) {return new Symbol(sym.LITERAL_NUM_FLOTANTE, yyline, yycolumn, yytext());}

// Literales
((\"[^\"] ~\")|(\"\")) {return new Symbol(sym.LITERAL_STRING, yyline, yycolumn, yytext());}
//\"({LETRA}|{DIGITO}|{ESPACIO}|{SIMBOLO})*+\" | ("#"{DIGITO}{DIGITO}) {lexeme=yytext(); line=yyline; return LITERAL_STRING;}
("#"{DIGITO}+) {return new Symbol(sym.LITERAL_STRING, yyline, yycolumn, yytext());}
("(-"{DIGITO}+")")|{DIGITO}+ {return new Symbol(sym.LITERAL_NUM_ENTERO, yyline, yycolumn, yytext());} // Un numero entero


// |-------------------- RECONOCER ERRORES --------------------| //
// Identificadores
//identificador mayor a 127 caracteres
{LETRA}(({LETRA}|{DIGITO}){127})({LETRA}|{DIGITO})* {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}
//identificador no comienza con digito
(({DIGITO}+)({LETRA}|{ACENTO}))(({LETRA}|{DIGITO}|{SIMBOLO}|{ACENTO}))* {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}
//identificador no lleva simbolos
({LETRA}|{ACENTO}|{SIMBOLO})(({LETRA}|{DIGITO}|{SIMBOLO}|{ACENTO}))+ {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}

// Flotantes
// 12.12.12...
{DIGITO}+"."{DIGITO}+("."{DIGITO}*)+ {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// .12e12 / .12e / .12  | 12.23e-23.12
("."{DIGITO}+([eE][-]?{DIGITO}*)?) | ({DIGITO}+"."{DIGITO}+([eE][-]?)({DIGITO}*"."{DIGITO}*))* {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 12ab.12 | ab12.12
({DIGITO}+{LETRA}+"."{DIGITO}+) | ({LETRA}+{DIGITO}+"."{DIGITO}+) {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 12.12ab | 12.ab12
({DIGITO}+"."{DIGITO}+{LETRA}+) | ({DIGITO}+"."{LETRA}+{DIGITO}+) {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// ab.12ab | ab.ab12
({LETRA}+"."{DIGITO}+{LETRA}+) | ({LETRA}+"."{LETRA}+{DIGITO}+) {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 12. | 12e.
({DIGITO}+{LETRA}*".") {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 3,14
{DIGITO}+","{DIGITO}+ {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}

// Literales
"#"{LETRA}+ {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
'[^'] ~' {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}

// Comentarios
\"[^\"]* {return new Symbol(sym.error, yyline, yycolumn, yytext());}
\(\*[^\)\*]* {return new Symbol(sym.error, yyline, yycolumn, yytext());}
\{[^\}]* {return new Symbol(sym.error, yyline, yycolumn, yytext());}

. {return new Symbol(sym.error, yyline, yycolumn, yytext());}

