Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2010 22:54:37 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:38838 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab0CYVyd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Mar 2010 22:54:33 +0100
Received: by bwz7 with SMTP id 7so3701755bwz.24
        for <linux-mips@linux-mips.org>; Thu, 25 Mar 2010 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=U6AzHWBBdohWt4VFX8vqRf7coVUSr1h7r19ko7tjRUw=;
        b=lmWKriDYfUTscRc/AeyM1VJg2R2tGdqcYtKkY0PjG+Xd3Tq6S+ni0FDDqVeqY56nRS
         fZ7t9iaDwNX+JYrzVupcDJEZ/SqP/aUAxQV9LifJkLAcG/1TEb3+r9alYaQZkY3LCj7e
         h/ggjheVR6QWhwQm2z9qbXksuYIDCKH+SgzT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=efGBK3Omys/4ykNfnbwOt9wcJn0JcWerTqCr8yPhRPloMrTraMKLA0SBUGHPB5JoQE
         R5cohP7jAn5UZM/ksiuAo10pgLxBZZRBobUuGSdpMPp76/+TxlaFFuuhdrwlvwHsb6dj
         9MdVj6edVtgW37UHq1a3m9fcPV6+wODu7IyFk=
Received: by 10.204.136.156 with SMTP id r28mr327987bkt.112.1269554067553;
        Thu, 25 Mar 2010 14:54:27 -0700 (PDT)
Received: from localhost.localdomain (p5496DF61.dip.t-dialin.net [84.150.223.97])
        by mx.google.com with ESMTPS id 16sm177394bwz.5.2010.03.25.14.54.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 14:54:27 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: fix up residual devboard poweroff/reboot code.
Date:   Thu, 25 Mar 2010 22:55:38 +0100
Message-Id: <1269554138-4620-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Clean out stray unused board_reset() calls in pb1x boards,
the pb1000 is different from the rest and gets private methods.

(Cleanup after 32fd6901a6d8d19f94e4de6be4e4b552ab078620)

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: fix formatting as pointed out by Sergei

 arch/mips/alchemy/devboards/pb1000/board_setup.c |   16 +++++++++++++++-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    5 -----
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    6 ------
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    5 -----
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    5 -----
 5 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index b5311d8..4ef50d8 100644
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
+	_machine_halt = board_power_off;
+	_machine_restart = board_reset;
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
