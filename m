Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5KJL6nC007766
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 20 Jun 2002 12:21:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5KJL6hM007765
	for linux-mips-outgoing; Thu, 20 Jun 2002 12:21:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc03.attbi.com (sccrmhc03.attbi.com [204.127.202.63])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5KJJunC007750
	for <linux-mips@oss.sgi.com>; Thu, 20 Jun 2002 12:19:57 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc03.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020620192254.FSQ20219.sccrmhc03.attbi.com@ocean.lucon.org>;
          Thu, 20 Jun 2002 19:22:54 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 49FAA125C1; Thu, 20 Jun 2002 12:22:49 -0700 (PDT)
Date: Thu, 20 Jun 2002 12:22:49 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-gcc@vger.kernel.org, GNU C Library <libc-alpha@sources.redhat.com>,
   gcc@gcc.gnu.org, Kenneth Albanowski <kjahds@kjahds.com>,
   Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   Leonard Zubkoff <lnz@dandelion.com>, "Steven J. Hill" <sjhill@cotw.com>
Subject: The Linux binutils 2.12.90.0.12 is released
Message-ID: <20020620122249.A17654@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is the beta release of binutils 2.12.90.0.12 for Linux, which is
based on binutils 2002 0618 in CVS on sourecs.redhat.com plus various
changes. It is purely for Linux.

The Linux/mips support is added. You have to use

# rpm --target=[mips|mipsel] -ta binutils-xx.xx.xx.xx.xx.tar.gz

to build it. Or you can read mips/README in the source tree to apply
the mips patches and build it by hand.

FYI, the binutils man pages now are generated from the texinfo files
during the build. As the result, those man pages may be changed for
each build even if you only have done

# ..../configure ...
# make

That means you may have many failures on the man pages when you apply
the binutils diffs next time. Those failures can be safely ignored.
You should remove all those man pages from your source tree by

# find -name *.1 | xargs rm -f
# find -name *.1.rej | xargs rm -f
# find -name *.man | xargs rm -f
# find -name *.man.rej | xargs rm -f

Please report any bugs related to binutils 2.12.90.0.12 to hjl@lucon.org.

For arm-linux targets, there are some important differences in behaviour 
between these tools and binutils 2.9.1.0.x.  The linker emulation name has 
changed from elf32arm{26} to armelf_linux{26}.  Also, the "-p" flag must be 
passed with the linker when working with object files (or static libraries) 
created using older versions of the assembler.  If this flag is omitted the 
linker will silently generate bad output when given old input files.

To get the correct behaviour from gcc, amend the *link section of your specs 
file as follows:

*link:
%{h*} %{version:-v}    %{b} %{Wl,*:%*}    %{static:-Bstatic}    %{shared:-shared}    %{symbolic:-Bsymbolic}    %{rdynamic:-export-dynamic}    %{!dynamic-linker: -dynamic-linker /lib/ld-linux.so.2}    -X    %{mbig-endian:-EB} %{mapcs-26:-m armelf_linux26} %{!mapcs-26:-m armelf_linux} -p


Changes from binutils 2.12.90.0.11:
1. Update from binutils 2002 0618.
2. Fix an mips assembler bug.

Changes from binutils 2.12.90.0.9:

1. Update from binutils 2002 0608.
2. Fix an ELF/mips SHF_MERGE bug.

Changes from binutils 2.12.90.0.7:

1. Update from binutils 2002 0526.
2. Support "-z muldefs".

Changes from binutils 2.12.90.0.4:

1. Update from binutils 2002 0423.
2. ELF EH frame bug fix.
3. MIPS ELF visibility bug fix.

Changes from binutils 2.12.90.0.3:

1. Update from binutils 2002 0408.
2. Bug fixes for ELF/sparc.
3. Bug fixes for ELF/CRIS.

Changes from binutils 2.12.90.0.1:

1. Update from binutils 2002 0323.
2. Fix linking a.out relocatable files with ELF.
3. Fix a PPC altivec assembler bug.

Changes from binutils 2.11.93.0.2:

1. Update from binutils 2002 0307.
2. Add the .preinit_array/.init_array/.fini_array support.
3. Fix eh_frame.
4. Turn on combreloc by default.
5. Enable gprof for Linux/mips.

Changes from binutils 2.11.92.0.12.3:

1. Update from binutils 2002 0207.
2. Fix a weak symbol alpha linker bug for glibc.
3. More support for gcc 3.1.

Changes from binutils 2.11.92.0.12:

1. Fix a regression in 2.11.92.0.12 when linking with none-ELF object
files.

Changes from binutils 2.11.92.0.10:

1. Update from binutils 2001 1121.
2. Fix a linker symbol version bug for common symbols.
3. Update handling relocations against the discarded sections. You may
need to apply the kernel patch enclosed here to your kernel source. If
you still see things like

drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in discarded section .text.exit'

in the final kernel link, that means you have compiled a driver into
the kernel which has a reference to the symbol in a discarded section.
Kernel 2.4.17 or above should work fine.

4. Support "-march=xxx -mipsN" for mips gas if they are compatible.

Changes from binutils 2.11.92.0.7:

1. Update from binutils 2001 1021.
2. Fix the ELF/PPC linker.
3. Fix the ELF/cris linker.
4. Fix ELF strip.

Changes from binutils 2.11.92.0.5:

1. Update from binutils 2001 1016.
2. Fix all breakages introduced in 2.11.92.0.12.

Changes from binutils 2.11.90.0.31:

1. Update from binutils 2001 1005.
2. Support gcc 3.1 for ia64.
3. Support prelink for ELF/PPC.
4. Fix an ELF/x86 linker bug for Oracle.
5. Fix a weak symbol bug.
6. Support locale.

Changes from binutils 2.11.90.0.29:

1. Update from binutils 2001 0830.
2. Fix a mips linker bug.

Changes from binutils 2.11.90.0.27:

1. Update from binutils 2001 0827.
2. Fix an alpha assembler bug.
3. Fix an ia64 linker bug.
4. Fix a mips linker bug.
5. Support `-z combreloc|nocombreloc' in linker.

Changes from binutils 2.11.90.0.25:

1. Update from binutils 2001 0810.
2. Fix an x86 linker bug.

Changes from binutils 2.11.90.0.24:

1. Update from binutils 2001 0726.
2. Fix an x86 assembler bug.
3. "make check" in the windres test in binutils may call uudecode. We
are working on it.
4. "make check" fails the windres test in binutils if the i386/pe
is enabled in bfd. Fixed in the next release.
5. "make check" has 2 failures in the ld-selective test in ld on
Linux/alpha. They should be marked xfail. Fixed in the next release.

Changes from binutils 2.11.90.0.23:

1. Update from binutils 2001 0714.
2. Fix Sparc/ElF for Linux/sparc.
3. Fix Alpha/ELF for gcc 3.0.

Changes from binutils 2.11.90.0.19:

1. Update from binutils 2001 0706.
2. Fix objcopy/strip broken by accident.
3. Avoid COPY relocs on ia32.
4. Fix the ia64 assembler.
5. This release may not work on Linux/sparc due to the unaligned
relocation changes, which are not handled by all versions of glibc.
The current glibc in CVS on sourceware should be ok. The last known
working binutils for Linux/sparc is 2.11.90.0.8. We are working on it.

Changes from binutils 2.11.90.0.15:

1. Update from binutils 2001 0620.
2. Fix a static linking the PIC object files on ia32.
3. Add the verion script support for --export-dynamic. It can be used
to selectively export dynamic symbols from the executables.

Changes from binutils 2.11.90.0.8:

1. Update from binutils 2001 0610.
2. Fix a gas bug for gcc 3.0.

Changes from binutils 2.11.90.0.7:

1. Update from binutils 2001 0512.
2. Fix some P/III SSE 2 assembler bugs.
3. Fix DT_NEEDED and symbol version bugs.
4. Support hidden versioned symbols in DSOs.

Changes from binutils 2.11.90.0.6:

1. Update from binutils 2001 0427.
2. Fix the -Bsymbolic bug introduced in binutils 2.11.90.0.5.

Changes from binutils 2.11.90.0.5:

1. Update from binutils 2001 0425.
2. Update "ld --multilib-dir PATH".

Changes from binutils 2.11.90.0.4:

1. Update from binutils 2001 0414.
2. Fix an ia64 assembler bug.
3. Change Linux/MIPS to use the SVR4 MIPS ABI instead of the IRIX ABI.
since there are no supports for the IRIX ABI in glibc. The current
Linux/MIPS targets are elf64-tradlittlemips for little endian MIPS
instead of elf32-littlemips and elf64-tradbigmips for big endian MIPS
instead of elf32-bigmips. Glibc, gcc and kernel may have to be modified
for this change. 

Changes from binutils 2.11.90.0.1:

1. Update from binutils 2001 0401.
2. Fix a gas bug for the gcc from the CVS main trunk. It involves some
changes in gas. I compiled kernel 2.2.18, gcc and glibc under
Linux/ia32. The resulting binaries work fine. 
3. Fix the linker core dump on unsupported ELF binaries.

Changes from binutils 2.10.91.0.4:

1. Update from binutils 2001 0309.

Changes from binutils 2.10.91.0.2:

1. Update from binutils 2001 0223.
2. More ia64 bug fixes.

Changes from binutils 2.10.1.0.7:

1. Update from binutils 2001 0215.
2. More ia64 bug fixes. Support EFI and "ld -relax" on ia64.
3. Fix a weak definition, -Bsymbolic, non-PIC bug for ia32.

Changes from binutils 2.10.1.0.4:

1. Update from binutils 2001 0206.
2. Enable the IA64 support.
3. Now you need to use

# ld --oformat TARGET

instead of

# ld -oformat TARGET

The Linux kernel build may be affected. BTW

# ld --oformat TARGET

should work with all previous releases of binutils.

Changes from binutils 2.10.1.0.2:

1. Update from binutils 2000 1221.

Changes from binutils 2.10.0.33:

1. Update from binutils 2000 1119.
2. It has some symbol versioning related updates.

Changes from binutils 2.10.0.32:

1. Update from binutils 2000 1018.
2. A proper ELF/PPC visibility fix.
3. m68k-a.out is supposed to be fixed.

Changes from binutils 2.10.0.31:

1. Update from binutils 2000 1014.
2. An ELF/PPC weak symbol bug fix.
3. A new linkonce section name approach.
4. m68k-a.out is still broken. To be fixed.

Changes from binutils 2.10.0.29:

1. Update from binutils 2000 1011.
2. Back out the linkonce section name change so that C++ will work.
A different approach is being worked on.
3. m68k-a.out is known to be broken. To be fixed.

Changes from binutils 2.10.0.26:

1. Update from binutils 2000 1008.

Changes from binutils 2.10.0.24:

1. Update from binutils 2000 0907.

Changes from binutils 2.10.0.18:

1. Update from binutils 2000 0823. Fix DT_RPATH/DT_RUNPATH handling.
Fix the ELF/ia32 DSO not compiled with PIC.
2. Try to fix the ELF visibility bug on PPC with glibc 2.2.

Changes from binutils 2.10.0.12:

1. Update from binutils 2000 0720.
2. Fix the DT_NEEDED link bug.
3. Add the new DT_XXXX dynamic tags. Glibc 2.2 will use them at least
on libpthread.so.

Changes from binutils 2.10.0.9:

1. Update from binutils 2000 0701. Fix the parallel build in ld when PE
is enabled.

Changes from binutils 2.9.5.0.46:

1. Update from binutils 2000 0617. The demangler support for the new
g++ ABI. Minor fix for the ELF visibility. Fix linking non-ELF
relocatable object files under ELF with symbol versioning.
2. Support for linking PE relocatable object files under ia32/ELF.

Changes from binutils 2.9.5.0.42:

1. Update from binutils 2000 0604. The ELF visibility attribuite should
work correctly now.
2. The ia32 assembler has changed the way it assembles the "jmp"
instructions to the global symbols. The old assembler will optimize the
jump to the global symbol defined in the same source file so that no
relocation will be used. The new assembler will use relocation for
global jumps. It will mainly affect PIC asm code. The segment like

	.globl  __setjmp
__setjmp:
	...
	jmp __sigsetjmp
	...
	.globl __sigsetjmp
__sigsetjmp:

is no longer PIC safe since "jmp __sigsetjmp" jumps to a global symbol
and relocation will be used. Instead, it can be changed to

	.globl  __setjmp
__setjmp:
	...
	jmp sigsetjmp
	...
	.globl __sigsetjmp
__sigsetjmp:
sigsetjmp:

so that "jmp sigsetjmp" jumps to a local symbol and the new assembler
will optimize out the relocation.

Changes from binutils 2.9.5.0.41:

1. Update from binutils 2000 0512.
2. Add testsuite for ELF visibility.

Changes from binutils 2.9.5.0.37:

1. Update from binutils 2000 0502.
2. Support STV_HIDDEN and STV_INTERNAL.

Changes from binutils 2.9.5.0.35:

1. Update from binutils 2000 0418.
2. Fix an ld demangle style option bug.

Changes from binutils 2.9.5.0.34:

1. Update from binutils 2000 0412. Fix a relocation bug which affects
the Linux kernel compilation.
2. An ELF/PPC linker script update.

Changes from binutils 2.9.5.0.33:

1. Update from binutils 2000 0404. Fix the bug report bug.

Changes from binutils 2.9.5.0.32:

1. Update from binutils 2000 0403. Fix the 16bit ia32 assembler bug.

Changes from binutils 2.9.5.0.31:

1. Update from binutils 2000 0331. Fix the Linux/ARM assembler bug.
2. Fix a Debian assembler security bug.

Changes from binutils 2.9.5.0.29:

1. Update from binutils 2000 0319.
2. An ELF/alpha bug is fixed.

Changes from binutils 2.9.5.0.27:

1. Update from binutils 2000 0301.
2. A demangler bug is fixed.
3. A better fix for undefined symbols with -Bsymbolic when building
shared library.

Changes from binutils 2.9.5.0.24:

1. Update from binutils 2000 0204.
2. Added -taso to linker on alpha.
3. Fixed a -shared -Bsymbolic bug when PIC is not used.

Changes from binutils 2.9.5.0.22:

1. Update from binutils 2000 0113.
2. A symbol version bug is fixed.
3. A -Bsymbolic bug is fixed.

Changes from binutils 2.9.5.0.21:

1. Update from binutils 1999 1202.
2. Remove a MIPS/ELF change.
3. Enable SOM for HPPA.

Changes from binutils 2.9.5.0.19:

1. Update from binutils 1999 1122. An ia32 gas bug is fixed.

Changes from binutils 2.9.5.0.16:

1. Update from binutils 1999 1104.
2. i370 is changed to use EM_S370 and ELFOSABI_LINUX. Update readelf.
3. Fix Compaq's demangler support.

Changes from binutils 2.9.5.0.14:

1. Update from binutils 1999 1012. A gas bug which affects Linux 2.3.21
is fixed.
2. i370 update.
3. The new demangler code. You should use "--style=xxx" to select the
demnangle style instead of "--lang=xxx".

Changes from binutils 2.9.5.0.13:

1. Update from binutils 1999 0925.
2. Fix a -s and linker script bug.

Changes from binutils 2.9.5.0.12:

1. Update from binutils 1999 0922.
2. i370 update.

Changes from binutils 2.9.5.0.11:

1. Update from binutils 1999 0910. It fixed a PIC linker bug on ix86
   and sparc introduced in the last release.
2. i370 update.

Changes from binutils 2.9.5.0.10:

1. Update from binutils 1999 0906. It fixed a PIC linker bug on ix86
   and sparc.
2. Remove elf/hppa since it is WIP.

Changes from binutils 2.9.5.0.8:

1. Update from binutils 1999 0831. It allows spaces around '(' and ')'
   in x86 FP register names.

Changes from binutils 2.9.5.0.7:

1. Update from binutils 1999 0821.
2. Some MIPS changes.

Changes from binutils 2.9.5.0.6:

1. Update from binutils 1999 0813.
2. i370 update.

Changes from binutils 2.9.5.0.5:

1. Update from binutils 1999 0809. An ELF/Sparc ld bug is fixed.

Changes from binutils 2.9.5.0.4:

1. Update from binutils 1999 0806. A Solaris/Sparc gas bug is fixed.
2. Remove mips gas patches from binutils 2.9.1.0.25.

Changes from binutils 2.9.5.0.3:

1. Update from binutils 1999 0801.
2. Support for real mode x86 gcc.

Changes from binutils 2.9.4.0.8:

1. Update from binutils 1999 0719. A libc 5 related bug fix.
2. Fix a typo in mips gas.

Changes from binutils 2.9.4.0.7:

1. Update from binutils 1999 0710. A weak symbol bug

http://egcs.cygnus.com/ml/egcs-bugs/1999-07/msg00129.html

is fixed.

Changes from binutils 2.9.4.0.6:

1. Update from binutils 1999 0626.

Changes from binutils 2.9.4.0.5:

1. Update from binutils 1999 0620.
2. Remove my fwait fix and use the one in cvs.
3. Use "--only-section=section" instead of "--extract-section=section".
   for objcopy.

Changes from binutils 2.9.4.0.4:

1. Update from binutils 1999 0612.
2. Remove various temporary fixes of mine since those bugs are fixed
   now.

Changes from binutils 2.9.4.0.3:

1. Update from binutils 1999 0611.
2. Remove my ELF/Alpha bfd changes.
3. Use the local symbol copy fix in binutils 1999 0611.

Changes from binutils 2.9.4.0.2:

1. Update from binutils 1999 0607.
2. Remove my Sparc hacks.
3. Fix local symbol copy.

Changes from binutils 2.9.4.0.1:

1. Update from binutils 1999 0606.
2. Restore relocation overflow checking in binutils 2.9.1.0.25 so that
   Linux kernel can build.
3. Fix i370 for the new gas.

Changes from binutils 1999 0605:

1. Fix a -Bsymbolic bug for Linux/alpha.
2. Add ELF/i370.
3. Fix 8/16-bit relocations for i386.
4. Add --redefine-sym=old_form=new_form to objcopy.
5. Add "-j section" for objcopy.
6. Fix i386 disassembler for fwait.
7. Fix a Sparc asm bug.
8. Add Ada demangle support.
9. Fix MIPS/ELF bugs.
10. Add some vxworks suppport.
11. Fix a.out assembler.

The file list:

1. binutils-2.12.90.0.12.tar.gz. Source code.
2. binutils-2.12.90.0.11-2.12.90.0.12.diff.gz. Patch against the
   previous beta source code.
3. binutils-2.12.90.0.12-1.i386.rpm. IA-32 binary RPM for RedHat 7.3.

There is no separate source rpm. You can do

# rpm -ta binutils-2.12.90.0.12.tar.gz

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://ftp.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
06/19/2002
