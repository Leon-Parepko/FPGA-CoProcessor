import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;

import javax.swing.*;
import javax.swing.event.PopupMenuEvent;
import javax.swing.event.PopupMenuListener;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

public class MainAppFrame extends JFrame {
    private JPanel MainPanel;
    private JButton sendButton;
    private JComboBox<String> PortsComboBox;
    private JComboBox<Integer> DataBits_comboBox;
    private JComboBox<Integer> StopBits_comboBox;
    private JSlider BitrateSlider;
    private JTextArea inputArea;
    private JButton openPortButton;
    private JTextArea textArea2;
    private JLabel BitTrade_Text;
    private JLabel Status;

    SerialPort[] AvailablePorts;
    SerialPort currentPort = null;

    int bitrateIndex;

    public MainAppFrame(String title) {
        super(title);

        this.setContentPane(MainPanel);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        AvailablePorts = SerialPort.getCommPorts();
        for (SerialPort s : AvailablePorts) {
            PortsComboBox.addItem(s.getSystemPortName() + ": " + s);
        }

        BitrateSlider.addChangeListener(e -> {
            bitrateIndex = BitrateSlider.getValue();
            BitTrade_Text.setText(String.valueOf(bitrateIndex * 1200));

            currentPort.setBaudRate(bitrateIndex * 1200);
        });

        openPortButton.addActionListener(e -> {
            currentPort.openPort();
        });

        PortsComboBox.addPopupMenuListener(new PopupMenuListener() {
            @Override
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
                PortsComboBox.removeAllItems();

                AvailablePorts = SerialPort.getCommPorts();
                for (SerialPort s : AvailablePorts) {
                    PortsComboBox.addItem(s.getSystemPortName() + ": " + s);
                }
            }

            @Override
            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {

            }

            @Override
            public void popupMenuCanceled(PopupMenuEvent e) {

            }
        });

        PortsComboBox.addActionListener(e -> {
            // Remove data listener from previous port
            if (currentPort != null) {
                currentPort.removeDataListener();
                currentPort.closePort();
            }

            int position = PortsComboBox.getSelectedIndex();
            if (position != -1) {
                currentPort = AvailablePorts[position];

                currentPort.addDataListener(new SerialPortDataListener() {
                    @Override
                    public int getListeningEvents() {
                        return SerialPort.LISTENING_EVENT_DATA_RECEIVED;
                    }

                    @Override
                    public void serialEvent(SerialPortEvent serialPortEvent) {
                        byte[] incomingData = serialPortEvent.getReceivedData();
                        System.out.println(new String(incomingData));
                    }
                });
            }
        });

        sendButton.addActionListener(e -> {
            try {
                OutputStream outputStream = currentPort.getOutputStream();
                outputStream.write(inputArea.getText().getBytes(StandardCharsets.UTF_8));
            } catch (ArrayIndexOutOfBoundsException | IOException a) {
                Status.setText("Could not send Data!");
            } catch (NullPointerException a) {
                Status.setText("No ports available!");
            }
        });
    }

    public static void main(String[] args) {
        JFrame appFrame = new MainAppFrame("COM-Port Communication App");
        appFrame.setSize(500, 500);
        appFrame.setVisible(true);
    }
}