Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2005 23:40:41 +0100 (BST)
Received: from web31502.mail.mud.yahoo.com ([68.142.198.131]:1190 "HELO
	web31502.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3465584AbVJKWkW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Oct 2005 23:40:22 +0100
Received: (qmail 60211 invoked by uid 60001); 11 Oct 2005 22:40:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fzIa6VklEEodefr+/wYUCMuTZT40M2nhDC+7XDXPQczwiYv350c68p+Bdaffll+bPRO1Cm024+Wm01OrBqdgMakLiwIoWMAk3G62gE2RIs1DiVA3Bjd6V5G3ZyZY5RquVq3Oolg1iCooMnkEv5UhxYpWkxWJJlM3Er3Blk8dlmU=  ;
Message-ID: <20051011224009.60209.qmail@web31502.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31502.mail.mud.yahoo.com via HTTP; Tue, 11 Oct 2005 15:40:09 PDT
Date:	Tue, 11 Oct 2005 15:40:09 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Run into another Linux kernel compile problem
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

I've got a working system for a Broadcom SB1, thanks
to the considerable help (and patches) from here, and
the helpful step-through on Linux From Scratch.
However, I've subsequently run into a problem when
upgrading the kernel, using the version in CVS on the
Linux-MIPS site. (I'm applying the same set of
patches, am using the same .config file, and have not
changed the toolchain. That's next on my list.)

The version in CVS on September 22nd
(linux-2.6.14-rc1-mipscvs-20050922) compiles fine.

The version currently in CVS
(linux-2.6.14-rc1-mipscvs-20051011) crashes out with
the following errors:

make
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/mips/kernel/asm-offsets.s
In file included from include/asm/pgtable.h:19,
                 from include/linux/mm.h:36,
                 from
arch/mips/kernel/asm-offsets.c:15:
include/asm/io.h: In function 'outq':
include/asm/io.h:440: error: size of array 'type name'
is negative
include/asm/io.h: In function 'inq':
include/asm/io.h:440: error: size of array 'type name'
is negative
include/asm/io.h: In function 'outq_p':
include/asm/io.h:440: error: size of array 'type name'
is negative
include/asm/io.h: In function 'inq_p':
include/asm/io.h:440: error: size of array 'type name'
is negative
include/asm/io.h: In function 'mem_outq':
include/asm/io.h:440: error: size of array 'type name'
is negative
include/asm/io.h: In function 'mem_inq':
include/asm/io.h:440: error: size of array 'type name'
is negative
include/asm/io.h: In function 'mem_outq_p':
include/asm/io.h:440: error: size of array 'type name'
is negative
include/asm/io.h: In function 'mem_inq_p':
include/asm/io.h:440: error: size of array 'type name'
is negative
make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

If I delete lines 339-441 - which do a
BUILDIO_IOPORT(q, u64), conditional on it being a
64-bit compile - then the kernel will compile. I do,
however, get the following warnings:

include/asm/io.h: In function 'outsq':
include/asm/io.h:517: warning: implicit declaration of
function 'mem_outq'
include/asm/io.h: In function 'insq':
include/asm/io.h:517: warning: implicit declaration of
function 'mem_inq'

I'm guessing that the BUILDIO_IOPORT() is setting up
these calls, but it's not quite clear to me as to
where.

The only obvious difference in the macro call from any
of the other macros in that group is the use of u64.
Declaring a dummy variable at the start of the header
file of this type does not produce any warnings or
errors, so I'm satisfied that the type definition
exists.

An inspection of the .config file verifies that the
CPU is declared as an SB1, and that it is a 64-bit
kernel build.

Any ideas?



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
