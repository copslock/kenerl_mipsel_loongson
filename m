Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:45:07 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:49543 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491045Ab1EHImg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:36 +0200
Received: by wwb17 with SMTP id 17so3946498wwb.24
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=kJeqd/+DSzUIXKRsvB/e3HALQssnFtetvXhte3QM8/s=;
        b=x8Zes5pJ79QHdqZT+meGyhl4Bm95GS578Cze2JJ0A0PmUrHY/96YV2h73Eb+a5DLoh
         fYKgywDzauf+fNRFLM2mOc/PTi+4BKXRH38DQQrMT/wXVkYxTTP3k/7cOd9/MlAworuA
         jRJbmdpL8BNjl/8WqvdF1jmxa9IfvzOfilfrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ShH386dnHbsNH3Eg2foLY3Sl4rgEUx8785kNlu+cNfMJTRNEWKF9/kDfbk8/I9eDL4
         l9BHSoBElWjVOBcupCRBWHcsu9JkJgUM5QExPoc1D3Vu0cS/LMn/TzJVlKHG/vc1/s8t
         uZqPw102IAeA2xkpe2Qs+w+aoMtcoNgQ3jOR4=
Received: by 10.216.237.155 with SMTP id y27mr1384159weq.82.1304844150390;
        Sun, 08 May 2011 01:42:30 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:30 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 5/9] MIPS: Alchemy: convert dbdma.c to syscore_ops
Date:   Sun,  8 May 2011 10:42:16 +0200
Message-Id: <1304844140-3259-6-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
In-Reply-To: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

convert the PM sysdev to syscore_ops and clean up the ddma addresses
a bit.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/dbdma.c                 |  123 ++++++++--------------
 arch/mips/include/asm/mach-au1x00/au1000.h       |    4 +-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    8 --
 3 files changed, 47 insertions(+), 88 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index ca0506a..3a5abb5 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -36,7 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 
@@ -58,7 +58,8 @@ static DEFINE_SPINLOCK(au1xxx_dbdma_spin_lock);
 /* I couldn't find a macro that did this... */
 #define ALIGN_ADDR(x, a)	((((u32)(x)) + (a-1)) & ~(a-1))
 
-static dbdma_global_t *dbdma_gptr = (dbdma_global_t *)DDMA_GLOBAL_BASE;
+static dbdma_global_t *dbdma_gptr =
+			(dbdma_global_t *)KSEG1ADDR(AU1550_DBDMA_CONF_PHYS_ADDR);
 static int dbdma_initialized;
 
 static dbdev_tab_t dbdev_tab[] = {
@@ -299,7 +300,7 @@ u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
 	if (ctp != NULL) {
 		memset(ctp, 0, sizeof(chan_tab_t));
 		ctp->chan_index = chan = i;
-		dcp = DDMA_CHANNEL_BASE;
+		dcp = KSEG1ADDR(AU1550_DBDMA_PHYS_ADDR);
 		dcp += (0x0100 * chan);
 		ctp->chan_ptr = (au1x_dma_chan_t *)dcp;
 		cp = (au1x_dma_chan_t *)dcp;
@@ -958,105 +959,75 @@ u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr)
 }
 
 
-struct alchemy_dbdma_sysdev {
-	struct sys_device sysdev;
-	u32 pm_regs[NUM_DBDMA_CHANS + 1][6];
-};
+static unsigned long alchemy_dbdma_pm_data[NUM_DBDMA_CHANS + 1][6];
 
