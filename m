Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 18:03:27 +0100 (BST)
Received: from smtp.uk.colt.net ([IPv6:::ffff:195.110.64.125]:14522 "EHLO
	smtp.uk.colt.net") by linux-mips.org with ESMTP id <S8225722AbVDRRDH>;
	Mon, 18 Apr 2005 18:03:07 +0100
Received: from euskadi.packetvision (unknown [213.86.106.84])
	by smtp.uk.colt.net (Postfix) with ESMTP id 766F0127750
	for <linux-mips@linux-mips.org>; Mon, 18 Apr 2005 17:59:21 +0100 (BST)
Subject: Building native binutils/gcc/glibc
From:	Alex Gonzalez <alex.gonzalez@packetvision.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary="=-ts/afQCHMsiboRljnl2a"
Message-Id: <1113843806.4266.20.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Mon, 18 Apr 2005 18:03:26 +0100
Return-Path: <alex.gonzalez@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.gonzalez@packetvision.com
Precedence: bulk
X-list: linux-mips


--=-ts/afQCHMsiboRljnl2a
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have a cross compilation toolchain that successfully builds a linux
2.6.11 kernel (o32) for my mips target, and elf executables to run on
it.

I am trying to cross compile native binutils/gcc and glibc to be able to
build on the target, using:

binutils 2.14
gcc 3.3.5
glibc 2.3.5

I configure them with --host=mips-linux-gnu --build=i686-pc-linux-glibc2.2 and target=mips-linux-gnu

After installing them in the target root filesystem, I try to compile a simple "Hello World" program, and I get the following error:

 Reading specs from /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/specs
Configured with: ../gcc-3.3.5/configure --host=mips-linux-gnu --target=mips-linux-gnu --build=i686-pc-linux-gnulibc2.2 --prefix=/home/alex/nfsroot/pv-rootfs --enable-clocale=gnu --enable-languages=c,c++
Thread model: posix
gcc driver version 3.3.5 executing gcc version 3.3-mips64linux-031001
 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/cc1 -quiet -v -I /usr/include -iprefix /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/ -isystem /usr/lib/include -D__GNUC__=3 -D__GNUC_MINOR__=3 -D__GNUC_PATCHLEVEL__=0 hello.c -quiet -dumpbase hello.c -auxbase hello -version -o ./ccKgGMsl.s
ignoring nonexistent directory "/usr/lib/include"
GNU C version 3.3.5 (mips-linux-gnu)
        compiled by GNU C version 3.3-mips64linux-031001.
GGC heuristics: --param ggc-min-expand=47 --param ggc-min-heapsize=32046
ignoring nonexistent directory "/mips-linux-gnu/include"
ignoring nonexistent directory "/usr/local/include"
ignoring nonexistent directory "/home/alex/nfsroot/pv-rootfs/include"
ignoring nonexistent directory "/home/alex/nfsroot/pv-rootfs/lib/gcc-lib/mips-linux-gnu/3.3.5/include"
ignoring nonexistent directory "/home/alex/nfsroot/pv-rootfs/mips-linux-gnu/include"
ignoring duplicate directory "/usr/include"
  as it is a non-system directory that duplicates a system directory
#include "..." search starts here:
#include <...> search starts here:
 /lib/gcc-lib/mips-linux-gnu/3.3.5/include
 /usr/include
End of search list.
 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/as -EB -g0 -32 -v -KPIC -o ./ccYlX6Ij.o ./ccKgGMsl.s
GNU assembler version 2.14 (mips-linux-gnu) using BFD version 2.14 20030612
 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/collect2 --eh-frame-hdr -EB -dynamic-linker /lib/ld.so.1 /usr/lib/crt1.o /usr/lib/crti.o /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o -L/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5 -L/bin/../lib/gcc-lib -L/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/lib ./ccYlX6Ij.o -lgcc -lgcc_eh -rpath-link /lib:/usr/lib -lc -lgcc -lgcc_eh /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o /usr/lib/crtn.o
/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/ld: ./ccYlX6Ij.o: linking abicalls files with non-abicalls files
Bad value: failed to merge target specific data of file ./ccYlX6Ij.o
collect2: ld returned 1 exit status

Passing -a to gas, I see the .abicalls in the object file. Trying to compile with -mno-abicalls removes the .abicall from the object file but does not remove the error.

I have tried different versions of binutils/gcc/glibc, but I don't know if the problem comes from glibc, gcc or gas.

Does anybody have any clue about what's going on?

I enclose the output of,

gcc hello.c -I /usr/include -B /usr/lib -Wl,-t,-M -Wa,-a -mno-abicalls

in case it helps. 

Thanks a lot,
Alex


--=-ts/afQCHMsiboRljnl2a
Content-Disposition: attachment; filename=out.3
Content-Type: text/x-troff-man; name=out.3; charset=
Content-Transfer-Encoding: 7bit

Reading specs from /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/specs
Configured with: ../gcc-3.3.5/configure --host=mips-linux-gnu --target=mips-linux-gnu --build=i686-pc-linux-gnulibc2.2 --prefix=/home/alex/nfsroot/pv-rootfs --enable-clocale=gnu --enable-languages=c,c++
Thread model: posix
gcc driver version 3.3.5 executing gcc version 3.3-mips64linux-031001
 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/cc1 -quiet -v -I /usr/include -iprefix /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/ -isystem /usr/lib/include -D__GNUC__=3 -D__GNUC_MINOR__=3 -D__GNUC_PATCHLEVEL__=0 hello.c -quiet -dumpbase hello.c -mno-abicalls -auxbase hello -version -o ./ccY7LCg6.s
ignoring nonexistent directory "/usr/lib/include"
GNU C version 3.3.5 (mips-linux-gnu)
	compiled by GNU C version 3.3-mips64linux-031001.
GGC heuristics: --param ggc-min-expand=47 --param ggc-min-heapsize=32046
ignoring nonexistent directory "/mips-linux-gnu/include"
ignoring nonexistent directory "/usr/local/include"
ignoring nonexistent directory "/home/alex/nfsroot/pv-rootfs/include"
ignoring nonexistent directory "/home/alex/nfsroot/pv-rootfs/lib/gcc-lib/mips-linux-gnu/3.3.5/include"
ignoring nonexistent directory "/home/alex/nfsroot/pv-rootfs/mips-linux-gnu/include"
ignoring duplicate directory "/usr/include"
  as it is a non-system directory that duplicates a system directory
#include "..." search starts here:
#include <...> search starts here:
 /lib/gcc-lib/mips-linux-gnu/3.3.5/include
 /usr/include
End of search list.
 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/as -EB -g0 -32 -v -KPIC -a -o ./cc2XtIzO.o ./ccY7LCg6.s
GNU assembler version 2.14 (mips-linux-gnu) using BFD version 2.14 20030612
./ccY7LCg6.s: Assembler messages:
./ccY7LCg6.s:22: Warning: No .cprestore pseudo-op used in PIC code
GAS LISTING ./ccY7LCg6.s 			page 1


   1              		.file	1 "hello.c"
   2              		.section .mdebug.abi32
   3              		.previous
   4              		.rdata
   5              		.align	2
   6              	$LC0:
   7 0000 48656C6C 		.ascii	"Hello World!\000"
   7      6F20576F 
   7      726C6421 
   7      00
   8 000d 000000   		.text
   9              		.align	2
  10              		.globl	main
  11              		.ent	main
  12              		.type	main, @function
  13              	main:
  14              		.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
  15              		.mask	0xc0000000,-4
  16              		.fmask	0x00000000,0
  17 0000 27BDFFE8 		subu	$sp,$sp,24
  18 0004 AFBF0014 		sw	$31,20($sp)
  19 0008 AFBE0010 		sw	$fp,16($sp)
  20 000c 03A0F021 		move	$fp,$sp
  21 0010 8F840000 		la	$4,$LC0
  21      00000000 
  21      24840000 
  22 001c 8F990000 		jal	printf
****  Warning:No .cprestore pseudo-op used in PIC code
  22      00000000 
  22      0320F809 
  22      00000000 
  23 002c 03C0E821 		move	$sp,$fp
  24 0030 8FBF0014 		lw	$31,20($sp)
  25 0034 8FBE0010 		lw	$fp,16($sp)
  26 0038 03E00008 		addu	$sp,$sp,24
  27 003c 27BD0018 		j	$31
  28              		.end	main
  29              		.ident	"GCC: (GNU) 3.3.5"
GAS LISTING ./ccY7LCg6.s 			page 2


DEFINED SYMBOLS
                            *ABS*:0000000000000000 hello.c
        ./ccY7LCg6.s:13     .text:0000000000000000 main

UNDEFINED SYMBOLS
printf
 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/collect2 --eh-frame-hdr -EB -dynamic-linker /lib/ld.so.1 /usr/lib/crt1.o /usr/lib/crti.o /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o -L/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5 -L/bin/../lib/gcc-lib -L/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/lib ./cc2XtIzO.o -t -M -lgcc -lgcc_eh -rpath-link /lib:/usr/lib -lc -lgcc -lgcc_eh /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o /usr/lib/crtn.o
/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/ld: ./cc2XtIzO.o: linking abicalls files with non-abicalls files
Bad value: failed to merge target specific data of file ./cc2XtIzO.o
/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/ld: mode elf32btsmip
/usr/lib/crt1.o
/usr/lib/crti.o
/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
./cc2XtIzO.o
/lib/libc.so.6
Archive member included because of file (symbol)

/usr/lib/libc_nonshared.a(elf-init.oS)
                              /usr/lib/crt1.o (__libc_csu_init)
(/usr/lib/libc_nonshared.a)elf-init.oS
/bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o
/usr/lib/crtn.o

Memory Configuration

Name             Origin             Length             Attributes
*default*        0x0000000000000000 0xffffffffffffffff

Linker script and memory map

LOAD /usr/lib/crt1.o
LOAD /usr/lib/crti.o
LOAD /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
LOAD ./cc2XtIzO.o
LOAD /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/libgcc.a
LOAD /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/libgcc_eh.a
LOAD /usr/lib/libc.so
START GROUP
LOAD /lib/libc.so.6
LOAD /usr/lib/libc_nonshared.a
END GROUP
LOAD /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/libgcc.a
LOAD /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/libgcc_eh.a
LOAD /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o
LOAD /usr/lib/crtn.o
                0x0000000000400114                . = (0x400000 + SIZEOF_HEADERS)

.interp         0x0000000000400114        0xd
 *(.interp)
 .interp        0x0000000000400114        0xd /usr/lib/crt1.o

.note.ABI-tag   0x0000000000400124       0x20
 .note.ABI-tag  0x0000000000400124       0x20 /usr/lib/crt1.o

.reginfo        0x0000000000400144       0x18
 *(.reginfo)
 .reginfo       0x0000000000400144       0x18 /usr/lib/crt1.o

.dynamic        0x000000000040015c       0xf0
 *(.dynamic)
 .dynamic       0x000000000040015c       0xf0 /usr/lib/crt1.o
                0x000000000040015c                _DYNAMIC

.hash           0x000000000040024c       0x9c
 *(.hash)
 .hash          0x000000000040024c       0x9c /usr/lib/crt1.o

.dynsym         0x00000000004002e8      0x140
 *(.dynsym)
 .dynsym        0x00000000004002e8      0x140 /usr/lib/crt1.o

.dynstr         0x0000000000400428      0x11a
 *(.dynstr)
 .dynstr        0x0000000000400428      0x11a /usr/lib/crt1.o

.gnu.version    0x0000000000400542       0x28
 *(.gnu.version)
 .gnu.version   0x0000000000400542       0x28 /usr/lib/crt1.o

.gnu.version_d
 *(.gnu.version_d)

.gnu.version_r  0x000000000040056c       0x20
 *(.gnu.version_r)
 .gnu.version_r
                0x000000000040056c       0x20 /usr/lib/crt1.o

.rel.dyn
 *(.rel.init)
 *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*)
 *(.rel.fini)
 *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*)
 *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*)
 *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*)
 *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*)
 *(.rel.ctors)
 *(.rel.dtors)
 *(.rel.got)
 *(.rel.sdata .rel.sdata.* .rel.gnu.linkonce.s.*)
 *(.rel.sbss .rel.sbss.* .rel.gnu.linkonce.sb.*)
 *(.rel.sdata2 .rel.sdata2.* .rel.gnu.linkonce.s2.*)
 *(.rel.sbss2 .rel.sbss2.* .rel.gnu.linkonce.sb2.*)
 *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*)

