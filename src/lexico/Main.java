/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lexico;

import java.io.File;

/**
 *
 * @author root
 */
public class Main {

    public static void main(String[] args) {
        String ruta = "/root/NetBeansProjects/Analizador/src/lexico/Lexer.flex";
        generarLexer(ruta);
    }

    public static void generarLexer(String ruta) {
        File archivo = new File(ruta);
        JFlex.Main.generate(archivo);
    }
}
