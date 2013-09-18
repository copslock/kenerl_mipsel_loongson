Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:33:10 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44793 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824104Ab3IRLdIMEwlX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 13:33:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C13EB8F62;
        Wed, 18 Sep 2013 13:33:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WceLv3opVUqq; Wed, 18 Sep 2013 13:33:03 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id EC300857F;
        Wed, 18 Sep 2013 13:33:02 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] MIPS: BCM47XX: fix clock detection for BCM5354 with 200MHz clock
Date:   Wed, 18 Sep 2013 13:32:59 +0200
Message-Id: <1379503980-9156-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Some BCM5354 SoCs are running at 200MHz, but it is not possible to read
the clock from a register like it is done on some other SoC in ssb and
bcma. These devices should have a clkfreq nvram configuration value set
to 200, read it and set the clock to the correct value.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/time.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 536374d..5e5d797 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -27,10 +27,14 @@
 #include <linux/ssb/ssb.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
+#include <bcm47xx_nvram.h>
 
 void __init plat_time_init(void)
 {
 	unsigned long hz = 0;
+	u16 chip_id = 0;
+	char buf[10];
+	int len;
 
 	/*
 	 * Use deterministic values for initial counter interrupt
@@ -43,15 +47,23 @@ void __init plat_time_init(void)
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		hz = ssb_cpu_clock(&bcm47xx_bus.ssb.mipscore) / 2;
+		chip_id = bcm47xx_bus.ssb.chip_id;
 		break;
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
 		hz = bcma_cpu_clock(&bcm47xx_bus.bcma.bus.drv_mips) / 2;
+		chip_id = bcm47xx_bus.bcma.bus.chipinfo.id;
 		break;
 #endif
 	}
 
+	if (chip_id == 0x5354) {
+		len = bcm47xx_nvram_getenv("clkfreq", buf, sizeof(buf));
+		if (len >= 0 && !strncmp(buf, "200", 4))
+			hz = 100000000;
+	}
+
 	if (!hz)
 		hz = 100000000;
 
-- 
1.7.10.4
