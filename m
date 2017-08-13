Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:45:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17432 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993917AbdHMEneNHN7d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:43:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id AD913573E35E;
        Sun, 13 Aug 2017 05:43:23 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:43:25 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 20/38] irqchip: mips-gic: Remove GIC_CPU_INT* macros
Date:   Sat, 12 Aug 2017 21:36:28 -0700
Message-ID: <20170813043646.25821-21-paul.burton@imgtec.com>
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
X-archive-position: 59536
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

The GIC_CPU_INT* macros are never used. Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 include/linux/irqchip/mips-gic.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 9546947d1842..e93aaf529baa 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -21,14 +21,6 @@
 #define GIC_UMV_SH_COUNTER_31_00_OFS	0x0000
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
 
-/* GIC nomenclature for Core Interrupt Pins. */
-#define GIC_CPU_INT0		0 /* Core Interrupt 2 */
-#define GIC_CPU_INT1		1 /* .		      */
-#define GIC_CPU_INT2		2 /* .		      */
-#define GIC_CPU_INT3		3 /* .		      */
-#define GIC_CPU_INT4		4 /* .		      */
-#define GIC_CPU_INT5		5 /* Core Interrupt 7 */
-
 /* Add 2 to convert GIC CPU pin to core interrupt */
 #define GIC_CPU_PIN_OFFSET	2
 
-- 
2.14.0
