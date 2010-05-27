Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 16:24:10 +0200 (CEST)
Received: from mails.thu.edu.cn ([166.111.8.27]:25136 "HELO mails.thu.edu.cn"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1492157Ab0EaOK1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 31 May 2010 16:10:27 +0200
Received: from mails.thu.edu.cn([127.0.0.1]) by mails.tsinghua.edu.cn(AIMC 3.2.0.0)
        with SMTP id jm44c043a47; Mon, 31 May 2010 22:10:02 +0800
Received: from mailgate.tsinghua.edu.cn([166.111.8.44]) by mails.tsinghua.edu.cn(AIMC 3.2.0.0)
        with SMTP id jm1054bfee055; Fri, 28 May 2010 04:09:42 +0800
X-MAILFROM: <libc-alpha-return-22901-chenyj99=mails.tsinghua.edu.cn@sourceware.org>
X-RCPTTO: <chenyj99@mails.tsinghua.edu.cn>
X-FROMIP: 209.132.180.131
X-EQManager-Scaned: 1
X-Received: server1.sourceware.org,209.132.180.131,20100528040940
Received: from server1.sourceware.org (HELO sourceware.org) (209.132.180.131)
  by localhost with SMTP; 27 May 2010 20:09:40 -0000
Received: (qmail 18436 invoked by alias); 27 May 2010 20:09:36 -0000
Received: (qmail 25308 invoked by uid 22791); 27 May 2010 19:58:20 -0000
X-SWARE-Spam-Status: No, hits=-0.2 required=5.0
        tests=AWL,BAYES_05,NO_DNS_FOR_FROM,TW_BJ,TW_CP,TW_CR,TW_FN,TW_JC,TW_OV,T_RP_MATCHES_RCVD
X-ExtLoop1: 1
Date:   Thu, 27 May 2010 12:58:10 -0700
From:   "H.J. Lu" <hongjiu.lu@intel.com>
To:     linux-gcc@vger.kernel.org, gcc@gcc.gnu.org,
        GNU C Library <libc-alpha@sourceware.org>,
        Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-vax@pergamentum.com
Subject: The Linux binutils 2.20.51.0.9 is released
Message-ID: <20100527195810.GA17604@lucon.org>
Reply-To: "H.J. Lu" <hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Mailing-List: contact libc-alpha-help@sourceware.org; run by ezmlm
Precedence: bulk
X-AIMC-AUTH: (null)
X-AIMC-MAILFROM: libc-alpha-return-22901-chenyj99=mails.tsinghua.edu.cn@sourceware.org
X-AIMC-Msg-ID: J3gYjRYB
X-AIMC-AUTH: (null)
X-AIMC-MAILFROM: hongjiu.lu@intel.com
Return-Path: <hongjiu.lu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26941
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hongjiu.lu@intel.com
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.20.51.0.9 for Linux, which is
based on binutils 2010 0526 in CVS on sourceware.org plus various
changes. It is purely for Linux.

All relevant patches in patches have been applied to the source tree.
You can take a look at patches/README to see what have been applied and
in what order they have been applied.

Starting from the 2.20.51.0.4 release, no diffs against the previous
release will be provided.

You can enable both gold and bfd ld with --enable-gold=both.  Gold will
be installed as ld.gold and bfd ld will be installed as ld.bfd.  By
default, ld.bfd will be installed as ld.  You can use the configure
option, --enable-gold=both/gold to choose gold as the default linker,
ld.  IA-32 binary and X64_64 binary tar balls are configured with
--enable-gold=both/ld --enable-plugins --enable-threads.

Starting from the 2.18.50.0.4 release, the x86 assembler no longer
accepts

	fnstsw %eax

fnstsw stores 16bit into %ax and the upper 16bit of %eax is unchanged.
Please use

	fnstsw %ax

Starting from the 2.17.50.0.4 release, the default output section LMA
(load memory address) has changed for allocatable sections from being
equal to VMA (virtual memory address), to keeping the difference between
LMA and VMA the same as the previous output section in the same region.

For

.data.init_task : { *(.data.init_task) }

LMA of .data.init_task section is equal to its VMA with the old linker.
With the new linker, it depends on the previous output section. You
can use

.data.init_task : AT (ADDR(.data.init_task)) { *(.data.init_task) }

to ensure that LMA of .data.init_task section is always equal to its
VMA. The linker script in the older 2.6 x86-64 kernel depends on the
old behavior.  You can add AT (ADDR(section)) to force LMA of
.data.init_task section equal to its VMA. It will work with both old
and new linkers. The x86-64 kernel linker script in kernel 2.6.13 and
above is OK.

The new x86_64 assembler no longer accepts

	monitor %eax,%ecx,%edx

You should use

	monitor %rax,%ecx,%edx

or
	monitor

which works with both old and new x86_64 assemblers. They should
generate the same opcode.

The new i386/x86_64 assemblers no longer accept instructions for moving
between a segment register and a 32bit memory location, i.e.,

	movl (%eax),%ds
	movl %ds,(%eax)

To generate instructions for moving between a segment register and a
16bit memory location without the 16bit operand size prefix, 0x66,

	mov (%eax),%ds
	mov %ds,(%eax)

should be used. It will work with both new and old assemblers. The
assembler starting from 2.16.90.0.1 will also support

	movw (%eax),%ds
	movw %ds,(%eax)

without the 0x66 prefix. Patches for 2.4 and 2.6 Linux kernels are
available at

http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch
http://www.kernel.org/pub/linux/devel/binutils/linux-2.6-seg-5.patch

The ia64 assembler is now defaulted to tune for Itanium 2 processors.
To build a kernel for Itanium 1 processors, you will need to add

ifeq ($(CONFIG_ITANIUM),y)
	CFLAGS += -Wa,-mtune=itanium1
	AFLAGS += -Wa,-mtune=itanium1
endif

to arch/ia64/Makefile in your kernel source tree.

Please report any bugs related to binutils 2.20.51.0.9 to
hjl.tools@gmail.com

and

http://www.sourceware.org/bugzilla/

Changes from binutils 2.20.51.0.8:

1. Update from binutils 2010 0526.
2. Implement SHF_EXCLUDE support for ELF targets.  PR 11600.
3. Restore "call|jmp [xtrn]" in x86 assembler.  PR 11535.
4. Properly handle ".equ symbol, reg + NUM" in x86 Intel syntax in x86
assembler.  PR 11509.
5. Correct cross linker installation.  PR 11510.
6: Remove relocation against discarded sections for relocatable link.
PR 11542.
7. Add a linker warning if value of SEGMENT_START isn't multiple of
maximum page size.  PR 11628.
8. Improve x86 disassembler on unknown opcodes.
9. Avoid linker crash.  PR 11583.
10. Support SH FDPIC.
11. Remove the leading underscore in symbol names from PE/x86-64.
12. Improve ELF overlap linker support.
13. Improve altmacro support in assembler.
14. Improve gold.
15. Improve VMS support.
16. Improve COFF support.
17. Improve arm support.
18. Improve hppa support.
19. Improve L1OM support.
20. Improve mips support.
21. Improve TI C6X support.
22. Improve ppc support.

Changes from binutils 2.20.51.0.7:

1. Update from binutils 2010 0412.
2. Don't bind unique symbol locally. PR 11434.
3. Add DWARF 4 support to linker and readelf.
4. Fix --no-export-dynamic for PIE. PR 11413.
5. Speed up x86 assembler.
6. Use memmove instead of memcpy to copy overlap memory in assembler.
PR 11456.
7. Improve gold.
8. Improve VMS support.
9. Improve PE support.
10. Add TI C6X support.
11. Improve arm support.
12. Improve cris support.
13. Improve ppc support.

Changes from binutils 2.20.51.0.6:

1. Update from binutils 2010 0318.
2. Don't set ELFOSABI_LINUX for undefined STT_GNU_IFUNC symbols.
3. Improve x86 assembler error messages.
4. Support vpermilp[ds] for x86.
5. Fix strip for group sections.
6. Fix objcopy for PE PIE.  PR 11396.
7. Avoid 32bit overflow in linker.
8. Correct backslash quote logic in assembler.  PR 11356.
9. Improve linker --section-start support.  PR 11304.
10. Properly update LMA.  PR 11219.
11. Don't combine .init_array/.fini_array sections for relocatable link.
12. Add Solaris Sparc/x86 linker support.
13. Support dumping .ARM.exidx/.ARM.extab.
14. Add STT_GNU_IFUNC support for Sparc.
15. Improve gold.
16. Improve arm support.
17. Improve avr support.
18. Improve mips support.
19. Improve ppc support.
20. Improve xtensa support.

Changes from binutils 2.20.51.0.5:

1. Update from binutils 2010 0205.
2. Support x86 XSAVE extended state core dump.
3. Add an option, -mavxscalar=, to x86 assembler to encoding AVX
scalar instructions with VL=256 and update x86 disassembler.
4. Add xsave64/xrstor64 to x86 assembler/disassembler.
5. Add all the possible aliases for VPCOM* insns to x86 assembler.
5. Fix --gc-sections to detect unresolved symbol in DSO.  PR 11218.
6. Support number of ELF program segments > 64K.
7. Support BSD4.4 extended archive write.
8. Report error on bad section name with "objdump -j". PR 11225.
9. Linker now checks if all files are present and indicates those missing.
PR 4437.
10. Allow adding section from empy file with objcopy.
11. Update C++ demangler to support vector.
12. Improve gold.
13. Improve arm support.
14. Improve hppa support.
15. Improve ppc support.
16. Improve s390 support.

Changes from binutils 2.20.51.0.4:

1. Update from binutils 2010 0115.
2. Optimize x86 assembler/disassembler.
3. Add a new program, elfedit, to edit ELF files.  PR 11131.
4. Add --dyn-syms to readelf.  PR 11146.
5. Remove "Warning: " from objcopy error message.  PR 11130.
6. Fix linker --gc-sections with undefined __start_XXX/__stop_XXX symbols.
PR 11133.
7. Fix linker --gc-sections with SHT_NOTE section.  PR 11143.
8. Fix a c++filt bug.  PR 11137.
9. Fix assembler listing.  PR 11122.
10. Improve gold. Change --enable-gold to --enable-gold=[both[/{gold,bfd}]].
11. Improve arm support.
12. Improve mips support.
13. Improve ppc support.
14. Improve MacOS support.

Changes from binutils 2.20.51.0.3:

1. Update from binutils 2009 1214.
2. Update x86 assembler to check lockable instructions for lock prefix.
3. Update x86 disassembler to display all prefixes.
4. Support AMD XOP new instructions.
5. Fix an x86 assembler regression on Intel syntax.  PR 11037.
6. Improve ia64 linker relaxation.  PR 10955.
7. Add --no-relax linker option.
8. Update readelf to dump .debug_pubtype sections.
9. Improve gold:
	a. Support linking against STT_GNU_IFUNC symbols defined in
	   shared libraries.
	b. Support linking with STB_GNU_UNIQUE symbols.
10. Improve arm support.
11. Improve m68k support.
12. Improve mips support.
13. Improve ppc support.

Changes from binutils 2.20.51.0.2:

1. Update from binutils 2009 1109.
2. Fix "ld -s -static" with STT_GNU_IFUNC symbols.  PR 10911.
3. Fix file permission on PIE with objcopy. PR 10802.
4. Fix x86 Intel syntax assembler with relocation.  PR 10856.
5. Fix x86 Intel syntax assembler with far jump.  PR 10740.
6. Add AMD LWP support.
7. Renamed linker option --add-needed to --copy-dt-needed-entries.
8. Support enabling both ld and gold with --enable-gold=both and
--enable-linker=[bfd,gold].
9. Improve gold.
10. Improve arm support.
11. Improve cris support.
12. Improve hppa support.
13. Improve m68k support.
14. Improve RX support.
15. Improve spu support.
16. Improve vax support.
17. Improve MacOS support.
18. Improve Windows support.

Changes from binutils 2.20.51.0.1:

1. Update from binutils 2009 1009.
2. Add .cfi_sections to assembler.
3. Fix a linker bug with local dynamic symbols. PR 10630.
4. Add DWARF-3/DWARF-4 support.
5. Fix the x86 assembler PIC bug. PR 10677.
6. Fix the x86-64 displacement assembler bug.  PR 10636.
7. Fix the x86 assembler bug with Intel memory syntax.  PR 10637.
8. Fix the x86 PIC assembler bug with Intel syntax. PR 10704.
9. Add RX support.
10. Improve gold.
11. Improve arm support.
12. Improve bfin support.
13. Improve cr16 support.
14. Improve m68k support.
15. Improve mips support.
16. Improve ppc support.

Changes from binutils 2.19.51.0.14:

1. Update from binutils 2009 0905.
2. Add Intel L1OM support.
3. Add MicroBlaze support.
4. Fix assembler for DWARF info without .file/.loc directives.  PR 10531.
5. Improve -pie with TLS relocations on ia32 and x86-64.  PRs 6443/10434.
6. Fix linker page size support.  PR 10569.
7. Fix wildcard in linker version script.  PR 10518.
8. Fix strip with STB_GNU_UNIQUE. PR 10492.
9. Fix strip on unwriteable files.  PR 10364.
10. Fix crash with "ld --build-id /usr/lib/libc.a".  PR 10555.
11. Fix linker for Linux kernel build.  PR 10429.
12. Support string merge on .comment section.
13. Improve build with C++ compiler.
14. Improve gold.
15. Improve arm support.
16. Improve bfin support.
11. Improve m32c support.
17. Improve m68k support.
18. Improve mep support.
19. Improve mips support.
20. Improve ppc support.
21. Improve spu support.
22. Improve xtensa support.

Changes from binutils 2.19.51.0.13:

1. Update from binutils 2009 0722.
2. Fix linker for STT_GNU_IFUNC symbols in static executables.  PR 10433.
3. Fix linker bug for Linux kernel build.  PR 10429.

Changes from binutils 2.19.51.0.12:

1. Update from binutils 2009 0721.
2. Fix linker for undefined STT_GNU_IFUNC symbols.  PR 10426.
3. Fix x86 assembler for nops in 64bit.  PR 10420.
4. Add a new option, --insn-width, to objdump.
5. Improve arm support.
6. Improve mips support.
7. Improve gold support.

Changes from binutils 2.19.51.0.11:

1. Update from binutils 2009 0716.
2. Fix x86 assembler for jumping to local STT_GNU_IFUNC symbols.
3. Fix x86 linker for relocatable link with local STT_GNU_IFUNC symbols.
4. Implement ppc STT_GNU_IFUNC support.
5. Support x86 FMA4.
6. Fix linker regression with Linux kernel build.
7. Support unordered references in DWARF reader.
8. Improve PE/COFF support.
8. Improve arm support.
9. Improve m10300 support.
10. Improve ppc support.
11. Improve spu support.
12. Improve gold support.

Changes from binutils 2.19.51.0.10:

1. Update from binutils 2009 0627.
2. Fix strip on static executable with STT_GNU_IFUNC symbol.  PR 10337.
3. Add STB_GNU_UNIQUE support.
4. Fix objcopy on empty file.  PR 10321.
5. Fix debug section for PE-COFF.
6. Suport build with gcc 4.5.0.
7. Improve arm support.
8. Improve ppc support.
9. Improve m10300 support.
10. Improve mep support.
11. Improve MacOS support.
12. Improve gold support.

Changes from binutils 2.19.51.0.9:

1. Update from binutils 2009 0618.
2. Update STT_GNU_IFUNC symbol support.  PR 10269/10270.
3. Fix an assembler CFI bug.  PR 10255.
4. Improve objdump.  PR 10263/10288
5. Improve readelf.
6. Improve arm support.
7. Improve moxie support.
8. Improve spu support.
9. Improve vax support.
10. Improve COFF/PE support.
11. Improve MacOS support.

Changes from binutils 2.19.51.0.8:

1. Update from binutils 2009 0606.
2. Update STT_GNU_IFUNC symbol support.

Changes from binutils 2.19.51.0.7:

1. Update from binutils 2009 0603.
2. Fix STT_GNU_IFUNC symbol with pointer equality.

Changes from binutils 2.19.51.0.6:

1. Update from binutils 2009 0601.
2. Update STT_GNU_IFUNC support. PR 10205.
3. Fix x86 asssembler Intel syntax regression with '$'. PR 10198.

Changes from binutils 2.19.51.0.5:

1. Update from binutils 2009 0529.
2. Rewrite STT_GNU_IFUNC, R_386_IRELATIVE and R_X86_64_IRELATIVE linker
support for STT_GNU_IFUNC symbols in shared library, dynamic executable
and static executable.
3. Add plugin support.
4. Improve spu support.

Changes from binutils 2.19.51.0.4:

1. Update from binutils 2009 0525.
2. Add STT_GNU_IFUNC, R_386_IRELATIVE and R_X86_64_IRELATIVE support to
assembler and linker.
3. Add LD_AS_NEEDED support to linker.
4. Remove AMD SSE5 support.
5. A new Intel syntax parser in x86 assembler.
6. Add DWARF discriminator support.
7. Add --64 support for x86 PE/COFF assembler.
8. Support common symbol with alignment for PE/COFF.
9. Improve gold support.
10. Improve arm support.
11. Improve mep support.
12. Improve mips support.
13. Improve ppc support.
14. Improve spu support.

Changes from binutils 2.19.51.0.3:

1. Update from binutils 2009 0418.
2. Remove EFI targets and use PEI targets for EFI. Add --file-alignment,
--heap, --image-base, --section-alignment, --stack and --subsystem command
line options for objcopy.  PR 10074.
3. Update linker to warn alternate ELF machine code.
4. Fix x86 linker TLS transition.  PR 9938.
5. Improve DWARF dumper to check relocations against STT_SECTION
symbol.
6. Guard DWARF dumper on bad DWARF input.
7. Add EM_ETPU and EM_SLE9X.  Reserve 3 ELF machine types for Intel.
8. Adding a linker missing entry symbol warning for -pie. PR 9970.
9. Make the -e option for linker to imply -u.  PR 6766.
10. Properly handle paging for PEI targets.
11. Fix assembler listing with input from stdin.
12. Update objcopy/string to generate symbol table if there is any
relocation in output.  PR 9945.
13. Require texinfo 4.7 for build.  PR 10039.
14. Add moxie support.
15. Improve gold support.
16. Improve AIX support.
17. Improve arm support.
18. Improve cris support.
19. Improve crx support.
20. Improve mips support.
21. Improve ppc support.
22. Improve s390 support.
23. Improve spu support.
24. Improve vax support.

Changes from binutils 2.19.51.0.2:

1. Update from binutils 2009 0310.
2. Fix strip on common symbols in relocatable file.  PR 9933.
3. Fix --enable-targets=all build.
4. Fix ia64 build with -Wformat-security.  PR 9874.
5. Add REGION_ALIAS support in linker script.
6. Add think archive support to readelf.
7. Improve DWARF support in objdump.
8. Improve alpha support.
9. Improve arm support.
10. Improve hppa support.
11. Improve m68k support.
12. Improve mips support.
13. Improve ppc support.
14. Improve xtensa support.
15. Add score 7 support.

Changes from binutils 2.19.51.0.1:

1. Update from binutils 2009 0204.
2. Support AVX Programming Reference (January, 2009)
3. Improve .s suffix support in x86 disassembler.
4. Add --prefix/--prefix-strip for objdump -S.  PR 9784.
5. Change "ld --as-needed" to resolve undefined references in DSO.
6. Add -Ttext-segment to ld to set address of text segment.
7. Fix "ld -r --gc-sections --entry" crash with COMDAT group.  PR 9727.
8. Improve linker compatibility for g++ 3.4 `.gnu.linkonce.r.*.
9. Add VMS/ia64 support.
10. Improve arm support.
11. Improve cris support.
12. Improve m68k support.
13. Improve mips support.
14. Improve spu support.

Changes from binutils 2.19.50.0.1:

1. Update from binutils 2009 0106.
2. Support AVX Programming Reference (December, 2008)
2. Encode AVX insns with 2byte VEX prefix if possible.
4. Add .s suffix support to swap register operands to x86 assembler.
5. Properly select NOP insns for code alignment in x86 assembler.
6. Fix 2 symbol visibility linker bugs.  PRs 9676/9679.
7. Fix an ia64 linker relaxation bug.  PR 7036.
8. Fix a symbol versioning bug. PR 7047.
9. Fix unitialized data in linker.  PR 7028.
10. Avoid a linker crash on bad input.  PR 7023.
11. Fix a linker memory leak.  PR 7012.
12. Fix strip/objcopy crash on PT_GNU_RELRO.  PR 7011.
13. Improve MacOS support.
14. Fix a COFF linker bug.  PR 6945.
15. Add LM32 support.
16. Fix various arm bugs.
17. Fix various avr bugs.
18. Fix various CR16  bugs.
19. Fix various cris bugs.
20. Fix various m32c bugs.
21. Fix various m68k bugs.
22. Fix various mips bugs.
23. Fix various ppc bugs.
24. Fix various s390 bugs.
25. Fix various sparc bugs.
26. Fix various spu bugs.
27. Fix various xtensa bugs.

The file list:

1. binutils-2.20.51.0.9.tar.bz2. Source code.
2. binutils-2.20.51.0.9.i686.tar.bz2. IA-32 binary tar ball for RedHat
   EL 5.
3. binutils-2.20.51.0.9.ia64.tar.bz2. IA-64 binary tar ball for RedHat
   EL 5.
4. binutils-2.20.51.0.9.x86_64.tar.bz2. X64_64 binary tar ball for RedHat
   EL 5.

The primary sites for the beta Linux binutils are:

1. http://www.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl.tools@gmail.com
05/27/2010
