Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 00:24:11 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.115]:20760 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225239AbTFXXYG>; Wed, 25 Jun 2003 00:24:06 +0100
Received: from lucon.org (12-234-88-5.client.attbi.com [12.234.88.5])
 by mtaout02.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HH00005LE9FSP@mtaout02.icomcast.net>; Tue,
 24 Jun 2003 19:22:47 -0400 (EDT)
Received: by lucon.org (Postfix, from userid 1000)	id 9E2732C4E6; Tue,
 24 Jun 2003 23:22:27 +0000 (UTC)
Date: Tue, 24 Jun 2003 16:22:27 -0700
From: "H. J. Lu" <hjl@lucon.org>
Subject: The Linux binutils 2.14.90.0.4.1 is released
To: linux-gcc@vger.kernel.org
Cc: gcc@gcc.gnu.org, GNU C Library <libc-alpha@sources.redhat.com>,
	Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>,
	"Steven J. Hill" <sjhill@cotw.com>
Message-id: <20030624232227.GA4484@lucon.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

This is the beta release of binutils 2.14.90.0.4.1 for Linux, which is
based on binutils 2003 0523 in CVS on sourecs.redhat.com plus various
changes. It is purely for Linux.

Please report any bugs related to binutils 2.14.90.0.4.1 to hjl@lucon.org.

If you don't use

# rpmbuild -ta binutils-xx.xx.xx.xx.xx.tar.gz

to compile the Linux binutils, please read patches/README in source
tree to apply Linux patches.

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

1. binutils-2.14.90.0.4.1.tar.gz. Source code.
2. binutils-2.14.90.0.4-2.14.90.0.4.1.diff.gz. Patch against the
   previous beta source code.
3. binutils-2.14.90.0.4.1-1.i386.rpm. IA-32 binary RPM for RedHat 9.
4. binutils-2.14.90.0.4.1-1.ia64.rpm. IA-64 binary RPM for RedHat AS 2.1.

There is no separate source rpm. You can do

# rpm -ta binutils-2.14.90.0.4.1.tar.gz

to create both binary and source rpms.

The primary sites for the beta Linux binutils are:

1. http://www.kernel.org/pub/linux/devel/binutils/

Thanks.


H.J. Lu
hjl@lucon.org
06/24/2003
