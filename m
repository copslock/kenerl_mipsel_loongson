Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2017 10:27:49 +0200 (CEST)
Received: from smtpbg202.qq.com ([184.105.206.29]:60046 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993612AbdC2I1lgxHTX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Mar 2017 10:27:41 +0200
X-QQ-mid: bizesmtp1t1490776035tnwgb6ghg
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Mar 2017 16:25:20 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82000A0000000
X-QQ-FEAT: 0ESs8nxzjD9Ay+/kuOxz2dh2NNq6lYcxPAsvdlDkrqAVP1GcKDb6htpphmpXb
        mNdnCEEkyF6/zDzkiZdTUCIWnM75xAsKTskMMWFZHkuyc8LP15d66KK2/XJm6xUeLiWd1g9
        q8AozW0k46JdaZtVU4bAAAzJCRMaabOedoUK7bfcmyyEsjjMbAuAk5AD+Ty4fHoRFhfKUUL
        SQ8kDgqQCAG2NOwqLJxnry561ui8NpoiFLoJuXNVSj5pcLeUzotq5ttIXiYmjYdydOrXwq6
        bJEC7wihc0/xcE6E0FjCIZctT2qzWQp6ZZ3U97NOEx5xPz
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 4/8] MIPS: Loongson-3: IRQ balancing for PCI devices
Date:   Wed, 29 Mar 2017 16:24:32 +0800
Message-Id: <1490775876-29918-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
References: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57463
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

IRQ0 (HPET), IRQ1 (Keyboard), IRQ2 (Cascade), IRQ7 (SCI), IRQ8 (RTC)
and IRQ12 (Mouse) are handled by core-0 locally. Other PCI IRQs (3, 4,
5, 6, 14, 15) are balanced by all cores from Node-0. This can improve
I/O performance significantly.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/irq.c | 19 +++++++++++++++++--
 arch/mips/loongson64/loongson-3/smp.c | 18 +++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 548f759..2e6e205 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -9,17 +9,32 @@
 
 #include "smp.h"
 
+extern void loongson3_send_irq_by_ipi(int cpu, int irqs);
 unsigned int ht_irq[] = {0, 1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
+unsigned int local_irq = 1<<0 | 1<<1 | 1<<2 | 1<<7 | 1<<8 | 1<<12;
 
 static void ht_irqdispatch(void)
 {
-	unsigned int i, irq;
+	unsigned int i, irq, irq0, irq1;
+	static unsigned int dest_cpu = 0;
 
 	irq = LOONGSON_HT1_INT_VECTOR(0);
 	LOONGSON_HT1_INT_VECTOR(0) = irq; /* Acknowledge the IRQs */
 
+	irq0 = irq & local_irq;  /* handled by local core */
+	irq1 = irq & ~local_irq; /* balanced by other cores */
+
+	if (dest_cpu == 0 || !cpu_online(dest_cpu))
+		irq0 |= irq1;
+	else
+		loongson3_send_irq_by_ipi(dest_cpu, irq1);
+
+	dest_cpu = dest_cpu + 1;
+	if (dest_cpu >= num_possible_cpus() || cpu_data[dest_cpu].package > 0)
+		dest_cpu = 0;
+
 	for (i = 0; i < ARRAY_SIZE(ht_irq); i++) {
-		if (irq & (0x1 << ht_irq[i]))
+		if (irq0 & (0x1 << ht_irq[i]))
 			do_IRQ(ht_irq[i]);
 	}
 }
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 1629743..b7a355c 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -254,13 +254,21 @@ loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 		loongson3_ipi_write32((u32)action, ipi_set0_regs[cpu_logical_map(i)]);
 }
 
+#define IPI_IRQ_OFFSET 6
+
+void loongson3_send_irq_by_ipi(int cpu, int irqs)
+{
+	loongson3_ipi_write32(irqs << IPI_IRQ_OFFSET, ipi_set0_regs[cpu_logical_map(cpu)]);
+}
+
 void loongson3_ipi_interrupt(struct pt_regs *regs)
 {
 	int i, cpu = smp_processor_id();
-	unsigned int action, c0count;
+	unsigned int action, c0count, irqs;
 
 	/* Load the ipi register to figure out what we're supposed to do */
 	action = loongson3_ipi_read32(ipi_status0_regs[cpu_logical_map(cpu)]);
+	irqs = action >> IPI_IRQ_OFFSET;
 
 	/* Clear the ipi register to clear the interrupt */
 	loongson3_ipi_write32((u32)action, ipi_clear0_regs[cpu_logical_map(cpu)]);
@@ -282,6 +290,14 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 			core0_c0count[i] = c0count;
 		__wbflush(); /* Let others see the result ASAP */
 	}
+
+	if (irqs) {
+		int irq;
+		while ((irq = ffs(irqs))) {
+			do_IRQ(irq-1);
+			irqs &= ~(1<<(irq-1));
+		}
+	}
 }
 
 #define MAX_LOOPS 800
-- 
2.7.0


.
