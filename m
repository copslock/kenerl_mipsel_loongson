Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 18:05:25 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:34721 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903528Ab2HDQEI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Aug 2012 18:04:08 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 2A06423C00A1;
        Sat,  4 Aug 2012 18:04:05 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 3/3] MIPS: ath79: register USB host controller on the DB120 board
Date:   Sat,  4 Aug 2012 18:03:57 +0200
Message-Id: <1344096237-25221-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1344096237-25221-1-git-send-email-juhosg@openwrt.org>
References: <1344096237-25221-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 34061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/mach-db120.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/ath79/mach-db120.c b/arch/mips/ath79/mach-db120.c
index 1983e4d..42f540a 100644
--- a/arch/mips/ath79/mach-db120.c
+++ b/arch/mips/ath79/mach-db120.c
@@ -25,6 +25,7 @@
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
+#include "dev-usb.h"
 #include "dev-wmac.h"
 #include "pci.h"
 
@@ -126,6 +127,7 @@ static void __init db120_setup(void)
 					db120_gpio_keys);
 	ath79_register_spi(&db120_spi_data, db120_spi_info,
 			   ARRAY_SIZE(db120_spi_info));
+	ath79_register_usb();
 	ath79_register_wmac(art + DB120_WMAC_CALDATA_OFFSET);
 	db120_pci_init(art + DB120_PCIE_CALDATA_OFFSET);
 }
-- 
1.7.10