.rela.dyn
 *(.rela.init)
 *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)
 *(.rela.fini)
 *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*)
 *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)
 *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*)
 *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*)
 *(.rela.ctors)
 *(.rela.dtors)
 *(.rela.got)
 *(.rela.sdata .rela.sdata.* .rela.gnu.linkonce.s.*)
 *(.rela.sbss .rela.sbss.* .rela.gnu.linkonce.sb.*)
 *(.rela.sdata2 .rela.sdata2.* .rela.gnu.linkonce.s2.*)
 *(.rela.sbss2 .rela.sbss2.* .rela.gnu.linkonce.sb2.*)
 *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)

.rel.plt
 *(.rel.plt)

.rela.plt
 *(.rela.plt)

.init           0x000000000040058c       0xa8
 *(.init)
 .init          0x000000000040058c       0x38 /usr/lib/crti.o
                0x000000000040058c                _init
 .init          0x00000000004005c4       0x30 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
 .init          0x00000000004005f4       0x30 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o
 .init          0x0000000000400624       0x10 /usr/lib/crtn.o

.plt
 *(.plt)

.text           0x0000000000400640      0x460
                0x0000000000400640                _ftext = .
 *(.text .stub .text.* .gnu.linkonce.t.*)
 .text          0x0000000000400640       0x70 /usr/lib/crt1.o
                0x0000000000400640                __start
 .stub          0x00000000004006b0       0x10 /usr/lib/crt1.o
 .text          0x00000000004006c0       0x50 /usr/lib/crti.o
 .text          0x0000000000400710      0x190 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
 .text          0x00000000004008a0       0x40 ./cc2XtIzO.o
                0x00000000004008a0                main
 .text          0x00000000004008e0      0x140 /usr/lib/libc_nonshared.a(elf-init.oS)
                0x000000000040097c                __libc_csu_fini
                0x00000000004008e0                __libc_csu_init
 .text          0x0000000000400a20       0x80 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o
 *(.gnu.warning)
 *(.mips16.fn.*)
 *(.mips16.call.*)

