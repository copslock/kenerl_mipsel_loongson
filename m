Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:40:12 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4697 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab3FJHkDdG23g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:03 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:36:09 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:39:48 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:39:48 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0F619F2D72; Mon, 10
 Jun 2013 00:39:46 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 01/11] MIPS: Netlogic: Split XLP device tree code to
 dt.c
Date:   Mon, 10 Jun 2013 13:11:00 +0530
Message-ID: <1370850070-5127-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5E6331W33902810-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Create new flle arch/mips/netlogic/xlp/dt.c and move the device
tree related code there.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    1 +
 arch/mips/netlogic/xlp/Makefile              |    2 +-
 arch/mips/netlogic/xlp/dt.c                  |   99 ++++++++++++++++++++++++++
 arch/mips/netlogic/xlp/setup.c               |   73 ++-----------------
 4 files changed, 105 insertions(+), 70 deletions(-)
 create mode 100644 arch/mips/netlogic/xlp/dt.c

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 7e47209..f4ea0f7 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -59,6 +59,7 @@ void xlp_wakeup_secondary_cpus(void);
 
 void xlp_mmu_init(void);
 void nlm_hal_init(void);
+void *xlp_dt_init(void *fdtp);
 
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_NLM_XLP_H */
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index e8dd14c..85ac4a8 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,3 +1,3 @@
-obj-y				+= setup.o nlm_hal.o cop2-ex.o
+obj-y				+= setup.o nlm_hal.o cop2-ex.o dt.o
 obj-$(CONFIG_SMP)		+= wakeup.o
 obj-$(CONFIG_USB)		+= usb-init.o
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
new file mode 100644
index 0000000..d1eb6bb
--- /dev/null
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright 2003-2013 Broadcom Corporation.
+ * All Rights Reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bootmem.h>
+
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+
+extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[], __dtb_start[];
+
+void __init *xlp_dt_init(void *fdtp)
+{
+	if (!fdtp) {
+		switch (current_cpu_data.processor_id & 0xff00) {
+#ifdef CONFIG_DT_XLP_SVP
+		case PRID_IMP_NETLOGIC_XLP3XX:
+			fdtp = __dtb_xlp_svp_begin;
+			break;
+#endif
+#ifdef CONFIG_DT_XLP_EVP
+		case PRID_IMP_NETLOGIC_XLP8XX:
+			fdtp = __dtb_xlp_evp_begin;
+			break;
+#endif
+		default:
+			/* Pick a built-in if any, and hope for the best */
+			fdtp = __dtb_start;
+			break;
+		}
+	}
+	initial_boot_params = fdtp;
+	return fdtp;
+}
+
+void __init device_tree_init(void)
+{
+	unsigned long base, size;
+
+	if (!initial_boot_params)
+		return;
+
+	base = virt_to_phys((void *)initial_boot_params);
+	size = be32_to_cpu(initial_boot_params->totalsize);
+
+	/* Before we do anything, lets reserve the dt blob */
+	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
+
+	unflatten_device_tree();
+
+	/* free the space reserved for the dt blob */
+	free_bootmem(base, size);
+}
+
+static struct of_device_id __initdata xlp_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+int __init xlp8xx_ds_publish_devices(void)
+{
+	if (!of_have_populated_dt())
+		return 0;
+	return of_platform_bus_probe(NULL, xlp_ids, NULL);
+}
+
+device_initcall(xlp8xx_ds_publish_devices);
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index eaa99d2..7b66949 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -33,19 +33,13 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/serial_8250.h>
-#include <linux/pm.h>
-#include <linux/bootmem.h>
+#include <linux/of_fdt.h>
 
 #include <asm/idle.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/bootinfo.h>
 
-#include <linux/of_fdt.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/common.h>
 
@@ -57,7 +51,6 @@ uint64_t nlm_io_base;
 struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 unsigned int nlm_threads_per_core;
-extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[], __dtb_start[];
 
 static void nlm_linux_exit(void)
 {
@@ -70,39 +63,13 @@ static void nlm_linux_exit(void)
 
 void __init plat_mem_setup(void)
 {
-	void *fdtp;
-
 	panic_timeout	= 5;
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
 	pm_power_off	= nlm_linux_exit;
 
-	/*
-	 * If no FDT pointer is passed in, use the built-in FDT.
-	 * device_tree_init() does not handle CKSEG0 pointers in
-	 * 64-bit, so convert pointer.
-	 */
-	fdtp = (void *)(long)fw_arg0;
-	if (!fdtp) {
-		switch (current_cpu_data.processor_id & 0xff00) {
-#ifdef CONFIG_DT_XLP_SVP
-		case PRID_IMP_NETLOGIC_XLP3XX:
-			fdtp = __dtb_xlp_svp_begin;
-			break;
-#endif
-#ifdef CONFIG_DT_XLP_EVP
-		case PRID_IMP_NETLOGIC_XLP8XX:
-			fdtp = __dtb_xlp_evp_begin;
-			break;
-#endif
-		default:
-			/* Pick a built-in if any, and hope for the best */
-			fdtp = __dtb_start;
-			break;
-		}
-	}
-	fdtp = phys_to_virt(__pa(fdtp));
-	early_init_devtree(fdtp);
+	/* memory and bootargs from DT */
+	early_init_devtree(initial_boot_params);
 }
 
 const char *get_system_type(void)
@@ -134,6 +101,7 @@ void __init prom_init(void)
 	nlm_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
 	xlp_mmu_init();
 	nlm_node_init(0);
+	xlp_dt_init((void *)(long)fw_arg0);
 
 #ifdef CONFIG_SMP
 	cpumask_setall(&nlm_cpumask);
@@ -145,36 +113,3 @@ void __init prom_init(void)
 	register_smp_ops(&nlm_smp_ops);
 #endif
 }
-
-void __init device_tree_init(void)
-{
-	unsigned long base, size;
-
-	if (!initial_boot_params)
-		return;
-
-	base = virt_to_phys((void *)initial_boot_params);
-	size = be32_to_cpu(initial_boot_params->totalsize);
-
-	/* Before we do anything, lets reserve the dt blob */
-	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
-
-	unflatten_device_tree();
-
-	/* free the space reserved for the dt blob */
-	free_bootmem(base, size);
-}
-
-static struct of_device_id __initdata xlp_ids[] = {
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-int __init xlp8xx_ds_publish_devices(void)
-{
-	if (!of_have_populated_dt())
-		return 0;
-	return of_platform_bus_probe(NULL, xlp_ids, NULL);
-}
-
-device_initcall(xlp8xx_ds_publish_devices);
-- 
1.7.9.5
