Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 11:51:00 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:59657 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994683AbeGEJqBx9FqY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jul 2018 11:46:01 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9420620913; Thu,  5 Jul 2018 11:45:55 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1783320914;
        Thu,  5 Jul 2018 11:45:30 +0200 (CEST)
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
        linux-wireless@vger.kernel.org
Subject: [PATCH 24/27] MIPS: jz4740: Move jz4740_nand.h header to include/linux/platform_data/jz4740
Date:   Thu,  5 Jul 2018 11:45:19 +0200
Message-Id: <20180705094522.12138-25-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705094522.12138-1-boris.brezillon@bootlin.com>
References: <20180705094522.12138-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64669
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

This way we will be able to compile the jz4740_nand driver when
COMPILE_TEST=y.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 arch/mips/jz4740/board-qi_lb60.c                                      | 3 ++-
 drivers/mtd/nand/raw/jz4740_nand.c                                    | 2 +-
 .../mach-jz4740 => include/linux/platform_data/jz4740}/jz4740_nand.h  | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)
 rename {arch/mips/include/asm/mach-jz4740 => include/linux/platform_data/jz4740}/jz4740_nand.h (91%)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 60f0767507c6..af0c8ace0141 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -29,10 +29,11 @@
 #include <linux/power/gpio-charger.h>
 #include <linux/pwm.h>
 
+#include <linux/platform_data/jz4740/jz4740_nand.h>
+
 #include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
-#include <asm/mach-jz4740/jz4740_nand.h>
 
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 613b00a9604b..a0254461812d 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -25,7 +25,7 @@
 
 #include <linux/gpio.h>
 
-#include <asm/mach-jz4740/jz4740_nand.h>
+#include <linux/platform_data/jz4740/jz4740_nand.h>
 
 #define JZ_REG_NAND_CTRL	0x50
 #define JZ_REG_NAND_ECC_CTRL	0x100
diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h b/include/linux/platform_data/jz4740/jz4740_nand.h
similarity index 91%
rename from arch/mips/include/asm/mach-jz4740/jz4740_nand.h
rename to include/linux/platform_data/jz4740/jz4740_nand.h
index f381d465e768..bc571f6d5ced 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
+++ b/include/linux/platform_data/jz4740/jz4740_nand.h
@@ -13,8 +13,8 @@
  *
  */
 
-#ifndef __ASM_MACH_JZ4740_JZ4740_NAND_H__
-#define __ASM_MACH_JZ4740_JZ4740_NAND_H__
+#ifndef __JZ4740_NAND_H__
+#define __JZ4740_NAND_H__
 
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-- 
2.14.1
