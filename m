Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 20:02:40 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34373 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012340AbcBITBJGIP9R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 20:01:09 +0100
Received: by mail-pa0-f65.google.com with SMTP id yy13so7335658pab.1;
        Tue, 09 Feb 2016 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVuAPnj3o2hMJtBD0DtdSQq/R9dp8xvBMTBLV0aRdD4=;
        b=tlw9w6XGIMIVT8Qy0j7HdPYIYBTKsfYe3hEW7SoAQfEVGfXcjxan7WH/uFkQV6JO+f
         6YhtyfBf3GFuHhYXfAHnJZLHVv6JypEe63LaN++EvujnH/A0SMF9aVR0LeN2HRauZICH
         a0/f1pSHg9QhM8M8d/uo/Mn4Zgb56dRnRkrdLm+2ji2bWtXjW/tsyqEO8r/BQEIdWbHg
         fpip00ZO+UFGKZbc6nGk983VEkqJ4uRH2g/UaeyJ47S1LopKCarNBQBklHUSYLM9gVXy
         D20Q2uBSodyavcjuUFnMRKHoC5zEO8Ba2qG8rLZSWjWsWqXrnewtMm6e/SYpVa9UOCfn
         NXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVuAPnj3o2hMJtBD0DtdSQq/R9dp8xvBMTBLV0aRdD4=;
        b=SyMMAksU22iR4YbWOeSeVzVCn+tdKuf4aaLHnDXJlMT8uzcnRwXAPfey6+GCzFhPXz
         Ug6aj7d0eM/1s/Tl6oqMAum+QsLpR9mUw2G6QBEiceHo4h2DtljMIUQrrhV5pyVH+/Rb
         wGydQufvLBxpuiprITF85uXHt2SYGidRjtetjFw2q1flDF9X4CjC1D+Bh/buUKkbB6eh
         vtCRndMVJzZYBC4qdX2+ygDkzIqYAiILzzD9/HcSKXaVvLuHFPyfvA5J9fJIK7jYy7Ne
         lbXJCzm1TvcFYujNQmBpgY1cv8BzxqfAH9mkYqo6uyssM3U+DR9TBfRr/TKANKt3lY/r
         IFYw==
X-Gm-Message-State: AG10YOR+ypoab8aVGw+dt2Co/hOQ7MFSXlT0uONk9nuS0bZaHXs5V7IhAgmO6TwuHseEcw==
X-Received: by 10.66.236.103 with SMTP id ut7mr52487371pac.4.1455044463432;
        Tue, 09 Feb 2016 11:01:03 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id 17sm25472515pfp.96.2016.02.09.11.00.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 11:00:58 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u19J0sHD009898;
        Tue, 9 Feb 2016 11:00:54 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u19J0scU009897;
        Tue, 9 Feb 2016 11:00:54 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 7/8] MIPS: OCTEON: Add SMP support for OCTEON cn78xx et al.
Date:   Tue,  9 Feb 2016 11:00:12 -0800
Message-Id: <1455044413-9823-8-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
References: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

OCTEON chips with the CIU3 interrupt controller use a different IPI
mechanism that previous models.

Add plat_smp_ops for the cn78xx and probing code to choose between the
two types of ops.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c       |   4 +-
 arch/mips/cavium-octeon/smp.c         | 145 +++++++++++++++++++++++++++++++---
 arch/mips/include/asm/octeon/octeon.h |   6 ++
 3 files changed, 139 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 54a214e..8ffc1f1 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -43,8 +43,6 @@
 #include <asm/octeon/cvmx-mio-defs.h>
 #include <asm/octeon/cvmx-rst-defs.h>
 
-extern struct plat_smp_ops octeon_smp_ops;
-
 #ifdef CONFIG_PCI
 extern void pci_console_init(const char *arg);
 #endif
@@ -888,7 +886,7 @@ void __init prom_init(void)
 #endif
 
 	octeon_user_io_init();
-	register_smp_ops(&octeon_smp_ops);
+	octeon_setup_smp();
 }
 
 /* Exclude a single page from the regions obtained in plat_mem_setup. */
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index b0f9a0a..29d1da5 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -30,25 +30,55 @@ uint64_t octeon_bootloader_entry_addr;
 EXPORT_SYMBOL(octeon_bootloader_entry_addr);
 #endif
 
+static void octeon_icache_flush(void)
+{
+	asm volatile ("synci 0($0)\n");
+}
+
+static void (*octeon_message_functions[8])(void) = {
+	scheduler_ipi,
+	generic_smp_call_function_interrupt,
+	octeon_icache_flush,
+};
+
 static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 {
-	const int coreid = cvmx_get_core_num();
-	uint64_t action;
+	u64 mbox_clrx = CVMX_CIU_MBOX_CLRX(cvmx_get_core_num());
+	u64 action;
+	int i;
+
+	/*
+	 * Make sure the function array initialization remains
+	 * correct.
+	 */
+	BUILD_BUG_ON(SMP_RESCHEDULE_YOURSELF != (1 << 0));
+	BUILD_BUG_ON(SMP_CALL_FUNCTION       != (1 << 1));
+	BUILD_BUG_ON(SMP_ICACHE_FLUSH        != (1 << 2));
+
+	/*
+	 * Load the mailbox register to figure out what we're supposed
+	 * to do.
+	 */
+	action = cvmx_read_csr(mbox_clrx);
 
-	/* Load the mailbox register to figure out what we're supposed to do */
-	action = cvmx_read_csr(CVMX_CIU_MBOX_CLRX(coreid)) & 0xffff;
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		action &= 0xff;
+	else
+		action &= 0xffff;
 
 	/* Clear the mailbox to clear the interrupt */
-	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), action);
+	cvmx_write_csr(mbox_clrx, action);
 
