###############################################################################
#	"make compile"  - compiles your verilog design - good for checking code
#	"make simulate" - compiles your design+TB & simulates your design
#	"make wave"     - compiles, simulates and displays waveforms
# 
###############################################################################
#
# CHANGE THESE THREE LINES FOR YOUR DESIGN
#
#TOOL INPUT
SOURCE    = ./source_list
WAVEFILE  = tb_top.vcd
###############################################################################
# SIMULATION OPTION
###############################################################################
#TOOLS
COMPILER = iverilog
SIMULATOR = vvp
VIEWER = gtkwave
#TOOL OPTIONS
COFLAGS = -v -o 
SFLAGS = -v
SOUTPUT = 	
#TOOL OUTPUT
COUTPUT = compile.out			
###############################################################################
#MAKE DIRECTIVES
compile : $(TESTBENCH) $(SOURCE)
	$(COMPILER) -g2005-sv -o compile.out -s tb_top -c $(SOURCE)

simulate: $(COUTPUT)
	$(SIMULATOR) $(SFLAGS) $(COUTPUT) $(SOUTPUT)

wave: $(WAVEFILE)
	$(VIEWER) $(WAVEFILE) &
#MAKE DEPENDANCIES
$(WAVEFILE): $(COUTPUT)
	$(SIMULATOR) $(SOPTIONS) $(COUTPUT) $(SOUTPUT)

$(COUTPUT): $(TESTBENCH) $(SOURCE)
	$(COMPILER) $(COFLAGS) $(COUTPUT) $(TESTBENCH) $(SOURCE)