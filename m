Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 11:42:30 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:50901 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491207Ab1HLJj7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 11:39:59 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so2860465fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BgjjEeBh1hreeskY1bvN/qwJ5hEbmhSPUaPab0ds6Yw=;
        b=tmvIaCxKWkiRgSPleYQ7562alLk9D5VWwPdfTSkxntV24aethVbUnnCdCa3CrW3LfQ
         DyxWe9WlH5ZWdiYG7Rw0Sfx1iKE9aWguNqMDKfWntadjfWK4HYrpelTO1I2jgDcTuwM5
         NQnjz6H1W23Da9AfD3tOu2IqfqnlnKfdPYhjA=
Received: by 10.223.144.136 with SMTP id z8mr1020518fau.31.1313141999616;
        Fri, 12 Aug 2011 02:39:59 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id s14sm467338fah.29.2011.08.12.02.39.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 02:39:58 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 5/8] MIPS: Alchemy: clean DMA code of CONFIG_SOC_AU1??? defines
Date:   Fri, 12 Aug 2011 11:39:42 +0200
Message-Id: <1313141985-5830-6-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9266

This patch gets rid of all CONFIG_SOC_AU1XXX defines in
DMA/DBDMA-related code.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/dbdma.c                 |  203 ++++++++++------------
 arch/mips/alchemy/common/dma.c                   |   60 +++----
 arch/mips/alchemy/common/platform.c              |   16 +-
 arch/mips/alchemy/devboards/db1200/platform.c    |   20 +-
 arch/mips/alchemy/devboards/pb1200/platform.c    |    4 +-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |  114 ++++++-------
 arch/mips/include/asm/mach-db1x00/db1x00.h       |    8 +-
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |    8 +-
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |    8 +-
 9 files changed, 206 insertions(+), 235 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 3a5abb5..0e63ee4 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -40,8 +40,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-
 /*
  * The Descriptor Based DMA supports up to 16 channels.
  *
@@ -62,120 +60,96 @@ static dbdma_global_t *dbdma_gptr =
 			(dbdma_global_t *)KSEG1ADDR(AU1550_DBDMA_CONF_PHYS_ADDR);
 static int dbdma_initialized;
 
-static dbdev_tab_t dbdev_tab[] = {
-#ifdef CONFIG_SOC_AU1550
+static dbdev_tab_t *dbdev_tab;
+
+static dbdev_tab_t au1550_dbdev_tab[] __initdata = {
 	/* UARTS */
-	{ DSCR_CMD0_UART0_TX, DEV_FLAGS_OUT, 0, 8, 0x11100004, 0, 0 },
-	{ DSCR_CMD0_UART0_RX, DEV_FLAGS_IN, 0, 8, 0x11100000, 0, 0 },
-	{ DSCR_CMD0_UART3_TX, DEV_FLAGS_OUT, 0, 8, 0x11400004, 0, 0 },
-	{ DSCR_CMD0_UART3_RX, DEV_FLAGS_IN, 0, 8, 0x11400000, 0, 0 },
+	{ AU1550_DSCR_CMD0_UART0_TX, DEV_FLAGS_OUT, 0, 8, 0x11100004, 0, 0 },
+	{ AU1550_DSCR_CMD0_UART0_RX, DEV_FLAGS_IN,  0, 8, 0x11100000, 0, 0 },
+	{ AU1550_DSCR_CMD0_UART3_TX, DEV_FLAGS_OUT, 0, 8, 0x11400004, 0, 0 },
+	{ AU1550_DSCR_CMD0_UART3_RX, DEV_FLAGS_IN,  0, 8, 0x11400000, 0, 0 },
 
 	/* EXT DMA */
-	{ DSCR_CMD0_DMA_REQ0, 0, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_DMA_REQ1, 0, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_DMA_REQ2, 0, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_DMA_REQ3, 0, 0, 0, 0x00000000, 0, 0 },
+	{ AU1550_DSCR_CMD0_DMA_REQ0, 0, 0, 0, 0x00000000, 0, 0 },
+	{ AU1550_DSCR_CMD0_DMA_REQ1, 0, 0, 0, 0x00000000, 0, 0 },
+	{ AU1550_DSCR_CMD0_DMA_REQ2, 0, 0, 0, 0x00000000, 0, 0 },
+	{ AU1550_DSCR_CMD0_DMA_REQ3, 0, 0, 0, 0x00000000, 0, 0 },
 
 	/* USB DEV */
