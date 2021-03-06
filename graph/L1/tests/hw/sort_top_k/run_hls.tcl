#
# Copyright 2019-2021 Xilinx, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

source settings.tcl

set PROJ "sortTopK.prj"
set SOLN "solution_OCL_REGION_0"

if {![info exists CLKP]} {
  set CLKP 300MHz
}

open_project -reset $PROJ

add_files "sort_top_k_test.cpp" -cflags "-I${XF_PROJ_ROOT}/L1/include/hw"
add_files -tb "sort_top_k_test.cpp" -cflags "-I${XF_PROJ_ROOT}/L1/include/hw"
set_top hls_sort_top_k_function

open_solution -reset $SOLN




set_part $XPART
create_clock -period $CLKP

if {$CSIM == 1} {
  csim_design
}

if {$CSYNTH == 1} {
  csynth_design
}

if {$COSIM == 1} {
  cosim_design
}

if {$VIVADO_SYN == 1} {
  export_design -flow syn -rtl verilog
}

if {$VIVADO_IMPL == 1} {
  export_design -flow impl -rtl verilog
}

exit