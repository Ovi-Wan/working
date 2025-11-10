package arrayConLista;

import arrayConLista.a000.Array;
import arrayConLista.a000.Lista;
import java.util.Scanner;

public class ArrayOuroboros {
    private Lista listaInterna;
    private int[] arregloInterno;
    private int cantidadElementos;

    // --- Constructor ---
    public ArrayOuroboros(int capacidadInicial) {
        assert capacidadInicial > 0 : "La capacidad inicial debe ser positiva.";

        listaInterna = new Lista();
        arregloInterno = new int[capacidadInicial];
        cantidadElementos = capacidadInicial;

        // inicializamos ambos con ceros
        for (int i = 0; i < capacidadInicial; i++) {
            listaInterna.agregar(0);
            arregloInterno[i] = 0;
        }
    }

    // --- Array-like methods ---
    public int get(int indice) {
        assert indice >= 0 && indice < cantidadElementos : "Índice fuera de rango";
        return listaInterna.obtener(indice);
    }

    public void set(int indice, int valor) {
        assert indice >= 0 && indice < cantidadElementos : "Índice fuera de rango";
        listaInterna.modificar(indice, valor);
        arregloInterno[indice] = valor;
    }

    public int longitud() {
        return cantidadElementos;
    }

    // --- List-like methods ---
    public void insertar(int valor, int posicion) {
        if (posicion < 0 || posicion > cantidadElementos) {
            System.out.println("Posición inválida.");
            return;
        }

        // expand array
        int[] nuevo = new int[arregloInterno.length + 1];
        for (int i = 0; i < posicion; i++) nuevo[i] = arregloInterno[i];
        nuevo[posicion] = valor;
        for (int i = posicion; i < arregloInterno.length; i++)
            nuevo[i + 1] = arregloInterno[i];
        arregloInterno = nuevo;

        // rebuild linked list
        reconstruirLista();
        cantidadElementos++;
    }

    public void eliminar(int posicion) {
        if (posicion < 0 || posicion >= cantidadElementos) {
            System.out.println("Posición inválida.");
            return;
        }

        int[] nuevo = new int[arregloInterno.length - 1];
        for (int i = 0, j = 0; i < arregloInterno.length; i++) {
            if (i != posicion) {
                nuevo[j++] = arregloInterno[i];
            }
        }
        arregloInterno = nuevo;

        reconstruirLista();
        cantidadElementos--;
    }

    // --- Helper: rebuild linked list to stay in sync ---
    private void reconstruirLista() {
        listaInterna = new Lista();
        for (int v : arregloInterno) {
            listaInterna.agregar(v);
        }
    }

    // --- Display ---
    public void mostrar() {
        System.out.print("[");
        for (int i = 0; i < cantidadElementos; i++) {
            System.out.print(get(i));
            if (i < cantidadElementos - 1) System.out.print(", ");
        }
        System.out.println("]");
    }

    // --- Demo for ouroboros behavior ---
    public static void demo() {
        ArrayOuroboros o = new ArrayOuroboros(5);

        System.out.println("INICIALIZACIÓN");
        System.out.println("Capacidad: " + o.longitud());

        System.out.println("\nESTABLECIENDO VALORES");
        for (int i = 0; i < o.longitud(); i++) {
            o.set(i, (i + 1) * 100);
        }

        System.out.println("\nCONTENIDO DEL OUROBOROS:");
        o.mostrar();

        System.out.println("\nMODIFICANDO POSICIÓN 2 → 999");
        o.set(2, 999);
        o.mostrar();

        System.out.println("\nINSERTANDO EN POSICIÓN 1 → 111");
        o.insertar(111, 1);
        o.mostrar();

        System.out.println("\nELIMINANDO POSICIÓN 3");
        o.eliminar(3);
        o.mostrar();
    }

    // --- Optional interactive menu ---
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayOuroboros lista = new ArrayOuroboros(3);

        int opcion;
        do {
            System.out.println("\n1. Insertar\n2. Eliminar\n3. Obtener\n4. Mostrar\n5. Demo\n0. Salir");
            System.out.print("Opción: ");
            opcion = sc.nextInt();

            switch (opcion) {
                case 1:
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
                    System.out.println("Valor: " + lista.get(po));
                    break;
                case 4:
                    lista.mostrar();
                    break;
                case 5:
                    demo();
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
