Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 21:28:31 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:59056 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045650AbXJSU2X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 21:28:23 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id F2EC5400D5;
	Fri, 19 Oct 2007 22:28:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id gtvCmAmUsV16; Fri, 19 Oct 2007 22:28:18 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A374E400A4;
	Fri, 19 Oct 2007 22:28:18 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JKSOTD023686;
	Fri, 19 Oct 2007 22:28:24 +0200
Date:	Fri, 19 Oct 2007 21:28:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: Add and reorder inclusions, remove unneeded ones
Message-ID: <Pine.LNX.4.64N.0710192125470.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Sort the header inclusions, add a few that are needed but pulled 
indirectly only and remove ones that are not really used.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a 
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.18-20060920-dz-include-4
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c linux-mips-2.6.18-20060920/drivers/serial/dz.c
--- linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c	2006-11-23 05:17:01.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/serial/dz.c	2007-01-15 02:09:38.000000000 +0000
@@ -6,7 +6,7 @@
  *
  * Email: olivier.lebaillif@ifrsys.com
  *
- * Copyright (C) 2004, 2006  Maciej W. Rozycki
+ * Copyright (C) 2004, 2006, 2007  Maciej W. Rozycki
  *
  * [31-AUG-98] triemer
  * Changed IRQ to use Harald's dec internals interrupts.h
@@ -32,26 +32,29 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
+#include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/console.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/module.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
 
 #include <asm/bootinfo.h>
+#include <asm/system.h>
+
 #include <asm/dec/interrupts.h>
 #include <asm/dec/kn01.h>
 #include <asm/dec/kn02.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/prom.h>
-#include <asm/irq.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
 
 #include "dz.h"
 
