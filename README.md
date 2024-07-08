# The CPU

The design of this controller was divided into five sections.

### 1: The register file:
First, the R0-R7 register transfer was designed in “reg_file.vhd”. This contains the registers for the operation in ALU.

### 2: Function Unit:
This is implemented in “fun_file.vhd”. This is the alu and it performs the operation as per the instruction from Control unit.

### 3: Datapath:

The “datapath.vhd” combines “reg_file.vhd” and “fun_file.vhd” together with mux at input driven by the control word itself. The constent is muxed with reg_file output, while data_in is muxed with function unit’s output.
The data path gets the control word from the memory and then performs operation from data_in or registers from reg_file.

### 4: Control and Memory:
The controller generates an address when go is 1 and provides it to the memory. When the memory gets the address, and RD is high, it provides a control word to the datapath.

### 5: Assign2:
This file combines all the sub-blocks, the controller provides an address to memory, and the memory provides a control word to the datapath. And in the datapath, the sub-section reg- file and fun-file can be seen.

