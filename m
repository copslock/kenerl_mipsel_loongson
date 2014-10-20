Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:06:16 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:39079 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011970AbaJTTERLb9WL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:17 +0200
Received: by mail-ig0-f202.google.com with SMTP id r10so853506igi.5
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dybuS8Nn8pqfeiTYI6Go0g7+BrfzOay9eCDeHInqP2E=;
        b=hknxk5p89fTawIgcr+78NhOhyV8mhqWFxHrLrk9iwsyGGQpzI1r1gcwoDiAiL3Wn1l
         Wo2pArEcLK8EkJmhsMcD0LfpCWODt25wox6dB8dtm3JGrnHMC6iKl799S6V3szr0dV4O
         qUmPlprrpBFd2ZdviNhfGs8xdeovrnJwgV0QmYtISaIW3ySKokMAyu7/nqJz7E+/elm6
         dgVR2mCN47ae/EN85fNnK72pIMjBBthgeamqTf/WbCYHN5PG0RIopiQpcHzFGPE8jLPg
         O1uS+FvwSDKe4UYc4K5IJXdtijVkmmhAyJn7/8JB0J48Bc+9qMZjmw8km+yO7bl4hcIe
         UeDA==
X-Gm-Message-State: ALoCoQlgyTmiwlf0QWqTbx+OL9gHMBtxOEpRCQ4GeGDZdgGGEtm4UDyqKeeNj/yygoJ2lR3sVYiE
X-Received: by 10.182.38.135 with SMTP id g7mr18949009obk.10.1413831850718;
        Mon, 20 Oct 2014 12:04:10 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si437283yhe.3.2014.10.20.12.04.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:10 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ezN2XdvX.2; Mon, 20 Oct 2014 12:04:10 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id B6F5E220D57; Mon, 20 Oct 2014 12:04:09 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] MIPS: Move gic.h to include/linux/irqchip/mips-gic.h
Date:   Mon, 20 Oct 2014 12:03:53 -0700
Message-Id: <1413831846-32100-7-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Now that the MIPS GIC irqchip lives in drivers/irqchip/, move
its header over to include/linux/irqchip/.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/include/asm/mips-boards/maltaint.h                    | 2 +-
 arch/mips/include/asm/mips-boards/sead3int.h                    | 2 +-
 arch/mips/kernel/cevt-gic.c                                     | 2 +-
 arch/mips/kernel/cevt-r4k.c                                     | 2 +-
 arch/mips/kernel/csrc-gic.c                                     | 3 +--
 arch/mips/kernel/smp-cmp.c                                      | 2 +-
 arch/mips/kernel/smp-cps.c                                      | 2 +-
 arch/mips/kernel/smp-gic.c                                      | 2 +-
 arch/mips/kernel/smp-mt.c                                       | 2 +-
 arch/mips/mti-malta/malta-int.c                                 | 2 +-
 arch/mips/mti-malta/malta-time.c                                | 2 +-
 arch/mips/mti-sead3/sead3-ehci.c                                | 2 +-
 arch/mips/mti-sead3/sead3-int.c                                 | 2 +-
 arch/mips/mti-sead3/sead3-net.c                                 | 2 +-
 arch/mips/mti-sead3/sead3-platform.c                            | 2 +-
 arch/mips/mti-sead3/sead3-time.c                                | 2 +-
 drivers/irqchip/irq-mips-gic.c                                  | 2 +-
 arch/mips/include/asm/gic.h => include/linux/irqchip/mips-gic.h | 0
 18 files changed, 17 insertions(+), 18 deletions(-)
 rename arch/mips/include/asm/gic.h => include/linux/irqchip/mips-gic.h (100%)

diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index 38b06a0..987ff58 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -10,7 +10,7 @@
 #ifndef _MIPS_MALTAINT_H
 #define _MIPS_MALTAINT_H
 
-#include <asm/gic.h>
+#include <linux/irqchip/mips-gic.h>
 
 /*
  * Interrupts 0..15 are used for Malta ISA compatible interrupts
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
index 59d6c32..8932c7d 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -10,7 +10,7 @@
 #ifndef _MIPS_SEAD3INT_H
 #define _MIPS_SEAD3INT_H
 
-#include <asm/gic.h>
+#include <linux/irqchip/mips-gic.h>
 
 /* SEAD-3 GIC address space definitions. */
 #define GIC_BASE_ADDR		0x1b1c0000
diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
index 4f9262a..9caa68a 100644
--- a/arch/mips/kernel/cevt-gic.c
+++ b/arch/mips/kernel/cevt-gic.c
@@ -10,9 +10,9 @@
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mips-gic.h>
 
 #include <asm/time.h>
-#include <asm/gic.h>
 #include <asm/mips-boards/maltaint.h>
 
 DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index fd0ef8d..6acaad0 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -11,10 +11,10 @@
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mips-gic.h>
 
 #include <asm/time.h>
 #include <asm/cevt-r4k.h>
-#include <asm/gic.h>
 
 static int mips_next_event(unsigned long delta,
 			   struct clock_event_device *evt)
