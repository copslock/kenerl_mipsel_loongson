Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:22:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50699 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861043AbaGQIVqPaLND (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:21:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6A646C3AED791
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:21:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:39 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:38 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/7] MIPS: GIC: Move GIC_NUM_INTRS into platform irq.h
Date:   Thu, 17 Jul 2014 09:20:54 +0100
Message-ID: <1405585259-24941-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Jeffrey Deans <jeffrey.deans@imgtec.com>

The value of GIC_NUM_INTRS is platform-specific. Using a default value
from gic.h will result in incorrect behaviour on some systems, so
require a suitable definition to be present in the platform's irq.h.

Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/gic.h            | 4 ++--
 arch/mips/include/asm/mach-malta/irq.h | 1 +
 arch/mips/include/asm/mach-sead3/irq.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 5b0e6a4b2c30..80804c16bb9d 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -14,6 +14,8 @@
 #include <linux/bitmap.h>
 #include <linux/threads.h>
 
+#include <irq.h>
+
 #undef	GICISBYTELITTLEENDIAN
 
 /* Constants */
@@ -22,8 +24,6 @@
 #define GIC_TRIG_EDGE			1
 #define GIC_TRIG_LEVEL			0
 
-#define GIC_NUM_INTRS			(24 + NR_CPUS * 2)
-
 #define MSK(n) ((1 << (n)) - 1)
 #define REG32(addr)		(*(volatile unsigned int *) (addr))
 #define REG(base, offs)		REG32((unsigned long)(base) + offs##_##OFS)
diff --git a/arch/mips/include/asm/mach-malta/irq.h b/arch/mips/include/asm/mach-malta/irq.h
index 47cfe64efbb0..f2c13d211abb 100644
--- a/arch/mips/include/asm/mach-malta/irq.h
+++ b/arch/mips/include/asm/mach-malta/irq.h
@@ -2,6 +2,7 @@
 #define __ASM_MACH_MIPS_IRQ_H
 
 
+#define GIC_NUM_INTRS (24 + NR_CPUS * 2)
 #define NR_IRQS 256
 
 #include_next <irq.h>
diff --git a/arch/mips/include/asm/mach-sead3/irq.h b/arch/mips/include/asm/mach-sead3/irq.h
index 5d154cfbcf4c..d8106f75b9af 100644
--- a/arch/mips/include/asm/mach-sead3/irq.h
+++ b/arch/mips/include/asm/mach-sead3/irq.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_MACH_MIPS_IRQ_H
 #define __ASM_MACH_MIPS_IRQ_H
 
+#define GIC_NUM_INTRS (24 + NR_CPUS * 2)
 #define NR_IRQS 256
 
 
-- 
2.0.0
