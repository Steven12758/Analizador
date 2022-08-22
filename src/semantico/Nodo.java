package semantico;

import java.util.ArrayList;

/**
 *
 * @author root
 */
public final class Nodo {
    public String Etiqueta; 
    public ArrayList<Nodo> hijos = new ArrayList<>();
    public String valor; 
    public int ID; 
    
    public Nodo(String etiqueta){
        setEtiqueta(etiqueta);
        hijos = new ArrayList<>();
        setIdNod(0);
    }
    
    public void AddHijos(Nodo hijo){
        hijos.add(hijo);
    }

    public String getEtiqueta() {
        return Etiqueta;
    }

    public void setEtiqueta(String Etiqueta) {
        this.Etiqueta = Etiqueta;
    }

    public ArrayList<Nodo> getHijos() {
        return hijos;
    }

    public void setHijos(ArrayList<Nodo> hijos) {
        this.hijos = hijos;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public int getIdNod() {
        return ID;
    }

    public void setIdNod(int idNod) {
        this.ID = idNod;
    }
}
