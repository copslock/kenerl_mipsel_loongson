Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 19:54:07 +0100 (BST)
Received: from sccrmhc01.attbi.com ([IPv6:::ffff:204.127.202.61]:50672 "EHLO
	sccrmhc01.attbi.com") by linux-mips.org with ESMTP
	id <S8225259AbTEWSyE>; Fri, 23 May 2003 19:54:04 +0100
Received: from lucon.org (12-234-88-5.client.attbi.com[12.234.88.5])
          by attbi.com (sccrmhc01) with ESMTP
          id <2003052318534600100rv1dde>; Fri, 23 May 2003 18:53:46 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 2593D2C683; Fri, 23 May 2003 11:53:39 -0700 (PDT)
Date: Fri, 23 May 2003 11:53:39 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-gcc@vger.kernel.org, gcc@gcc.gnu.org,
	GNU C Library <libc-alpha@sources.redhat.com>,
	Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ron Guilmette <rfg@monkeys.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>,
	"Steven J. Hill" <sjhill@cotw.com>
Subject: The Linux binutils 2.14.90.0.3 is released
Message-ID: <20030523115339.A4699@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.14.90.0.3 for Linux, which is
based on binutils 2003 0523 in CVS on sourecs.redhat.com plus various
changes. It is purely for Linux.

Please report any bugs related to binutils 2.14.90.0.3 to hjl@lucon.org.

If you don't use

# rpmbuild -ta binutils-xx.xx.xx.xx.xx.tar.gz

to compile the Linux binutils, please read patches/README in source
tree to apply Linux patches.

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

1. binutils-2.14.90.0.3.tar.gz. Source code.
2. binutils-2.14.90.0.2-2.14.90.0.3.diff.gz. Patch against the
   previous beta source code.
3. binutils-2.14.90.0.3-1.i386.rpm. IA-32 binary RPM for RedHat 9.
4. binutils-2.14.90.0.3-1.ia64.rpm. IA-64 binary RPM for RedHat AS 2.1.

There is no separate source rpm. You can do

# rpm -ta binutils-2.14.90.0.3.tar.gz

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://ftp.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
05/23/2003
