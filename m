Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2004 11:49:11 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:26044 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224985AbUCWLtI>; Tue, 23 Mar 2004 11:49:08 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 75C204AC6E; Tue, 23 Mar 2004 12:49:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 60579478CD; Tue, 23 Mar 2004 12:49:02 +0100 (CET)
Date: Tue, 23 Mar 2004 12:49:02 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kumba <kumba@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
In-Reply-To: <Pine.LNX.4.55.0403180141400.14525@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.55.0403221255200.6539@jurand.ds.pg.gda.pl>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org>
 <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org>
 <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl> <4058E89B.3010208@gentoo.org>
 <Pine.LNX.4.55.0403180141400.14525@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Mar 2004, Maciej W. Rozycki wrote:

>  Essentially all platforms that currently set the address to something
> that's not aligned to a 64kB boundry.  I'd like binutils to be fixed
> instead, though -- I'll try to track the problem down and cook a patch
> before 2.15.  I think the problem may be considered serious enough the
> release may even be deferred for a few days if necessary (since I believe
> it's quite close).

 After a study of the relevant BFD code, I'm now pretty sure it does its
job right -- the .text section which is placed at a fixed offset by the
linker script only imposes an alignment of 4 and the 64kB alignment is
required by the segment the section is placed in.  So BFD does the right 
job by lowering the segment's VMA so that the .text section is placed at 
the requested offset.

 What's important, segment alignment happens under the assumption a binary 
will be used in a paged environment.  This is not normally the case with a 
MIPS Linux kernel, so I think the right solution is to ask the linker not 
to do page aligning using the "-n" option.  Here's a patch that should do 
that.

 Ralf, OK to apply this?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.25-20040322-nmagic-0
diff -up --recursive --new-file linux-mips-2.4.25-20040322.macro/arch/mips/Makefile linux-mips-2.4.25-20040322/arch/mips/Makefile
--- linux-mips-2.4.25-20040322.macro/arch/mips/Makefile	2004-03-11 03:57:07.000000000 +0000
+++ linux-mips-2.4.25-20040322/arch/mips/Makefile	2004-03-23 11:45:26.000000000 +0000
@@ -46,7 +46,7 @@ check_gcc = $(shell if $(CC) $(1) -S -o 
 GCCFLAGS	:= -I $(TOPDIR)/include/asm/gcc
 GCCFLAGS	+= -G 0 -mno-abicalls -fno-pic -pipe
 GCCFLAGS	+= $(call check_gcc, -finline-limit=100000,)
-LINKFLAGS	+= -G 0 -static # -N
+LINKFLAGS	+= -G 0 -static -n
 MODFLAGS	+= -mlong-calls
 
 ifdef CONFIG_DEBUG_INFO
diff -up --recursive --new-file linux-mips-2.4.25-20040322.macro/arch/mips64/Makefile linux-mips-2.4.25-20040322/arch/mips64/Makefile
--- linux-mips-2.4.25-20040322.macro/arch/mips64/Makefile	2004-01-03 03:56:46.000000000 +0000
+++ linux-mips-2.4.25-20040322/arch/mips64/Makefile	2004-03-23 11:45:39.000000000 +0000
@@ -39,7 +39,7 @@ endif
 GCCFLAGS	:= -I $(TOPDIR)/include/asm/gcc
 GCCFLAGS	+= -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe
 GCCFLAGS	+= $(call check_gcc, -finline-limit=100000,)
-LINKFLAGS	+= -G 0 -static # -N
+LINKFLAGS	+= -G 0 -static -n
 MODFLAGS	+= -mlong-calls
 
 ifdef CONFIG_DEBUG_INFO