-	{ DSCR_CMD0_USBDEV_RX0, DEV_FLAGS_IN, 4, 8, 0x10200000, 0, 0 },
-	{ DSCR_CMD0_USBDEV_TX0, DEV_FLAGS_OUT, 4, 8, 0x10200004, 0, 0 },
-	{ DSCR_CMD0_USBDEV_TX1, DEV_FLAGS_OUT, 4, 8, 0x10200008, 0, 0 },
-	{ DSCR_CMD0_USBDEV_TX2, DEV_FLAGS_OUT, 4, 8, 0x1020000c, 0, 0 },
-	{ DSCR_CMD0_USBDEV_RX3, DEV_FLAGS_IN, 4, 8, 0x10200010, 0, 0 },
-	{ DSCR_CMD0_USBDEV_RX4, DEV_FLAGS_IN, 4, 8, 0x10200014, 0, 0 },
-
-	/* PSC 0 */
-	{ DSCR_CMD0_PSC0_TX, DEV_FLAGS_OUT, 0, 0, 0x11a0001c, 0, 0 },
-	{ DSCR_CMD0_PSC0_RX, DEV_FLAGS_IN, 0, 0, 0x11a0001c, 0, 0 },
-
-	/* PSC 1 */
-	{ DSCR_CMD0_PSC1_TX, DEV_FLAGS_OUT, 0, 0, 0x11b0001c, 0, 0 },
-	{ DSCR_CMD0_PSC1_RX, DEV_FLAGS_IN, 0, 0, 0x11b0001c, 0, 0 },
-
-	/* PSC 2 */
-	{ DSCR_CMD0_PSC2_TX, DEV_FLAGS_OUT, 0, 0, 0x10a0001c, 0, 0 },
-	{ DSCR_CMD0_PSC2_RX, DEV_FLAGS_IN, 0, 0, 0x10a0001c, 0, 0 },
-
-	/* PSC 3 */
-	{ DSCR_CMD0_PSC3_TX, DEV_FLAGS_OUT, 0, 0, 0x10b0001c, 0, 0 },
-	{ DSCR_CMD0_PSC3_RX, DEV_FLAGS_IN, 0, 0, 0x10b0001c, 0, 0 },
-
-	{ DSCR_CMD0_PCI_WRITE, 0, 0, 0, 0x00000000, 0, 0 },	/* PCI */
-	{ DSCR_CMD0_NAND_FLASH, 0, 0, 0, 0x00000000, 0, 0 },	/* NAND */
+	{ AU1550_DSCR_CMD0_USBDEV_RX0, DEV_FLAGS_IN,  4, 8, 0x10200000, 0, 0 },
+	{ AU1550_DSCR_CMD0_USBDEV_TX0, DEV_FLAGS_OUT, 4, 8, 0x10200004, 0, 0 },
+	{ AU1550_DSCR_CMD0_USBDEV_TX1, DEV_FLAGS_OUT, 4, 8, 0x10200008, 0, 0 },
+	{ AU1550_DSCR_CMD0_USBDEV_TX2, DEV_FLAGS_OUT, 4, 8, 0x1020000c, 0, 0 },
+	{ AU1550_DSCR_CMD0_USBDEV_RX3, DEV_FLAGS_IN,  4, 8, 0x10200010, 0, 0 },
+	{ AU1550_DSCR_CMD0_USBDEV_RX4, DEV_FLAGS_IN,  4, 8, 0x10200014, 0, 0 },
+
+	/* PSCs */
+	{ AU1550_DSCR_CMD0_PSC0_TX, DEV_FLAGS_OUT, 0, 0, 0x11a0001c, 0, 0 },
+	{ AU1550_DSCR_CMD0_PSC0_RX, DEV_FLAGS_IN,  0, 0, 0x11a0001c, 0, 0 },
+	{ AU1550_DSCR_CMD0_PSC1_TX, DEV_FLAGS_OUT, 0, 0, 0x11b0001c, 0, 0 },
+	{ AU1550_DSCR_CMD0_PSC1_RX, DEV_FLAGS_IN,  0, 0, 0x11b0001c, 0, 0 },
+	{ AU1550_DSCR_CMD0_PSC2_TX, DEV_FLAGS_OUT, 0, 0, 0x10a0001c, 0, 0 },
+	{ AU1550_DSCR_CMD0_PSC2_RX, DEV_FLAGS_IN,  0, 0, 0x10a0001c, 0, 0 },
+	{ AU1550_DSCR_CMD0_PSC3_TX, DEV_FLAGS_OUT, 0, 0, 0x10b0001c, 0, 0 },
+	{ AU1550_DSCR_CMD0_PSC3_RX, DEV_FLAGS_IN,  0, 0, 0x10b0001c, 0, 0 },
+
+	{ AU1550_DSCR_CMD0_PCI_WRITE,  0, 0, 0, 0x00000000, 0, 0 },  /* PCI */
+	{ AU1550_DSCR_CMD0_NAND_FLASH, 0, 0, 0, 0x00000000, 0, 0 }, /* NAND */
 
 	/* MAC 0 */