diff --git a/arch/mips/kernel/csrc-gic.c b/arch/mips/kernel/csrc-gic.c
index ab615c6..0bf28e6 100644
--- a/arch/mips/kernel/csrc-gic.c
+++ b/arch/mips/kernel/csrc-gic.c
@@ -6,10 +6,9 @@
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/init.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/time.h>
 
-#include <asm/gic.h>
-
 static cycle_t gic_hpt_read(struct clocksource *cs)
 {
 	return gic_read_count();
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index fc8a515..1e0a93c 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -24,6 +24,7 @@
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
+#include <linux/irqchip/mips-gic.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -37,7 +38,6 @@
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
 #include <asm/amon.h>
-#include <asm/gic.h>
 
 static void cmp_init_secondary(void)
 {
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index cd20aca..bed7590 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -9,13 +9,13 @@
  */
 
 #include <linux/io.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/bcache.h>
-#include <asm/gic.h>
 #include <asm/mips-cm.h>
 #include <asm/mips-cpc.h>
 #include <asm/mips_mt.h>
diff --git a/arch/mips/kernel/smp-gic.c b/arch/mips/kernel/smp-gic.c
index 3b21a96..5f0ab5b 100644
--- a/arch/mips/kernel/smp-gic.c
+++ b/arch/mips/kernel/smp-gic.c
@@ -12,9 +12,9 @@
  * option) any later version.
  */
 
+#include <linux/irqchip/mips-gic.h>
 #include <linux/printk.h>
 
-#include <asm/gic.h>
 #include <asm/mips-cpc.h>
 #include <asm/smp-ops.h>
 
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index d60475f..ad86951 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/compiler.h>
 #include <linux/smp.h>
 
@@ -34,7 +35,6 @@
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
-#include <asm/gic.h>
 
 static void __init smvp_copy_vpe_config(void)
 {
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 864d482..6ea4033 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/kernel_stat.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
@@ -33,7 +34,6 @@
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/msc01_pci.h>
 #include <asm/msc01_ic.h>
-#include <asm/gic.h>
 #include <asm/setup.h>
 #include <asm/rtlx.h>
 
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 39f3902..608655f 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/timex.h>
 #include <linux/mc146818rtc.h>
 
@@ -37,7 +38,6 @@
 #include <asm/time.h>
 #include <asm/mc146818-time.h>
 #include <asm/msc01_ic.h>
-#include <asm/gic.h>
 
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/maltaint.h>
diff --git a/arch/mips/mti-sead3/sead3-ehci.c b/arch/mips/mti-sead3/sead3-ehci.c
index 4ddaa0f..014dd7b 100644
--- a/arch/mips/mti-sead3/sead3-ehci.c
+++ b/arch/mips/mti-sead3/sead3-ehci.c
@@ -9,8 +9,8 @@
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/irqchip/mips-gic.h>
 
-#include <asm/gic.h>
 #include <asm/mips-boards/sead3int.h>
 
 struct resource ehci_resources[] = {
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index 995c401..5c6b949 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -7,9 +7,9 @@
  */
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/io.h>
 
-#include <asm/gic.h>
 #include <asm/irq_cpu.h>
 #include <asm/setup.h>
 
diff --git a/arch/mips/mti-sead3/sead3-net.c b/arch/mips/mti-sead3/sead3-net.c
index c9f728a..46176b8 100644
--- a/arch/mips/mti-sead3/sead3-net.c
+++ b/arch/mips/mti-sead3/sead3-net.c
@@ -7,10 +7,10 @@
  */
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 
-#include <asm/gic.h>
 #include <asm/mips-boards/sead3int.h>
 
 static struct smsc911x_platform_config sead3_smsc911x_data = {
diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3/sead3-platform.c
index d9661eb..53ee6f1 100644
--- a/arch/mips/mti-sead3/sead3-platform.c
+++ b/arch/mips/mti-sead3/sead3-platform.c
@@ -7,9 +7,9 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/serial_8250.h>
 
-#include <asm/gic.h>
 #include <asm/mips-boards/sead3int.h>
 
 #define UART(base)							\
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index fd40de3..ec1dd24 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -6,9 +6,9 @@
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/init.h>
+#include <linux/irqchip/mips-gic.h>
 
 #include <asm/cpu.h>
-#include <asm/gic.h>
 #include <asm/setup.h>
 #include <asm/time.h>
 #include <asm/irq.h>
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index afa3663..64a9729 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -9,13 +9,13 @@
 #include <linux/bitmap.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
 #include <linux/clocksource.h>
 
 #include <asm/io.h>
-#include <asm/gic.h>
 #include <asm/setup.h>
 #include <asm/traps.h>
 #include <linux/hardirq.h>
diff --git a/arch/mips/include/asm/gic.h b/include/linux/irqchip/mips-gic.h
similarity index 100%
rename from arch/mips/include/asm/gic.h
rename to include/linux/irqchip/mips-gic.h
-- 
2.1.0.rc2.206.gedb03e5
