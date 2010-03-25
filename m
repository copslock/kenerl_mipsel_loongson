Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2010 19:36:08 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.159]:19447 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492288Ab0CYSgF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Mar 2010 19:36:05 +0100
Received: by fg-out-1718.google.com with SMTP id 19so1922093fgg.6
        for <linux-mips@linux-mips.org>; Thu, 25 Mar 2010 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=y6mf+2XkzYvrqEfIkzGv/gd968K1s2PxSmCMb0pm+KA=;
        b=j/WIaXhbOkgvUkfa+RMPbOYbkVfz15gnrHakb94Xo/TBRhWq0v0l+JgUKECIEvYh18
         t5S1mG4ldzO+uoLSeJgeCs1WN4mYAgBKviUoMQHG8EBnVVZKeux7ZUenROal5OWW6PdK
         GtkQGKENFVB5hBdL1CYvoNcb3GJEDPvD0UtSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dhXCL+w6c1Jkxtj5Qr4AyiGzOE87jShaDrj/7nb+cP6YemUin5UvQBray2l8leuFCO
         bc+TBzB15/HPX3JAjePHl4JPMIVsWq4XKlp5CSWEkAeJxMQzP3KXrBkx1NB9rl/IFNpO
         dB4c8L9kAGw/aI07d5UsnMXDjxkUOfDL1DdZs=
Received: by 10.87.58.1 with SMTP id l1mr2439579fgk.75.1269542164236;
        Thu, 25 Mar 2010 11:36:04 -0700 (PDT)
Received: from localhost.localdomain (p5496DF61.dip.t-dialin.net [84.150.223.97])
        by mx.google.com with ESMTPS id l12sm3236388fgb.17.2010.03.25.11.36.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 11:36:03 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix up residual devboard poweroff/reboot code.
Date:   Thu, 25 Mar 2010 19:37:17 +0100
Message-Id: <1269542237-16617-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Clean out stray unused board_reset() calls in pb1x boards,
the pb1000 is different from the rest and gets private methods.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   16 +++++++++++++++-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    5 -----
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    6 ------
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    5 -----
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    5 -----
 5 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index b5311d8..9fa532c 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -27,8 +27,10 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1000.h>
+#include <asm/reboot.h>
 #include <prom.h>
 
 #include "../platform.h"
@@ -38,8 +40,16 @@ const char *get_system_type(void)
 	return "Alchemy Pb1000";
 }
 
-void board_reset(void)
+static void board_reset(char *c)
 {
+	asm volatile ("jr %0" : : "r" (0xbfc00000));
+}
+
+static void board_power_off(void)
+{
+	printk(KERN_ALERT "It's now safe to remove power\n");
+	while (1)
+		asm volatile (".set mips3 ; wait ; .set mips1");
 }
 
 void __init board_setup(void)
@@ -177,6 +187,10 @@ void __init board_setup(void)
 		au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
 		break;
 	}
+
+	pm_power_off = board_power_off;
+	 _machine_halt = board_power_off;
+	 _machine_restart = board_reset;
 }
 
 static int __init pb1000_init_irq(void)
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index c7b4caa..90dda5f 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -39,11 +39,6 @@ const char *get_system_type(void)
 	return "Alchemy Pb1100";
 }
 
-void board_reset(void)
-{
-	bcsr_write(BCSR_SYSTEM, 0);
-}
-
 void __init board_setup(void)
 {
 	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index 3184063..8b4466f 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -48,12 +48,6 @@ const char *get_system_type(void)
 	return "Alchemy Pb1200";
 }
 
-void board_reset(void)
-{
-	bcsr_write(BCSR_RESETS, 0);
-	bcsr_write(BCSR_SYSTEM, 0);
-}
-
 void __init board_setup(void)
 {
 	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index fa9770a..9cd9dfa 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -45,11 +45,6 @@ const char *get_system_type(void)
 	return "Alchemy Pb1500";
 }
 
-void board_reset(void)
-{
-	bcsr_write(BCSR_SYSTEM, 0);
-}
-
 void __init board_setup(void)
 {
 	u32 pin_func;
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index 1e8fb3d..9d7d6ed 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -48,11 +48,6 @@ const char *get_system_type(void)
 	return "Alchemy Pb1550";
 }
 
-void board_reset(void)
-{
-	bcsr_write(BCSR_SYSTEM, 0);
-}
-
 void __init board_setup(void)
 {
 	u32 pin_func;
-- 
1.7.0.3
