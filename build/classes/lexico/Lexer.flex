package lexico;
import static lexico.Tokens.*;
%%
%class Lexer
%type Tokens
%{
public String lexeme;
%}
// LENGUAGE: JAVA
LETRA = [a-zA-Z_]
DIGITO = [0-9]
ESPACIO = [ \t \r \n \f \r\n]
SIMBOLO = [#!$%&?¡_]
OPERADOR = ","|";"|"++"|"--"|">="|">"|"<="|"<"|"<>"|"="|"+"|"-"|"*"|"/"|"("|")"|"["|"]"|":="|"."|":"|"+="|"-="|"*="|"/="|">>"|"<<"|"<<="|">>="
ACENTO = [ñÑáéíóúÁÉÍÓÚ]
%%

{ESPACIO} {/*No se procesa*/} // espacio en blanco
"//".* {/*No se procesa*/} // dos slash de comentario
("\(\*" ~"\*\)" | "\(\*" "\*"+ "\)") {/*No se procesa*/} // comentario multilínea
("{" ~"}" | "{" "}") {/*No se procesa*/} // comentario multilínea

"<<EOF>>" {lexeme=yytext(); return OPERADOR;}
"//".* {/*Ignore*/}
"=" {lexeme=yytext(); return OPERADOR_IGUAL;}
"+" {lexeme=yytext(); return OPERADOR_ADICION;}
"-" {lexeme=yytext(); return OPERADOR_SUSTRACCION;}
"*" {lexeme=yytext(); return OPERADOR_MULTIPLICACION;}
"/" {lexeme=yytext(); return OPERADOR_DIVISION;}
";" {lexeme=yytext(); return TERMINADOR;}
"," {lexeme=yytext(); return OPERADOR_COMA;}
"++" {lexeme=yytext(); return OPERADOR_INCREMENTO;}
"--" {lexeme=yytext(); return OPERADOR_DISMINUCION;}
">=" {lexeme=yytext(); return OPERADOR_MAYOR_IGUAL_QUE;}
">" {lexeme=yytext(); return OPERADOR_MAYOR_QUE;}
"<=" {lexeme=yytext(); return OPERADOR_MENOR_IGUAL_QUE;}
"<" {lexeme=yytext(); return OPERADOR_MENOR_QUE;}
"<>" {lexeme=yytext(); return OPERADOR_DIFERENTE_DE;}
"(" {lexeme=yytext(); return OPERADOR_PARENTESIS_ABRIR;}
")" {lexeme=yytext(); return OPERADOR_PARENTESIS_CERRAR;}
"[" {lexeme=yytext(); return OPERADOR_CORCHETE_ABRIR;}
"]" {lexeme=yytext(); return OPERADOR_CORCHETE_CERRAR;}
"." {lexeme=yytext(); return OPERADOR_PUNTO;}
":" {lexeme=yytext(); return OPERADOR_DOS_PUNTOS;}
abstract | 
assert | 
boolean | 
boolean | 
byte | 
case | 
catch | 
char | 
class | 
continue | 
default | 
do | 
double | 
else | 
exports | 
extends | 
false | 
final | 
finally | 
float | 
for | 
if | 
implements | 
import | 
instanceof | 
int | 
interface | 
long | 
module | 
native | 
new | 
package | 
private | 
protected | 
public | 
requires | 
return | 
short | 
static | 
super | 
switch | 
syncronized | 
this | 
throw | 
throws | 
transient | 
try | 
true | 
void | 
volatile | 
while | 
null | 
var | 
const | 
goto | 
String |
while {lexeme=yytext(); return PALABRA_RESERVADA;}


// |-------------------- RECONOCER EXPRESIONES --------------------| //
// Identificadores
{LETRA}({LETRA}|{DIGITO})* {lexeme=yytext(); return IDENTIFICADOR;}

// Flotantes
(({DIGITO}+"."{DIGITO}+)) |
    (({DIGITO}"."{DIGITO}+)([eE][-]?{DIGITO}+)) {lexeme=yytext(); return LITERAL_NUM_FLOTANTE;}

// Literales
((\"[^\"] ~\")|(\"\")) {lexeme=yytext(); return LITERAL_STRING;}
("#"{DIGITO}+) {lexeme=yytext(); return LITERAL_STRING;}
("(-"{DIGITO}+")")|{DIGITO}+ {lexeme=yytext(); return LITERAL_NUM_ENTERO;}


// |-------------------- RECONOCER ERRORES --------------------| //
// Identificadores
//identificador mayor a 127 caracteres
{LETRA}(({LETRA}|{DIGITO}){127})({LETRA}|{DIGITO})* {lexeme=yytext(); return ERROR_IDENTIFICADOR;}
//identificador no comienza con digito
(({DIGITO}+)({LETRA}|{ACENTO}))(({LETRA}|{DIGITO}|{SIMBOLO}|{ACENTO}))* {lexeme=yytext(); return ERROR_IDENTIFICADOR;}
//identificador no lleva simbolos
({LETRA}|{ACENTO}|{SIMBOLO})(({LETRA}|{DIGITO}|{SIMBOLO}|{ACENTO}))+ {lexeme=yytext(); return ERROR_IDENTIFICADOR;}

// Flotantes
// 12.12.12...
{DIGITO}+"."{DIGITO}+("."{DIGITO}*)+ {lexeme=yytext(); return ERROR_LITERAL;}
// .12e12 / .12e / .12  | 12.23e-23.12
("."{DIGITO}+([eE][-]?{DIGITO}*)?) | ({DIGITO}+"."{DIGITO}+([eE][-]?)({DIGITO}*"."{DIGITO}*))* {lexeme=yytext(); return ERROR_LITERAL;}
// 12ab.12 | ab12.12
({DIGITO}+{LETRA}+"."{DIGITO}+) | ({LETRA}+{DIGITO}+"."{DIGITO}+) {lexeme=yytext(); return ERROR_LITERAL;}
// 12.12ab | 12.ab12
({DIGITO}+"."{DIGITO}+{LETRA}+) | ({DIGITO}+"."{LETRA}+{DIGITO}+) {lexeme=yytext(); return ERROR_LITERAL;}
// ab.12ab | ab.ab12
({LETRA}+"."{DIGITO}+{LETRA}+) | ({LETRA}+"."{LETRA}+{DIGITO}+) {lexeme=yytext(); return ERROR_LITERAL;}
// 12. | 12e.
({DIGITO}+{LETRA}*".") {lexeme=yytext(); return ERROR_LITERAL;}
// 3,14
{DIGITO}+","{DIGITO}+ {lexeme=yytext(); return ERROR_LITERAL;}

// Literales
"#"{LETRA}+ {lexeme=yytext(); return ERROR_LITERAL;}
'[^'] ~' {lexeme=yytext(); return ERROR_LITERAL;}

// Comentarios
\"[^\"]* {lexeme=yytext(); return ERROR;}
\(\*[^\)\*]* {lexeme=yytext(); return ERROR;}
\{[^\}]* {lexeme=yytext(); return ERROR;}

. {return ERROR;}

