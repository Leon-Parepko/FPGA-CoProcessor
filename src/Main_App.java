import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.event.PopupMenuEvent;
import javax.swing.event.PopupMenuListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.channels.ConnectionPendingException;

import com.fazecast.jSerialComm.SerialPort;

public class Main_App extends JFrame{
    private JPanel Main_Panel;
    private JButton sendButton;
    private JComboBox Ports_comboBox;
    private JComboBox DataBits_comboBox;
    private JComboBox StopBits_comboBox;
    private JSlider BitTrade_slider;
    private JTextArea textArea1;
    private JButton openPortButton;
    private JTextArea textArea2;
    private JLabel BitTrade_Text;
    private JLabel Status;


    //        CONFIG
    SerialPort []Available_ports = SerialPort.getCommPorts();
    SerialPort CurrentPort;
    int BitTradeIndex;




    public Main_App(String title){
        super(title);

        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setContentPane(Main_Panel);


        Ports_comboBox.addPopupMenuListener(new PopupMenuListener() {
            @Override
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
                Ports_comboBox.removeAllItems();
                Available_ports = SerialPort.getCommPorts();
                for (SerialPort port:Available_ports) {
                    Ports_comboBox.addItem(port.getSystemPortName());
                }
            }

            @Override
            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {}

            @Override
            public void popupMenuCanceled(PopupMenuEvent e) {}
        });



        BitTrade_slider.addChangeListener(new ChangeListener() {
            @Override
            public void stateChanged(ChangeEvent e) {
                BitTradeIndex = BitTrade_slider.getValue();
                BitTrade_Text.setText(String.valueOf(BitTradeIndex * 2 * 600));
            }
        });


//                OPEN COM PORT BUTTON
        openPortButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Available_ports = SerialPort.getCommPorts();
                try {
                    if (Ports_comboBox.getSelectedIndex() == -1 && Available_ports.length == 0){
                        throw new ConnectionPendingException();
                    }
                    else if (Ports_comboBox.getSelectedIndex() == -1 && Available_ports.length > 0){
                        throw new IOException("port_not_chosen");
                    }
                    CurrentPort = Available_ports[Ports_comboBox.getSelectedIndex()];
                    CurrentPort.setBaudRate(Integer.parseInt(BitTrade_Text.getText()));
                    CurrentPort.setNumDataBits(Integer.parseInt((String) DataBits_comboBox.getSelectedItem()));
                    CurrentPort.setNumStopBits(Integer.parseInt((String) StopBits_comboBox.getSelectedItem()));
                    CurrentPort.openPort();
                    Status.setText(CurrentPort.getSystemPortName() + " is running...");
                }

                catch (ConnectionPendingException a){
                    Status.setText("No available ports!");
                }
                catch (IOException b){
                    Status.setText("No port chosen!");
                }

            }
        });


//                SEND DATA BUTTON
        sendButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                try {
                    OutputStream OutStream = CurrentPort.getOutputStream();

                    OutStream.write(Integer.parseInt(textArea1.getText()));
                }

                catch (ArrayIndexOutOfBoundsException | IOException a){
                    Status.setText("Could not send Data!");
                }
                catch (NullPointerException a){
                    Status.setText("No ports available!");
                }
            }
        });

    }




    public static void main(String[] args) {

        JFrame frame = new Main_App("Test");
        frame.setVisible(true);
        frame.setSize(500, 500);

    }

}
