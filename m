Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2003 01:12:06 +0100 (BST)
Received: from harrier.mail.pas.earthlink.net ([IPv6:::ffff:207.217.120.12]:39678
	"EHLO harrier.mail.pas.earthlink.net") by linux-mips.org with ESMTP
	id <S8225396AbTINAMD>; Sun, 14 Sep 2003 01:12:03 +0100
Received: from user-38ld2mo.dsl.mindspring.com ([209.86.138.216] helo=earthlink.net)
	by harrier.mail.pas.earthlink.net with smtp (Exim 3.33 #1)
	id 19yKUe-0003EI-00
	for linux-mips@linux-mips.org; Sat, 13 Sep 2003 17:11:57 -0700
Date: Sat, 13 Sep 2003 20:14:53 -0400
To: linux-mips@linux-mips.org
Subject: [PATCH] version.h cleanup of arch/mips
Message-ID: <20030914001453.GA27609@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Return-Path: <rwhron@earthlink.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rwhron@earthlink.net
Precedence: bulk
X-list: linux-mips

version.h is included in some files that don't need it.
Removing the unnessary includes prevents extra compiles when
version.h changes.  Patch against 2.6.0-test5-bk3.



diff -Nur linux-2.6.0-test5-bk3/arch/mips/galileo-boards/ev64120/setup.c linux/arch/mips/galileo-boards/ev64120/setup.c
--- linux-2.6.0-test5-bk3/arch/mips/galileo-boards/ev64120/setup.c	2003-07-02 18:42:32.000000000 -0400
+++ linux/arch/mips/galileo-boards/ev64120/setup.c	2003-09-13 20:08:52.000000000 -0400
@@ -39,7 +39,6 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/timex.h>
-#include <linux/version.h>
 
 #include <asm/bootinfo.h>
 #include <asm/page.h>
diff -Nur linux-2.6.0-test5-bk3/arch/mips/gt64120/momenco_ocelot/setup.c linux/arch/mips/gt64120/momenco_ocelot/setup.c
--- linux-2.6.0-test5-bk3/arch/mips/gt64120/momenco_ocelot/setup.c	2003-08-09 06:09:57.000000000 -0400
+++ linux/arch/mips/gt64120/momenco_ocelot/setup.c	2003-09-13 20:08:50.000000000 -0400
@@ -60,7 +60,6 @@
 #include <asm/reboot.h>
 #include <asm/mc146818rtc.h>
 #include <asm/traps.h>
-#include <linux/version.h>
 #include <linux/bootmem.h>
 #include <linux/initrd.h>
 #include <asm/gt64120/gt64120.h>
diff -Nur linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_c/pci-irq.c linux/arch/mips/momentum/ocelot_c/pci-irq.c
--- linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_c/pci-irq.c	2003-07-02 18:42:32.000000000 -0400
+++ linux/arch/mips/momentum/ocelot_c/pci-irq.c	2003-09-13 20:08:55.000000000 -0400
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <asm/pci.h>
 
diff -Nur linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_c/setup.c linux/arch/mips/momentum/ocelot_c/setup.c
--- linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_c/setup.c	2003-07-27 14:39:59.000000000 -0400
+++ linux/arch/mips/momentum/ocelot_c/setup.c	2003-09-13 20:08:58.000000000 -0400
@@ -61,7 +61,6 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/mc146818rtc.h>
-#include <linux/version.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #include <asm/mv64340.h>
diff -Nur linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_g/pci-irq.c linux/arch/mips/momentum/ocelot_g/pci-irq.c
--- linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_g/pci-irq.c	2003-07-02 18:42:32.000000000 -0400
+++ linux/arch/mips/momentum/ocelot_g/pci-irq.c	2003-09-13 20:09:00.000000000 -0400
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <asm/pci.h>
 
diff -Nur linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_g/setup.c linux/arch/mips/momentum/ocelot_g/setup.c
--- linux-2.6.0-test5-bk3/arch/mips/momentum/ocelot_g/setup.c	2003-07-27 14:39:59.000000000 -0400
+++ linux/arch/mips/momentum/ocelot_g/setup.c	2003-09-13 20:09:04.000000000 -0400
@@ -62,7 +62,6 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/mc146818rtc.h>
-#include <linux/version.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #include "gt64240.h"
diff -Nur linux-2.6.0-test5-bk3/arch/mips/pci/fixup-ocelot.c linux/arch/mips/pci/fixup-ocelot.c
--- linux-2.6.0-test5-bk3/arch/mips/pci/fixup-ocelot.c	2003-07-02 18:42:32.000000000 -0400
+++ linux/arch/mips/pci/fixup-ocelot.c	2003-09-13 20:09:07.000000000 -0400
@@ -13,7 +13,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <asm/pci.h>
 
diff -Nur linux-2.6.0-test5-bk3/arch/mips/pci/ops-ev64120.c linux/arch/mips/pci/ops-ev64120.c
--- linux-2.6.0-test5-bk3/arch/mips/pci/ops-ev64120.c	2003-08-09 06:09:58.000000000 -0400
+++ linux/arch/mips/pci/ops-ev64120.c	2003-09-13 20:09:11.000000000 -0400
@@ -36,7 +36,6 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <asm/pci.h>
 #include <asm/io.h>
 #include <asm/galileo-boards/ev64120.h>
diff -Nur linux-2.6.0-test5-bk3/arch/mips/pci/ops-ocelot.c linux/arch/mips/pci/ops-ocelot.c
--- linux-2.6.0-test5-bk3/arch/mips/pci/ops-ocelot.c	2003-08-09 06:09:58.000000000 -0400
+++ linux/arch/mips/pci/ops-ocelot.c	2003-09-13 20:09:13.000000000 -0400
@@ -39,7 +39,6 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/cache.h>
 #include <asm/pci.h>
 #include <asm/io.h>
diff -Nur linux-2.6.0-test5-bk3/arch/mips/pci/pci-ocelot-c.c linux/arch/mips/pci/pci-ocelot-c.c
--- linux-2.6.0-test5-bk3/arch/mips/pci/pci-ocelot-c.c	2003-08-09 06:09:58.000000000 -0400
+++ linux/arch/mips/pci/pci-ocelot-c.c	2003-09-13 20:09:16.000000000 -0400
@@ -26,7 +26,6 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <asm/pci.h>
 #include <asm/io.h>
 #include <asm/mv64340.h>
diff -Nur linux-2.6.0-test5-bk3/arch/mips/pci/pci-ocelot-g.c linux/arch/mips/pci/pci-ocelot-g.c
--- linux-2.6.0-test5-bk3/arch/mips/pci/pci-ocelot-g.c	2003-08-09 06:09:58.000000000 -0400
+++ linux/arch/mips/pci/pci-ocelot-g.c	2003-09-13 20:09:19.000000000 -0400
@@ -26,7 +26,6 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <asm/pci.h>
 #include <asm/io.h>
 #include "gt64240.h"
diff -Nur linux-2.6.0-test5-bk3/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
--- linux-2.6.0-test5-bk3/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2003-09-08 20:00:37.000000000 -0400
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2003-09-13 20:09:27.000000000 -0400
@@ -132,7 +132,6 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
-#include <linux/version.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #ifdef CONFIG_RTC_DS1742
diff -Nur linux-2.6.0-test5-bk3/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
--- linux-2.6.0-test5-bk3/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2003-07-27 14:39:59.000000000 -0400
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2003-09-13 20:09:23.000000000 -0400
@@ -60,7 +60,6 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
-#include <linux/version.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #include <linux/console.h>


-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html
