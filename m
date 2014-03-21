Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 11:47:21 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51789 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862360AbaCUKqDDXxYo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2014 11:46:03 +0100
Received: by mail-pd0-f169.google.com with SMTP id fp1so2181630pdb.14
        for <multiple recipients>; Fri, 21 Mar 2014 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nNZWVBgOZTSICSCsv0KCiaOxPvnnsz65q6MUO2WmnAI=;
        b=dQ7Qu41URJt/LVsY7osLoI1R1E9bayEorHnW12mq3W9R8u1+1Ple7+ixx+hxJBOAIx
         pKkYBZ7NEupTrizCnyFKut3OB0BqQySHCFV2bJ/euXMhwFydJx5KtgBf6ZbKw5orrHlW
         i8pJ9UBedLBj7TXpb/LzwlDvW63ynQ8KBU35wmjWBMmAheyDTe+2CQE5D/Czu5Of9pJ1
         /7oJC+w8XgoK8a6QIWI2cgbMuW1vkKg+jXTAGWTnuLU/LZ3UanX1Bz2DrFq7Sde23f81
         H0ttwaI4EuMYDXNqAdDgdK3+f/IZ2XVQNEAa3ME4yU9fDcHjgVFuFzQ1TOYW55Skdj+Y
         B8ZA==
X-Received: by 10.66.136.131 with SMTP id qa3mr52365027pab.77.1395398756634;
        Fri, 21 Mar 2014 03:45:56 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ac5sm9144592pbc.37.2014.03.21.03.45.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 03:45:55 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V20 06/12] MIPS: Loongson 3: Add IRQ init and dispatch support
Date:   Fri, 21 Mar 2014 18:44:04 +0800
Message-Id: <1395398650-19292-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
References: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

IRQ routing path of Loongson-3:
Devices(most) --> I8259 --> HT Controller --> IRQ Routing Table --> CPU
                                                  ^
                                                  |
Device(legacy devices such as UART) --> Bonito ---|

IRQ Routing Table route 32 INTs to CPU's INT0~INT3(IP2~IP5 of CP0), 32
INTs include 16 HT INTs(mostly), 4 PCI INTs, 1 LPC INT, etc. IP6 is used
for IPI and IP7 is used for internal MIPS timer. LOONGSON_INT_ROUTER_*
are IRQ Routing Table registers.

I8259 IRQs are 1:1 mapped to HT1 INTs. LOONGSON_HT1_* are configuration
registers of HT1 controller.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Tested-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/include/asm/mach-loongson/irq.h      |   41 ++++++++++
 arch/mips/include/asm/mach-loongson/loongson.h |   10 +++
 arch/mips/loongson/Makefile                    |    6 ++
 arch/mips/loongson/loongson-3/Makefile         |    4 +
 arch/mips/loongson/loongson-3/irq.c            |   96 ++++++++++++++++++++++++
 5 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/irq.h
 create mode 100644 arch/mips/loongson/loongson-3/Makefile
 create mode 100644 arch/mips/loongson/loongson-3/irq.c

