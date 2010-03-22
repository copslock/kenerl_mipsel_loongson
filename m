Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2010 20:40:59 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64546 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491913Ab0CVTkz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Mar 2010 20:40:55 +0100
Received: by fxm9 with SMTP id 9so4707748fxm.24
        for <linux-mips@linux-mips.org>; Mon, 22 Mar 2010 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jeGufQSeJLzCHO8xTuPhNxbSoMvvWmNNvKgh0YY6jgo=;
        b=qmD/wgPbN+S82cSuy1Vk01rrm+m8SYnLrlRpwPJZg3O0gW7PAQ1jtCiOP4S0XUQeGr
         pQ+hr4KPyLu6uMuod2jH8EmpOrjVkqiGM830AHlxDJa/mrqdRNYPSWVLJImdP9OpcG13
         vNG7lVLoqXbLWHqIuBqsexVuaioJTHr/MOSdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MHLClW+r5TSp5lXV6B6awvzqBQr7hdPOirpq3tTkhqCzxzSmGjTrAG0B/6OU11V1AB
         vDwk4XSYBIji/5V+IP7uoob3oXOs/zd9rMAL5D/cEBD3NLCh5nQKb6LtKYuJ/QWhHKVj
         0yF0l4gyJqPptXzWdyMuO7NqRAA+FaUMwR5qU=
Received: by 10.223.81.90 with SMTP id w26mr277473fak.9.1269286848956;
        Mon, 22 Mar 2010 12:40:48 -0700 (PDT)
Received: from localhost.localdomain (p5496AFBB.dip.t-dialin.net [84.150.175.187])
        by mx.google.com with ESMTPS id z10sm9704509fka.1.2010.03.22.12.40.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 12:40:46 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <mano@roarinelk.homelinux.net>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: add sysdev for both irq controllers
Date:   Mon, 22 Mar 2010 20:41:34 +0100
Message-Id: <1269286894-15495-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mano@roarinelk.homelinux.net>

Use a sysdev to implement PM methods for the Au1000 interrupt controllers.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: register a sysdev for each of the 2 controllers (instead of a single one
    handling both).

 arch/mips/alchemy/common/irq.c             |  173 ++++++++++++++--------------
 arch/mips/alchemy/common/power.c           |    5 -
 arch/mips/include/asm/mach-au1x00/au1000.h |   34 +++++-
 3 files changed, 121 insertions(+), 91 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index b2821ac..6fc3473 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/sysdev.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -216,90 +217,6 @@ struct au1xxx_irqmap au1200_irqmap[] __initdata = {
 };
 
 
