Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 07:58:40 +0100 (CET)
Received: from mail-wg0-f53.google.com ([74.125.82.53]:50152 "EHLO
        mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006613AbaLAG6i5WKdQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2014 07:58:38 +0100
Received: by mail-wg0-f53.google.com with SMTP id l18so13036097wgh.26
        for <multiple recipients>; Sun, 30 Nov 2014 22:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=BxijoM9xeVwNOBHsXN7Lzq83Kq2bMluIs2ZCmnaCeSU=;
        b=ui5Q+2G42EQBKBkrokIPxgw+SaHg9bUDsVnDLmGPdqiH8Z3cBGuQT8Ig6efwoJJff0
         dGxXfUN7sePRQfqWlUJytmBhMk4HKAvBcn65XbZ9l0exNm2efn2iAbkiBbz9X/HNRji9
         5oa73vrqrJOGH0ckdfp0yhXsCeTbJJO2vGlRAG3mQPEJdW6UeUhILwXyBb56XEA3cHoZ
         BooDSp9WEwxVssMphEw69XuZPbytXQ/JCbFpb7MEX+Kthm2Di4jU7T20OVH2fDynQbD9
         GrLUMdlNzXpxYo5kdElLdKg/TYwQInRsbiMGsEwPAZj/78Vl44YkoD4YmvMT1sCobEcC
         GHrQ==
X-Received: by 10.194.150.148 with SMTP id ui20mr90070414wjb.90.1417417113772;
        Sun, 30 Nov 2014 22:58:33 -0800 (PST)
Received: from linux-tdhb.lan (static-91-227-21-4.devs.futuro.pl. [91.227.21.4])
        by mx.google.com with ESMTPSA id ck7sm10887362wjb.13.2014.11.30.22.58.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 22:58:33 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul@pwsan.com>, linux-soc@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Move NVRAM header to the include/linux/
Date:   Mon,  1 Dec 2014 07:58:18 +0100
Message-Id: <1417417098-8476-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

There are two reasons for having this header in the common place:
1) Simplifying drivers that read NVRAM entries. We will be able to
   safely call bcm47xx_nvram_* functions without #ifdef-s.
2) Getting NVRAM driver out of MIPS arch code. This is needed to support
   BCM5301X arch which also requires this NVRAM driver. Patch for that
   will follow once we get is reviewed.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
Hi guys,

As recently discussed (thanks Paul!), we will try yet another (3rd) path for our
NVRAM driver, this time it will be drivers/firmware/.
However this will require some time as I want to give ppl chance to review it
and probably we will need to discuss it too.

So meanwhile I'd like to move just a header file to the include/linux/. I
believe it won't raise any/too many objections and it should strip down
further discussions about bcm47xx_nvram.c.
---
 arch/mips/bcm47xx/board.c                             |  2 +-
 arch/mips/bcm47xx/nvram.c                             |  2 +-
 arch/mips/bcm47xx/setup.c                             |  1 -
 arch/mips/bcm47xx/sprom.c                             |  1 -
 arch/mips/bcm47xx/time.c                              |  1 -
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h          |  1 +
 drivers/bcma/driver_mips.c                            |  2 +-
 drivers/net/ethernet/broadcom/b44.c                   |  2 +-
 drivers/net/ethernet/broadcom/bgmac.c                 |  2 +-
 drivers/ssb/driver_chipcommon_pmu.c                   |  2 +-
 drivers/ssb/driver_mipscore.c                         |  2 +-
 .../mach-bcm47xx => include/linux}/bcm47xx_nvram.h    | 19 ++++++++++++++++---
 12 files changed, 24 insertions(+), 13 deletions(-)
 rename {arch/mips/include/asm/mach-bcm47xx => include/linux}/bcm47xx_nvram.h (63%)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index b3ae068..6e85130 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -1,8 +1,8 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/string.h>
+#include <bcm47xx.h>
 #include <bcm47xx_board.h>
-#include <bcm47xx_nvram.h>
 
 struct bcm47xx_board_type {
 	const enum bcm47xx_board board;
diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index c5c381c..65da3b0 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/mtd/mtd.h>
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 
 #define NVRAM_MAGIC		0x48534C46	/* 'FLSH' */
 #define NVRAM_SPACE		0x8000
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index e43b504..b26c9c2 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -42,7 +42,6 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <bcm47xx_board.h>
 
 union bcm47xx_bus bcm47xx_bus;
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 2eff7fe..a077ed2 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -27,7 +27,6 @@
  */
 
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 
diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 2c85d92..5b46510 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -27,7 +27,6 @@
 #include <linux/ssb/ssb.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <bcm47xx_board.h>
 
 void __init plat_time_init(void)
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 7527c1d..8ed77f6 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -22,6 +22,7 @@
 #include <linux/ssb/ssb.h>
 #include <linux/bcma/bcma.h>
 #include <linux/bcma/bcma_soc.h>
+#include <linux/bcm47xx_nvram.h>
 
 enum bcm47xx_bus_type {
 #ifdef CONFIG_BCM47XX_SSB
diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 8a653dc..15e278f 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -21,7 +21,7 @@
 #include <linux/serial_reg.h>
 #include <linux/time.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 enum bcma_boot_dev {
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 416620f..2095062 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -400,7 +400,7 @@ static void b44_set_flow_ctrl(struct b44 *bp, u32 local, u32 remote)
 }
 
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 static void b44_wap54g10_workaround(struct b44 *bp)
 {
 	char buf[20];
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 05c6af6..bdda57b 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -16,7 +16,7 @@
 #include <linux/phy.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 
 static const struct bcma_device_id bgmac_bcma_tbl[] = {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_4706_MAC_GBIT, BCMA_ANY_REV, BCMA_ANY_CLASS),
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index 1173a09..0942841 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 #include "ssb_private.h"
diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index 7b986f9..f87efef 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -16,7 +16,7 @@
 #include <linux/serial_reg.h>
 #include <linux/time.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 #include "ssb_private.h"
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
similarity index 63%
rename from arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
rename to include/linux/bcm47xx_nvram.h
index ee59ffe..b12b07e 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -1,7 +1,4 @@
 /*
- *  Copyright (C) 2005, Broadcom Corporation
- *  Copyright (C) 2006, Felix Fietkau <nbd@openwrt.org>
- *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
@@ -14,8 +11,24 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 
+#ifdef CONFIG_BCM47XX
 int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
 int bcm47xx_nvram_gpio_pin(const char *name);
+#else
+static inline int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
+{
+	return -ENOTSUPP;
+};
+static inline int bcm47xx_nvram_getenv(const char *name, char *val,
+				       size_t val_len)
+{
+	return -ENOTSUPP;
+};
+static inline int bcm47xx_nvram_gpio_pin(const char *name)
+{
+	return -ENOTSUPP;
+};
+#endif
 
 #endif /* __BCM47XX_NVRAM_H */
-- 
1.8.4.5
