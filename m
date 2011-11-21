Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 17:11:50 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:40735 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903800Ab1KUQIC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 17:08:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id D118A3B3B42;
        Mon, 21 Nov 2011 17:08:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P8JdyqfaGhT9; Mon, 21 Nov 2011 17:08:01 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 8CC2C3B0BB3;
        Mon, 21 Nov 2011 17:08:01 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 8/8 v2] MIPS: BCM63XX: make board setup code register the spi platform device
Date:   Mon, 21 Nov 2011 17:07:23 +0100
Message-Id: <1321891643-4119-9-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321891643-4119-1-git-send-email-florian@openwrt.org>
References: <1321891643-4119-1-git-send-email-florian@openwrt.org>
X-archive-position: 31890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17468

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1

 arch/mips/bcm63xx/boards/board_bcm963xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index e62461f..4f5f66f 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -25,6 +25,7 @@
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
 #include <bcm63xx_dev_pcmcia.h>
+#include <bcm63xx_dev_spi.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -887,6 +888,8 @@ int __init board_register_devices(void)
 	}
 #endif
 
+	bcm63xx_spi_register();
+
 	/* read base address of boot chip select (0) */
 	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
 	val &= MPI_CSBASE_BASE_MASK;
-- 
1.7.5.4
