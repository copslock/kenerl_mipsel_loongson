Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Apr 2006 18:02:43 +0100 (BST)
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:34960 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133537AbWD2RCW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 29 Apr 2006 18:02:22 +0100
Received: (qmail 89257 invoked from network); 29 Apr 2006 17:02:11 -0000
Received: from unknown (HELO lucon.org) (hjjean@sbcglobal.net@75.0.171.244 with login)
  by smtp109.sbc.mail.mud.yahoo.com with SMTP; 29 Apr 2006 17:02:10 -0000
Received: by lucon.org (Postfix, from userid 1000)
	id EE79A64034; Sat, 29 Apr 2006 10:02:07 -0700 (PDT)
Date:	Sat, 29 Apr 2006 10:02:07 -0700
From:	"H. J. Lu" <hjl@lucon.org>
To:	linux-gcc@lucon.org
Cc:	GNU C Library <libc-alpha@sources.redhat.com>, gcc@gcc.gnu.org,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>
Subject: The Linux binutils 2.17.50.0.1 is released
Message-ID: <20060429170207.GA4084@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.17.50.0.1 for Linux, which is
based on binutils 2006 0427 in CVS on sources.redhat.com plus various
changes. It is purely for Linux.

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

Please report any bugs related to binutils 2.17.50.0.1 to hjl@lucon.org

and

http://www.sourceware.org/bugzilla/

If you don't use

# rpmbuild -ta binutils-xx.xx.xx.xx.xx.tar.bz2

to compile the Linux binutils, please read patches/README in source
tree to apply Linux patches if there are any.

Changes from binutils 2.16.91.0.7:

1. Update from binutils 2006 0427.
2. Fix an objcopy regression (PR 2593).
3. Reduce ar memory usage (PR 2467).
4. Allow application specific ELF sections (PR 2537).
5. Fix an i386 TLS linker bug (PR 2513).
6. Speed up ia64 linker by 1300X in some cases (PR 2442).
7. Check illegal immediate register operand in i386 assembler (PR
2533).
8. Fix a strings bug (PR 2584).
9. Better handle corrupted ELF files (PR 2257).
10. Fix a MIPS linker bug (PR 2267).

Changes from binutils 2.16.91.0.6:

1. Update from binutils 2006 0317.
2. Support Intel Merom New Instructions in assembler/disassembler.
3. Support Intel new instructions in Montecito.
4. Fix linker "--as-needed" (PR 2434).
5. Fix linker "-s" regression (PR 2462).
6. Fix REP prefix for string instructions in x86 disassembler
(PR 2428).
7. Fix the weak undefined symbols in PIE (PR 2218).
8. Fix 2 DWARF reader bugs (PRs 2443, 2338).
9. Improve ELF linker error message (PR 2322).
10. Avoid abort with dynamic symbols in >64K sections (PR 2411).
11. Handle mismatched symbol types for executables (PR 2404).
12. Avoid a linker linkonce regression (PR 2342).

Changes from binutils 2.16.91.0.5:

1. Update from binutils 2006 0212.
2. Correct Linux linker search order for DT_NEEDED entries (PR 2290).
3. Fix the x86-64 disassembler for control/debug register moves.
4. Properly handle ELF strip/objcopy with unmodified program header
(PR 2258).
5. Improve ELF linker error handling when there are not enough room for
program headers (PR 2322).
6. Properly handle weak undefined symbols in PIE (PR 2218).
7. Support new i386/x86-64 TLS relocations.
8. Fix addr2line for linux kernel (PR 2096).
9. Fix an assembler memory leak with --statistics.
10. Avoid an ia64 assembler regression (PR 2117).

Changes from binutils 2.16.91.0.4:

1. Update from binutils 2005 1219.
2. Fix a MIPS linker regression (PR 1932).
3. Fix an objcopy bug for ia64 (PR 1991).
4. Fix a linker crash on bad input (PR 2008).
5. Fix 64bit monitor and mwait (PR 1874).

Changes from binutils 2.16.91.0.3:

