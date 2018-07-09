Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:16:28 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49461 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994675AbeGIUKUmfInt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:20 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 17B4920938; Mon,  9 Jul 2018 22:10:15 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 470912093A;
        Mon,  9 Jul 2018 22:09:59 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 19/24] MIPS: txx9: Move the ndfc.h header to include/linux/platform_data/txx9
Date:   Mon,  9 Jul 2018 22:09:40 +0200
Message-Id: <20180709200945.30116-20-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

This way we will be able to compile the ndfmc driver when
COMPILE_TEST=y.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 arch/mips/txx9/generic/setup.c                                      | 2 +-
 arch/mips/txx9/generic/setup_tx4938.c                               | 2 +-
 arch/mips/txx9/generic/setup_tx4939.c                               | 2 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                                    | 2 +-
 {arch/mips/include/asm => include/linux/platform_data}/txx9/ndfmc.h | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename {arch/mips/include/asm => include/linux/platform_data}/txx9/ndfmc.h (91%)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 1791a44ee570..aa47932abd28 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/txx9/ndfmc.h>
 #include <linux/serial_core.h>
 #include <linux/mtd/physmap.h>
 #include <linux/leds.h>
@@ -35,7 +36,6 @@
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9tmr.h>
-#include <asm/txx9/ndfmc.h>
 #include <asm/txx9/dmac.h>
 #ifdef CONFIG_CPU_TX49XX
 #include <asm/txx9/tx4938.h>
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 85d1795652da..17395d5d15ca 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -17,13 +17,13 @@
 #include <linux/ptrace.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/txx9/ndfmc.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
 #include <asm/txx9/generic.h>
-#include <asm/txx9/ndfmc.h>
 #include <asm/txx9/dmac.h>
 #include <asm/txx9/tx4938.h>
 
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index 274928987a21..360c388f4c82 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -21,13 +21,13 @@
 #include <linux/ptrace.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/txx9/ndfmc.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9/generic.h>
-#include <asm/txx9/ndfmc.h>
 #include <asm/txx9/dmac.h>
 #include <asm/txx9/tx4939.h>
 
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index b567d212fe7d..04d57474ef97 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -20,7 +20,7 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
-#include <asm/txx9/ndfmc.h>
+#include <linux/platform_data/txx9/ndfmc.h>
 
 /* TXX9 NDFMC Registers */
 #define TXX9_NDFDTR	0x00
diff --git a/arch/mips/include/asm/txx9/ndfmc.h b/include/linux/platform_data/txx9/ndfmc.h
similarity index 91%
rename from arch/mips/include/asm/txx9/ndfmc.h
rename to include/linux/platform_data/txx9/ndfmc.h
index fa67f3df78fc..fc172627d54e 100644
--- a/arch/mips/include/asm/txx9/ndfmc.h
+++ b/include/linux/platform_data/txx9/ndfmc.h
@@ -5,8 +5,8 @@
  *
  * (C) Copyright TOSHIBA CORPORATION 2007
  */
-#ifndef __ASM_TXX9_NDFMC_H
-#define __ASM_TXX9_NDFMC_H
+#ifndef __TXX9_NDFMC_H
+#define __TXX9_NDFMC_H
 
 #define NDFMC_PLAT_FLAG_USE_BSPRT	0x01
 #define NDFMC_PLAT_FLAG_NO_RSTR		0x02
@@ -27,4 +27,4 @@ struct txx9ndfmc_platform_data {
 void txx9_ndfmc_init(unsigned long baseaddr,
 		     const struct txx9ndfmc_platform_data *plat_data);
 
-#endif /* __ASM_TXX9_NDFMC_H */
+#endif /* __TXX9_NDFMC_H */
-- 
2.14.1
