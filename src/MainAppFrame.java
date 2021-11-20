import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;
import com.fazecast.jSerialComm.SerialPortInvalidPortException;

import javax.swing.*;
import javax.swing.event.PopupMenuEvent;
import javax.swing.event.PopupMenuListener;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.HashSet;
import java.util.stream.Collectors;

public class MainAppFrame extends JFrame {
    private JPanel MainPanel;

    private JLabel Title;
    private JLabel StatusLabel;
    private JLabel StatusMessage;
    private JLabel OutputLabel;

    private JTextArea InputText;
    private JTextArea OutputText;

    private JSlider BitrateSlider;
    private JComboBox comboBox1;
    private JComboBox comboBox2;
    private JComboBox comboBox3;
    private JComboBox<String> SerialPortComboBox;

    private JButton SendMessage;
    private JButton OpenButton;
    private JButton ClearButton;
    private JLabel BitrateLabel;

    SerialPort CurrentPort = null;

    int bitrateIndex = 8;

    void trace(String msg) {
        StatusMessage.setText(msg);
    }

    public MainAppFrame(String title) {
        super(title);

        this.setContentPane(MainPanel);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        OpenButton.setEnabled(false);

        SerialPortComboBox.addItem("None");
        SerialPortComboBox.addPopupMenuListener(new PopupMenuListener() {
            @Override
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
                HashSet<String> serialPortHashSet = Arrays.stream(
                        SerialPort.getCommPorts()).map(
                        i -> i.getSystemPortName() + ": " + i.getPortDescription()
                ).collect(Collectors.toCollection(HashSet::new)
                );

                int comboBoxSize = SerialPortComboBox.getItemCount();
                for (int i = 1; i < comboBoxSize; i++) {
                    String item = SerialPortComboBox.getItemAt(i);

                    if (serialPortHashSet.contains(item)) {
                        serialPortHashSet.remove(item);
                    } else {
                        SerialPortComboBox.removeItem(item);
                        --comboBoxSize;
                        --i;
                    }
                }

                for (String s : serialPortHashSet) {
                    SerialPortComboBox.addItem(s);
                }
            }

            @Override
            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {
            }

            @Override
            public void popupMenuCanceled(PopupMenuEvent e) {
            }
        });

        SerialPortComboBox.addActionListener(e -> {
            Object item = SerialPortComboBox.getSelectedItem();

            // Reset previous port connection
            if (CurrentPort != null) {
                CurrentPort.removeDataListener();
                CurrentPort.closePort();

                OpenButton.setEnabled(false);
                OpenButton.setText("---");

                trace(CurrentPort.getSystemPortName() + " connection closed!");
            }

            if (item != null) {
                String port = item.toString().split(":")[0];

                if (port != null && !port.equals("None")) {
                    try {
                        CurrentPort = SerialPort.getCommPort(port);

                        CurrentPort.addDataListener(new SerialPortDataListener() {
                            @Override
                            public int getListeningEvents() {
                                return SerialPort.LISTENING_EVENT_DATA_RECEIVED;
                            }

                            @Override
                            public void serialEvent(SerialPortEvent serialPortEvent) {
                                byte[] incomingData = serialPortEvent.getReceivedData();
                                OutputText.append(new String(incomingData));
                            }
                        });

                        OpenButton.setEnabled(true);
                        OpenButton.setText("Open " + port + " port");
                    } catch (SerialPortInvalidPortException ignored) {
                        trace("Invalid port");
                    }
                }
            }
        });

        BitrateSlider.addChangeListener(e -> {
            bitrateIndex = BitrateSlider.getValue();
            BitrateLabel.setText(String.valueOf(bitrateIndex * 1200));

            if (CurrentPort != null) {
                CurrentPort.setBaudRate(bitrateIndex * 1200);
            }
        });

        SendMessage.addActionListener(e -> {
            try {
                OutputStream outputStream = CurrentPort.getOutputStream();
                outputStream.write(InputText.getText().getBytes(StandardCharsets.UTF_8));
            } catch (ArrayIndexOutOfBoundsException | IOException a) {
                trace("Could not send data!");
            } catch (NullPointerException a) {
                trace("No ports available!");
            }
        });

        OpenButton.addActionListener(e -> {
            String port = CurrentPort.getSystemPortName();

            if (CurrentPort.isOpen()) {
                if (CurrentPort.closePort()) {
                    trace("Port " + port + " closed!");
                    OpenButton.setText("Open " + port + " port");
                } else {
                    trace("Failed to close " + port + " port!");
                    OpenButton.setText("Close " + port + " port");
                }
            } else {
                if (CurrentPort.openPort()) {
                    CurrentPort.setBaudRate(bitrateIndex * 1200);

                    trace("Port " + port + " opened!");
                    OpenButton.setText("Close " + port + " port");
                } else {
                    trace("Failed to open " + port + " port!");
                    OpenButton.setText("Open " + port + " port");
                }
            }
        });

        ClearButton.addActionListener(e -> OutputText.setText(""));
    }

    public static void main(String[] args) {
        JFrame appFrame = new MainAppFrame("COM-Port Communication App");
        appFrame.setSize(960, 540);
        appFrame.setVisible(true);
    }
}