-#ifdef CONFIG_PM
-
-/*
- * Save/restore the interrupt controller state.
- * Called from the save/restore core registers as part of the
- * au_sleep function in power.c.....maybe I should just pm_register()
- * them instead?
- */
-static unsigned int	sleep_intctl_config0[2];
-static unsigned int	sleep_intctl_config1[2];
-static unsigned int	sleep_intctl_config2[2];
-static unsigned int	sleep_intctl_src[2];
-static unsigned int	sleep_intctl_assign[2];
-static unsigned int	sleep_intctl_wake[2];
-static unsigned int	sleep_intctl_mask[2];
-
-void save_au1xxx_intctl(void)
-{
-	sleep_intctl_config0[0] = au_readl(IC0_CFG0RD);
-	sleep_intctl_config1[0] = au_readl(IC0_CFG1RD);
-	sleep_intctl_config2[0] = au_readl(IC0_CFG2RD);
-	sleep_intctl_src[0] = au_readl(IC0_SRCRD);
-	sleep_intctl_assign[0] = au_readl(IC0_ASSIGNRD);
-	sleep_intctl_wake[0] = au_readl(IC0_WAKERD);
-	sleep_intctl_mask[0] = au_readl(IC0_MASKRD);
-
-	sleep_intctl_config0[1] = au_readl(IC1_CFG0RD);
-	sleep_intctl_config1[1] = au_readl(IC1_CFG1RD);
-	sleep_intctl_config2[1] = au_readl(IC1_CFG2RD);
-	sleep_intctl_src[1] = au_readl(IC1_SRCRD);
-	sleep_intctl_assign[1] = au_readl(IC1_ASSIGNRD);
-	sleep_intctl_wake[1] = au_readl(IC1_WAKERD);
-	sleep_intctl_mask[1] = au_readl(IC1_MASKRD);
-}
-
-/*
- * For most restore operations, we clear the entire register and
- * then set the bits we found during the save.
- */
-void restore_au1xxx_intctl(void)
-{
-	au_writel(0xffffffff, IC0_MASKCLR); au_sync();
-
-	au_writel(0xffffffff, IC0_CFG0CLR); au_sync();
-	au_writel(sleep_intctl_config0[0], IC0_CFG0SET); au_sync();
-	au_writel(0xffffffff, IC0_CFG1CLR); au_sync();
-	au_writel(sleep_intctl_config1[0], IC0_CFG1SET); au_sync();
-	au_writel(0xffffffff, IC0_CFG2CLR); au_sync();
-	au_writel(sleep_intctl_config2[0], IC0_CFG2SET); au_sync();
-	au_writel(0xffffffff, IC0_SRCCLR); au_sync();
-	au_writel(sleep_intctl_src[0], IC0_SRCSET); au_sync();
-	au_writel(0xffffffff, IC0_ASSIGNCLR); au_sync();
-	au_writel(sleep_intctl_assign[0], IC0_ASSIGNSET); au_sync();
-	au_writel(0xffffffff, IC0_WAKECLR); au_sync();
-	au_writel(sleep_intctl_wake[0], IC0_WAKESET); au_sync();
-	au_writel(0xffffffff, IC0_RISINGCLR); au_sync();
-	au_writel(0xffffffff, IC0_FALLINGCLR); au_sync();
-	au_writel(0x00000000, IC0_TESTBIT); au_sync();
-
-	au_writel(0xffffffff, IC1_MASKCLR); au_sync();
-
-	au_writel(0xffffffff, IC1_CFG0CLR); au_sync();
-	au_writel(sleep_intctl_config0[1], IC1_CFG0SET); au_sync();
-	au_writel(0xffffffff, IC1_CFG1CLR); au_sync();
-	au_writel(sleep_intctl_config1[1], IC1_CFG1SET); au_sync();
-	au_writel(0xffffffff, IC1_CFG2CLR); au_sync();
-	au_writel(sleep_intctl_config2[1], IC1_CFG2SET); au_sync();
-	au_writel(0xffffffff, IC1_SRCCLR); au_sync();
-	au_writel(sleep_intctl_src[1], IC1_SRCSET); au_sync();
-	au_writel(0xffffffff, IC1_ASSIGNCLR); au_sync();
-	au_writel(sleep_intctl_assign[1], IC1_ASSIGNSET); au_sync();
-	au_writel(0xffffffff, IC1_WAKECLR); au_sync();
-	au_writel(sleep_intctl_wake[1], IC1_WAKESET); au_sync();
-	au_writel(0xffffffff, IC1_RISINGCLR); au_sync();
-	au_writel(0xffffffff, IC1_FALLINGCLR); au_sync();
-	au_writel(0x00000000, IC1_TESTBIT); au_sync();
-
-	au_writel(sleep_intctl_mask[1], IC1_MASKSET); au_sync();
-
-	au_writel(sleep_intctl_mask[0], IC0_MASKSET); au_sync();
-}
-#endif /* CONFIG_PM */
-
-
 static void au1x_ic0_unmask(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
@@ -635,3 +552,91 @@ void __init arch_init_irq(void)
 		break;
 	}
 }
