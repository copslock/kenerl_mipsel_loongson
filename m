Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:12:25 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59612 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904023Ab2AaOLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:11:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id D96FD3586EA;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xd8KJbvSoEBo; Tue, 31 Jan 2012 15:11:10 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 3327F358744;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/9 v3] MIPS: BCM63XX: remove SPI2 register
Date:   Tue, 31 Jan 2012 15:10:44 +0100
Message-Id: <1328019048-5892-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019048-5892-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
X-archive-position: 32351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This register was introduced with the support of the BCM6368 CPU in the idea
that its internal layout was different from the other CPUs SPI controller.
The controller is actually the same as the one present on BCM6358 so we can
remove this register and use the usual SPI register instead.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1 and v2

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 4c1e147..82a8175 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -102,7 +102,6 @@ enum bcm63xx_regs_set {
 	RSET_UART1,
 	RSET_GPIO,
 	RSET_SPI,
-	RSET_SPI2,
 	RSET_UDC0,
 	RSET_OHCI0,
 	RSET_OHCI_PRIV,
@@ -166,7 +165,6 @@ enum bcm63xx_regs_set {
 #define BCM_6338_UART1_BASE		(0xdeadbeef)
 #define BCM_6338_GPIO_BASE		(0xfffe0400)
 #define BCM_6338_SPI_BASE		(0xfffe0c00)
-#define BCM_6338_SPI2_BASE		(0xdeadbeef)
 #define BCM_6338_UDC0_BASE		(0xdeadbeef)
 #define BCM_6338_USBDMA_BASE		(0xfffe2400)
 #define BCM_6338_OHCI0_BASE		(0xdeadbeef)
@@ -210,7 +208,6 @@ enum bcm63xx_regs_set {
 #define BCM_6345_UART1_BASE		(0xdeadbeef)
 #define BCM_6345_GPIO_BASE		(0xfffe0400)
 #define BCM_6345_SPI_BASE		(0xdeadbeef)
-#define BCM_6345_SPI2_BASE		(0xdeadbeef)
 #define BCM_6345_UDC0_BASE		(0xdeadbeef)
 #define BCM_6345_USBDMA_BASE		(0xfffe2800)
 #define BCM_6345_ENET0_BASE		(0xfffe1800)
@@ -253,7 +250,6 @@ enum bcm63xx_regs_set {
 #define BCM_6348_UART1_BASE		(0xdeadbeef)
 #define BCM_6348_GPIO_BASE		(0xfffe0400)
 #define BCM_6348_SPI_BASE		(0xfffe0c00)
-#define BCM_6348_SPI2_BASE		(0xdeadbeef)
 #define BCM_6348_UDC0_BASE		(0xfffe1000)
 #define BCM_6348_OHCI0_BASE		(0xfffe1b00)
 #define BCM_6348_OHCI_PRIV_BASE		(0xfffe1c00)
@@ -294,7 +290,6 @@ enum bcm63xx_regs_set {
 #define BCM_6358_UART1_BASE		(0xfffe0120)
 #define BCM_6358_GPIO_BASE		(0xfffe0080)
 #define BCM_6358_SPI_BASE		(0xfffe0800)
-#define BCM_6358_SPI2_BASE		(0xfffe0800)
 #define BCM_6358_UDC0_BASE		(0xfffe0800)
 #define BCM_6358_OHCI0_BASE		(0xfffe1400)
 #define BCM_6358_OHCI_PRIV_BASE		(0xdeadbeef)
@@ -335,8 +330,7 @@ enum bcm63xx_regs_set {
 #define BCM_6368_UART0_BASE		(0xb0000100)
 #define BCM_6368_UART1_BASE		(0xb0000120)
 #define BCM_6368_GPIO_BASE		(0xb0000080)
-#define BCM_6368_SPI_BASE		(0xdeadbeef)
-#define BCM_6368_SPI2_BASE		(0xb0000800)
+#define BCM_6368_SPI_BASE		(0xb0000800)
 #define BCM_6368_UDC0_BASE		(0xdeadbeef)
 #define BCM_6368_OHCI0_BASE		(0xb0001600)
 #define BCM_6368_OHCI_PRIV_BASE		(0xdeadbeef)
@@ -383,7 +377,6 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, UART1)					\
 	__GEN_RSET_BASE(__cpu, GPIO)					\
 	__GEN_RSET_BASE(__cpu, SPI)					\
-	__GEN_RSET_BASE(__cpu, SPI2)					\
 	__GEN_RSET_BASE(__cpu, UDC0)					\
 	__GEN_RSET_BASE(__cpu, OHCI0)					\
 	__GEN_RSET_BASE(__cpu, OHCI_PRIV)				\
@@ -422,7 +415,6 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_UART1]		= BCM_## __cpu ##_UART1_BASE,		\
 	[RSET_GPIO]		= BCM_## __cpu ##_GPIO_BASE,		\
 	[RSET_SPI]		= BCM_## __cpu ##_SPI_BASE,		\
-	[RSET_SPI2]		= BCM_## __cpu ##_SPI2_BASE,		\
 	[RSET_UDC0]		= BCM_## __cpu ##_UDC0_BASE,		\
 	[RSET_OHCI0]		= BCM_## __cpu ##_OHCI0_BASE,		\
 	[RSET_OHCI_PRIV]	= BCM_## __cpu ##_OHCI_PRIV_BASE,	\
-- 
1.7.5.4
