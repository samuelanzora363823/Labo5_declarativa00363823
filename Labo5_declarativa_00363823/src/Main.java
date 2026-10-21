import javax.swing.SwingUtilities;

public class Main {
    public static void main(String[] args) throws Exception {
        Connection motor = new Connection();
        SwingUtilities.invokeLater(() -> new Window(motor).setVisible(true));
    }
}