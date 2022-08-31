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
        Path path = Paths.get("");
	String directoryName = path.toAbsolutePath().toString();
        
        String lexer = "";
        String sintactico = "";
        String[] rutas = {"-parser", "Syntax", ""};
        
        if(isWindows()){
            lexer = directoryName+"\\src\\lexico\\Lexer.flex";
            sintactico = directoryName+"\\src\\sintactico\\LexerCup.flex";
            rutas[2] = directoryName+"\\src\\sintactico\\Syntax.cup";
        }else{
            lexer = directoryName+"/src/lexico/Lexer.flex";
            sintactico = directoryName+"/src/sintactico/LexerCup.flex";
            rutas[2] = directoryName+"/src/sintactico/Syntax.cup";
        }
        generar(lexer, sintactico, rutas);
    }

    public static void generar(String ruta1, String ruta2, String[] rutaS) throws IOException, Exception {
        Path path = Paths.get("");
	String directoryName = path.toAbsolutePath().toString();
        String sintacticoPath = "";
        if(isWindows()){
            directoryName+= "\\";
            sintacticoPath = directoryName+"src\\sintactico\\";
        }else{
            directoryName+= "/";
            sintacticoPath = directoryName+"src/sintactico/";     
        }
        
            File archivo;
            archivo = new File(ruta1);
            JFlex.Main.generate(archivo);
            archivo = new File(ruta2);
            JFlex.Main.generate(archivo);
            java_cup.Main.main(rutaS);

            Path rutaSym = Paths.get(sintacticoPath+"sym.java");
            if (Files.exists(rutaSym)) {
                Files.delete(rutaSym);
            }
            Files.move(
                    Paths.get(directoryName+"sym.java"),
                    Paths.get(sintacticoPath+"sym.java")
            );
            Path rutaSin = Paths.get(sintacticoPath+"Syntax.java");
            if (Files.exists(rutaSin)) {
                Files.delete(rutaSin);
            }
        Files.move(
                Paths.get(directoryName+"Syntax.java"),
                Paths.get(sintacticoPath+"Syntax.java")
        );
    }

    public static boolean isWindows() {
        String os = System.getProperty("os.name").toLowerCase();
        return os.contains("win"); //Windows: else //Linux
    }
}
