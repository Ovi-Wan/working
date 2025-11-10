package arrayConLista;

import java.util.Scanner;

public class ArrayLista {
    private int[] elementos;
    private int cantidadElementos;
    private static final int TAMANIO_INICIAL = 5;

    // --- Constructor ---
    public ArrayLista() {
        elementos = new int[TAMANIO_INICIAL];
        cantidadElementos = 0;
    }

    public ArrayLista(int capacidadInicial) {
        elementos = new int[capacidadInicial];
        cantidadElementos = 0;
    }

    // --- Métodos estilo Array ---
    public int longitud() {
        return elementos.length;
    }

    public int get(int indice) {
        if (indice < 0 || indice >= cantidadElementos) {
            System.out.println("Índice inválido.");
            return -1;
        }
        return elementos[indice];
    }

    public void set(int indice, int valor) {
        if (indice < 0 || indice >= elementos.length) {
            System.out.println("Índice inválido.");
            return;
        }
        // Si está dentro del rango de elementos actuales, modifica.
        // Si no, amplía la cantidadElementos hasta ese punto.
        if (indice >= cantidadElementos) {
            cantidadElementos = indice + 1;
        }
        elementos[indice] = valor;
    }

    // --- Métodos estilo Lista ---
    public void insertar(int valor, int posicion) {
        if (posicion < 0 || posicion > cantidadElementos) {
            System.out.println("Posición inválida.");
            return;
        }

        if (cantidadElementos == elementos.length) {
            expandir();
        }

        for (int i = cantidadElementos - 1; i >= posicion; i--) {
            elementos[i + 1] = elementos[i];
        }

        elementos[posicion] = valor;
        cantidadElementos++;
    }

    public void eliminar(int posicion) {
        if (posicion < 0 || posicion >= cantidadElementos) {
            System.out.println("Posición inválida.");
            return;
        }

        for (int i = posicion; i < cantidadElementos - 1; i++) {
            elementos[i] = elementos[i + 1];
        }

        elementos[cantidadElementos - 1] = 0;
        cantidadElementos--;
    }

    public void mostrar() {
        System.out.print("[");
        for (int i = 0; i < cantidadElementos; i++) {
            System.out.print(elementos[i]);
            if (i < cantidadElementos - 1) System.out.print(", ");
        }
        System.out.println("]");
    }

    private void expandir() {
        int[] nuevoArray = new int[elementos.length * 2];
        for (int i = 0; i < elementos.length; i++) {
            nuevoArray[i] = elementos[i];
        }
        elementos = nuevoArray;
    }

    // --- Método para mostrar posiciones válidas ---
    public void mostrarPosicionesValidas() {
        System.out.print("Posiciones válidas para insertar: ");
        for (int i = 0; i <= cantidadElementos; i++) {
            System.out.print(i);
            if (i < cantidadElementos) System.out.print(", ");
        }
        System.out.println();
    }

    // --- Getter del número de elementos actuales ---
    public int getCantidadElementos() {
        return cantidadElementos;
    }

    // --- Método para pruebas estilo ClienteArray ---
    public static void demoArrayLista() {
        ArrayLista al = new ArrayLista(5);

        System.out.println("INICIALIZACIÓN");
        System.out.println("Capacidad: " + al.longitud());

        System.out.println("\nESTABLECIENDO VALORES");
        al.set(0, 100);
        al.set(1, 200);
        al.set(2, 300);
        al.set(3, 400);
        al.set(4, 500);

        System.out.println("\nCONTENIDO DEL ARRAY");
        al.mostrar();

        System.out.println("\nMODIFICANDO POSICIÓN 2");
        al.set(2, 999);
        al.mostrar();

        System.out.println("\nINSERTANDO EN POSICIÓN 1 (valor 111)");
        al.insertar(111, 1);
        al.mostrar();

        System.out.println("\nELIMINANDO POSICIÓN 3");
        al.eliminar(3);
        al.mostrar();
    }

    // --- Main opcional para probar interactivamente ---
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayLista lista = new ArrayLista();

        int opcion;
        do {
            System.out.println("\n1. Insertar\n2. Eliminar\n3. Obtener\n4. Mostrar\n5. Demo\n0. Salir");
            System.out.print("Ingrese opción: ");
            opcion = sc.nextInt();

            switch (opcion) {
                case 1:
                    lista.mostrarPosicionesValidas();
                    System.out.print("Valor: ");
                    int v = sc.nextInt();
                    System.out.print("Posición: ");
                    int p = sc.nextInt();
                    lista.insertar(v, p);
                    break;
                case 2:
                    System.out.print("Posición a eliminar: ");
                    int pe = sc.nextInt();
                    lista.eliminar(pe);
                    break;
                case 3:
                    System.out.print("Posición a obtener: ");
                    int po = sc.nextInt();
                    int valor = lista.get(po);
                    if (valor != -1) System.out.println("Valor: " + valor);
                    break;
                case 4:
                    lista.mostrar();
                    break;
                case 5:
                    demoArrayLista();
                    break;
                case 0:
                    System.out.println("Fin del programa.");
                    break;
                default:
                    System.out.println("Opción inválida.");
            }
        } while (opcion != 0);

        sc.close();
    }
}