1. Update from binutils 2005 1111.
2. Fix ELF orphan section handling (PR 1467)
3. Fix ELF section attribute handleing (PR 1487).
4. Fix IA64 unwind info dump for relocatable files. (PR 1436).
5. Add DWARF info dump to objdump.
6. Fix SHF_LINK_ORDER handling (PR 1321).
7. Don't allow "ld --just-symbols" on DSO (PR 1263).
8. Fix a "ld -u" crash on TLS symbol (PR 1301).
9. Fix an IA64 linker crash (PR 1247).
10. Fix a MIPS linker bug (PR 1150).
11. Fix a M68K linker bug (PR 1775).
12. Fix an ELF symbol versioning linker bug (PR 1540).
13. Improve linker error handling (PR 1208).
14. Add new SPARC processors to SunOS for objcopy (PR 1472).
15. Add "@file" to read options from a file.
16. Add assembler weakref support.

Changes from binutils 2.16.91.0.2:

1. Update from binutils 2005 0821.
2. Support x86-64 medium model.
3. Fix "objdump -S --adjust-vma=xxx" (PR 1179).
4. Reduce R_IA64_NONE relocations from R_IA64_LDXMOV relaxation.
5. Fix x86 linker regression for dosemu.
6. Add "readelf -t/--section-details" to display section details.
7. Fix "as -al=file" regression (PR 1118).

Changes from binutils 2.16.91.0.1:

1. Update from binutils 2005 0720.
2. Add Intel VMX support.
3. Add AMD SVME support.
4. Add x86-64 new relocations for medium model.
5. Fix a PIE regression (PR 975).
6. Fix an x86_64 signed 32bit displacement regression.
7. Fix PPC PLT (PR 1004). 
8. Improve empty section removal.

Changes from binutils 2.16.90.0.3:

1. Update from binutils 2005 0622.
2. Fix a linker versioning bug exposed by gcc 4 (PR 1022/1023/1025).
3. Optimize ia64 br->brl relaxation (PR 834).
4. Improve linker empty section removal.
5. Fix DWARF 2 line number reporting (PR 990).
6. Fix DWARF 2 line number reporting regression on assembly file (PR
1000).

Changes from binutils 2.16.90.0.2:

1. Update from binutils 2005 0510.
2. Update ia64 assembler to support comdat group section generated by
gcc 4 (PR 940).
3. Fix a linker crash on bad input (PR 939).
4. Fix a sh64 assembler regression (PR 936).
5. Support linker script on executable (PR 882).
6. Fix the linker -pie regression (PR 878).
7. Fix an x86_64 disassembler bug (PR 843).
8. Fix a PPC linker regression.
9. Misc speed up.

Changes from binutils 2.16.90.0.1:

1. Update from binutils 2005 0429.
2. Fix an ELF linker regression (PR 815).
3. Fix an empty section removal related bug.
4. Fix an ia64 linker regression (PR 855).
5. Don't allow local symbol to be equated common/undefined symbols (PR
857).
6. Fix the ia64 linker to handle local dynamic symbol error reporting.
7. Make non-debugging reference to discarded section an error (PR 858).
8. Support Sparc/TLS.
9. Support rpm build with newer rpm.
10. Fix an alpha linker regression.
11. Fix the non-gcc build regression.

Changes from binutils 2.15.94.0.2.2:

1. Update from binutils 2005 0408.
2. The i386/x86_64 assemblers no longer accept instructions for moving
between a segment register and a 32bit memory location.
3. The x86_64 assembler now allows movq between a segment register and
a 64bit general purpose register.
4. 20x Speed up linker for input files with >64K sections.
5. Properly report ia64 linker relaxation failures.
6. Support tuning ia64 assembler for Itanium 2 processors.
7. Linker will remove empty unused output sections.
8. Add -N to readelf to display full section names.
9. Fix the ia64 linker to support linkonce text sections without unwind
sections.
10. More unwind directive checkings in the ia64 assembler.
11. Speed up linker with wildcard handling.
12. Fix readelf to properly dump .debug_ranges and .debug_loc sections.

Changes from binutils 2.15.94.0.2:

