//========================================================================
// ProcMem
//========================================================================

`ifndef PROC_MEM_V
`define PROC_MEM_V

module ProcMem
(
  (* keep=1 *) input  logic        clk,
  (* keep=1 *) input  logic        rst,

  (* keep=1 *) input  logic        imemreq_val,
  (* keep=1 *) input  logic [31:0] imemreq_addr,
  (* keep=1 *) output logic [31:0] imemresp_data,

  (* keep=1 *) input  logic        dmemreq_val,
  (* keep=1 *) input  logic        dmemreq_type,
  (* keep=1 *) input  logic [31:0] dmemreq_addr,
  (* keep=1 *) input  logic [31:0] dmemreq_wdata,
  (* keep=1 *) output logic [31:0] dmemresp_rdata
);

  localparam memsize = 2**6;

  logic [31:0] mem [memsize];

  // Unused address bits

  logic [31-$clog2(memsize)-2:0] imemreq_addr0_unused;
  assign imemreq_addr0_unused = imemreq_addr[31:$clog2(memsize)+2];

  logic [1:0] imemreq_addr1_unused;
  assign imemreq_addr1_unused = imemreq_addr[1:0];

  logic [31-$clog2(memsize)-2:0] dmemreq_addr0_unused;
  assign dmemreq_addr0_unused = dmemreq_addr[31:$clog2(memsize)+2];

  logic [1:0] dmemreq_addr1_unused;
  assign dmemreq_addr1_unused = dmemreq_addr[1:0];

  // Write port

  always_ff @(posedge clk) begin

    if ( rst ) begin

      mem[   0] <= 32'h7c301073; // 00000000 csrw out1, x0
      mem[   1] <= 32'hfc2020f3; // 00000004 csrr x1, in0
      mem[   2] <= 32'hfc402173; // 00000008 csrr x2, in2
      mem[   3] <= 32'h00100193; // 0000000c addi x3, x0, 1
      mem[   4] <= 32'hfe311ae3; // 00000010 bne  x2, x3, 0x004
      mem[   5] <= 32'h7c209073; // 00000014 csrw out0, x1
      mem[   6] <= 32'h00000293; // 00000018 addi x5, x0, 0
      mem[   7] <= 32'h00000493; // 0000001c addi x9, x0, 0
      mem[   8] <= 32'h08000413; // 00000020 addi x8, x0, 0x80
      mem[   9] <= 32'h00042203; // 00000024 lw x4, 0(x8)
      mem[  10] <= 32'h00148493; // 00000028 addi x9, x9, 1
      mem[  11] <= 32'h00440413; // 0000002c addi x8, x8, 4
      mem[  12] <= 32'h005202b3; // 00000030 add x5, x4, x5
      mem[  13] <= 32'hfe1498e3; // 00000034 bne x9, x1, 0x024
      mem[  14] <= 32'h7c329073; // 00000038 csrw out1, x5
      mem[  15] <= 32'h0000006f; // 0000003c jal x0, 0x03c
      mem[  32] <= 32'h00000024; // 00000080 data
      mem[  33] <= 32'h0000001a; // 00000084 data
      mem[  34] <= 32'h00000045; // 00000088 data
      mem[  35] <= 32'h00000039; // 0000008c data
      mem[  36] <= 32'h0000000b; // 00000090 data
      mem[  37] <= 32'h00000044; // 00000094 data
      mem[  38] <= 32'h00000029; // 00000098 data
      mem[  39] <= 32'h0000005a; // 0000009c data
      mem[  40] <= 32'h00000020; // 000000a0 data
      mem[  41] <= 32'h0000004c; // 000000a4 data
      mem[  42] <= 32'h0000002c; // 000000a8 data
      mem[  43] <= 32'h00000013; // 000000ac data
      mem[  44] <= 32'h00000011; // 000000b0 data
      mem[  45] <= 32'h0000003b; // 000000b4 data
      mem[  46] <= 32'h00000063; // 000000b8 data
      mem[  47] <= 32'h00000031; // 000000bc data
      mem[  48] <= 32'h00000041; // 000000c0 data
      mem[  49] <= 32'h0000000c; // 000000c4 data
      mem[  50] <= 32'h00000037; // 000000c8 data
      mem[  51] <= 32'h00000000; // 000000cc data
      mem[  52] <= 32'h00000033; // 000000d0 data
      mem[  53] <= 32'h0000002a; // 000000d4 data
      mem[  54] <= 32'h00000052; // 000000d8 data
      mem[  55] <= 32'h00000017; // 000000dc data
      mem[  56] <= 32'h00000015; // 000000e0 data
      mem[  57] <= 32'h00000036; // 000000e4 data
      mem[  58] <= 32'h00000053; // 000000e8 data
      mem[  59] <= 32'h0000001f; // 000000ec data
      mem[  60] <= 32'h00000010; // 000000f0 data
      mem[  61] <= 32'h0000004c; // 000000f4 data
      mem[  62] <= 32'h00000015; // 000000f8 data
      mem[  63] <= 32'h00000004; // 000000fc data


    end
    else if ( dmemreq_val && (dmemreq_type == 1) ) begin
      mem[dmemreq_addr[$clog2(memsize)+1:2]] <= dmemreq_wdata;
    end

  end

  // Read port

  always_comb begin

    if ( imemreq_val )
      imemresp_data = mem[imemreq_addr[$clog2(memsize)+1:2]];
    else
      imemresp_data = 32'bx;

    if ( dmemreq_val && (dmemreq_type == 0) )
      dmemresp_rdata = mem[dmemreq_addr[$clog2(memsize)+1:2]];
    else
      dmemresp_rdata = 32'bx;

  end

endmodule

`endif /* PROC_MEM_V */

