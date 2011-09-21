Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:43:37 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50311 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491876Ab1IUNkf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 15:40:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id BB6D332A4D0;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9JDcb4PakrE1; Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 6B24432D671;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <ffainelli@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/5] MIPS: bcm63xx: remove BCM6345 hacks to read base boot address
Date:   Wed, 21 Sep 2011 15:39:49 +0200
Message-Id: <1316612390-6367-7-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1316612390-6367-1-git-send-email-florian@openwrt.org>
References: <1316612390-6367-1-git-send-email-florian@openwrt.org>
X-archive-position: 31122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11655

From: Florian Fainelli <ffainelli@freebox.fr>

Though BCM6345 does not technically have the same MPI register layout
than the other SoCs, reading the chip-select registers is done the same
way, and particularly for chip-select 0, which is the boot flash.
Now that BCM6345 has a MPI_BASE register defined, use it.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 40b223b..ac948c2 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -709,15 +709,9 @@ void __init board_prom_init(void)
 	char cfe_version[32];
 	u32 val;
 
-	/* read base address of boot chip select (0)
-	 * 6345 does not have MPI but boots from standard
-	 * MIPS Flash address */
-	if (BCMCPU_IS_6345())
-		val = 0x1fc00000;
-	else {
-		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-		val &= MPI_CSBASE_BASE_MASK;
-	}
+	/* read base address of boot chip select (0) */
+	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+	val &= MPI_CSBASE_BASE_MASK;
 	boot_addr = (u8 *)KSEG1ADDR(val);
 
 	/* dump cfe version */
@@ -893,12 +887,9 @@ int __init board_register_devices(void)
 		bcm63xx_dsp_register(&board.dsp);
 
 	/* read base address of boot chip select (0) */
-	if (BCMCPU_IS_6345())
-		val = 0x1fc00000;
-	else {
-		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-		val &= MPI_CSBASE_BASE_MASK;
-	}
+	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+	val &= MPI_CSBASE_BASE_MASK;
+
 	mtd_resources[0].start = val;
 	mtd_resources[0].end = 0x1FFFFFFF;
 
-- 
1.7.4.1