-	{ DSCR_CMD0_MAC0_RX, DEV_FLAGS_IN, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_MAC0_TX, DEV_FLAGS_OUT, 0, 0, 0x00000000, 0, 0 },
+	{ AU1550_DSCR_CMD0_MAC0_RX, DEV_FLAGS_IN,  0, 0, 0x00000000, 0, 0 },
+	{ AU1550_DSCR_CMD0_MAC0_TX, DEV_FLAGS_OUT, 0, 0, 0x00000000, 0, 0 },
 
 	/* MAC 1 */
-	{ DSCR_CMD0_MAC1_RX, DEV_FLAGS_IN, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_MAC1_TX, DEV_FLAGS_OUT, 0, 0, 0x00000000, 0, 0 },
-
-#endif /* CONFIG_SOC_AU1550 */
+	{ AU1550_DSCR_CMD0_MAC1_RX, DEV_FLAGS_IN,  0, 0, 0x00000000, 0, 0 },
+	{ AU1550_DSCR_CMD0_MAC1_TX, DEV_FLAGS_OUT, 0, 0, 0x00000000, 0, 0 },
 
-#ifdef CONFIG_SOC_AU1200
-	{ DSCR_CMD0_UART0_TX, DEV_FLAGS_OUT, 0, 8, 0x11100004, 0, 0 },
-	{ DSCR_CMD0_UART0_RX, DEV_FLAGS_IN, 0, 8, 0x11100000, 0, 0 },
-	{ DSCR_CMD0_UART1_TX, DEV_FLAGS_OUT, 0, 8, 0x11200004, 0, 0 },
-	{ DSCR_CMD0_UART1_RX, DEV_FLAGS_IN, 0, 8, 0x11200000, 0, 0 },
-
-	{ DSCR_CMD0_DMA_REQ0, 0, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_DMA_REQ1, 0, 0, 0, 0x00000000, 0, 0 },
+	{ DSCR_CMD0_THROTTLE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ DSCR_CMD0_ALWAYS,   DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+};
 
