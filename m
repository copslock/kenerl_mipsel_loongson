Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 02:07:00 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:64924 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022967AbXG3BG6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2007 02:06:58 +0100
Received: (qmail 23951 invoked by uid 511); 30 Jul 2007 01:11:37 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 30 Jul 2007 01:11:37 -0000
From:	Songmao Tian <tiansm@lemote.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS]Remove unneeded header file
Date:	Mon, 30 Jul 2007 09:06:45 +0800
Message-Id: <11857576051105-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.2
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 arch/mips/lemote/lm2e/prom.c  |    4 ----
 arch/mips/lemote/lm2e/setup.c |   10 ----------
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/mips/lemote/lm2e/prom.c b/arch/mips/lemote/lm2e/prom.c
index 535674e..323bd93 100644
--- a/arch/mips/lemote/lm2e/prom.c
+++ b/arch/mips/lemote/lm2e/prom.c
@@ -15,11 +15,7 @@
  * option) any later version.
  */
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
 #include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 extern unsigned long bus_clock;
diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
index c043c9c..0d74315 100644
--- a/arch/mips/lemote/lm2e/setup.c
+++ b/arch/mips/lemote/lm2e/setup.c
@@ -28,17 +28,7 @@
  */
 #include <linux/bootmem.h>
 #include <linux/init.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/mc146818rtc.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/tty.h>
-#include <linux/types.h>
 
 #include <asm/bootinfo.h>
 #include <asm/mc146818-time.h>
-- 
1.5.2.2
