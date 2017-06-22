Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 17:12:43 +0200 (CEST)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:50480 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991172AbdFVPMhQkUDI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jun 2017 17:12:37 +0200
X-QQ-mid: bizesmtp7t1498144334t4o9lqwkr
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 22 Jun 2017 23:11:02 +0800 (CST)
X-QQ-SSF: 01100000002000F0FLF2000A0000000
X-QQ-FEAT: EmmLG+1XAgoqpUml8VzV9FqCV/wyriWcWi/yYM8X5eqvnOkJ42qHBPyV4qeVQ
        fcbH5Qvha/x4KVTwfpH1/fnsIFo9XRzx9dY4dsMAfJFTOrtNiNudztRholPOlIUCM7TmYo/
        tJzvdMQqz4cWMfiVB6R512oGGFKAya9zMlN/69t97aBNY6jlt0gDDyw8y+DD8bVAHV3G5Q2
        BGD4YWOBiVPzKd4etwSkBe4v6JbxFPAlo6OKxHnLTiSVsunaLYpTTVbcQtpumjcMg1UGDjS
        AjyhXFXApX2uFIiGya5c0+1F1OEGsDdVbpk1s3U3i+3FzC
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V7 5/9] MIPS: Loongson-3: IRQ balancing for PCI devices
Date:   Thu, 22 Jun 2017 23:06:52 +0800
Message-Id: <1498144016-9111-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58750
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
