Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2007 15:08:44 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40452 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022711AbXE2OIn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 May 2007 15:08:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 880FBE1C88;
	Tue, 29 May 2007 16:08:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhaP85S1JNYC; Tue, 29 May 2007 16:08:01 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 14965E1C63;
	Tue, 29 May 2007 16:08:01 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l4TE8CA8004364;
	Tue, 29 May 2007 16:08:12 +0200
Date:	Tue, 29 May 2007 15:08:07 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] No I/O ports on the DECstation
Message-ID: <Pine.LNX.4.64N.0705291505370.14456@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.2/3323/Tue May 29 14:10:43 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 There are no I/O ports on the DECstation whatsoever in any configuration 
as neither the CPU nor the peripheral buses used have a concept of such.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.21-20070502-dec-no_ioport-0
diff -up --recursive --new-file linux-mips-2.6.21-20070502.macro/arch/mips/Kconfig linux-mips-2.6.21-20070502/arch/mips/Kconfig
--- linux-mips-2.6.21-20070502.macro/arch/mips/Kconfig	2007-05-02 04:55:32.000000000 +0000
+++ linux-mips-2.6.21-20070502/arch/mips/Kconfig	2007-05-27 22:19:35.000000000 +0000
@@ -177,6 +177,7 @@ config MACH_DECSTATION
 	bool "DECstations"
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
+	select NO_IOPORT
 	select SYS_HAS_EARLY_PRINTK
 	select IRQ_CPU
 	select SYS_HAS_CPU_R3000
@@ -943,6 +944,9 @@ config MIPS_NILE4
 config MIPS_DISABLE_OBSOLETE_IDE
 	bool
 
+config NO_IOPORT
+	def_bool n
+
 config GENERIC_ISA_DMA_SUPPORT_BROKEN
 	bool
 