-	if (action & SMP_CALL_FUNCTION)
-		generic_smp_call_function_interrupt();
-	if (action & SMP_RESCHEDULE_YOURSELF)
-		scheduler_ipi();
+	for (i = 0; i < ARRAY_SIZE(octeon_message_functions) && action;) {
+		if (action & 1) {
+			void (*fn)(void) = octeon_message_functions[i];
 
-	/* Check if we've been told to flush the icache */
-	if (action & SMP_ICACHE_FLUSH)
-		asm volatile ("synci 0($0)\n");
+			if (fn)
+				fn();
+		}
+		action >>= 1;
+		i++;
+	}
 	return IRQ_HANDLED;
 }
 
@@ -102,10 +132,10 @@ static void octeon_smp_setup(void)
 	const int coreid = cvmx_get_core_num();
 	int cpus;
 	int id;
-	int core_mask = octeon_get_boot_coremask();
 	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
 
 #ifdef CONFIG_HOTPLUG_CPU
+	int core_mask = octeon_get_boot_coremask();
 	unsigned int num_cores = cvmx_octeon_num_cores();
 #endif
 
@@ -390,3 +420,92 @@ struct plat_smp_ops octeon_smp_ops = {
 	.cpu_die		= octeon_cpu_die,
 #endif
 };
+
+static irqreturn_t octeon_78xx_reched_interrupt(int irq, void *dev_id)
+{
+	scheduler_ipi();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t octeon_78xx_call_function_interrupt(int irq, void *dev_id)
+{
+	generic_smp_call_function_interrupt();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t octeon_78xx_icache_flush_interrupt(int irq, void *dev_id)
+{
+	octeon_icache_flush();
+	return IRQ_HANDLED;
+}
+
+/*
+ * Callout to firmware before smp_init
+ */
+static void octeon_78xx_prepare_cpus(unsigned int max_cpus)
+{
+	if (request_irq(OCTEON_IRQ_MBOX0 + 0,
+			octeon_78xx_reched_interrupt,
+			IRQF_PERCPU | IRQF_NO_THREAD, "Scheduler",
+			octeon_78xx_reched_interrupt)) {
+		panic("Cannot request_irq for SchedulerIPI");
+	}
+	if (request_irq(OCTEON_IRQ_MBOX0 + 1,
+			octeon_78xx_call_function_interrupt,
+			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-Call",
+			octeon_78xx_call_function_interrupt)) {
+		panic("Cannot request_irq for SMP-Call");
+	}
+	if (request_irq(OCTEON_IRQ_MBOX0 + 2,
+			octeon_78xx_icache_flush_interrupt,
+			IRQF_PERCPU | IRQF_NO_THREAD, "ICache-Flush",
+			octeon_78xx_icache_flush_interrupt)) {
+		panic("Cannot request_irq for ICache-Flush");
+	}
+}
+
+static void octeon_78xx_send_ipi_single(int cpu, unsigned int action)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		if (action & 1)
+			octeon_ciu3_mbox_send(cpu, i);
+		action >>= 1;
+	}
+}
+
+static void octeon_78xx_send_ipi_mask(const struct cpumask *mask,
+				      unsigned int action)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask)
+		octeon_78xx_send_ipi_single(cpu, action);
+}
+
+static struct plat_smp_ops octeon_78xx_smp_ops = {
+	.send_ipi_single	= octeon_78xx_send_ipi_single,
+	.send_ipi_mask		= octeon_78xx_send_ipi_mask,
+	.init_secondary		= octeon_init_secondary,
+	.smp_finish		= octeon_smp_finish,
+	.boot_secondary		= octeon_boot_secondary,
+	.smp_setup		= octeon_smp_setup,
+	.prepare_cpus		= octeon_78xx_prepare_cpus,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= octeon_cpu_disable,
+	.cpu_die		= octeon_cpu_die,
+#endif
+};
+
+void __init octeon_setup_smp(void)
+{
+	struct plat_smp_ops *ops;
+
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3))
+		ops = &octeon_78xx_smp_ops;
+	else
+		ops = &octeon_smp_ops;
+
+	register_smp_ops(ops);
+}
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 53d51ae..07c0516 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -299,6 +299,12 @@ static inline void octeon_npi_write32(uint64_t address, uint32_t val)
 	cvmx_read64_uint32(address ^ 4);
 }
 
+#ifdef CONFIG_SMP
+void octeon_setup_smp(void);
+#else
+static inline void octeon_setup_smp(void) {}
+#endif
+
 struct irq_domain;
 struct device_node;
 struct irq_data;
-- 
1.7.11.7
