Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2012 14:02:17 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:50501 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903649Ab2DCMCA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2012 14:02:00 +0200
Received: by dadq36 with SMTP id q36so2907831dad.36
        for <multiple recipients>; Tue, 03 Apr 2012 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=OmAowsoKBYdtqANVRaFu3OqJ9T1GmGB++S0MxYkbkBI=;
        b=jbWSSCXaTniCcxDkId0lBTybfjRicuJtW0BI7ldpbuwbk4oK3eHRwdxFvxr5xBp11g
         4sakt7VUJ88OtPc/ejVBqw4VRgNTg6cmTjDGlqe+mUv+/U/PFFxsneITsFHqpx83/oUw
         Le0CpdLzKylfDz16YAwqN1bZ/v3RdfxkJ96RRQrkSg0CaXnTNwL6ojIbEVuYKEluQwDS
         EY1p/wLd9Z77LE5ztyebIB7inkJh5weIG/dfTLYEDq4K4NjzO3KuxkxJO/Z7mBXQ/q4x
         xW26icj0zJPTZ87A3iDHF4egnkYHAzzPFBBpfmamaAOmvI04KGgF85O19AC+QX2iv/qX
         TSlg==
Received: by 10.68.221.227 with SMTP id qh3mr28557793pbc.43.1333454513295;
        Tue, 03 Apr 2012 05:01:53 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by mx.google.com with ESMTPS id r10sm16200208pbf.22.2012.04.03.05.01.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 05:01:52 -0700 (PDT)
Received: by masabert (Postfix, from userid 500)
        id 91AA1A36E5; Tue,  3 Apr 2012 21:01:48 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        Masanari Iida <standby24x7@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] [trivial] mips: Fix typo in mips
Date:   Tue,  3 Apr 2012 21:01:45 +0900
Message-Id: <1333454506-7625-1-git-send-email-standby24x7@gmail.com>
X-Mailer: git-send-email 1.7.10.rc3.11.gd8282
X-archive-position: 32858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: standby24x7@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Correct spelling typo in printk messages, comments and macro.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/Kconfig                |    4 ++--
 arch/mips/Kconfig.debug          |    2 +-
 arch/mips/lantiq/xway/dma.c      |    6 +++---
 arch/mips/lantiq/xway/gpio.c     |    2 +-
 arch/mips/lantiq/xway/gpio_ebu.c |    2 +-
 arch/mips/lantiq/xway/gpio_stp.c |    2 +-
 arch/mips/pci/pci-lantiq.c       |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ce30e2f..923a6c3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1001,12 +1001,12 @@ config HOLES_IN_ZONE
 	bool
 
 #
-# Endianess selection.  Sufficiently obscure so many users don't know what to
+# Endianness selection.  Sufficiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a
 # choice statement should be more obvious to the user.
 #
 choice
-	prompt "Endianess selection"
+	prompt "Endianness selection"
 	help
 	  Some MIPS machines can be configured for either little or big endian
 	  byte order. These modes require different kernels and a different
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 83ed00a..5a43aa0 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -57,7 +57,7 @@ config CMDLINE
 	  options.
 
 config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides firware arguments"
+	bool "Built-in command line overrides firmware arguments"
 	default n
 	depends on CMDLINE_BOOL
 	help
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index b210e93..d1eafb0 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -47,7 +47,7 @@
 #define DMA_CLK_DIV4		BIT(6)		/* polling clock divider */
 #define DMA_2W_BURST		BIT(1)		/* 2 word burst length */
 #define DMA_MAX_CHANNEL		20		/* the soc has 20 channels */
-#define DMA_ETOP_ENDIANESS	(0xf << 8) /* endianess swap etop channels */
+#define DMA_ETOP_ENDIANNESS	(0xf << 8) /* endianness swap etop channels */
 #define DMA_WEIGHT	(BIT(17) | BIT(16))	/* default channel wheight */
 
 #define ltq_dma_r32(x)			ltq_r32(ltq_dma_membase + (x))
@@ -197,10 +197,10 @@ ltq_dma_init_port(int p)
 	switch (p) {
 	case DMA_PORT_ETOP:
 		/*
-		 * Tell the DMA engine to swap the endianess of data frames and
+		 * Tell the DMA engine to swap the endianness of data frames and
 		 * drop packets if the channel arbitration fails.
 		 */
-		ltq_dma_w32_mask(0, DMA_ETOP_ENDIANESS | DMA_PDEN,
+		ltq_dma_w32_mask(0, DMA_ETOP_ENDIANNESS | DMA_PDEN,
 			LTQ_DMA_PCTRL);
 		break;
 
diff --git a/arch/mips/lantiq/xway/gpio.c b/arch/mips/lantiq/xway/gpio.c
index d2fa98f..c429a5b 100644
--- a/arch/mips/lantiq/xway/gpio.c
+++ b/arch/mips/lantiq/xway/gpio.c
@@ -188,7 +188,7 @@ int __init ltq_gpio_init(void)
 	int ret = platform_driver_register(&ltq_gpio_driver);
 
 	if (ret)
-		pr_info("ltq_gpio : Error registering platfom driver!");
+		pr_info("ltq_gpio : Error registering platform driver!");
 	return ret;
 }
 
diff --git a/arch/mips/lantiq/xway/gpio_ebu.c b/arch/mips/lantiq/xway/gpio_ebu.c
index b91c7f1..aae1717 100644
--- a/arch/mips/lantiq/xway/gpio_ebu.c
+++ b/arch/mips/lantiq/xway/gpio_ebu.c
@@ -119,7 +119,7 @@ static int __init ltq_ebu_init(void)
 	int ret = platform_driver_register(&ltq_ebu_driver);
 
 	if (ret)
-		pr_info("ltq_ebu : Error registering platfom driver!");
+		pr_info("ltq_ebu : Error registering platform driver!");
 	return ret;
 }
 
diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index ff9991c..fd07d87 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -150,7 +150,7 @@ int __init ltq_stp_init(void)
 	int ret = platform_driver_register(&ltq_stp_driver);
 
 	if (ret)
-		pr_info("ltq_stp: error registering platfom driver");
+		pr_info("ltq_stp: error registering platform driver");
 	return ret;
 }
 
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 030c77e..70fdf2c 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -297,7 +297,7 @@ int __init pcibios_init(void)
 {
 	int ret = platform_driver_register(&ltq_pci_driver);
 	if (ret)
-		printk(KERN_INFO "ltq_pci: Error registering platfom driver!");
+		printk(KERN_INFO "ltq_pci: Error registering platform driver!");
 	return ret;
 }
 
-- 
1.7.10.rc3.11.gd8282
