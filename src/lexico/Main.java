package lexico;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author root
 */
public class Main {

    public static void main(String[] args) throws Exception {
        String lexer = "/home/thend/Documentos/Analizador/src/lexico/Lexer.flex";
        String sintactico = "/home/thend/Documentos/Analizador/src/sintactico/LexerCup.flex";
        String[] rutas = {"-parser", "Syntax", "/home/thend/Documentos/Analizador/src/sintactico/Syntax.cup"};
        generar(lexer, sintactico, rutas);
    }

    public static void generar(String ruta1, String ruta2, String[] rutaS) throws IOException, Exception{
        File archivo;
        archivo = new File(ruta1);
        JFlex.Main.generate(archivo);
        archivo = new File(ruta2);
        JFlex.Main.generate(archivo);
        java_cup.Main.main(rutaS);
        
        Path rutaSym = Paths.get("/home/thend/Documentos/Analizador/src/sintactico/sym.java");
        if (Files.exists(rutaSym)) {
            Files.delete(rutaSym);
        }
        Files.move(
                Paths.get("/home/thend/Documentos/Analizador/sym.java"), 
                Paths.get("/home/thend/Documentos/Analizador/src/sintactico/sym.java")
        );
        Path rutaSin = Paths.get("/home/thend/Documentos/Analizador/src/sintactico/Syntax.java");
        if (Files.exists(rutaSin)) {
            Files.delete(rutaSin);
        }
        Files.move(
                Paths.get("/home/thend/Documentos/Analizador/Syntax.java"), 
                Paths.get("/home/thend/Documentos/Analizador/src/sintactico/Syntax.java")
        );
    }
}