diff --git a/arch/mips/include/asm/mach-loongson/irq.h b/arch/mips/include/asm/mach-loongson/irq.h
new file mode 100644
index 0000000..29c2dff
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/irq.h
@@ -0,0 +1,41 @@
+#ifndef __ASM_MACH_LOONGSON_IRQ_H_
+#define __ASM_MACH_LOONGSON_IRQ_H_
+
+#include <boot_param.h>
+
+#ifdef CONFIG_CPU_LOONGSON3
+
+/* cpu core interrupt numbers */
+#define MIPS_CPU_IRQ_BASE 56
+
+#define LOONGSON_UART_IRQ   (MIPS_CPU_IRQ_BASE + 2) /* UART */
+#define LOONGSON_HT1_IRQ    (MIPS_CPU_IRQ_BASE + 3) /* HT1 */
+#define LOONGSON_TIMER_IRQ  (MIPS_CPU_IRQ_BASE + 7) /* CPU Timer */
+
+#define LOONGSON_HT1_CFG_BASE		loongson_sysconf.ht_control_base
+#define LOONGSON_HT1_INT_VECTOR_BASE	(LOONGSON_HT1_CFG_BASE + 0x80)
+#define LOONGSON_HT1_INT_EN_BASE	(LOONGSON_HT1_CFG_BASE + 0xa0)
+#define LOONGSON_HT1_INT_VECTOR(n)	\
+		LOONGSON3_REG32(LOONGSON_HT1_INT_VECTOR_BASE, 4 * (n))
+#define LOONGSON_HT1_INTN_EN(n)		\
+		LOONGSON3_REG32(LOONGSON_HT1_INT_EN_BASE, 4 * (n))
+
+#define LOONGSON_INT_ROUTER_OFFSET	0x1400
+#define LOONGSON_INT_ROUTER_INTEN	\
+	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x24)
+#define LOONGSON_INT_ROUTER_INTENSET	\
+	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x28)
+#define LOONGSON_INT_ROUTER_INTENCLR	\
+	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x2c)
+#define LOONGSON_INT_ROUTER_ENTRY(n)	\
+	  LOONGSON3_REG8(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + n)
+#define LOONGSON_INT_ROUTER_LPC		LOONGSON_INT_ROUTER_ENTRY(0x0a)
+#define LOONGSON_INT_ROUTER_HT1(n)	LOONGSON_INT_ROUTER_ENTRY(n + 0x18)
+
+#define LOONGSON_INT_CORE0_INT0		0x11 /* route to int 0 of core 0 */
+#define LOONGSON_INT_CORE0_INT1		0x21 /* route to int 1 of core 0 */
+
+#endif
+
+#include_next <irq.h>
+#endif /* __ASM_MACH_LOONGSON_IRQ_H_ */
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index f0367ff..69e9d9e 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -62,6 +62,12 @@ extern int mach_i8259_irq(void);
 #define LOONGSON_REG(x) \
 	(*(volatile u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
 
+#define LOONGSON3_REG8(base, x) \
+	(*(volatile u8 *)((char *)TO_UNCAC(base) + (x)))
+
+#define LOONGSON3_REG32(base, x) \
+	(*(volatile u32 *)((char *)TO_UNCAC(base) + (x)))
+
 #define LOONGSON_IRQ_BASE	32
 #define LOONGSON2_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
 
@@ -87,6 +93,10 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_REG_BASE	0x1fe00000
 #define LOONGSON_REG_SIZE	0x00100000	/* 256Bytes + 256Bytes + ??? */
 #define LOONGSON_REG_TOP	(LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
+/* Loongson-3 specific registers */
+#define LOONGSON3_REG_BASE	0x3ff00000
+#define LOONGSON3_REG_SIZE	0x00100000	/* 256Bytes + 256Bytes + ??? */
+#define LOONGSON3_REG_TOP	(LOONGSON3_REG_BASE+LOONGSON3_REG_SIZE-1)
 
 #define LOONGSON_LIO1_BASE	0x1ff00000
 #define LOONGSON_LIO1_SIZE	0x00100000	/* 1M */
diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
index 0dc0055..7429994 100644
--- a/arch/mips/loongson/Makefile
+++ b/arch/mips/loongson/Makefile
@@ -15,3 +15,9 @@ obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fuloong-2e/
 #
 
 obj-$(CONFIG_LEMOTE_MACH2F)  += lemote-2f/
+
+#
+# All Loongson-3 family machines
+#
+
+obj-$(CONFIG_CPU_LOONGSON3)  += loongson-3/
diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
new file mode 100644
index 0000000..b9968cd
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for Loongson-3 family machines
+#
+obj-y			+= irq.o
diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
new file mode 100644
index 0000000..b2dc62b
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -0,0 +1,96 @@
+#include <loongson.h>
+#include <irq.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+
+unsigned int ht_irq[] = {1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
+
+static void ht_irqdispatch(void)
+{
+	unsigned int i, irq;
+
+	irq = LOONGSON_HT1_INT_VECTOR(0);
+	LOONGSON_HT1_INT_VECTOR(0) = irq; /* Acknowledge the IRQs */
+
+	for (i = 0; i < ARRAY_SIZE(ht_irq); i++) {
+		if (irq & (0x1 << ht_irq[i]))
+			do_IRQ(ht_irq[i]);
+	}
+}
+
+void mach_irq_dispatch(unsigned int pending)
+{
+	if (pending & CAUSEF_IP7)
+		do_IRQ(LOONGSON_TIMER_IRQ);
+	else if (pending & CAUSEF_IP3)
+		ht_irqdispatch();
+	else if (pending & CAUSEF_IP2)
+		do_IRQ(LOONGSON_UART_IRQ);
+	else {
+		pr_err("%s : spurious interrupt\n", __func__);
+		spurious_interrupt();
+	}
+}
+
+static struct irqaction cascade_irqaction = {
+	.handler = no_action,
+	.name = "cascade",
+};
+
+static inline void mask_loongson_irq(struct irq_data *d)
+{
+	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
+	irq_disable_hazard();
+}
+
+static inline void unmask_loongson_irq(struct irq_data *d)
+{
+	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
+	irq_enable_hazard();
+}
+
+ /* For MIPS IRQs which shared by all cores */
+static struct irq_chip loongson_irq_chip = {
+	.name		= "Loongson",
+	.irq_ack	= mask_loongson_irq,
+	.irq_mask	= mask_loongson_irq,
+	.irq_mask_ack	= mask_loongson_irq,
+	.irq_unmask	= unmask_loongson_irq,
+	.irq_eoi	= unmask_loongson_irq,
+};
+
+void irq_router_init(void)
+{
+	int i;
+
+	/* route LPC int to cpu core0 int 0 */
+	LOONGSON_INT_ROUTER_LPC = LOONGSON_INT_CORE0_INT0;
+	/* route HT1 int0 ~ int7 to cpu core0 INT1*/
+	for (i = 0; i < 8; i++)
+		LOONGSON_INT_ROUTER_HT1(i) = LOONGSON_INT_CORE0_INT1;
+	/* enable HT1 interrupt */
+	LOONGSON_HT1_INTN_EN(0) = 0xffffffff;
+	/* enable router interrupt intenset */
+	LOONGSON_INT_ROUTER_INTENSET =
+		LOONGSON_INT_ROUTER_INTEN | (0xffff << 16) | 0x1 << 10;
+}
+
+void __init mach_init_irq(void)
+{
+	clear_c0_status(ST0_IM | ST0_BEV);
+
+	irq_router_init();
+	mips_cpu_irq_init();
+	init_i8259_irqs();
+	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
+			&loongson_irq_chip, handle_level_irq);
+
+	/* setup HT1 irq */
+	setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);
+
+	set_c0_status(STATUSF_IP2 | STATUSF_IP6);
+}
-- 
1.7.7.3