.fini           0x0000000000400aa0       0x58
 *(.fini)
 .fini          0x0000000000400aa0       0x18 /usr/lib/crti.o
                0x0000000000400aa0                _fini
 .fini          0x0000000000400ab8       0x30 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
 .fini          0x0000000000400ae8       0x10 /usr/lib/crtn.o
                0x0000000000400af8                PROVIDE (__etext, .)
                0x0000000000400af8                PROVIDE (_etext, .)
                0x0000000000400af8                PROVIDE (etext, .)

.rodata         0x0000000000400b00       0x20
 *(.rodata .rodata.* .gnu.linkonce.r.*)
 .rodata        0x0000000000400b00       0x10 /usr/lib/crt1.o
                0x0000000000400b00                _IO_stdin_used
 .rodata        0x0000000000400b10       0x10 ./cc2XtIzO.o

.rodata1
 *(.rodata1)

.sdata2
 *(.sdata2 .sdata2.* .gnu.linkonce.s2.*)

.sbss2
 *(.sbss2 .sbss2.* .gnu.linkonce.sb2.*)

.eh_frame_hdr
 *(.eh_frame_hdr)
                0x0000000010000000                . = 0x10000000
                0x0000000010000000                . = ALIGN (0x4)
                0x0000000010000000                PROVIDE (__preinit_array_start, .)