-static int alchemy_dbdma_suspend(struct sys_device *dev,
-				 pm_message_t state)
+static int alchemy_dbdma_suspend(void)
 {
-	struct alchemy_dbdma_sysdev *sdev =
-		container_of(dev, struct alchemy_dbdma_sysdev, sysdev);
 	int i;
-	u32 addr;
+	void __iomem *addr;
 
-	addr = DDMA_GLOBAL_BASE;
-	sdev->pm_regs[0][0] = au_readl(addr + 0x00);
-	sdev->pm_regs[0][1] = au_readl(addr + 0x04);
-	sdev->pm_regs[0][2] = au_readl(addr + 0x08);
-	sdev->pm_regs[0][3] = au_readl(addr + 0x0c);
+	addr = (void __iomem *)KSEG1ADDR(AU1550_DBDMA_CONF_PHYS_ADDR);
+	alchemy_dbdma_pm_data[0][0] = __raw_readl(addr + 0x00);
+	alchemy_dbdma_pm_data[0][1] = __raw_readl(addr + 0x04);
+	alchemy_dbdma_pm_data[0][2] = __raw_readl(addr + 0x08);
+	alchemy_dbdma_pm_data[0][3] = __raw_readl(addr + 0x0c);
 
 	/* save channel configurations */
-	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
-		sdev->pm_regs[i][0] = au_readl(addr + 0x00);
-		sdev->pm_regs[i][1] = au_readl(addr + 0x04);
-		sdev->pm_regs[i][2] = au_readl(addr + 0x08);
-		sdev->pm_regs[i][3] = au_readl(addr + 0x0c);
-		sdev->pm_regs[i][4] = au_readl(addr + 0x10);
-		sdev->pm_regs[i][5] = au_readl(addr + 0x14);
+	addr = (void __iomem *)KSEG1ADDR(AU1550_DBDMA_PHYS_ADDR);
+	for (i = 1; i <= NUM_DBDMA_CHANS; i++) {
+		alchemy_dbdma_pm_data[i][0] = __raw_readl(addr + 0x00);
+		alchemy_dbdma_pm_data[i][1] = __raw_readl(addr + 0x04);
+		alchemy_dbdma_pm_data[i][2] = __raw_readl(addr + 0x08);
+		alchemy_dbdma_pm_data[i][3] = __raw_readl(addr + 0x0c);
+		alchemy_dbdma_pm_data[i][4] = __raw_readl(addr + 0x10);
+		alchemy_dbdma_pm_data[i][5] = __raw_readl(addr + 0x14);
 
 		/* halt channel */
-		au_writel(sdev->pm_regs[i][0] & ~1, addr + 0x00);
-		au_sync();
-		while (!(au_readl(addr + 0x14) & 1))
-			au_sync();
+		__raw_writel(alchemy_dbdma_pm_data[i][0] & ~1, addr + 0x00);
+		wmb();
+		while (!(__raw_readl(addr + 0x14) & 1))
+			wmb();
 
 		addr += 0x100;	/* next channel base */
 	}
 	/* disable channel interrupts */
-	au_writel(0, DDMA_GLOBAL_BASE + 0x0c);
-	au_sync();
+	addr = (void __iomem *)KSEG1ADDR(AU1550_DBDMA_CONF_PHYS_ADDR);
+	__raw_writel(0, addr + 0x0c);
+	wmb();
 
 	return 0;
 }
 
-static int alchemy_dbdma_resume(struct sys_device *dev)
+static void alchemy_dbdma_resume(void)
 {
-	struct alchemy_dbdma_sysdev *sdev =
-		container_of(dev, struct alchemy_dbdma_sysdev, sysdev);
 	int i;
-	u32 addr;
+	void __iomem *addr;
 
-	addr = DDMA_GLOBAL_BASE;
-	au_writel(sdev->pm_regs[0][0], addr + 0x00);
-	au_writel(sdev->pm_regs[0][1], addr + 0x04);
-	au_writel(sdev->pm_regs[0][2], addr + 0x08);
-	au_writel(sdev->pm_regs[0][3], addr + 0x0c);
+	addr = (void __iomem *)KSEG1ADDR(AU1550_DBDMA_CONF_PHYS_ADDR);
+	__raw_writel(alchemy_dbdma_pm_data[0][0], addr + 0x00);
+	__raw_writel(alchemy_dbdma_pm_data[0][1], addr + 0x04);
+	__raw_writel(alchemy_dbdma_pm_data[0][2], addr + 0x08);
+	__raw_writel(alchemy_dbdma_pm_data[0][3], addr + 0x0c);
 
 	/* restore channel configurations */
-	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
-		au_writel(sdev->pm_regs[i][0], addr + 0x00);
-		au_writel(sdev->pm_regs[i][1], addr + 0x04);
-		au_writel(sdev->pm_regs[i][2], addr + 0x08);
-		au_writel(sdev->pm_regs[i][3], addr + 0x0c);
-		au_writel(sdev->pm_regs[i][4], addr + 0x10);
-		au_writel(sdev->pm_regs[i][5], addr + 0x14);
-		au_sync();
+	addr = (void __iomem *)KSEG1ADDR(AU1550_DBDMA_PHYS_ADDR);
+	for (i = 1; i <= NUM_DBDMA_CHANS; i++) {
+		__raw_writel(alchemy_dbdma_pm_data[i][0], addr + 0x00);
+		__raw_writel(alchemy_dbdma_pm_data[i][1], addr + 0x04);
+		__raw_writel(alchemy_dbdma_pm_data[i][2], addr + 0x08);
+		__raw_writel(alchemy_dbdma_pm_data[i][3], addr + 0x0c);
+		__raw_writel(alchemy_dbdma_pm_data[i][4], addr + 0x10);
+		__raw_writel(alchemy_dbdma_pm_data[i][5], addr + 0x14);
+		wmb();
 		addr += 0x100;	/* next channel base */
 	}
-
-	return 0;
 }
 
