Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 12:56:32 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:39324 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDNL4b>; Mon, 14 Apr 2003 12:56:31 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA25085;
	Mon, 14 Apr 2003 13:57:02 +0200 (MET DST)
Date: Mon, 14 Apr 2003 13:57:01 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>,
	Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030413152226.GB1968@excalibur.cologne.de>
Message-ID: <Pine.GSO.3.96.1030414134631.24742A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 13 Apr 2003, Karsten Merker wrote:

> > Modified files:
> > 	drivers/char   : Tag: linux_2_4 dz.c 
> > 	drivers/tc     : Tag: linux_2_4 zs.c 
> > 
> > Log message:
> > 	Set .owner in case the code gets modularized.  Patch by Hanna Linder.
> 
> I guess something went wrong here. Maciej, you are trying to set a field
> "owner" in a struct tty_driver, which does not have an "owner" field.
> This results in dz.c and zs.c not compiling.

 Yep, I noticed it yesterday -- the fix should have been applied to 2.5
only.  I'm committing a reversion immediately. 

> uses current_cpu_data instead of mips_cpu but does not define it. To get
> them defined, inclusion of <asm/processor.h> and <linux/smp.h> is needed.

 I find it bogus to include <linux/smp.h> in code that has no slightest
possibility to ever meet an SMP configuration.  I think <asm/processor.h>
should be fixed instead.

 Following is a fix -- Ralf, I hope that's OK.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-pre4-20030411-dec-cpu_data-1
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/dec/prom/init.c linux-mips-2.4.21-pre4-20030411/arch/mips/dec/prom/init.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/dec/prom/init.c	2003-04-07 02:56:23.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/dec/prom/init.c	2003-04-13 19:40:03.000000000 +0000
@@ -10,6 +10,8 @@
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/processor.h>
+
 #include <asm/dec/prom.h>
 
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips/processor.h linux-mips-2.4.21-pre4-20030411/include/asm-mips/processor.h
--- linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips/processor.h	2003-04-10 02:57:34.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/include/asm-mips/processor.h	2003-04-13 19:52:53.000000000 +0000
@@ -22,7 +22,9 @@
 #define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
 #ifndef __ASSEMBLY__
+#include <linux/smp.h>
 #include <linux/threads.h>
+
 #include <asm/cachectl.h>
 #include <asm/mipsregs.h>
 #include <asm/reg.h>
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips64/processor.h linux-mips-2.4.21-pre4-20030411/include/asm-mips64/processor.h
--- linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips64/processor.h	2003-04-13 18:48:34.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/include/asm-mips64/processor.h	2003-04-13 19:52:10.000000000 +0000
@@ -31,6 +31,8 @@
 })
 
 #ifndef __ASSEMBLY__
+#include <linux/smp.h>
+
 #include <asm/cachectl.h>
 #include <asm/mipsregs.h>
 #include <asm/reg.h>
