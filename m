Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2010 20:10:07 +0200 (CEST)
Received: from mail-ew0-f211.google.com ([209.85.219.211]:44881 "EHLO
        mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492525Ab0DMSKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Apr 2010 20:10:02 +0200
Received: by ewy3 with SMTP id 3so2550ewy.26
        for <linux-mips@linux-mips.org>; Tue, 13 Apr 2010 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=s3pwaZjzIMr9U9GW4Pv8ouRoythi9cxKnbF/dIefJtI=;
        b=pbMhJi0vnYNQddYF9BG8Xuoxu1Rw62R1vfpBIO/tdZ61ZCtOZZWxGmiXbpgJzMWbJm
         Cc55EnkCixHof5o9QRkvbIPgKPI02jTG3GOtP+iQo7xS6z/TUrA2xE03ttN6TEvfGlDH
         t+I9NuLYdwlYBlmKFYDdFgvbLhcw89DUmwhRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sO2NZ5K/TYyQqhK+eOCsOm7OTyc+wE5VSc7qK6wUpSdmDArkoZEPi/ckgF3lr4zbv5
         NytyZfruM1XlfwixzjLSSwbKnyhnoFXQS2W4S1Ng/YHxUJst/N3B7vMLW02my1DSGlqQ
         G3MBDmp/s76ShOeId8VenaaL0B2wSuQD6MU20=
Received: by 10.87.53.22 with SMTP id f22mr5227784fgk.41.1271182196119;
        Tue, 13 Apr 2010 11:09:56 -0700 (PDT)
Received: from localhost.localdomain (p5496D173.dip.t-dialin.net [84.150.209.115])
        by mx.google.com with ESMTPS id 9sm11614748fks.26.2010.04.13.11.09.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 11:09:55 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v4] MIPS: Alchemy: add sysdev for IRQ PM.
Date:   Tue, 13 Apr 2010 20:09:40 +0200
Message-Id: <1271182180-8158-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Use a sysdev to implement PM methods for the Au1000 interrupt controllers.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v4: need slab.h for kzalloc
v3: fix odd formatting
v2: register a sysdev for each of the 2 controllers (instead of a single one
   handling both).

 arch/mips/alchemy/common/irq.c             |  197 ++++++++++++++++------------
 arch/mips/alchemy/common/power.c           |    5 -
 arch/mips/include/asm/mach-au1x00/au1000.h |    2 -
 3 files changed, 113 insertions(+), 91 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index b2821ac..4792c89 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -29,6 +29,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/sysdev.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -216,90 +218,6 @@ struct au1xxx_irqmap au1200_irqmap[] __initdata = {
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
@@ -635,3 +553,114 @@ void __init arch_init_irq(void)
 		break;
 	}
 }
