Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 14:41:04 +0100 (CET)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57064 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011346AbaJ1NlCvsurQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 14:41:02 +0100
Received: by mail-wg0-f47.google.com with SMTP id a1so871676wgh.18
        for <multiple recipients>; Tue, 28 Oct 2014 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=AlODZ8FPEKdMLaaCHrpDpFm+C22nzrMS1psPUdBdWKs=;
        b=zihLhmi5U3/x4kcmpMIXdrmnKWSUD7pK2lendmkG65gzAuqYH8aw2BQ16ZLhBoYexq
         ylYUOYHVaOfISJL3GU473o7bbzqQdtbxt4YeWDSV97sMlGdxZvZ2vq+pSwqEEKGr9Ndo
         ShPD4dgSfwfek09wNFaqm94Xqf/0giLsUJXSqNdADJ2j7fMrMHOp4bb9x0mN8nMaTF//
         4hGZVvMXaVqunABRe4pJaT3zn+3UahtHF2CkLh4w196oINv8hgmJ5m8G77edd9SM8BFn
         JPqd/OG8+jdpQX2a6sM1mxWzfZvhn1DiJGRJt2N44/5uidgFJ/Yhxm9TgUWELcz7z+VN
         JRqA==
X-Received: by 10.180.91.49 with SMTP id cb17mr4397946wib.30.1414503657591;
        Tue, 28 Oct 2014 06:40:57 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id fv2sm2277999wib.2.2014.10.28.06.40.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 06:40:56 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Initialize bcma bus later (with mm available)
Date:   Tue, 28 Oct 2014 14:40:38 +0100
Message-Id: <1414503638-11424-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43633
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

Initializaion with memory allocator available will be much simpler, this
will allow cleanup in the bcma code.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
Since MIPS git tree is based on 3.18-rcX (and includes required bcma patches),
this patch can finally go into it. Re-sending without RFC.
---
 arch/mips/bcm47xx/bcm47xx_private.h |  3 +++
 arch/mips/bcm47xx/irq.c             |  8 ++++++++
 arch/mips/bcm47xx/setup.c           | 33 +++++++++++++++++++++++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index 12a112d..ea909a5 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -15,6 +15,9 @@ int __init bcm47xx_buttons_register(void);
 /* leds.c */
 void __init bcm47xx_leds_register(void);
 
+/* setup.c */
+void __init bcm47xx_bus_setup(void);
+
 /* workarounds.c */
 void __init bcm47xx_workarounds(void);
 
diff --git a/arch/mips/bcm47xx/irq.c b/arch/mips/bcm47xx/irq.c
index e0585b7..21b4497 100644
--- a/arch/mips/bcm47xx/irq.c
+++ b/arch/mips/bcm47xx/irq.c
@@ -22,6 +22,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include "bcm47xx_private.h"
+
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -65,6 +67,12 @@ DEFINE_HWx_IRQDISPATCH(7)
 
 void __init arch_init_irq(void)
 {
+	/*
+	 * This is the first arch callback after mm_init (we can use kmalloc),
+	 * so let's finish bus initialization now.
+	 */
+	bcm47xx_bus_setup();
+
 #ifdef CONFIG_BCM47XX_BCMA
 	if (bcm47xx_bus_type == BCM47XX_BUS_TYPE_BCMA) {
 		bcma_write32(bcm47xx_bus.bcma.bus.drv_mips.core,
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 444c65a..e43b504 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -156,15 +156,14 @@ static void __init bcm47xx_register_bcma(void)
 	err = bcma_host_soc_register(&bcm47xx_bus.bcma);
 	if (err)
 		panic("Failed to register BCMA bus (err %d)", err);
-
-	err = bcma_host_soc_init(&bcm47xx_bus.bcma);
-	if (err)
-		panic("Failed to initialize BCMA bus (err %d)", err);
-
-	bcm47xx_fill_bcma_boardinfo(&bcm47xx_bus.bcma.bus.boardinfo, NULL);
 }
 #endif
 
+/*
+ * Memory setup is done in the early part of MIPS's arch_mem_init. It's supposed
+ * to detect memory and record it with add_memory_region.
+ * Any extra initializaion performed here must not use kmalloc or bootmem.
+ */
 void __init plat_mem_setup(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -193,6 +192,28 @@ void __init plat_mem_setup(void)
 	_machine_restart = bcm47xx_machine_restart;
 	_machine_halt = bcm47xx_machine_halt;
 	pm_power_off = bcm47xx_machine_halt;
+}
+
+/*
+ * This finishes bus initialization doing things that were not possible without
+ * kmalloc. Make sure to call it late enough (after mm_init).
+ */
+void __init bcm47xx_bus_setup(void)
+{
+#ifdef CONFIG_BCM47XX_BCMA
+	if (bcm47xx_bus_type == BCM47XX_BUS_TYPE_BCMA) {
+		int err;
+
+		err = bcma_host_soc_init(&bcm47xx_bus.bcma);
+		if (err)
+			panic("Failed to initialize BCMA bus (err %d)", err);
+
+		bcm47xx_fill_bcma_boardinfo(&bcm47xx_bus.bcma.bus.boardinfo,
+					    NULL);
+	}
+#endif
+
+	/* With bus initialized we can access NVRAM and detect the board */
 	bcm47xx_board_detect();
 	mips_set_machine_name(bcm47xx_board_get_name());
 }
-- 
1.8.4.5
