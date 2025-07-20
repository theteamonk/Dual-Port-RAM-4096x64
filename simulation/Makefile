# Makefile for Memory - Regression Testing - Lab10

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = Questa
FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64
RTL= ../rtl/*.v
work= work #library name
SVTB1= ../env_lib/ram_if.sv
INC = +incdir+../env +incdir+../env_lib +incdir+../test
SVTB2 = ../test/ram_pkg.sv  ../test/top.sv
COVOP = -coveropt 3 +cover=bcft
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"

help:
	@echo ===========================================================================================================
	@echo " USAGE   	--  make target                      								"
	@echo " clean   	=>  clean the earlier log and intermediate files.      						"
	@echo " sv_cmp    	=>  Create library and compile the code.              						"									   
	@echo " TC1       	=>  To compile and run the testcase1 in batch mode.						" 
	@echo " TC2        	=>  To compile and run the testcase2 in batch mode.						" 
	@echo " TC3       	=>  To compile and run the testcase3 in batch mode.						" 	
	@echo " TC4       	=>  To compile and run the testcase3 in batch mode.						" 		
	@echo " regress_12  	=>  clean, compile and run testcases TC1 and TC2 in batch mode.					" 
	@echo " report_12    =>  To merge coverage reports for testcases TC1, TC2 and  convert to html format.			" 
	@echo " regress_123  =>  clean, compile and run testcases TC1,TC2,TC3 in batch mode.					" 
	@echo " report_123   =>  To merge coverage reports for testcases TC1,TC2,TC3 and convert to html format.		"
	@echo " regress_1234  =>  clean, compile and run testcases TC1,TC2,TC3, TC4 in batch mode.    " 
	@echo " report_1234   =>  To merge coverage reports for testcases TC1,TC2,TC3, TC4 and convert to html format.		"
	@echo " covhtml		=>  To view the coverage report in firefox.									"
	@echo " covtxt	     => To view the coverage report in text editor [only for VCS]					"
	@echo "cov_verdi 	=> To view the coverage report in verdi [only for VCS]		"
	@echo ===========================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
TC1 : TC1_$(SIMULATOR)
TC2 : TC2_$(SIMULATOR)
TC3 : TC3_$(SIMULATOR)
TC4 : TC4_$(SIMULATOR)
regress_12 : regress_12_$(SIMULATOR)
report_12 : report_12_$(SIMULATOR)

regress_123 : regress_123_$(SIMULATOR)
report_123 : report_123_$(SIMULATOR)

regress_1234 : regress_1234_$(SIMULATOR)
report_1234 : report_1234_$(SIMULATOR)

view_wave : view_wave_$(SIMULATOR)
covhtml : covhtml_$(SIMULATOR)
covtxt: covtxt_$(SIMULATOR)
cov_verdi: cov_verdi_$(SIMULATOR)

# ---- Start of Definitions for Mentor's Questa Specific Targets -----#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) $(COVOP)
		
TC1_Questa:sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed 2975249645 work.top +TEST1  
	vcover report  -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

TC2_Questa:sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed 1556525292 work.top +TEST2 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2
	
TC3_Questa:sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed 821475296 work.top +TEST3 
	vcover report -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3
 
TC4_Questa:sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log +ntb_random_seed_automatic work.top +TEST4
	vcover report -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4
	
report_12_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress_12_Questa: clean sv_cmp TC1 TC2 report_12 
 
report_123_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress_123_Questa: clean_Questa sv_cmp_Questa TC1_Questa TC2_Questa TC3_Questa report_123_Questa

report_1234_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov
 
regress_1234_Questa: clean_Questa sv_cmp_Questa TC1_Questa TC2_Questa TC3_Questa TC4_Questa report_1234_Questa
 
covhtml_Questa:
	 firefox covhtmlreport/index.html&
	
clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

# ---- End of Definitions for Mentor's Questa Specific Targets -----#
	
# ---- Start of Definitions for Synopsys VCS Specific Targets -----#

sv_cmp_VCS:
	vcs -full64 -l comp.log -sverilog -debug_access+all -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB1) $(SVTB2)

TC1_VCS:clean_VCS  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave_file1.fsdb -cm_dir ./cov1 +ntb_random_seed=4137323363 +TEST1 
	urg -dir cov1.vdb -format both -report urgReport
	
TC2_VCS:	
	./simv -a vcs.log +fsdbfile+wave_file2.fsdb -cm_dir ./cov2 +ntb_random_seed=3072812991 +TEST2 	
	urg -dir cov2.vdb -format both -report urgReport2
	
TC3_VCS:	
	./simv -a vcs.log +fsdbfile+wave_file3.fsdb -cm_dir ./cov3 +ntb_random_seed_automatic +TEST3
	urg -dir cov3.vdb -format both -report urgReport3
	
clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb verdi*
	clear 
	
report_12_VCS:
	urg -dir cov1.vdb cov2.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_12_VCS: clean_VCS sv_cmp_VCS TC1_VCS TC2_VCS report_12_VCS 
 
report_123_VCS:
	urg -dir cov1.vdb cov2.vdb cov3.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_123_VCS: clean_VCS sv_cmp_VCS TC1_VCS TC2_VCS TC3_VCS report_123_VCS 

covhtml_VCS:
	firefox urgReport/grp*.html &
	
covtxt_VCS:
	vi urgReport/grp*.txt
cov_verdi_VCS:
	verdi -cov -covdir merged_dir.vdb

# ---- End of Definitions for Synopsys VCS Specific Targets -----#	
