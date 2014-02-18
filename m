Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2014 19:39:52 +0100 (CET)
Received: from mail-ea0-f172.google.com ([209.85.215.172]:42302 "EHLO
        mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824815AbaBRSjJkEXvB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Feb 2014 19:39:09 +0100
Received: by mail-ea0-f172.google.com with SMTP id l9so7519686eaj.3
        for <linux-mips@linux-mips.org>; Tue, 18 Feb 2014 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wZo+G66oIr4l3Pd6aXNxsjUSOHfPPbDeAFRYlP7ABek=;
        b=OMKyvnzYecH74NO3ehuIA8VB4PTEckt6BVJ7k8sAkgZtvQuWtGlwY0oM8H/1PDnMVt
         SyecxyziQGfp2nTss8chEDhOH912IWeAbD0q8NvgcEguXEJVBKunZommQMvRzYTtir4q
         /UVo53J87Rotnm1JW3IjERfnGHpTI86vBaaSG2m2o39+NKqPeDCdeS8HF7YNi2G/AmDH
         vbYT30mWcnz7b0mdHD6VrQtqRBaJugo6hhBlZTvCLhkTgB9EuJup3Qa9ABLf0AmthdbB
         /syToa223Y1UZuU4N5ITzORo9bV7cVSnHTWJCK3L+UcBGa8ihh4ejt9FToZQ0uGGQ5ts
         d26Q==
X-Received: by 10.15.51.196 with SMTP id n44mr35575945eew.27.1392748744285;
        Tue, 18 Feb 2014 10:39:04 -0800 (PST)
Received: from localhost.localdomain (p54B21680.dip0.t-ipconnect.de. [84.178.22.128])
        by mx.google.com with ESMTPSA id j42sm73785779eep.21.2014.02.18.10.39.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2014 10:39:03 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 2/3] MIPS: Alchemy: determine cohereny at runtime based on type
Date:   Tue, 18 Feb 2014 19:38:54 +0100
Message-Id: <1392748735-16745-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1392748735-16745-1-git-send-email-manuel.lauss@gmail.com>
References: <1392748735-16745-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

All Alchemy chips have coherent DMA, but for example the USB or AC97
peripherals on the Au1000/1500/1100 are not.
This patch uses DMA_MAYBE_COHERENT on Alchemy and sets coherentio based
on CPU type.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/Kconfig                |  1 +
 arch/mips/alchemy/Kconfig        |  5 -----
 arch/mips/alchemy/common/setup.c | 10 ++++++++++
 arch/mips/pci/pci-alchemy.c      |  5 ++---
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dcae3a7..623fd96 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -62,6 +62,7 @@ config MIPS_ALCHEMY
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_CPU
+	select DMA_MAYBE_COHERENT	# Au1000,1500,1100 aren't, rest is
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 7032ac7..4138672 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -20,7 +20,6 @@ choice
 
 config MIPS_MTX1
 	bool "4G Systems MTX-1 board"
-	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select ALCHEMY_GPIOINT_AU1000
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -29,7 +28,6 @@ config MIPS_MTX1
 config MIPS_DB1000
 	bool "Alchemy DB1000/DB1500/DB1100 PB1500/1100 boards"
 	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -39,13 +37,11 @@ config MIPS_DB1235
 	bool "Alchemy DB1200/PB1200/DB1300/DB1550/PB1550 boards"
 	select ARCH_REQUIRE_GPIOLIB
 	select HW_HAS_PCI
-	select DMA_COHERENT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_XXS1500
 	bool "MyCable XXS1500 board"
-	select DMA_NONCOHERENT
 	select ALCHEMY_GPIOINT_AU1000
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
@@ -54,7 +50,6 @@ config MIPS_GPR
 	bool "Trapeze ITS GPR board"
 	select ALCHEMY_GPIOINT_AU1000
 	select HW_HAS_PCI
-	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 62b4e7b..566a174 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -30,6 +30,7 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 
+#include <asm/dma-coherence.h>
 #include <asm/mipsregs.h>
 #include <asm/time.h>
 
@@ -59,6 +60,15 @@ void __init plat_mem_setup(void)
 		/* Clear to obtain best system bus performance */
 		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
+	hw_coherentio = 0;
+	coherentio = 1;
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+		coherentio = 0;
+	}
+
 	board_setup();	/* board specific setup */
 
 	/* IO/MEM resources. */
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index d1faece..563d1f6 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -16,6 +16,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/vmalloc.h>
 
+#include <asm/dma-coherence.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/tlbmisc.h>
 
@@ -411,17 +412,15 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 	}
 	ctx->alchemy_pci_ctrl.io_map_base = (unsigned long)virt_io;
 
-#ifdef CONFIG_DMA_NONCOHERENT
 	/* Au1500 revisions older than AD have borked coherent PCI */
 	if ((alchemy_get_cputype() == ALCHEMY_CPU_AU1500) &&
-	    (read_c0_prid() < 0x01030202)) {
+	    (read_c0_prid() < 0x01030202) && !coherentio) {
 		val = __raw_readl(ctx->regs + PCI_REG_CONFIG);
 		val |= PCI_CONFIG_NC;
 		__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
 		wmb();
 		dev_info(&pdev->dev, "non-coherent PCI on Au1500 AA/AB/AC\n");
 	}
-#endif
 
 	if (pd->board_map_irq)
 		ctx->board_map_irq = pd->board_map_irq;
-- 
1.8.5.5