-	{ DSCR_CMD0_MAE_BE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_MAE_FE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_MAE_BOTH, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_LCD, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+static dbdev_tab_t au1200_dbdev_tab[] __initdata = {
+	{ AU1200_DSCR_CMD0_UART0_TX, DEV_FLAGS_OUT, 0, 8, 0x11100004, 0, 0 },
+	{ AU1200_DSCR_CMD0_UART0_RX, DEV_FLAGS_IN,  0, 8, 0x11100000, 0, 0 },
+	{ AU1200_DSCR_CMD0_UART1_TX, DEV_FLAGS_OUT, 0, 8, 0x11200004, 0, 0 },
+	{ AU1200_DSCR_CMD0_UART1_RX, DEV_FLAGS_IN,  0, 8, 0x11200000, 0, 0 },
 
-	{ DSCR_CMD0_SDMS_TX0, DEV_FLAGS_OUT, 4, 8, 0x10600000, 0, 0 },
-	{ DSCR_CMD0_SDMS_RX0, DEV_FLAGS_IN, 4, 8, 0x10600004, 0, 0 },
-	{ DSCR_CMD0_SDMS_TX1, DEV_FLAGS_OUT, 4, 8, 0x10680000, 0, 0 },
-	{ DSCR_CMD0_SDMS_RX1, DEV_FLAGS_IN, 4, 8, 0x10680004, 0, 0 },
+	{ AU1200_DSCR_CMD0_DMA_REQ0, 0, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_DMA_REQ1, 0, 0, 0, 0x00000000, 0, 0 },
 
-	{ DSCR_CMD0_AES_RX, DEV_FLAGS_IN , 4, 32, 0x10300008, 0, 0 },
-	{ DSCR_CMD0_AES_TX, DEV_FLAGS_OUT, 4, 32, 0x10300004, 0, 0 },
+	{ AU1200_DSCR_CMD0_MAE_BE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_MAE_FE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_MAE_BOTH, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_LCD, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 
-	{ DSCR_CMD0_PSC0_TX, DEV_FLAGS_OUT, 0, 16, 0x11a0001c, 0, 0 },
-	{ DSCR_CMD0_PSC0_RX, DEV_FLAGS_IN, 0, 16, 0x11a0001c, 0, 0 },
-	{ DSCR_CMD0_PSC0_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_SDMS_TX0, DEV_FLAGS_OUT, 4, 8, 0x10600000, 0, 0 },
+	{ AU1200_DSCR_CMD0_SDMS_RX0, DEV_FLAGS_IN,  4, 8, 0x10600004, 0, 0 },
+	{ AU1200_DSCR_CMD0_SDMS_TX1, DEV_FLAGS_OUT, 4, 8, 0x10680000, 0, 0 },
+	{ AU1200_DSCR_CMD0_SDMS_RX1, DEV_FLAGS_IN,  4, 8, 0x10680004, 0, 0 },
 
-	{ DSCR_CMD0_PSC1_TX, DEV_FLAGS_OUT, 0, 16, 0x11b0001c, 0, 0 },
-	{ DSCR_CMD0_PSC1_RX, DEV_FLAGS_IN, 0, 16, 0x11b0001c, 0, 0 },
-	{ DSCR_CMD0_PSC1_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_AES_RX, DEV_FLAGS_IN , 4, 32, 0x10300008, 0, 0 },
+	{ AU1200_DSCR_CMD0_AES_TX, DEV_FLAGS_OUT, 4, 32, 0x10300004, 0, 0 },
 
-	{ DSCR_CMD0_CIM_RXA, DEV_FLAGS_IN, 0, 32, 0x14004020, 0, 0 },
-	{ DSCR_CMD0_CIM_RXB, DEV_FLAGS_IN, 0, 32, 0x14004040, 0, 0 },
-	{ DSCR_CMD0_CIM_RXC, DEV_FLAGS_IN, 0, 32, 0x14004060, 0, 0 },
-	{ DSCR_CMD0_CIM_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_PSC0_TX,   DEV_FLAGS_OUT, 0, 16, 0x11a0001c, 0, 0 },
+	{ AU1200_DSCR_CMD0_PSC0_RX,   DEV_FLAGS_IN,  0, 16, 0x11a0001c, 0, 0 },
+	{ AU1200_DSCR_CMD0_PSC0_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_PSC1_TX,   DEV_FLAGS_OUT, 0, 16, 0x11b0001c, 0, 0 },
+	{ AU1200_DSCR_CMD0_PSC1_RX,   DEV_FLAGS_IN,  0, 16, 0x11b0001c, 0, 0 },
+	{ AU1200_DSCR_CMD0_PSC1_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 
-	{ DSCR_CMD0_NAND_FLASH, DEV_FLAGS_IN, 0, 0, 0x00000000, 0, 0 },
+	{ AU1200_DSCR_CMD0_CIM_RXA,  DEV_FLAGS_IN, 0, 32, 0x14004020, 0, 0 },
+	{ AU1200_DSCR_CMD0_CIM_RXB,  DEV_FLAGS_IN, 0, 32, 0x14004040, 0, 0 },
+	{ AU1200_DSCR_CMD0_CIM_RXC,  DEV_FLAGS_IN, 0, 32, 0x14004060, 0, 0 },
+	{ AU1200_DSCR_CMD0_CIM_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 
-#endif /* CONFIG_SOC_AU1200 */
+	{ AU1200_DSCR_CMD0_NAND_FLASH, DEV_FLAGS_IN, 0, 0, 0x00000000, 0, 0 },
 
 	{ DSCR_CMD0_THROTTLE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
-	{ DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
-
-	/* Provide 16 user definable device types */
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
-	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_CMD0_ALWAYS,   DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 };
 
-#define DBDEV_TAB_SIZE	ARRAY_SIZE(dbdev_tab)
-
+/* 32 predefined plus 32 custom */
+#define DBDEV_TAB_SIZE		64
 
 static chan_tab_t *chan_tab_ptr[NUM_DBDMA_CHANS];
 
@@ -1028,38 +1002,43 @@ static struct syscore_ops alchemy_dbdma_syscore_ops = {
 	.resume		= alchemy_dbdma_resume,
 };
 
-static int __init au1xxx_dbdma_init(void)
+static int __init dbdma_setup(unsigned int irq, dbdev_tab_t *idtable)
 {
-	int irq_nr, ret;
+	int ret;
+
+	dbdev_tab = kzalloc(sizeof(dbdev_tab_t) * DBDEV_TAB_SIZE, GFP_KERNEL);
+	if (!dbdev_tab)
+		return -ENOMEM;
+
+	memcpy(dbdev_tab, idtable, 32 * sizeof(dbdev_tab_t));
+	for (ret = 32; ret < DBDEV_TAB_SIZE; ret++)
+		dbdev_tab[ret].dev_id = ~0;
 
 	dbdma_gptr->ddma_config = 0;
 	dbdma_gptr->ddma_throttle = 0;
 	dbdma_gptr->ddma_inten = 0xffff;
 	au_sync();
 
-	switch (alchemy_get_cputype()) {
-	case ALCHEMY_CPU_AU1550:
-		irq_nr = AU1550_DDMA_INT;
-		break;
-	case ALCHEMY_CPU_AU1200:
-		irq_nr = AU1200_DDMA_INT;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	ret = request_irq(irq_nr, dbdma_interrupt, IRQF_DISABLED,
-			"Au1xxx dbdma", (void *)dbdma_gptr);
+	ret = request_irq(irq, dbdma_interrupt, IRQF_DISABLED, "dbdma",
+			  (void *)dbdma_gptr);
 	if (ret)
 		printk(KERN_ERR "Cannot grab DBDMA interrupt!\n");
 	else {
 		dbdma_initialized = 1;
-		printk(KERN_INFO "Alchemy DBDMA initialized\n");
 		register_syscore_ops(&alchemy_dbdma_syscore_ops);
 	}
 
 	return ret;
 }
-subsys_initcall(au1xxx_dbdma_init);
 
-#endif /* defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) */
+static int __init alchemy_dbdma_init(void)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1550:
+		return dbdma_setup(AU1550_DDMA_INT, au1550_dbdev_tab);
+	case ALCHEMY_CPU_AU1200:
+		return dbdma_setup(AU1200_DDMA_INT, au1200_dbdev_tab);
+	}
+	return 0;
+}
+subsys_initcall(alchemy_dbdma_init);
diff --git a/arch/mips/alchemy/common/dma.c b/arch/mips/alchemy/common/dma.c
index 6652a23..9b624e2 100644
--- a/arch/mips/alchemy/common/dma.c
+++ b/arch/mips/alchemy/common/dma.c
@@ -40,8 +40,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
 
-#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1500) || \
-    defined(CONFIG_SOC_AU1100)
 /*
  * A note on resource allocation:
  *
@@ -170,13 +168,13 @@ int request_au1000_dma(int dev_id, const char *dev_str,
 	const struct dma_dev *dev;
 	int i, ret;
 
-#if defined(CONFIG_SOC_AU1100)
-	if (dev_id < 0 || dev_id >= (DMA_NUM_DEV + DMA_NUM_DEV_BANK2))
-		return -EINVAL;
-#else
-	if (dev_id < 0 || dev_id >= DMA_NUM_DEV)
-		return -EINVAL;
-#endif
+	if (alchemy_get_cputype() == ALCHEMY_CPU_AU1100) {
+		if (dev_id < 0 || dev_id >= (DMA_NUM_DEV + DMA_NUM_DEV_BANK2))
+			return -EINVAL;
+	} else {
+		if (dev_id < 0 || dev_id >= DMA_NUM_DEV)
+			return -EINVAL;
+	}
 
 	for (i = 0; i < NUM_AU1000_DMA_CHANNELS; i++)
 		if (au1000_dma_table[i].dev_id < 0)
@@ -239,30 +237,28 @@ EXPORT_SYMBOL(free_au1000_dma);
 
 static int __init au1000_dma_init(void)
 {
-        int base, i;
-
-        switch (alchemy_get_cputype()) {
-        case ALCHEMY_CPU_AU1000:
-                base = AU1000_DMA_INT_BASE;
-                break;
-        case ALCHEMY_CPU_AU1500:
-                base = AU1500_DMA_INT_BASE;
-                break;
-        case ALCHEMY_CPU_AU1100:
-                base = AU1100_DMA_INT_BASE;
-                break;
-        default:
-                goto out;
-        }
-
-        for (i = 0; i < NUM_AU1000_DMA_CHANNELS; i++)
-                au1000_dma_table[i].irq = base + i;
-
-        printk(KERN_INFO "Alchemy DMA initialized\n");
+	int base, i;
+
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+		base = AU1000_DMA_INT_BASE;
+		break;
+	case ALCHEMY_CPU_AU1500:
+		base = AU1500_DMA_INT_BASE;
+		break;
+	case ALCHEMY_CPU_AU1100:
+		base = AU1100_DMA_INT_BASE;
+		break;
+	default:
+		goto out;
+	}
+
+	for (i = 0; i < NUM_AU1000_DMA_CHANNELS; i++)
+		au1000_dma_table[i].irq = base + i;
+
+	printk(KERN_INFO "Alchemy DMA initialized\n");
 
 out:
-        return 0;
+	return 0;
 }
 arch_initcall(au1000_dma_init);
-
-#endif /* AU1000 AU1500 AU1100 */
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index bf1ac41..7eca306 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -263,13 +263,13 @@ static struct resource au1200_mmc0_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start		= DSCR_CMD0_SDMS_TX0,
-		.end		= DSCR_CMD0_SDMS_TX0,
+		.start		= AU1200_DSCR_CMD0_SDMS_TX0,
+		.end		= AU1200_DSCR_CMD0_SDMS_TX0,
 		.flags		= IORESOURCE_DMA,
 	},
 	[3] = {
-		.start          = DSCR_CMD0_SDMS_RX0,
-		.end		= DSCR_CMD0_SDMS_RX0,
+		.start          = AU1200_DSCR_CMD0_SDMS_RX0,
+		.end		= AU1200_DSCR_CMD0_SDMS_RX0,
 		.flags          = IORESOURCE_DMA,
 	}
 };
@@ -299,13 +299,13 @@ static struct resource au1200_mmc1_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start		= DSCR_CMD0_SDMS_TX1,
-		.end		= DSCR_CMD0_SDMS_TX1,
+		.start		= AU1200_DSCR_CMD0_SDMS_TX1,
+		.end		= AU1200_DSCR_CMD0_SDMS_TX1,
 		.flags		= IORESOURCE_DMA,
 	},
 	[3] = {
-		.start          = DSCR_CMD0_SDMS_RX1,
-		.end		= DSCR_CMD0_SDMS_RX1,
+		.start          = AU1200_DSCR_CMD0_SDMS_RX1,
+		.end		= AU1200_DSCR_CMD0_SDMS_RX1,
 		.flags          = IORESOURCE_DMA,
 	}
 };
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index 6fd070d..1bc16f0 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -215,8 +215,8 @@ static struct resource db1200_ide_res[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start	= DSCR_CMD0_DMA_REQ1,
-		.end	= DSCR_CMD0_DMA_REQ1,
+		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
+		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
 		.flags	= IORESOURCE_DMA,
 	},
 };