+
+struct alchemy_ic_sysdev {
+	struct sys_device sysdev;
+	unsigned long pmdata[7 * 2];
+};
+
+static int alchemy_ic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct alchemy_ic_sysdev *icdev =
+			container_of(dev, struct alchemy_ic_sysdev, sysdev);
+
+	icdev->pmdata[0] = au_readl(IC0_CFG0RD);
+	icdev->pmdata[1] = au_readl(IC0_CFG1RD);
+	icdev->pmdata[2] = au_readl(IC0_CFG2RD);
+	icdev->pmdata[3] = au_readl(IC0_SRCRD);
+	icdev->pmdata[4] = au_readl(IC0_ASSIGNRD);
+	icdev->pmdata[5] = au_readl(IC0_WAKERD);
+	icdev->pmdata[6] = au_readl(IC0_MASKRD);
+
+	icdev->pmdata[7] = au_readl(IC1_CFG0RD);
+	icdev->pmdata[8] = au_readl(IC1_CFG1RD);
+	icdev->pmdata[9] = au_readl(IC1_CFG2RD);
+	icdev->pmdata[10] = au_readl(IC1_SRCRD);
+	icdev->pmdata[11] = au_readl(IC1_ASSIGNRD);
+	icdev->pmdata[12] = au_readl(IC1_WAKERD);
+	icdev->pmdata[13] = au_readl(IC1_MASKRD);
+
+	return 0;
+}
+
+static int alchemy_ic_resume(struct sys_device *dev)
+{
+	struct alchemy_ic_sysdev *icdev =
+			container_of(dev, struct alchemy_ic_sysdev, sysdev);
+
+	au_writel(0xffffffff, IC0_MASKCLR);
+	au_writel(0xffffffff, IC0_CFG0CLR);
+	au_writel(0xffffffff, IC0_CFG1CLR);
+	au_writel(0xffffffff, IC0_CFG2CLR);
+	au_writel(0xffffffff, IC0_SRCCLR);
+	au_writel(0xffffffff, IC0_ASSIGNCLR);
+	au_writel(0xffffffff, IC0_WAKECLR);
+	au_writel(0xffffffff, IC0_RISINGCLR);
+	au_writel(0xffffffff, IC0_FALLINGCLR);
+	au_writel(0x00000000, IC0_TESTBIT);
+	au_sync();
+	au_writel(icdev->pmdata[0], IC0_CFG0SET);
+	au_writel(icdev->pmdata[1], IC0_CFG1SET);
+	au_writel(icdev->pmdata[2], IC0_CFG2SET);
+	au_writel(icdev->pmdata[3], IC0_SRCSET);
+	au_writel(icdev->pmdata[4], IC0_ASSIGNSET);
+	au_writel(icdev->pmdata[5], IC0_WAKESET);
+	au_sync();
+
+	au_writel(0xffffffff, IC1_MASKCLR);
+	au_writel(0xffffffff, IC1_CFG0CLR);
+	au_writel(0xffffffff, IC1_CFG1CLR);
+	au_writel(0xffffffff, IC1_CFG2CLR);
+	au_writel(0xffffffff, IC1_SRCCLR);
+	au_writel(0xffffffff, IC1_ASSIGNCLR);
+	au_writel(0xffffffff, IC1_WAKECLR);
+	au_writel(0xffffffff, IC1_RISINGCLR);
+	au_writel(0xffffffff, IC1_FALLINGCLR);
+	au_writel(0x00000000, IC1_TESTBIT);
+	au_sync();
+	au_writel(icdev->pmdata[7], IC1_CFG0SET);
+	au_writel(icdev->pmdata[8], IC1_CFG1SET);
+	au_writel(icdev->pmdata[9], IC1_CFG2SET);
+	au_writel(icdev->pmdata[10], IC1_SRCSET);
+	au_writel(icdev->pmdata[11], IC1_ASSIGNSET);
+	au_writel(icdev->pmdata[12], IC1_WAKESET);
+	au_sync();
+
+	au_writel(icdev->pmdata[13], IC1_MASKSET);
+	au_sync();
+	au_writel(icdev->pmdata[6], IC0_MASKSET);
+	au_sync();
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
+	int err;
+
+	icdev = kzalloc(sizeof(struct alchemy_ic_sysdev), GFP_KERNEL);
+	if (!icdev)
+		return -ENOMEM;
+
+	err = sysdev_class_register(&alchemy_ic_sysdev_class);
+	if (err) {
+		kfree(icdev);
+		return err;
+	}
+
+	icdev->sysdev.id = 0;
+	icdev->sysdev.cls = &alchemy_ic_sysdev_class;
+	err = sysdev_register(&icdev->sysdev);
+	if (err)
+		kfree(icdev);
+
+	return err;
+}
+device_initcall(alchemy_ic_sysdev_init);
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index c07101c..e097094 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -106,9 +106,6 @@ static void save_core_regs(void)
 	sleep_usb[1] = au_readl(0xb4020024);	/* OTG_MUX */
 #endif
 
-	/* Save interrupt controller state. */
-	save_au1xxx_intctl();
-
 	/* Clocks and PLLs. */
 	sleep_sys_clocks[0] = au_readl(SYS_FREQCTRL0);
 	sleep_sys_clocks[1] = au_readl(SYS_FREQCTRL1);
@@ -200,8 +197,6 @@ static void restore_core_regs(void)
 		au_writel(sleep_uart0_clkdiv, UART0_ADDR + UART_CLK); au_sync();
 	}
 
-	restore_au1xxx_intctl();
-
 #if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
 	au1xxx_dbdma_resume();
 #endif
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index cb91714..c84fcd6 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -191,8 +191,6 @@ extern unsigned long au1xxx_calc_clock(void);
 void alchemy_sleep_au1000(void);
 void alchemy_sleep_au1550(void);
 void au_sleep(void);
-void save_au1xxx_intctl(void);
-void restore_au1xxx_intctl(void);
 
 
 /* SOC Interrupt numbers */
-- 
1.7.0.3
