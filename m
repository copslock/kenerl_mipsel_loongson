Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:13:58 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59620 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904024Ab2AaOLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:11:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 08C9C3586AF;
        Tue, 31 Jan 2012 15:11:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gW5OOWUFEhOd; Tue, 31 Jan 2012 15:11:10 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 0387F3588D7;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/9 v3] MIPS: BCM63XX: add IRQ_SPI and CPU specific SPI IRQ values
Date:   Tue, 31 Jan 2012 15:10:40 +0100
Message-Id: <1328019048-5892-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019048-5892-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
X-archive-position: 32355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1 and v2

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 5b8d15b..9975727 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -478,6 +478,7 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
  */
 enum bcm63xx_irq {
 	IRQ_TIMER = 0,
+	IRQ_SPI,
 	IRQ_UART0,
 	IRQ_UART1,
 	IRQ_DSL,
@@ -509,6 +510,7 @@ enum bcm63xx_irq {
  * 6338 irqs
  */
 #define BCM_6338_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6338_SPI_IRQ		(IRQ_INTERNAL_BASE + 1)
 #define BCM_6338_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
 #define BCM_6338_UART1_IRQ		0
 #define BCM_6338_DSL_IRQ		(IRQ_INTERNAL_BASE + 5)
@@ -539,6 +541,7 @@ enum bcm63xx_irq {
  * 6345 irqs
  */
 #define BCM_6345_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6345_SPI_IRQ		0
 #define BCM_6345_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
 #define BCM_6345_UART1_IRQ		0
 #define BCM_6345_DSL_IRQ		(IRQ_INTERNAL_BASE + 3)
@@ -569,6 +572,7 @@ enum bcm63xx_irq {
  * 6348 irqs
  */
 #define BCM_6348_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6348_SPI_IRQ		(IRQ_INTERNAL_BASE + 1)
 #define BCM_6348_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
 #define BCM_6348_UART1_IRQ		0
 #define BCM_6348_DSL_IRQ		(IRQ_INTERNAL_BASE + 4)
@@ -599,6 +603,7 @@ enum bcm63xx_irq {
  * 6358 irqs
  */
 #define BCM_6358_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6358_SPI_IRQ		(IRQ_INTERNAL_BASE + 1)
 #define BCM_6358_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
 #define BCM_6358_UART1_IRQ		(IRQ_INTERNAL_BASE + 3)
 #define BCM_6358_DSL_IRQ		(IRQ_INTERNAL_BASE + 29)
@@ -638,6 +643,7 @@ enum bcm63xx_irq {
 #define BCM_6368_HIGH_IRQ_BASE		(IRQ_INTERNAL_BASE + 32)
 
 #define BCM_6368_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6368_SPI_IRQ		(IRQ_INTERNAL_BASE + 1)
 #define BCM_6368_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
 #define BCM_6368_UART1_IRQ		(IRQ_INTERNAL_BASE + 3)
 #define BCM_6368_DSL_IRQ		(IRQ_INTERNAL_BASE + 4)
@@ -677,6 +683,7 @@ extern const int *bcm63xx_irqs;
 
 #define __GEN_CPU_IRQ_TABLE(__cpu)					\
 	[IRQ_TIMER]		= BCM_## __cpu ##_TIMER_IRQ,		\
+	[IRQ_SPI]		= BCM_## __cpu ##_SPI_IRQ,		\
 	[IRQ_UART0]		= BCM_## __cpu ##_UART0_IRQ,		\
 	[IRQ_UART1]		= BCM_## __cpu ##_UART1_IRQ,		\
 	[IRQ_DSL]		= BCM_## __cpu ##_DSL_IRQ,		\
-- 
1.7.5.4
