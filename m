Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2004 16:48:45 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:27063 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225740AbUDOPsn>; Thu, 15 Apr 2004 16:48:43 +0100
Received: from lucon.org ([24.6.43.109]) by comcast.net (sccrmhc13) with ESMTP
          id <20040415154827016003er10e>; Thu, 15 Apr 2004 15:48:35 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 4BF9764D14; Thu, 15 Apr 2004 08:48:24 -0700 (PDT)
Date: Thu, 15 Apr 2004 08:48:24 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-gcc@vger.kernel.org, Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>,
	"Steven J. Hill" <sjhill@realitydiluted.com>, gcc@gcc.gnu.org,
	GNU C Library <libc-alpha@sources.redhat.com>
Subject: The Linux binutils 2.15.90.0.3 is released
Message-ID: <20040415154824.GA28202@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.15.90.0.3 for Linux, which is
based on binutils 2004 0415 in CVS on sources.redhat.com plus various
changes. It is purely for Linux.

Please report any bugs related to binutils 2.15.90.0.3 to hjl@lucon.org.

If you don't use

# rpmbuild -ta binutils-xx.xx.xx.xx.xx.tar.bz2

to compile the Linux binutils, please read patches/README in source
tree to apply Linux patches.

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
2. Support Intel Precott New Instructions.

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

1. binutils-2.15.90.0.3.tar.bz2. Source code.
2. binutils-2.15.90.0.2-2.15.90.0.3.diff.bz2. Patch against the
   previous beta source code.
3. binutils-2.15.90.0.3-1.i386.rpm. IA-32 binary RPM for RedHat EL 3.
4. binutils-2.15.90.0.3-1.ia64.rpm. IA-64 binary RPM for RedHat EL 3.
5. binutils-2.15.90.0.3-1.x86_64.rpm. X64_64 binary RPM for RedHat EL 3.

There is no separate source rpm. You can do

# rpmbuild -ta binutils-2.15.90.0.3.tar.bz2

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://www.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
04/15/2004
