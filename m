Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2003 06:33:23 +0100 (BST)
Received: from rwcrmhc51.attbi.com ([IPv6:::ffff:204.127.198.38]:671 "EHLO
	rwcrmhc51.attbi.com") by linux-mips.org with ESMTP
	id <S8225211AbTEFFdS>; Tue, 6 May 2003 06:33:18 +0100
Received: from lucon.org (12-234-88-5.client.attbi.com[12.234.88.5])
          by attbi.com (rwcrmhc51) with ESMTP
          id <2003050605330405100jdkuee>; Tue, 6 May 2003 05:33:04 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 62BE52C681; Mon,  5 May 2003 22:33:01 -0700 (PDT)
Date: Mon, 5 May 2003 22:33:01 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-gcc@vger.kernel.org,
	GNU C Library <libc-alpha@sources.redhat.com>,
	gcc@gcc.gnu.org, Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ron Guilmette <rfg@monkeys.com>,
	"Polstra; John" <linux-binutils-in@polstra.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>,
	Leonard Zubkoff <lnz@dandelion.com>,
	"Steven J. Hill" <sjhill@cotw.com>
Subject: The Linux binutils 2.14.90.0.1 is released
Message-ID: <20030505223301.A28436@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.14.90.0.1 for Linux, which is
based on binutils 2003 0505 in CVS on sourecs.redhat.com plus various
changes. It is purely for Linux.

The Linux/mips support is added. You have to use

# rpm --target=[mips|mipsel] -ta binutils-xx.xx.xx.xx.xx.tar.gz

to build it. Or you can read mips/README in the source tree to apply
the mips patches and build it by hand.

Please report any bugs related to binutils 2.14.90.0.1 to hjl@lucon.org.

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

1. binutils-2.14.90.0.1.tar.gz. Source code.
2. binutils-2.13.90.0.18-2.14.90.0.1.diff.gz. Patch against the
   previous beta source code.
3. binutils-2.14.90.0.1-1.i386.rpm. IA-32 binary RPM for RedHat 9.

There is no separate source rpm. You can do

# rpm -ta binutils-2.14.90.0.1.tar.gz

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://ftp.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
05/05/2003
