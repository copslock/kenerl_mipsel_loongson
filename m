Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 22:30:14 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:41116 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225271AbUANWaN>; Wed, 14 Jan 2004 22:30:13 +0000
Received: from lucon.org ([24.6.43.109]) by comcast.net (sccrmhc11) with ESMTP
          id <2004011422300601100la0sge>; Wed, 14 Jan 2004 22:30:06 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 9954B649CC; Wed, 14 Jan 2004 14:30:04 -0800 (PST)
Date: Wed, 14 Jan 2004 14:30:04 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: linux-gcc@vger.kernel.org,
	GNU C Library <libc-alpha@sources.redhat.com>,
	gcc@gcc.gnu.org, Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>,
	"Steven J. Hill" <sjhill@realitydiluted.com>
Subject: The Linux binutils 2.14.90.0.8 is released
Message-ID: <20040114223004.GA6313@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.14.90.0.8 for Linux, which is
based on binutils 2004 0114 in CVS on sources.redhat.com plus various
changes. It is purely for Linux.

Please report any bugs related to binutils 2.14.90.0.8 to hjl@lucon.org.

If you don't use

# rpmbuild -ta binutils-xx.xx.xx.xx.xx.tar.gz

to compile the Linux binutils, please read patches/README in source
tree to apply Linux patches.

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

1. binutils-2.14.90.0.8.tar.gz. Source code.
2. binutils-2.14.90.0.7-2.14.90.0.8.diff.gz. Patch against the
   previous beta source code.
3. binutils-2.14.90.0.8-1.i386.rpm. IA-32 binary RPM for RedHat EL 3.
4. binutils-2.14.90.0.8-1.ia64.rpm. IA-64 binary RPM for RedHat EL 3.

There is no separate source rpm. You can do

# rpmbuild -ta binutils-2.14.90.0.8.tar.gz

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://www.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
01/14/2004