1. Fix greater than 64K section support in linker.
2. Properly handle i386 and x86_64 protected symbols in linker.
3. Fix readelf for LEB128 on 64bit hosts.
4. Speed up readelf for section group process.
5. Include ia64 texinfo pages.
6. Change ia64 assembler to check hint.b for Montecito.
7. Improve relaxation failure report in ia64 linker.
8. Fix ia64 linker to allow relax backward branch in the same section.

Changes from binutils 2.15.94.0.1:

1. Update from binutils 2004 1220.
2. Fix strip for TLS symbol references.

Changes from binutils 2.15.92.0.2:

1. Update from binutils 2004 1121.
2. Put ia64 .ctors/.dtors sections next to small data section for
Intel ia64 compiler.
3. Fix -Bdynamic/-Bstatic handling for linker script.
4. Provide more information on relocation overflow.
5. Add --sort-section to linker.
6. Support icc 8.1 unwind info in readelf.
7. Fix the infinite loop bug on bad input in the ia64 assembler.
8. Fix ia64 SECREL relocation in linker.
9. Fix a section group memory leak in readelf.

Changes from binutils 2.15.91.0.2:

1. Update from binutils 2004 0927.
2. Work around a section header bug in Intel ia64 compiler.
3. Fix an unwind directive bug in the ia64 assembler.
4. Fix various PPC bugs.
5. Update ARM support.
6. Fix an x86-64 linker warning while building Linux kernel.

Changes from binutils 2.15.91.0.1:

1. Update from binutils 2004 0727.
2. Fix the x86_64 linker to prevent non-PIC code in shared library.
3. Fix the ia64 linker to warn the relotable files which can't be
relaxed.
4. Fix the comdat group support. Allow mix single-member comdat group
with linkonce section.
5. Added --add-needed/--no-add-needed options to linker.
6. Fix the SHF_LINK_ORDER support.
7. Fix the ia64 assembler for multiple sections with the same name and
SHT_IA_64_UNWIND sections.
8. Fix the ia64 assembler for merge section and relaxation.

Changes from binutils 2.15.90.0.3:

1. Update from binutils 2004 0527.
2. Fix -x auto option in the ia64 assembler.
3. Add the AR check in the ia64 assembler.
4. Fix the section group support.
5. Add a new -z relro linker option.
6. Fix an exception section placement bug in linker.
7. Add .serialize.data and .serialize.instruction to the ia64
assembler.

Changes from binutils 2.15.90.0.2:

1. Update from binutils 2004 0415.
2. Fix the linker for weak undefined symbol handling.
3. Fix the ELF/Sparc and ELF/Sparc64 linker for statically linking PIC
code.

Changes from binutils 2.15.90.0.1.1:

1. Update from binutils 2004 0412.
2. Add --as-needed/--no-as-needed to linker.
3. Fix -z defs in linker.
4. Always reserve the memory for ia64 dynamic linker.
5. Fix a race condition in ia64 lazy binding.

Changes from binutils 2.15.90.0.1:

1. Fixed an ia64 assembler bug.
2. Install the assembler man page.

Changes from binutils 2.14.90.0.8:

1. Update from binutils 2004 0303.
2. Fixed linker for undefined symbols with non-default visibility.
3. Sped up linker weakdef symbol handling.
4. Fixed mixing ELF32 and ELF64 object files in archive.
5. Added ia64 linker brl optimization.
6. Fixed ia64 linker to disallow invalid dynamic relocations.
7. Fixed DT_TEXTREL handling in ia64 linker.
8. Fixed alignment handling in ia64 assembler.
9. Improved ia64 assembler unwind table handling. 

Changes from binutils 2.14.90.0.7:

1. Update from binutils 2004 0114.
2. Fixed an ia64 assembler unwind table bug. 
3. Better handle IPF linker relaxation overflow.
4. Fixed misc PPC bugs.

Changes from binutils 2.14.90.0.6:

1. Update from binutils 2003 1029.
2. Allow type changes for undefined symbols.
3. Fix EH frame optimization.
4. Fix the check for undefined versioned symbol with wildcard.
5. Support generating code for Itanium.
6. Detect and warn bad symbol index.
7. Update IPF assemebler DV check.