@@ -358,13 +358,13 @@ static struct resource au1200_psc0_res[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start	= DSCR_CMD0_PSC0_TX,
-		.end	= DSCR_CMD0_PSC0_TX,
+		.start	= AU1200_DSCR_CMD0_PSC0_TX,
+		.end	= AU1200_DSCR_CMD0_PSC0_TX,
 		.flags	= IORESOURCE_DMA,
 	},
 	[3] = {
-		.start	= DSCR_CMD0_PSC0_RX,
-		.end	= DSCR_CMD0_PSC0_RX,
+		.start	= AU1200_DSCR_CMD0_PSC0_RX,
+		.end	= AU1200_DSCR_CMD0_PSC0_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 };
@@ -416,13 +416,13 @@ static struct resource au1200_psc1_res[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start	= DSCR_CMD0_PSC1_TX,
-		.end	= DSCR_CMD0_PSC1_TX,
+		.start	= AU1200_DSCR_CMD0_PSC1_TX,
+		.end	= AU1200_DSCR_CMD0_PSC1_TX,
 		.flags	= IORESOURCE_DMA,
 	},
 	[3] = {
-		.start	= DSCR_CMD0_PSC1_RX,
-		.end	= DSCR_CMD0_PSC1_RX,
+		.start	= AU1200_DSCR_CMD0_PSC1_RX,
+		.end	= AU1200_DSCR_CMD0_PSC1_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 };
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 6ac0494..7de4f88 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -118,8 +118,8 @@ static struct resource ide_resources[] = {
 		.flags	= IORESOURCE_IRQ
 	},
 	[2] = {
-		.start	= DSCR_CMD0_DMA_REQ1,
-		.end	= DSCR_CMD0_DMA_REQ1,
+		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
+		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
 		.flags	= IORESOURCE_DMA,
 	},
 };
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index 2fdacfe..323ce2d 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -126,66 +126,62 @@ typedef volatile struct au1xxx_ddma_desc {
 #define SW_STATUS_INUSE 	(1 << 0)
 
 /* Command 0 device IDs. */
-#ifdef CONFIG_SOC_AU1550
-#define DSCR_CMD0_UART0_TX	0
-#define DSCR_CMD0_UART0_RX	1
-#define DSCR_CMD0_UART3_TX	2
-#define DSCR_CMD0_UART3_RX	3
-#define DSCR_CMD0_DMA_REQ0	4
-#define DSCR_CMD0_DMA_REQ1	5
-#define DSCR_CMD0_DMA_REQ2	6
-#define DSCR_CMD0_DMA_REQ3	7
-#define DSCR_CMD0_USBDEV_RX0	8
-#define DSCR_CMD0_USBDEV_TX0	9
-#define DSCR_CMD0_USBDEV_TX1	10
-#define DSCR_CMD0_USBDEV_TX2	11
-#define DSCR_CMD0_USBDEV_RX3	12
-#define DSCR_CMD0_USBDEV_RX4	13
-#define DSCR_CMD0_PSC0_TX	14
-#define DSCR_CMD0_PSC0_RX	15
-#define DSCR_CMD0_PSC1_TX	16
-#define DSCR_CMD0_PSC1_RX	17
-#define DSCR_CMD0_PSC2_TX	18
-#define DSCR_CMD0_PSC2_RX	19
-#define DSCR_CMD0_PSC3_TX	20
-#define DSCR_CMD0_PSC3_RX	21
-#define DSCR_CMD0_PCI_WRITE	22
-#define DSCR_CMD0_NAND_FLASH	23
-#define DSCR_CMD0_MAC0_RX	24
-#define DSCR_CMD0_MAC0_TX	25
-#define DSCR_CMD0_MAC1_RX	26
-#define DSCR_CMD0_MAC1_TX	27
-#endif /* CONFIG_SOC_AU1550 */
-
-#ifdef CONFIG_SOC_AU1200
-#define DSCR_CMD0_UART0_TX	0
-#define DSCR_CMD0_UART0_RX	1
-#define DSCR_CMD0_UART1_TX	2
-#define DSCR_CMD0_UART1_RX	3
-#define DSCR_CMD0_DMA_REQ0	4
-#define DSCR_CMD0_DMA_REQ1	5
-#define DSCR_CMD0_MAE_BE	6
-#define DSCR_CMD0_MAE_FE	7
-#define DSCR_CMD0_SDMS_TX0	8
-#define DSCR_CMD0_SDMS_RX0	9
-#define DSCR_CMD0_SDMS_TX1	10
-#define DSCR_CMD0_SDMS_RX1	11
-#define DSCR_CMD0_AES_TX	13
-#define DSCR_CMD0_AES_RX	12
-#define DSCR_CMD0_PSC0_TX	14
-#define DSCR_CMD0_PSC0_RX	15
-#define DSCR_CMD0_PSC1_TX	16
-#define DSCR_CMD0_PSC1_RX	17
-#define DSCR_CMD0_CIM_RXA	18
-#define DSCR_CMD0_CIM_RXB	19
-#define DSCR_CMD0_CIM_RXC	20
-#define DSCR_CMD0_MAE_BOTH	21
-#define DSCR_CMD0_LCD		22
-#define DSCR_CMD0_NAND_FLASH	23
-#define DSCR_CMD0_PSC0_SYNC	24
-#define DSCR_CMD0_PSC1_SYNC	25
-#define DSCR_CMD0_CIM_SYNC	26
-#endif /* CONFIG_SOC_AU1200 */
+#define AU1550_DSCR_CMD0_UART0_TX	0
+#define AU1550_DSCR_CMD0_UART0_RX	1
+#define AU1550_DSCR_CMD0_UART3_TX	2
+#define AU1550_DSCR_CMD0_UART3_RX	3
+#define AU1550_DSCR_CMD0_DMA_REQ0	4
+#define AU1550_DSCR_CMD0_DMA_REQ1	5
+#define AU1550_DSCR_CMD0_DMA_REQ2	6
+#define AU1550_DSCR_CMD0_DMA_REQ3	7
+#define AU1550_DSCR_CMD0_USBDEV_RX0	8
+#define AU1550_DSCR_CMD0_USBDEV_TX0	9
+#define AU1550_DSCR_CMD0_USBDEV_TX1	10
+#define AU1550_DSCR_CMD0_USBDEV_TX2	11
+#define AU1550_DSCR_CMD0_USBDEV_RX3	12
+#define AU1550_DSCR_CMD0_USBDEV_RX4	13
+#define AU1550_DSCR_CMD0_PSC0_TX	14
+#define AU1550_DSCR_CMD0_PSC0_RX	15
+#define AU1550_DSCR_CMD0_PSC1_TX	16
+#define AU1550_DSCR_CMD0_PSC1_RX	17
+#define AU1550_DSCR_CMD0_PSC2_TX	18
+#define AU1550_DSCR_CMD0_PSC2_RX	19
+#define AU1550_DSCR_CMD0_PSC3_TX	20
+#define AU1550_DSCR_CMD0_PSC3_RX	21
+#define AU1550_DSCR_CMD0_PCI_WRITE	22
+#define AU1550_DSCR_CMD0_NAND_FLASH	23
+#define AU1550_DSCR_CMD0_MAC0_RX	24
+#define AU1550_DSCR_CMD0_MAC0_TX	25
+#define AU1550_DSCR_CMD0_MAC1_RX	26
+#define AU1550_DSCR_CMD0_MAC1_TX	27
+
+#define AU1200_DSCR_CMD0_UART0_TX	0
+#define AU1200_DSCR_CMD0_UART0_RX	1
+#define AU1200_DSCR_CMD0_UART1_TX	2
+#define AU1200_DSCR_CMD0_UART1_RX	3
+#define AU1200_DSCR_CMD0_DMA_REQ0	4
+#define AU1200_DSCR_CMD0_DMA_REQ1	5
+#define AU1200_DSCR_CMD0_MAE_BE		6
+#define AU1200_DSCR_CMD0_MAE_FE		7
+#define AU1200_DSCR_CMD0_SDMS_TX0	8
+#define AU1200_DSCR_CMD0_SDMS_RX0	9
+#define AU1200_DSCR_CMD0_SDMS_TX1	10
+#define AU1200_DSCR_CMD0_SDMS_RX1	11
+#define AU1200_DSCR_CMD0_AES_TX		13
+#define AU1200_DSCR_CMD0_AES_RX		12
+#define AU1200_DSCR_CMD0_PSC0_TX	14
+#define AU1200_DSCR_CMD0_PSC0_RX	15
+#define AU1200_DSCR_CMD0_PSC1_TX	16
+#define AU1200_DSCR_CMD0_PSC1_RX	17
+#define AU1200_DSCR_CMD0_CIM_RXA	18
+#define AU1200_DSCR_CMD0_CIM_RXB	19
+#define AU1200_DSCR_CMD0_CIM_RXC	20
+#define AU1200_DSCR_CMD0_MAE_BOTH	21
+#define AU1200_DSCR_CMD0_LCD		22
+#define AU1200_DSCR_CMD0_NAND_FLASH	23
+#define AU1200_DSCR_CMD0_PSC0_SYNC	24
+#define AU1200_DSCR_CMD0_PSC1_SYNC	25
+#define AU1200_DSCR_CMD0_CIM_SYNC	26
 
 #define DSCR_CMD0_THROTTLE	30
 #define DSCR_CMD0_ALWAYS	31
diff --git a/arch/mips/include/asm/mach-db1x00/db1x00.h b/arch/mips/include/asm/mach-db1x00/db1x00.h
index 115cc7c..a5affb0 100644
--- a/arch/mips/include/asm/mach-db1x00/db1x00.h
+++ b/arch/mips/include/asm/mach-db1x00/db1x00.h
@@ -31,10 +31,10 @@
 
 #ifdef CONFIG_MIPS_DB1550
 
-#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC3_TX
-#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC3_RX
+#define DBDMA_AC97_TX_CHAN	AU1550_DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN	AU1550_DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN	AU1550_DSCR_CMD0_PSC3_TX
+#define DBDMA_I2S_RX_CHAN	AU1550_DSCR_CMD0_PSC3_RX
 
 #define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
 #define AC97_PSC_BASE		AU1550_PSC1_PHYS_ADDR
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
index 56865e9..374416a 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1200.h
@@ -28,10 +28,10 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC1_TX
-#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC1_RX
+#define DBDMA_AC97_TX_CHAN	AU1200_DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN	AU1200_DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN	AU1200_DSCR_CMD0_PSC1_TX
+#define DBDMA_I2S_RX_CHAN	AU1200_DSCR_CMD0_PSC1_RX
 
 /*
  * SPI and SMB are muxed on the Pb1200 board.
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1550.h b/arch/mips/include/asm/mach-pb1x00/pb1550.h
index 0b0f462..443b88a 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1550.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1550.h
@@ -30,10 +30,10 @@
 #include <linux/types.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC3_TX
-#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC3_RX
+#define DBDMA_AC97_TX_CHAN	AU1550_DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN	AU1550_DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN	AU1550_DSCR_CMD0_PSC3_TX
+#define DBDMA_I2S_RX_CHAN	AU1550_DSCR_CMD0_PSC3_RX
 
 #define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
 #define AC97_PSC_BASE		AU1550_PSC1_PHYS_ADDR
-- 
1.7.6
