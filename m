Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2003 16:06:09 +0100 (BST)
Received: from sccrmhc02.attbi.com ([IPv6:::ffff:204.127.202.62]:17911 "EHLO
	sccrmhc02.attbi.com") by linux-mips.org with ESMTP
	id <S8225225AbTEPPGE>; Fri, 16 May 2003 16:06:04 +0100
Received: from lucon.org (12-234-88-5.client.attbi.com[12.234.88.5])
          by attbi.com (sccrmhc02) with ESMTP
          id <2003051615055000200ha7jte>; Fri, 16 May 2003 15:05:50 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id D783F2C681; Fri, 16 May 2003 08:05:44 -0700 (PDT)
Date: Fri, 16 May 2003 08:05:44 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-gcc@vger.kernel.org, gcc@gcc.gnu.org,
	GNU C Library <libc-alpha@sources.redhat.com>,
	Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ron Guilmette <rfg@monkeys.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>,
	Leonard Zubkoff <lnz@dandelion.com>,
	"Steven J. Hill" <sjhill@cotw.com>
Subject: The Linux binutils 2.14.90.0.2 is released
Message-ID: <20030516080544.A30912@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.14.90.0.2 for Linux, which is
based on binutils 2003 0515 in CVS on sourecs.redhat.com plus various
changes. It is purely for Linux.

Please report any bugs related to binutils 2.14.90.0.2 to hjl@lucon.org.

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

1. binutils-2.14.90.0.2.tar.gz. Source code.
2. binutils-2.14.90.0.1-2.14.90.0.2.diff.gz. Patch against the
   previous beta source code.
3. binutils-2.14.90.0.2-1.i386.rpm. IA-32 binary RPM for RedHat 9.
4. binutils-2.14.90.0.2-1.ia64.rpm. IA-64 binary RPM for RedHat AS 2.1.

There is no separate source rpm. You can do

# rpm -ta binutils-2.14.90.0.2.tar.gz

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://ftp.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
05/16/2003