.preinit_array
 *(.preinit_array)
                0x0000000010000000                PROVIDE (__preinit_array_end, .)
                0x0000000010000000                PROVIDE (__init_array_start, .)

.init_array
 *(.init_array)
                0x0000000010000000                PROVIDE (__init_array_end, .)
                0x0000000010000000                PROVIDE (__fini_array_start, .)

.fini_array
 *(.fini_array)
                0x0000000010000000                PROVIDE (__fini_array_end, .)

.data           0x0000000010000000       0x20
                0x0000000010000000                _fdata = .
 *(.data .data.* .gnu.linkonce.d.*)
 .data          0x0000000010000000       0x10 /usr/lib/crt1.o
                0x0000000010000000                data_start
                0x0000000010000000                __data_start
 .data          0x0000000010000010       0x10 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
                0x0000000010000010                __dso_handle

.rld_map        0x0000000010000020        0x4
 .rld_map       0x0000000010000020        0x4 /usr/lib/crt1.o
                0x0000000010000020                __RLD_MAP

.data1
 *(.data1)

.tdata
 *(.tdata .tdata.* .gnu.linkonce.td.*)

.tbss
 *(.tbss .tbss.* .gnu.linkonce.tb.*)
 *(.tcommon)

.eh_frame       0x0000000010000024        0x4
 *(.eh_frame)
 .eh_frame      0x0000000010000024        0x4 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o

