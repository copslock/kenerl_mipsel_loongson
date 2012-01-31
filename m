Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:11:41 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59603 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904022Ab2AaOLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:11:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id C76493586EB;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7oe-azHHCEbh; Tue, 31 Jan 2012 15:11:10 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 2C9573586EA;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/9 v3] MIPS: BCM63XX: define SPI register sizes.
Date:   Tue, 31 Jan 2012 15:10:43 +0100
Message-Id: <1328019048-5892-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019048-5892-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
X-archive-position: 32349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

There are two distinct sizes for the SPI register depending on the SoC
generation (6338 & 6348 vs 6358 & 6368).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v2:
- added different sizes accounting for the different SPI controller FIFO sizes
No changes in v1

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 016dc9e..4c1e147 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -135,6 +135,10 @@ enum bcm63xx_regs_set {
 #define RSET_DSL_LMEM_SIZE		(64 * 1024 * 4)
 #define RSET_DSL_SIZE			4096
 #define RSET_WDT_SIZE			12
+#define BCM_6338_RSET_SPI_SIZE		64
+#define BCM_6348_RSET_SPI_SIZE		64
+#define BCM_6358_RSET_SPI_SIZE		1804
+#define BCM_6368_RSET_SPI_SIZE		1804
 #define RSET_ENET_SIZE			2048
 #define RSET_ENETDMA_SIZE		2048
 #define RSET_ENETSW_SIZE		65536
-- 
1.7.5.4
