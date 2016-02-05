Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 01:44:10 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36455 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014892AbcBEAnTX--ll (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 01:43:19 +0100
Received: by mail-pf0-f194.google.com with SMTP id n128so4498545pfn.3;
        Thu, 04 Feb 2016 16:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3G+xTDm1nx3kSgfqcTS2L6C3m7+no7gbedggbK2fUzI=;
        b=fPxzsZ3w6egaD/DUgDXPFSb8WaCQwaAVaAEzdv6032HjjqqcMnSdp4wS4d5yj/YfQY
         3MC6I46ahf8ruTE6sFYOdb7Pay8ufzRTsSZsKTb5eTMpPqqaZQxrv3dYkj7TldoZjztV
         XHIkAm5Z305n+OWn2m3TYkQJ5/93Y2W15TzcsJ2qYwBOxCVZFpW/6pBAOE8HMp801gmN
         dHNZeapVQ4sVVK+0WqfmfL6uWd8LmCgHrToJkgd2X8w0ahLaKxgjs9OYDXOyKQuxo5v8
         PJVM2eCcZuVTW4wlgqBSQOWD+TTuwl5ZA420cvNfmdtKyxwTLiNR2PRGvv0in5nB3Ks8
         i0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3G+xTDm1nx3kSgfqcTS2L6C3m7+no7gbedggbK2fUzI=;
        b=hAj0aOMKCBqWAiF61DwyY7acB14+tRJqVF8mtK1ToCqHQ/+hpNzIma++12oBCdZagp
         jjjfIXg+9ijGCXYPmXYXQpNLNUOj6FxAvCKtfj8o/BbvCnX6rJEoEDy5tO/01vr0JkR9
         fkvaunDQ6KULlx8Ufye0p5+MF+vtEsOBOrukZpxeU42BBd/iiimQdeuFZ+iV4Ujy0At6
         yMHvg7+U3a7iPVg0FlZV1ecIZErCzN0l/hGRgZfNZfI2ZpJA6CwwDzttNcKxlHcUMWNp
         FbYKxP3SLNkwwVgKPoY7yEZNt8can5qACPkioyzUD0qHwdSowYP9SkpLBaewabMdmnte
         zQDA==
X-Gm-Message-State: AG10YOQu/LeodmzxXKHwOl60JyO9P/i0hk+tmYexaOi6EWKRUMGyisekWksdWwn3X3BTaA==
X-Received: by 10.98.1.197 with SMTP id 188mr15880992pfb.8.1454632993744;
        Thu, 04 Feb 2016 16:43:13 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id g26sm19818179pfg.35.2016.02.04.16.43.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:43:08 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u150h5ew007755;
        Thu, 4 Feb 2016 16:43:05 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u150h5Od007754;
        Thu, 4 Feb 2016 16:43:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 7/7] MIPS: OCTEON: Add SMP support for OCTEON cn78xx et al.
Date:   Thu,  4 Feb 2016 16:42:54 -0800
Message-Id: <1454632974-7686-8-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51797
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
index 780ca6b..282affb 100644
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
 void octeon_ciu3_mbox_send(int cpu, unsigned int mbox);
 
 /* Octeon multiplier save/restore routines from octeon_switch.S */
-- 
1.7.11.7