.gcc_except_table
 *(.gcc_except_table)

.ctors          0x0000000010000028        0x8
 *crtbegin*.o(.ctors)
 *(EXCLUDE_FILE(*crtend*.o) .ctors)
 .ctors         0x0000000010000028        0x4 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
 *(SORT(.ctors.*))
 *(.ctors)
 .ctors         0x000000001000002c        0x4 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o

.dtors          0x0000000010000030        0x8
 *crtbegin*.o(.dtors)
 *(EXCLUDE_FILE(*crtend*.o) .dtors)
 .dtors         0x0000000010000030        0x4 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
 *(SORT(.dtors.*))
 *(.dtors)
 .dtors         0x0000000010000034        0x4 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o

.jcr            0x0000000010000038        0x4
 *(.jcr)
 .jcr           0x0000000010000038        0x4 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o
                0x0000000010008030                _gp = (ALIGN (0x10) + 0x7ff0)

.got            0x0000000010000040       0x58
 *(.got.plt)
 *(.got)
 .got           0x0000000010000040       0x58 /usr/lib/crt1.o
                0x0000000010000040                _GLOBAL_OFFSET_TABLE_

.sdata
 *(.sdata .sdata.* .gnu.linkonce.s.*)

.lit8
 *(.lit8)

.lit4
 *(.lit4)
                0x0000000010000098                _edata = .
                0x0000000010000098                PROVIDE (edata, .)
                0x0000000010000098                __bss_start = .
                0x0000000010000098                _fbss = .

.sbss           0x0000000010000098        0x0
                0x0000000010000098                PROVIDE (__sbss_start, .)
                0x0000000010000098                PROVIDE (___sbss_start, .)
 *(.dynsbss)
 *(.sbss .sbss.* .gnu.linkonce.sb.*)
 *(.scommon)
                0x0000000010000098                PROVIDE (__sbss_end, .)
                0x0000000010000098                PROVIDE (___sbss_end, .)

.bss            0x00000000100000a0       0x20
 *(.dynbss)
 *(.bss .bss.* .gnu.linkonce.b.*)
 .bss           0x00000000100000a0       0x20 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
 *(COMMON)
                0x00000000100000c0                . = ALIGN (0x4)
                0x00000000100000c0                . = ALIGN (0x4)
                0x00000000100000c0                _end = .
                0x00000000100000c0                PROVIDE (end, .)

.stab
 *(.stab)

.stabstr
 *(.stabstr)

.stab.excl
 *(.stab.excl)

.stab.exclstr
 *(.stab.exclstr)

.stab.index
 *(.stab.index)

.stab.indexstr
 *(.stab.indexstr)

.comment        0x0000000000000000       0xe4
 *(.comment)
 .comment       0x0000000000000000       0x23 /usr/lib/crt1.o
 .comment       0x0000000000000023       0x23 /usr/lib/crti.o
 .comment       0x0000000000000046       0x23 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtbegin.o
 .comment       0x0000000000000069       0x12 ./cc2XtIzO.o
 .comment       0x000000000000007b       0x23 /usr/lib/libc_nonshared.a(elf-init.oS)
 .comment       0x000000000000009e       0x23 /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/crtend.o
 .comment       0x00000000000000c1       0x23 /usr/lib/crtn.o

