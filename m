Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2014 13:52:24 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:60786 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007900AbaIBLwXGxDhj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2014 13:52:23 +0200
Received: by mail-wg0-f49.google.com with SMTP id y10so6717662wgg.8
        for <multiple recipients>; Tue, 02 Sep 2014 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5o2Hg3UOiAx2TUSN9BPOex7dO7IsG4pQPK8fQifaVLE=;
        b=fi3+ziSx3vWwxoLd9Zgu3nmp0TdqXmEez/JGYVtBktx4xC23NDePIxW/9wijj7H14t
         X3RQ+2egT5iHudKZktk25UGG5xPJkzZ4Xqeu9STgJSzXZBvm3FfQ+YZ2zG60Gy6ty4MA
         1AV49RkgJHy0BVzfU092mrfIf/ukzrr6WYXEzBUoyNytUGQFreuQycQc+vVcfcL7flvg
         Wn21MMPIQj5pFRXNvh9ooL3ZExolT46l0QPD9mDue9kXFj0oj3i9TZWNfb4Ipfd55Dkb
         A8b+ZMCdSwfRAYCjs0Zp8h4VlR85jh72N7tPn/2fP4J5438zLlIfy3JAwBVc2QGSXZen
         XuCg==
X-Received: by 10.180.149.244 with SMTP id ud20mr27733508wib.55.1409658737745;
        Tue, 02 Sep 2014 04:52:17 -0700 (PDT)
Received: from linux-tdhb.lan (static-91-227-21-4.devs.futuro.pl. [91.227.21.4])
        by mx.google.com with ESMTPSA id wr10sm9044608wjc.10.2014.09.02.04.52.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Sep 2014 04:52:16 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH][RFC][Ack req] MIPS: BCM47XX: Initialize bcma bus later (with mm available)
Date:   Tue,  2 Sep 2014 13:51:59 +0200
Message-Id: <1409658719-32110-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42367
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
---
Hi Ralf,

As recently described in the e-mail thread
"Booting bcm47xx (bcma & stuff), sharing code with bcm53xx"
I plan to simplify bcma code for SoC booting.

This is one of my patches. As most of them touch "bcma" driver code, I
wanted to push them through John's wireless-next tree. Of course this
patch is not wireless related at all, so I'd need your Ack for it.

Could you review it and let me know if it looks OK for you? Is that
acceptable for you to push this one patch using wireless-next git tree?

This patch already depends on two that were submitted to John:
[PATCH 1/2] bcma: move bus struct setup into early part of host specific code
[PATCH 2/2] bcma: use separated function to initialize bus on SoC

Hauke: could you review it as well, please?
---
 arch/mips/bcm47xx/bcm47xx_private.h |  3 +++
 arch/mips/bcm47xx/irq.c             |  8 ++++++++
 arch/mips/bcm47xx/setup.c           | 33 +++++++++++++++++++++++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index f1cc9d0..43c34a2 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -12,6 +12,9 @@ int __init bcm47xx_buttons_register(void);
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
index a75ddbb..d4425ea 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -217,15 +217,14 @@ static void __init bcm47xx_register_bcma(void)
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
@@ -252,6 +251,28 @@ void __init plat_mem_setup(void)
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
