Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:41:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55713 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011773AbbARWlBakKLi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:41:01 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AFD86D0E85089;
        Sun, 18 Jan 2015 22:40:51 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:40:55 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:40:50 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 23/36] MIPS: jz4740: define IRQ numbers based on number of intc IRQs
Date:   Sun, 18 Jan 2015 14:40:46 -0800
Message-ID: <1421620846-24917-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45272
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

For interrupts numbered after those of the interrupt controller, define
their numbers based upon the number of interrupts provided by the SoC
interrupt controller. This is in preparation for supporting later jz47xx
series SoCs which provide more interrupts.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/irq.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index df50736..b218f76 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -19,6 +19,10 @@
 #define MIPS_CPU_IRQ_BASE 0
 #define JZ4740_IRQ_BASE 8
 
+#ifdef CONFIG_MACH_JZ4740
+# define NR_INTC_IRQS	32
+#endif
+
 /* 1st-level interrupts */
 #define JZ4740_IRQ(x)		(JZ4740_IRQ_BASE + (x))
 #define JZ4740_IRQ_I2C		JZ4740_IRQ(1)
@@ -45,12 +49,12 @@
 #define JZ4740_IRQ_LCD		JZ4740_IRQ(30)
 
 /* 2nd-level interrupts */
-#define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(32) + (x))
+#define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(NR_INTC_IRQS) + (x))
 
 #define JZ4740_IRQ_INTC_GPIO(x) (JZ4740_IRQ_GPIO0 - (x))
-#define JZ4740_IRQ_GPIO(x)	(JZ4740_IRQ(48) + (x))
+#define JZ4740_IRQ_GPIO(x)	(JZ4740_IRQ(NR_INTC_IRQS + 16) + (x))
 
-#define JZ4740_IRQ_ADC_BASE	JZ4740_IRQ(176)
+#define JZ4740_IRQ_ADC_BASE	JZ4740_IRQ(NR_INTC_IRQS + 144)
 
 #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
 
-- 
2.2.1