.debug
 *(.debug)

.line
 *(.line)

.debug_srcinfo
 *(.debug_srcinfo)

.debug_sfnames
 *(.debug_sfnames)

.debug_aranges  0x0000000000000000       0x98
 *(.debug_aranges)
 .debug_aranges
                0x0000000000000000       0x20 /usr/lib/crt1.o
 .debug_aranges
                0x0000000000000020       0x30 /usr/lib/crti.o
 .debug_aranges
                0x0000000000000050       0x20 /usr/lib/libc_nonshared.a(elf-init.oS)
 .debug_aranges
                0x0000000000000070       0x28 /usr/lib/crtn.o

.debug_pubnames
                0x0000000000000000       0x5f
 *(.debug_pubnames)
 .debug_pubnames
                0x0000000000000000       0x25 /usr/lib/crt1.o
 .debug_pubnames
                0x0000000000000025       0x3a /usr/lib/libc_nonshared.a(elf-init.oS)

.debug_info     0x0000000000000000      0xb5a
 *(.debug_info .gnu.linkonce.wi.*)
 .debug_info    0x0000000000000000      0x95b /usr/lib/crt1.o
 .debug_info    0x000000000000095b       0x73 /usr/lib/crti.o
 .debug_info    0x00000000000009ce      0x119 /usr/lib/libc_nonshared.a(elf-init.oS)
 .debug_info    0x0000000000000ae7       0x73 /usr/lib/crtn.o

.debug_abbrev   0x0000000000000000      0x1ec
 *(.debug_abbrev)
 .debug_abbrev  0x0000000000000000      0x118 /usr/lib/crt1.o
 .debug_abbrev  0x0000000000000118       0x10 /usr/lib/crti.o
 .debug_abbrev  0x0000000000000128       0xb4 /usr/lib/libc_nonshared.a(elf-init.oS)
 .debug_abbrev  0x00000000000001dc       0x10 /usr/lib/crtn.o

.debug_line     /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/ld: link errors found, deleting executable `a.out'
0x0000000000000000      0x38d
 *(.debug_line)
 .debug_line    0x0000000000000000      0x17e /usr/lib/crt1.o
 .debug_line    0x000000000000017e       0xaf /usr/lib/crti.o
 .debug_line    0x000000000000022d       0xd1 /usr/lib/libc_nonshared.a(elf-init.oS)
 .debug_line    0x00000000000002fe       0x8f /usr/lib/crtn.o

.debug_frame    0x0000000000000000       0x54
 *(.debug_frame)
 .debug_frame   0x0000000000000000       0x54 /usr/lib/libc_nonshared.a(elf-init.oS)

.debug_str      0x0000000000000000      0x712
 *(.debug_str)
 .debug_str     0x0000000000000000      0x690 /usr/lib/crt1.o
                                        0x6d7 (size before relaxing)
 .debug_str     0x0000000000000690       0x82 /usr/lib/libc_nonshared.a(elf-init.oS)
                                         0xe2 (size before relaxing)

.debug_loc
 *(.debug_loc)

.debug_macinfo
 *(.debug_macinfo)

.debug_weaknames
 *(.debug_weaknames)

.debug_funcnames
 *(.debug_funcnames)

.debug_typenames
 *(.debug_typenames)

.debug_varnames
 *(.debug_varnames)

.gptab.sdata
 *(.gptab.data)
 *(.gptab.sdata)

.gptab.sbss
 *(.gptab.bss)
 *(.gptab.sbss)
OUTPUT(a.out elf32-tradbigmips)

.pdr            0x0000000000000000       0x60
 .pdr           0x0000000000000000       0x20 ./cc2XtIzO.o
 .pdr           0x0000000000000020       0x40 /usr/lib/libc_nonshared.a(elf-init.oS)

.mdebug.abi32   0x0000000000000000        0x0
collect2: ld returned 1 exit status

--=-ts/afQCHMsiboRljnl2a--