Changes from binutils 2.14.90.0.5:

1. Update from binutils 2003 0820.
2. No longer use section names for ELF section types nor flags.
3. Fix some ELF/IA64 linker bugs.
4. Fix some ELF/ppc bugs.
5. Add archive support to readelf.

Changes from binutils 2.14.90.0.4.1:

1. Update from binutils 2003 0722.
2. Fix an ELF/mips linker bug.
3. Fix an ELF/hpppa linker bug.
4. Fix an ELF/ia64 assembler bug.
5. Fix a linkonce support with C++ debug.
6. A new working C++ demangler.
7. Various alpha, mips, ia64, ... bug fixes.
8. Support for the current gcc and glibc.

Changes from binutils 2.14.90.0.4:
 
1. Fix an ia64 assembler hint@pause bug.
2. Support Intel Prescott New Instructions.

Changes from binutils 2.14.90.0.3:

1. Work around the brain dead libtool.

Changes from binutils 2.14.90.0.2:

1. Update from binutils 2003 0523.
2. Fix 2 ELF visibility bugs.
3. Fix ELF/ppc linker bugs.

Changes from binutils 2.14.90.0.1:

1. Update from binutils 2003 0515.
2. Fix various ELF visibility bugs.
3. Fix some ia64 linker bugs.
4. Add more IAS compatibilities to ia64 assembler.

Changes from binutils 2.13.90.0.20:

1. Update from binutils 2003 0505.
2. Fix various ELF visibility bugs.
3. Fix some ia64 linker bugs.
4. Fix some ia64 assembler bugs.
5. Add some IAS compatibilities to ia64 assembler.
6. Fix ELF common symbol alignment.
7. Fix ELF weak symbol handling.

Changes from binutils 2.13.90.0.18:

1. Update from binutils 2003 0319.
2. Fix an ia64 linker brl relaxation bug.
3. Fix some ELF/ppc linker bugs.

Changes from binutils 2.13.90.0.16:

1. Update from binutils 2003 0121.
2. Fix an ia64 gas bug.
3. Fix some TLS bugs.
4. Fix some ELF/ppc bugs.
5. Fix an ELF/m68k bug.

2. Include /usr/bin/c++filt.
Changes from binutils 2.13.90.0.14:

1. Update from binutils 2002 1126.
2. Include /usr/bin/c++filt.
3. Fix "ld -r" with execption handling.

Changes from binutils 2.13.90.0.10:

1. Update from binutils 2002 1114.
2. Fix ELF/alpha bugs.
3. Fix an ELF/i386 assembler bug.

Changes from binutils 2.13.90.0.4:

1. Update from binutils 2002 1010.
2. More ELF/PPC linker bug fixes.
3. Fix an ELF/alpha linker bug.
4. Fix an ELF/sparc linker bug to support Solaris.
5. More TLS updates.

Changes from binutils 2.13.90.0.3:

1. Update from binutils 2002 0814.
2. Fix symbol versioning bugs for gcc 3.2.
3. Fix mips gas.

Changes from binutils 2.13.90.0.2:

1. Update from binutils 2002 0809.
2. Fix a mips gas compatibility bug.
3. Fix an x86 TLS bfd bug.
4. Fix an x86 PIC gas bug.
5. Improve symbol versioning support.

The file list:

1. binutils-2.17.50.0.1.tar.bz2. Source code.
2. binutils-2.16.91.0.7-2.17.50.0.1.diff.bz2. Patch against the
   previous beta source code.
3. binutils-2.17.50.0.1-1.i386.rpm. IA-32 binary RPM for RedHat EL 4.
4. binutils-2.17.50.0.1-1.ia64.rpm. IA-64 binary RPM for RedHat EL 4.
5. binutils-2.17.50.0.1-1.x86_64.rpm. X64_64 binary RPM for RedHat
   EL 4.

There is no separate source rpm. You can do

# rpmbuild -ta binutils-2.17.50.0.1.tar.bz2

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://www.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
04/29/2006