+
+struct alchemy_ic_sysdev {
+	struct sys_device sysdev;
+	void __iomem *base;
+	unsigned long pmdata[7];
+};
+
+static int alchemy_ic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct alchemy_ic_sysdev *icdev =
+			container_of(dev, struct alchemy_ic_sysdev, sysdev);
+
+	icdev->pmdata[ 0] = __raw_readl(icdev->base + IC_CFG0RD);
+	icdev->pmdata[ 1] = __raw_readl(icdev->base + IC_CFG1RD);
+	icdev->pmdata[ 2] = __raw_readl(icdev->base + IC_CFG2RD);
+	icdev->pmdata[ 3] = __raw_readl(icdev->base + IC_SRCRD);
+	icdev->pmdata[ 4] = __raw_readl(icdev->base + IC_ASSIGNRD);
+	icdev->pmdata[ 5] = __raw_readl(icdev->base + IC_WAKERD);
+	icdev->pmdata[ 6] = __raw_readl(icdev->base + IC_MASKRD);
+
+	return 0;
+}
+
+static int alchemy_ic_resume(struct sys_device *dev)
+{
+	struct alchemy_ic_sysdev *icdev =
+			container_of(dev, struct alchemy_ic_sysdev, sysdev);
+
+	__raw_writel(0xffffffff, icdev->base + IC_MASKCLR);
+	__raw_writel(0xffffffff, icdev->base + IC_CFG0CLR);
+	__raw_writel(0xffffffff, icdev->base + IC_CFG1CLR);
+	__raw_writel(0xffffffff, icdev->base + IC_CFG2CLR);
+	__raw_writel(0xffffffff, icdev->base + IC_SRCCLR);
+	__raw_writel(0xffffffff, icdev->base + IC_ASSIGNCLR);
+	__raw_writel(0xffffffff, icdev->base + IC_WAKECLR);
+	__raw_writel(0xffffffff, icdev->base + IC_RISINGCLR);
+	__raw_writel(0xffffffff, icdev->base + IC_FALLINGCLR);
+	__raw_writel(0x00000000, icdev->base + IC_TESTBIT);
+	wmb();
+	__raw_writel(icdev->pmdata[ 0], icdev->base + IC_CFG0SET);
+	__raw_writel(icdev->pmdata[ 1], icdev->base + IC_CFG1SET);
+	__raw_writel(icdev->pmdata[ 2], icdev->base + IC_CFG2SET);
+	__raw_writel(icdev->pmdata[ 3], icdev->base + IC_SRCSET);
+	__raw_writel(icdev->pmdata[ 4], icdev->base + IC_ASSIGNSET);
+	__raw_writel(icdev->pmdata[ 5], icdev->base + IC_WAKESET);
+	wmb();
+
+	__raw_writel(icdev->pmdata[ 6], icdev->base + IC_MASKSET);
+	wmb();
+
+	return 0;
+}
+
+static struct sysdev_class alchemy_ic_sysdev_class = {
+	.name		= "ic",
+	.suspend	= alchemy_ic_suspend,
+	.resume		= alchemy_ic_resume,
+};
+
+static int __init alchemy_ic_sysdev_init(void)
+{
+	struct alchemy_ic_sysdev *icdev;
+	unsigned long icbase[2] = { IC0_PHYS_ADDR, IC1_PHYS_ADDR };
+	int err, i;
+
+	err = sysdev_class_register(&alchemy_ic_sysdev_class);
+	if (err)
+		return err;
+
+	for (i = 0; i < 2; i++) {
+		icdev = kzalloc(sizeof(struct alchemy_ic_sysdev), GFP_KERNEL);
+		if (!icdev)
+			return -ENOMEM;
+
+		icdev->base = ioremap(icbase[i], 0x1000);
+
+		icdev->sysdev.id = i;
+		icdev->sysdev.cls = &alchemy_ic_sysdev_class;
+		err = sysdev_register(&icdev->sysdev);
+		if (err) {
+			kfree(icdev);
+			return err;
+		}
+	}
+
+	return 0;
+}
+device_initcall(alchemy_ic_sysdev_init);
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 7543cf2..cbc9eed 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -85,9 +85,6 @@ static void save_core_regs(void)
 	sleep_usb[1] = au_readl(0xb4020024);	/* OTG_MUX */
 #endif
 
-	/* Save interrupt controller state. */
-	save_au1xxx_intctl();
-
 	/* Clocks and PLLs. */
 	sleep_sys_clocks[0] = au_readl(SYS_FREQCTRL0);
 	sleep_sys_clocks[1] = au_readl(SYS_FREQCTRL1);
@@ -165,8 +162,6 @@ static void restore_core_regs(void)
 	au_writel(sleep_static_memctlr[3][1], MEM_STTIME3);
 	au_writel(sleep_static_memctlr[3][2], MEM_STADDR3);
 
-	restore_au1xxx_intctl();
-
 #if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
 	au1xxx_dbdma_resume();
 #endif
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index cb91714..a697661 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -191,8 +191,6 @@ extern unsigned long au1xxx_calc_clock(void);
 void alchemy_sleep_au1000(void);
 void alchemy_sleep_au1550(void);
 void au_sleep(void);
-void save_au1xxx_intctl(void);
-void restore_au1xxx_intctl(void);
 
 
 /* SOC Interrupt numbers */
@@ -836,6 +834,38 @@ enum soc_au1200_ints {
 #define MEM_STNAND_DATA 	0x20
 #endif
 
+
+/* Interrupt Controller register offsets */
+#define IC_CFG0RD		0x40
+#define IC_CFG0SET		0x40
+#define IC_CFG0CLR		0x44
+#define IC_CFG1RD		0x48
+#define IC_CFG1SET		0x48
+#define IC_CFG1CLR		0x4C
+#define IC_CFG2RD		0x50
+#define IC_CFG2SET		0x50
+#define IC_CFG2CLR		0x54
+#define IC_REQ0INT		0x54
+#define IC_SRCRD		0x58
+#define IC_SRCSET		0x58
+#define IC_SRCCLR		0x5C
+#define IC_REQ1INT		0x5C
+#define IC_ASSIGNRD		0x60
+#define IC_ASSIGNSET		0x60
+#define IC_ASSIGNCLR		0x64
+#define IC_WAKERD		0x68
+#define IC_WAKESET		0x68
+#define IC_WAKECLR		0x6C
+#define IC_MASKRD		0x70
+#define IC_MASKSET		0x70
+#define IC_MASKCLR		0x74
+#define IC_RISINGRD		0x78
+#define IC_RISINGCLR		0x78
+#define IC_FALLINGRD		0x7C
+#define IC_FALLINGCLR		0x7C
+#define IC_TESTBIT		0x80
+
+
 /* Interrupt Controller 0 */
 #define IC0_CFG0RD		0xB0400040
 #define IC0_CFG0SET		0xB0400040
-- 
1.7.0.2
