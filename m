Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:34:52 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225297AbSLWLeb>; Mon, 23 Dec 2002 11:34:31 +0000
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17033 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S868808AbSLUS6U>; Sat, 21 Dec 2002 19:58:20 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA07618;
	Sat, 21 Dec 2002 19:55:04 +0100 (MET)
Date: Sat, 21 Dec 2002 19:55:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
In-Reply-To: <m2ptrwg2zr.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021221194520.7158B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 20 Dec 2002, Juan Quintela wrote:

> ralf> Applied slightly modified.  I removed two other unused targets.
> 
> Please, add that back, and things will indeed compile :)

 Ralf did that right -- it's annoying to have the COFF image for mips64
built in the mips tree.  Unlike the intermediate object files, this target
is visible to a non-developer.  But a few bits are missing, indeed.  How
about the following patch?  It's a trivial modification of what I use for
about half a year now.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021220-mips64-ecoff-0
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021220.macro/arch/mips64/boot/Makefile linux-mips-2.4.20-pre6-20021220/arch/mips64/boot/Makefile
--- linux-mips-2.4.20-pre6-20021220.macro/arch/mips64/boot/Makefile	2002-06-26 03:04:47.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021220/arch/mips64/boot/Makefile	2002-12-21 14:23:32.000000000 +0000
@@ -22,11 +22,11 @@ all: vmlinux.ecoff addinitrd
 vmlinux.ecoff:	$(CONFIGURE) elf2ecoff $(TOPDIR)/vmlinux
 	./elf2ecoff $(TOPDIR)/vmlinux vmlinux.ecoff $(E2EFLAGS)
 
-elf2ecoff: elf2ecoff.c
-	$(HOSTCC) -o $@ $^
+elf2ecoff: $(TOPDIR)/arch/mips/boot/elf2ecoff.c
+	$(HOSTCC) -I$(TOPDIR)/arch/mips/boot -I- -o $@ $^
 
-addinitrd: addinitrd.c
-	$(HOSTCC) -o $@ $^
+addinitrd: $(TOPDIR)/arch/mips/boot/addinitrd.c
+	$(HOSTCC) -I$(TOPDIR)/arch/mips/boot -I- -o $@ $^
 
 # Don't build dependencies, this may die if $(CC) isn't gcc
 dep:
