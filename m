Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:48:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19755 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993932AbdHMEqQX1KQd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:46:16 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 451B133EDA8AE;
        Sun, 13 Aug 2017 05:46:08 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:46:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 29/38] MIPS: VDSO: Avoid use of linux/irqchip/mips-gic.h
Date:   Sat, 12 Aug 2017 21:36:37 -0700
Message-ID: <20170813043646.25821-30-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Our VDSO code makes use of macros from linux/irqchip/mips-gic.h to
provide offsets to register values, but these are trivial offsets to the
two 32 bit halves of a 64 bit value. Replace use of the macros with zero
(ie. omit adding an offset) and the size of the low 32 bit of the value.
This removes our need for linux/irqchip/mips-gic.h & prepares us for it
to be removed.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 arch/mips/vdso/gettimeofday.c    | 7 +++----
 include/linux/irqchip/mips-gic.h | 4 ----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index fec7835b9de7..e22b422f282c 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -11,7 +11,6 @@
 #include "vdso.h"
 
 #include <linux/compiler.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/time.h>
 
 #include <asm/clocksource.h>
@@ -125,9 +124,9 @@ static __always_inline u64 read_gic_count(const union mips_vdso_data *data)
 	u32 hi, hi2, lo;
 
 	do {
-		hi = __raw_readl(gic + GIC_UMV_SH_COUNTER_63_32_OFS);
-		lo = __raw_readl(gic + GIC_UMV_SH_COUNTER_31_00_OFS);
-		hi2 = __raw_readl(gic + GIC_UMV_SH_COUNTER_63_32_OFS);
+		hi = __raw_readl(gic + sizeof(lo));
+		lo = __raw_readl(gic);
+		hi2 = __raw_readl(gic + sizeof(lo));
 	} while (hi2 != hi);
 
 	return (((u64)hi) << 32) + lo;
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 277d5be03a57..6e6c9adea049 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -11,8 +11,4 @@
 #include <linux/clocksource.h>
 #include <linux/ioport.h>
 
-/* User Mode Visible Section Register Map */
-#define GIC_UMV_SH_COUNTER_31_00_OFS	0x0000
-#define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
-
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.14.0
