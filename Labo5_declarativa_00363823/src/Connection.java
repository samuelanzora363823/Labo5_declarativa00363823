import alice.tuprolog.Prolog;
import alice.tuprolog.SolveInfo;
import alice.tuprolog.Theory;
import alice.tuprolog.Term;
import alice.tuprolog.Struct;
import java.io.InputStream;

public class Connection {
    private final Prolog engine = new Prolog();

    public Connection() throws Exception {
        try (InputStream in = getClass().getResourceAsStream("/calculo.pl")) {
            if (in == null) throw new IllegalStateException("No se encontró calculo.pl");
            engine.setTheory(new Theory(in));
        }
    }

    public String consultar(String predicado, String expresion) throws Exception {
        SolveInfo info = engine.solve(predicado + "(x, " + expresion + ", R).");
        if (info.isSuccess()) {
            Term resultado = info.getTerm("R");
            return formatearTermino(resultado);
        } else {
            return "Sin solución para esa expresión";
        }
    }

    // Convierte el árbol sintáctico de tuProlog a expresión matemática legible
    private String formatearTermino(Term t) {
        if (t == null) return "";

        if (t instanceof Struct) {
            Struct s = (Struct) t;
            String op = s.getName().replace("'", "").trim();
            int arity = s.getArity();

            if (arity == 2) {
                if (op.equals("+") || op.equals("-") || op.equals("*") || op.equals("/") || op.equals("^")) {
                    return formatearTermino(s.getArg(0)) + op + formatearTermino(s.getArg(1));
                }
            } else if (arity == 1) {
                return op + "(" + formatearTermino(s.getArg(0)) + ")";
            } else if (arity == 0) {
                return op;
            }
        }

        return t.toString().replace("'", "").trim();
    }
}