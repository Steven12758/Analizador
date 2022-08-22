/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package lexico;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author root
 */
public class GUI_Lexico extends javax.swing.JFrame {

    /**
     * Creates new form GUI_Lexico
     */
    public GUI_Lexico() {
        initComponents();
        this.setLocationRelativeTo(null);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        btnAnalizar = new javax.swing.JButton();
        txtEntrada = new javax.swing.JTextField();
        jScrollPane1 = new javax.swing.JScrollPane();
        txtResultado = new javax.swing.JTextArea();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        btnAnalizar.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        btnAnalizar.setText("Analizar");
        btnAnalizar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAnalizarActionPerformed(evt);
            }
        });

        txtEntrada.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N

        txtResultado.setColumns(20);
        txtResultado.setRows(5);
        jScrollPane1.setViewportView(txtResultado);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(txtEntrada, javax.swing.GroupLayout.PREFERRED_SIZE, 342, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnAnalizar, javax.swing.GroupLayout.PREFERRED_SIZE, 121, Short.MAX_VALUE))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnAnalizar)
                    .addComponent(txtEntrada, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 247, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnAnalizarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAnalizarActionPerformed
        // TODO add your handling code here:
        File archivo = new File("archivo.txt");
        PrintWriter escribir;
        try {
            escribir = new PrintWriter(archivo);
            escribir.print(txtEntrada.getText());
            escribir.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(GUI_Lexico.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            Reader lector = new BufferedReader(new FileReader("archivo.txt"));
            Lexer lexer = new Lexer(lector);
            String resultado = "";
            while (true) {
                Tokens tokens = lexer.yylex();
                if (tokens == null) {
                    resultado += "FIN";
                    txtResultado.setText(resultado);
                    return;
                }
                switch (tokens) {
                    case IDENTIFICADOR:
                        resultado += "  <Identificador>\t\t" + lexer.lexeme + "\n";
                        break;
                    case Comillas:
                        resultado += "  <Comillas>\t\t" + lexer.lexeme + "\n";
                        break;
                    case Linea:
                        resultado += "  <Linea>\t\t" + lexer.lexeme + "\n";
                        break;
                    case P_RESERVADA:
                        resultado += "  <Palabra Reservada>\t\t" + lexer.lexeme + "\n";
                        break;
                    case Void:
                        resultado += "  <Palabra Reservada>\t\t" + lexer.lexeme + "\n";
                        break;
                    case Main:
                        resultado += "  <Palabra Reservada>\t" + lexer.lexeme + "\n";
                        break;
                    case Op_ACCESO:
                        resultado += "  <Operador Acceso>\t\t" + lexer.lexeme + "\n";
                        break;
                    case Suma:
                        resultado += "  <Operador suma>\t" + lexer.lexeme + "\n";
                        break;
                    case Resta:
                        resultado += "  <Operador resta>\t" + lexer.lexeme + "\n";
                        break;
                    case Multiplicacion:
                        resultado += "  <Operador multiplicacion>\t" + lexer.lexeme + "\n";
                        break;
                    case Division:
                        resultado += "  <Operador division>\t" + lexer.lexeme + "\n";
                        break;
                    case ASIGNACION:
                        resultado += "  <Operador igual>\t" + lexer.lexeme + "\n";
                        break;
                    case Op_incremento:
                        resultado += "  <Operador incremento>\t" + lexer.lexeme + "\n";
                        break;
                    case Op_disminucion:
                        resultado += "  <Operador disminucion>\t" + lexer.lexeme + "\n";
                        break;
                    case Op_atribucion:
                        resultado += "  <Operador atribucion>\t" + lexer.lexeme + "\n";
                        break;
                    case If:
                        resultado += "  <Reservada if>\t" + lexer.lexeme + "\n";
                        break;
                    case Else:
                        resultado += "  <Reservada else>\t" + lexer.lexeme + "\n";
                        break;
                    case Do:
                        resultado += "  <Reservada do>\t" + lexer.lexeme + "\n";
                        break;
                    case While:
                        resultado += "  <Reservada while>\t" + lexer.lexeme + "\n";
                        break;
                    case For:
                        resultado += "  <Reservada while>\t" + lexer.lexeme + "\n";
                        break;
                    case PUNTO:
                        resultado += "  <Punto>\t" + lexer.lexeme + "\n";
                        break;
                    case Op_DOS_PUNTOS:
                        resultado += "  <Dos puntos>\t" + lexer.lexeme + "\n";
                        break;
                    case P_TERMINADOR:
                        resultado += "  <Punto y coma>\t" + lexer.lexeme + "\n";
                        break;
                    case COMA:
                        resultado += "  <Coma>\t" + lexer.lexeme + "\n";
                        break;
                    case T_dato:
                        resultado += "  <Tipo de dato>\t" + lexer.lexeme + "\n";
                        break;
                    case Numero:
                        resultado += "  <Identificador Numero>\t" + lexer.lexeme + "\n";
                        break;
                    case Cadena:
                        resultado += "  <Identificador Cadena\t" + lexer.lexeme + "\n";
                        break;
                    case Op_logico:
                        resultado += "  <Operador logico>\t" + lexer.lexeme + "\n";
                        break;
                    case Op_booleano:
                        resultado += "  <Operador booleano>\t" + lexer.lexeme + "\n";
                        break;
                    case Op_relacional:
                        resultado += "  <Operador relacional>\t" + lexer.lexeme + "\n";
                        break;
                    case Parentesis_a:
                        resultado += "  <Parentesis de apertura>\t" + lexer.lexeme + "\n";
                        break;
                    case Parentesis_c:
                        resultado += "  <Parentesis de cierre>\t" + lexer.lexeme + "\n";
                        break;
                    case Llave_a:
                        resultado += "  <Llave de apertura>\t" + lexer.lexeme + "\n";
                        break;
                    case Llave_c:
                        resultado += "  <Llave de cierre>\t" + lexer.lexeme + "\n";
                        break;
                    case Corchete_a:
                        resultado += "  <Corchete de apertura>\t" + lexer.lexeme + "\n";
                        break;
                    case Corchete_c:
                        resultado += "  <Corchete de cierre>\t" + lexer.lexeme + "\n";
                        break;
                    case ERROR:
                        resultado += "  <Simbolo no definido>\n";
                        break;
                    default:
                        resultado += "  < " + lexer.lexeme + " >\n";
                        break;
                }
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(GUI_Lexico.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(GUI_Lexico.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_btnAnalizarActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(GUI_Lexico.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(GUI_Lexico.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(GUI_Lexico.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GUI_Lexico.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new GUI_Lexico().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAnalizar;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextField txtEntrada;
    private javax.swing.JTextArea txtResultado;
    // End of variables declaration//GEN-END:variables
}
