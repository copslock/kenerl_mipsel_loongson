Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 00:37:34 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:56773 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824799Ab3IXWhI2Fsif (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 00:37:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 33C67857F;
        Wed, 25 Sep 2013 00:37:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WTMBd5+XjfAA; Wed, 25 Sep 2013 00:37:05 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id A7DA38F61;
        Wed, 25 Sep 2013 00:37:00 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     sergei.shtylyov@cogentembedded.com, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 2/2] MIPS: BCM47XX: add EARLY_PRINTK_8250 support
Date:   Wed, 25 Sep 2013 00:36:56 +0200
Message-Id: <1380062216-24031-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1380062216-24031-1-git-send-email-hauke@hauke-m.de>
References: <1380062216-24031-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37946
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

The BCM47xx SoCs have a 8250 serial compatible console at address
0x18000300 and an other at 0x18000400. On most devices 0x18000300 is
wired to some pins on the board, we should use that.
This is the smae for the AI (bcma) and the SB (ssb) bus, this is some
offset on the chip common core.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig        |    2 ++
 arch/mips/bcm47xx/prom.c |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f73cb81..02a3a66 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -117,6 +117,8 @@ config BCM47XX
 	select NO_EXCEPT_FILL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
+	select EARLY_PRINTK_8250 if EARLY_PRINTK
 	help
 	 Support for BCM47XX based boards
 
diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 99c3ce2..0af808d 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -28,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
+#include <linux/ssb/ssb_driver_chipcommon.h>
+#include <linux/ssb/ssb_regs.h>
 #include <linux/smp.h>
 #include <asm/bootinfo.h>
 #include <bcm47xx.h>
@@ -94,9 +96,16 @@ static __init void prom_init_mem(void)
 	add_memory_region(0, mem, BOOT_MEM_RAM);
 }
 
+/*
+ * This is the first serial on the chip common core, it is at this position
+ * for sb (ssb) and ai (bcma) bus.
+ */
+#define BCM47XX_SERIAL_ADDR (SSB_ENUM_BASE + SSB_CHIPCO_UART0_DATA)
+
 void __init prom_init(void)
 {
 	prom_init_mem();
+	setup_8250_early_printk_port(CKSEG1ADDR(BCM47XX_SERIAL_ADDR), 0, 0);
 }
 
 void __init prom_free_prom_memory(void)
-- 
1.7.10.4
