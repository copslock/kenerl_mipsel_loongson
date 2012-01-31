Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:12:48 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59627 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904027Ab2AaOLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:11:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 1F0AF358722;
        Tue, 31 Jan 2012 15:11:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AwosbyQqHrGB; Tue, 31 Jan 2012 15:11:10 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 4F69E35880C;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 8/9 v3] MIPS: BCM63XX: make board setup code register the spi platform device
Date:   Tue, 31 Jan 2012 15:10:47 +0100
Message-Id: <1328019048-5892-9-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019048-5892-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
X-archive-position: 32352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1 and v2

 arch/mips/bcm63xx/boards/board_bcm963xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 2f1773f..ea65c0f 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -25,6 +25,7 @@
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
 #include <bcm63xx_dev_pcmcia.h>
+#include <bcm63xx_dev_spi.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -890,6 +891,8 @@ int __init board_register_devices(void)
 	}
 #endif
 
+	bcm63xx_spi_register();
+
 	/* read base address of boot chip select (0) */
 	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
 	val &= MPI_CSBASE_BASE_MASK;
-- 
1.7.5.4
