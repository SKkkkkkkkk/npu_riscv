OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv",
       "elf32-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)
MEMORY
{
  external_ram (rwx) : ORIGIN = 0x00000000, LENGTH = 512M
  dram (rw) : ORIGIN = 0xf0000000, LENGTH = 32K
}
SECTIONS
{
  . = ORIGIN(external_ram);
  .vectors (ORIGIN(external_ram)):
  {
    PROVIDE(__vector_start = .);
    KEEP(*(.vectors));
  } >external_ram
  PROVIDE(__boot_address = ORIGIN(external_ram)+0x80);
  .init (__boot_address):
  {
    KEEP (*(SORT_NONE(.init)))
    KEEP (*(.text.start))
    KEEP (*(.text.handlers))
  } >external_ram
  .text :
  {
    *(.text.unlikely .text.*_unlikely .text.unlikely.*)
    *(.text.exit .text.exit.*)
    *(.text.startup .text.startup.*)
    *(.text.hot .text.hot.*)
    *(SORT(.text.sorted.*))
    *(.text .stub .text.* .gnu.linkonce.t.*)
    *(.gnu.warning)
  } >external_ram
  PROVIDE (__etext = .);
  PROVIDE (_etext = .);
  PROVIDE (etext = .);
  .rodata :
  {
    *(.rodata .rodata.* .gnu.linkonce.r.*)
  } >external_ram
  .data :
  {
    __DATA_BEGIN__ = .;
    *(.data .data.* .gnu.linkonce.d.*)
    SORT(CONSTRUCTORS)
  } >external_ram
  .sdata :
  {
    __SDATA_BEGIN__ = .;
    *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata .srodata.*)
    *(.sdata .sdata.* .gnu.linkonce.s.*)
  } >external_ram
  _edata = .; PROVIDE (edata = .);
  . = ORIGIN(dram);
  __bss_start = .;
  .sbss :
  {
    *(.dynsbss)
    *(.sbss .sbss.* .gnu.linkonce.sb.*)
    *(.scommon)
  } >dram
  .bss :
  {
   *(.dynbss)
   *(.bss .bss.* .gnu.linkonce.b.*)
   *(COMMON)
   . = ALIGN(. != 0 ? 32 / 8 : 1);
  } >dram
  . = ALIGN(32 / 8);
  . = SEGMENT_START("ldata-segment", .);
  . = ALIGN(32 / 8);
  __bss_end = .;
  _end = .; PROVIDE (end = .);
  .heap : ALIGN(16)
  {
   PROVIDE(__heap_start = .);
   . = . + 4K;
   PROVIDE(__heap_end = .);
  } >dram
  __stack_top = ORIGIN(dram) + LENGTH(dram);
}