-static struct sysdev_class alchemy_dbdma_sysdev_class = {
-	.name		= "dbdma",
+static struct syscore_ops alchemy_dbdma_syscore_ops = {
 	.suspend	= alchemy_dbdma_suspend,
 	.resume		= alchemy_dbdma_resume,
 };
 
-static int __init alchemy_dbdma_sysdev_init(void)
-{
-	struct alchemy_dbdma_sysdev *sdev;
-	int ret;
-
-	ret = sysdev_class_register(&alchemy_dbdma_sysdev_class);
-	if (ret)
-		return ret;
-
-	sdev = kzalloc(sizeof(struct alchemy_dbdma_sysdev), GFP_KERNEL);
-	if (!sdev)
-		return -ENOMEM;
-
-	sdev->sysdev.id = -1;
-	sdev->sysdev.cls = &alchemy_dbdma_sysdev_class;
-	ret = sysdev_register(&sdev->sysdev);
-	if (ret)
-		kfree(sdev);
-
-	return ret;
-}
-
 static int __init au1xxx_dbdma_init(void)
 {
 	int irq_nr, ret;
@@ -1084,11 +1055,7 @@ static int __init au1xxx_dbdma_init(void)
 	else {
 		dbdma_initialized = 1;
 		printk(KERN_INFO "Alchemy DBDMA initialized\n");
-		ret = alchemy_dbdma_sysdev_init();
-		if (ret) {
-			printk(KERN_ERR "DBDMA PM init failed\n");
-			ret = 0;
-		}
+		register_syscore_ops(&alchemy_dbdma_syscore_ops);
 	}
 
 	return ret;
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 66cfcdc..eb8f103 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -635,6 +635,8 @@ enum soc_au1200_ints {
 
 #define AU1000_IC0_PHYS_ADDR		0x10400000 /* 01234 */
 #define AU1000_IC1_PHYS_ADDR		0x11800000 /* 01234 */
+#define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 34 */
+#define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
 
 
 #ifdef CONFIG_SOC_AU1000
@@ -761,7 +763,6 @@ enum soc_au1200_ints {
 #define	UART3_PHYS_ADDR		0x11400000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
-#define	DDMA_PHYS_ADDR		0x14002000
 #define PE_PHYS_ADDR		0x14008000
 #define PSC0_PHYS_ADDR		0x11A00000
 #define PSC1_PHYS_ADDR		0x11B00000
@@ -789,7 +790,6 @@ enum soc_au1200_ints {
 #define	UART1_PHYS_ADDR		0x11200000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
-#define	DDMA_PHYS_ADDR		0x14002000
 #define PSC0_PHYS_ADDR	 	0x11A00000
 #define PSC1_PHYS_ADDR	 	0x11B00000
 #define SD0_PHYS_ADDR		0x10600000
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index c8a553a3..2fdacfe 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -37,14 +37,6 @@
 
 #ifndef _LANGUAGE_ASSEMBLY
 
-/*
- * The DMA base addresses.
- * The channels are every 256 bytes (0x0100) from the channel 0 base.
- * Interrupt status/enable is bits 15:0 for channels 15 to zero.
- */
-#define DDMA_GLOBAL_BASE	0xb4003000
-#define DDMA_CHANNEL_BASE	0xb4002000
-
 typedef volatile struct dbdma_global {
 	u32	ddma_config;
 	u32	ddma_intstat;
-- 
1.7.5.rc3
