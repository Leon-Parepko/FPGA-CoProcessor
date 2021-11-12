-- The following program receives a UART (8N1) character on the rx pin and then stores it in an array. It then outputs the same character 
-- back on the tx pin.

library IEEE;
use IEEE.STD_Logic_1164.ALL;

-- Define Clock as input, rx as input, tx as output and LED_rx as Output

entity UART is
	Port(	clk:		in STD_LOGIC;
			rx:		in STD_LOGIC;
			tx:		out STD_LOGIC;
			LED_rx: 	out STD_LOGIC);
	end UART;


architecture Behavioral of UART is

	
begin

-- Instructions are executed sequencially with the process
	process(clk)
	
	variable counter:			integer range 0 to 50000 :=0;								-- Counter used for reading rx pin
	variable counter_2:		integer range 0 to 50000 :=0;								-- Counter used for reading tx pin
	variable tx_flag:			std_LOGIC :='0';												-- Flag to start transmitting data on tx pin
	variable UART_buffer: 	STD_LOGIC_VECTOR (9 DOWNTO 0) :="0000000000";		-- Array to store incoming data
	
	
	variable data_receiving: STD_LOGIC :='0';												-- Flag to indicate incoming serial data
	
	begin
			if clk' event and clk='1' then  													-- The IF condition is executed during the rising edge of the clock
			
						
						if (rx='0' and counter=0) then										-- Detects Start bit of the message
								data_receiving:='1';
								
-- Receiving UART message on rx	
-- Counter values are hard coded to receive 9600 bits/sec. Each bit is stored in an array.
								
						elsif (counter=2604 and data_receiving='1') then
								UART_buffer(0):=rx;
						
						elsif (counter=7812 and data_receiving='1') then
								UART_buffer(1):=rx;
								
						elsif (counter=13020 and data_receiving='1') then
								UART_buffer(2):=rx;
						
						elsif (counter=18228 and data_receiving='1') then
								UART_buffer(3):=rx;
								
						elsif (counter=23436 and data_receiving='1') then
								UART_buffer(4):=rx;
						
						elsif (counter=28644 and data_receiving='1') then
								UART_buffer(5):=rx;
								
						elsif (counter=33852 and data_receiving='1') then
								UART_buffer(6):=rx;
								
						elsif (counter=39060 and data_receiving='1') then
								UART_buffer(7):=rx;
								
						elsif (counter=44268 and data_receiving='1') then
								UART_buffer(8):=rx;
						
						elsif (rx='1' and data_receiving='1' and counter=49476) then
								counter:=0;
								data_receiving:='0';
								tx_flag:='1';
								UART_buffer(9):=rx;
								
						end if;
						
						
						if(data_receiving='1') then
								counter:=counter+1;
						end if;

	
-- Sending UART message on tx	
-- A seperate counter is used to send the character stored in array at a rate of 9600 bits/sec.
						
						if(tx_flag='1' and counter_2=0) then
								tx<=UART_buffer(0);
								
						elsif (tx_flag='1' and counter_2=5208) then
								tx<=UART_buffer(1);
								
						elsif (tx_flag='1' and counter_2=10416) then
								tx<=UART_buffer(2);
								
						elsif (tx_flag='1' and counter_2=15624) then
								tx<=UART_buffer(3);
								
						elsif (tx_flag='1' and counter_2=20832) then
								tx<=UART_buffer(4);
								
						elsif (tx_flag='1' and counter_2=26040) then
								tx<=UART_buffer(5);
								
						elsif (tx_flag='1' and counter_2=31248) then
								tx<=UART_buffer(6);
						
						elsif (tx_flag='1' and counter_2=36456) then
								tx<=UART_buffer(7);
								
						elsif (tx_flag='1' and counter_2=41664) then
								tx<=UART_buffer(8);
								
						elsif (tx_flag='1' and counter_2=46872) then
								tx<=UART_buffer(9);
								tx_flag:='0';															-- Initializes counter and flag
								counter_2:=0;	
								
						end if;
						
						if (tx_flag='1') then
						counter_2:=counter_2+1;														-- Updates counter_2
						end if;
						
				
			end if;
			
	end process;

LED_rx<=rx;																								--Maps Rx to LED

end Behavioral;