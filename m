Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 20:33:59 +0200 (CEST)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:62406 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492775Ab0DNSdy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Apr 2010 20:33:54 +0200
Received: by bwz26 with SMTP id 26so498708bwz.27
        for <linux-mips@linux-mips.org>; Wed, 14 Apr 2010 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=K07UjI/AZ6pJ7ZvtfSqByXzOmAq8W/Z935qBVz+Nwvs=;
        b=NUVlldRhQ7QsXSIFUAXEvsq6gV76Pq5mLUlik9noSCmj8Sl2GCJSiXvj8MueTKoFCv
         g3mXWj2iSWRYcu39snJPkxRsyPToOVRKcQXw6Uv9Ljr0OFBTetyW3zgHk8PQ2qFhQefO
         aEec/d5Ry+eLMjJM0TY/i6Z+GPjxEQYnuXphg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CG6oOJ0TK7p+8I3MGn5h5meONekUJFZroYJIPJAVmIUajaVMBNmMBPzP/nsLJu8j5f
         cZ7jOYMCIn6s27D1eUQ6kvdOHnh6PVBIa5po3ACuUTSR65HRdNxMFVMeMV4Y81UVSw3t
         uDJUBSOjAFu8giYcSUql8Dzyk8YsH7t5Y7Nno=
Received: by 10.204.22.79 with SMTP id m15mr285385bkb.80.1271270027192;
        Wed, 14 Apr 2010 11:33:47 -0700 (PDT)
Received: from localhost.localdomain (p5496CD44.dip.t-dialin.net [84.150.205.68])
        by mx.google.com with ESMTPS id 14sm642696bwz.2.2010.04.14.11.33.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 11:33:46 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: add sysdev for DBDMA PM.
Date:   Wed, 14 Apr 2010 20:33:44 +0200
Message-Id: <1271270024-26684-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Add a sysdev for DBDMA PM.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested on DB1200; no changes since yesterday.  It works as intended
and per-channel sysdevs seem like overdoing it.

 arch/mips/alchemy/common/dbdma.c                 |  101 +++++++++++++++------
 arch/mips/alchemy/common/power.c                 |   11 ---
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    4 -
 3 files changed, 72 insertions(+), 44 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 99ae84c..ca0506a 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/sysdev.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 
@@ -174,10 +175,6 @@ static dbdev_tab_t dbdev_tab[] = {
 
 #define DBDEV_TAB_SIZE	ARRAY_SIZE(dbdev_tab)
 
-#ifdef CONFIG_PM
-static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][6];
-#endif
-
 
 static chan_tab_t *chan_tab_ptr[NUM_DBDMA_CHANS];
 
@@ -960,29 +957,37 @@ u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr)
 	return nbytes;
 }
 
-#ifdef CONFIG_PM
-void au1xxx_dbdma_suspend(void)
+
+struct alchemy_dbdma_sysdev {
+	struct sys_device sysdev;
+	u32 pm_regs[NUM_DBDMA_CHANS + 1][6];
+};
+
+static int alchemy_dbdma_suspend(struct sys_device *dev,
+				 pm_message_t state)
 {
+	struct alchemy_dbdma_sysdev *sdev =
+		container_of(dev, struct alchemy_dbdma_sysdev, sysdev);
 	int i;
 	u32 addr;
 
 	addr = DDMA_GLOBAL_BASE;
-	au1xxx_dbdma_pm_regs[0][0] = au_readl(addr + 0x00);
-	au1xxx_dbdma_pm_regs[0][1] = au_readl(addr + 0x04);
-	au1xxx_dbdma_pm_regs[0][2] = au_readl(addr + 0x08);
-	au1xxx_dbdma_pm_regs[0][3] = au_readl(addr + 0x0c);
+	sdev->pm_regs[0][0] = au_readl(addr + 0x00);
+	sdev->pm_regs[0][1] = au_readl(addr + 0x04);
+	sdev->pm_regs[0][2] = au_readl(addr + 0x08);
+	sdev->pm_regs[0][3] = au_readl(addr + 0x0c);
 
 	/* save channel configurations */
 	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
-		au1xxx_dbdma_pm_regs[i][0] = au_readl(addr + 0x00);
-		au1xxx_dbdma_pm_regs[i][1] = au_readl(addr + 0x04);
-		au1xxx_dbdma_pm_regs[i][2] = au_readl(addr + 0x08);
-		au1xxx_dbdma_pm_regs[i][3] = au_readl(addr + 0x0c);
-		au1xxx_dbdma_pm_regs[i][4] = au_readl(addr + 0x10);
-		au1xxx_dbdma_pm_regs[i][5] = au_readl(addr + 0x14);
+		sdev->pm_regs[i][0] = au_readl(addr + 0x00);
+		sdev->pm_regs[i][1] = au_readl(addr + 0x04);
+		sdev->pm_regs[i][2] = au_readl(addr + 0x08);
+		sdev->pm_regs[i][3] = au_readl(addr + 0x0c);
+		sdev->pm_regs[i][4] = au_readl(addr + 0x10);
+		sdev->pm_regs[i][5] = au_readl(addr + 0x14);
 
 		/* halt channel */
-		au_writel(au1xxx_dbdma_pm_regs[i][0] & ~1, addr + 0x00);
+		au_writel(sdev->pm_regs[i][0] & ~1, addr + 0x00);
 		au_sync();
 		while (!(au_readl(addr + 0x14) & 1))
 			au_sync();
@@ -992,32 +997,65 @@ void au1xxx_dbdma_suspend(void)
 	/* disable channel interrupts */
 	au_writel(0, DDMA_GLOBAL_BASE + 0x0c);
 	au_sync();
+
+	return 0;
 }
 
-void au1xxx_dbdma_resume(void)
+static int alchemy_dbdma_resume(struct sys_device *dev)
 {
+	struct alchemy_dbdma_sysdev *sdev =
+		container_of(dev, struct alchemy_dbdma_sysdev, sysdev);
 	int i;
 	u32 addr;
 
 	addr = DDMA_GLOBAL_BASE;
-	au_writel(au1xxx_dbdma_pm_regs[0][0], addr + 0x00);
-	au_writel(au1xxx_dbdma_pm_regs[0][1], addr + 0x04);
-	au_writel(au1xxx_dbdma_pm_regs[0][2], addr + 0x08);
-	au_writel(au1xxx_dbdma_pm_regs[0][3], addr + 0x0c);
+	au_writel(sdev->pm_regs[0][0], addr + 0x00);
+	au_writel(sdev->pm_regs[0][1], addr + 0x04);
+	au_writel(sdev->pm_regs[0][2], addr + 0x08);
+	au_writel(sdev->pm_regs[0][3], addr + 0x0c);
 
 	/* restore channel configurations */
 	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
-		au_writel(au1xxx_dbdma_pm_regs[i][0], addr + 0x00);
-		au_writel(au1xxx_dbdma_pm_regs[i][1], addr + 0x04);
-		au_writel(au1xxx_dbdma_pm_regs[i][2], addr + 0x08);
-		au_writel(au1xxx_dbdma_pm_regs[i][3], addr + 0x0c);
-		au_writel(au1xxx_dbdma_pm_regs[i][4], addr + 0x10);
-		au_writel(au1xxx_dbdma_pm_regs[i][5], addr + 0x14);
+		au_writel(sdev->pm_regs[i][0], addr + 0x00);
+		au_writel(sdev->pm_regs[i][1], addr + 0x04);
+		au_writel(sdev->pm_regs[i][2], addr + 0x08);
+		au_writel(sdev->pm_regs[i][3], addr + 0x0c);
+		au_writel(sdev->pm_regs[i][4], addr + 0x10);
+		au_writel(sdev->pm_regs[i][5], addr + 0x14);
 		au_sync();
 		addr += 0x100;	/* next channel base */
 	}
+
+	return 0;
+}
+
+static struct sysdev_class alchemy_dbdma_sysdev_class = {
+	.name		= "dbdma",
+	.suspend	= alchemy_dbdma_suspend,
+	.resume		= alchemy_dbdma_resume,
+};
+
+static int __init alchemy_dbdma_sysdev_init(void)
+{
+	struct alchemy_dbdma_sysdev *sdev;
+	int ret;
+
+	ret = sysdev_class_register(&alchemy_dbdma_sysdev_class);
+	if (ret)
+		return ret;
+
+	sdev = kzalloc(sizeof(struct alchemy_dbdma_sysdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	sdev->sysdev.id = -1;
+	sdev->sysdev.cls = &alchemy_dbdma_sysdev_class;
+	ret = sysdev_register(&sdev->sysdev);
+	if (ret)
+		kfree(sdev);
+
+	return ret;
 }
-#endif	/* CONFIG_PM */
 
 static int __init au1xxx_dbdma_init(void)
 {
@@ -1046,6 +1084,11 @@ static int __init au1xxx_dbdma_init(void)
 	else {
 		dbdma_initialized = 1;
 		printk(KERN_INFO "Alchemy DBDMA initialized\n");
+		ret = alchemy_dbdma_sysdev_init();
+		if (ret) {
+			printk(KERN_ERR "DBDMA PM init failed\n");
+			ret = 0;
+		}
 	}
 
 	return ret;
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index e097094..5ef06a1 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -36,9 +36,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/mach-au1x00/au1000.h>
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-#endif
 
 #ifdef CONFIG_PM
 
@@ -129,10 +126,6 @@ static void save_core_regs(void)
 	sleep_static_memctlr[3][0] = au_readl(MEM_STCFG3);
 	sleep_static_memctlr[3][1] = au_readl(MEM_STTIME3);
 	sleep_static_memctlr[3][2] = au_readl(MEM_STADDR3);
-
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-	au1xxx_dbdma_suspend();
-#endif
 }
 
 static void restore_core_regs(void)
@@ -196,10 +189,6 @@ static void restore_core_regs(void)
 		au_writel(sleep_uart0_linectl, UART0_ADDR + UART_LCR); au_sync();
 		au_writel(sleep_uart0_clkdiv, UART0_ADDR + UART_CLK); au_sync();
 	}
-
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-	au1xxx_dbdma_resume();
-#endif
 }
 
 void au_sleep(void)
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index 8c6b110..c8a553a 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -358,10 +358,6 @@ u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr);
 u32 au1xxx_ddma_add_device(dbdev_tab_t *dev);
 extern void au1xxx_ddma_del_device(u32 devid);
 void *au1xxx_ddma_get_nextptr_virt(au1x_ddma_desc_t *dp);
-#ifdef CONFIG_PM
-void au1xxx_dbdma_suspend(void);
-void au1xxx_dbdma_resume(void);
-#endif
 
 /*
  *	Flags for the put_source/put_dest functions.
-- 
1.7.0.4
