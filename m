Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:30:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21353 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993359AbdFBTal7Ibzn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:30:41 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DDB442D7CB13B;
        Fri,  2 Jun 2017 20:30:30 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:30:34
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/9] MIPS: generic/yamon-dt: Pull YAMON DT shim code out of SEAD-3 board
Date:   Fri, 2 Jun 2017 12:29:51 -0700
Message-ID: <20170602192959.25435-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602192959.25435-1-paul.burton@imgtec.com>
References: <20170602192959.25435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58144
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

In preparation for supporting other YAMON-using boards (Malta) & sharing
code to translate information from YAMON into device tree properties,
pull the code doing so for the kernel command line, system memory &
serial configuration out of the SEAD-3 board code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/generic/Kconfig        |   8 ++
 arch/mips/generic/Makefile       |   1 +
 arch/mips/generic/board-sead3.c  | 178 +-----------------------------------
 arch/mips/generic/yamon-dt.c     | 190 +++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/yamon-dt.h |  48 ++++++++++
 5 files changed, 251 insertions(+), 174 deletions(-)
 create mode 100644 arch/mips/generic/yamon-dt.c
 create mode 100644 arch/mips/include/asm/yamon-dt.h

diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index a606b3f9196c..446b7c68133d 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -9,9 +9,17 @@ config LEGACY_BOARDS
 	  kernel is booted without being provided with an FDT via the UHI
 	  boot protocol.
 
+config YAMON_DT_SHIM
+	bool
+	help
+	  Select this from your board if the board uses the YAMON bootloader
+	  and you wish to include code which helps translate various
+	  YAMON-provided environment variables into a device tree properties.
+
 config LEGACY_BOARD_SEAD3
 	bool "Support MIPS SEAD-3 boards"
 	select LEGACY_BOARDS
+	select YAMON_DT_SHIM
 	help
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index acb9b6d62b16..56b3ea565ed9 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -12,5 +12,6 @@ obj-y += init.o
 obj-y += irq.o
 obj-y += proc.o
 
+obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
 obj-$(CONFIG_KEXEC)			+= kexec.o
diff --git a/arch/mips/generic/board-sead3.c b/arch/mips/generic/board-sead3.c
index f4ae0584a33b..63fdc98738ba 100644
--- a/arch/mips/generic/board-sead3.c
+++ b/arch/mips/generic/board-sead3.c
@@ -17,6 +17,7 @@
 #include <asm/fw/fw.h>
 #include <asm/io.h>
 #include <asm/machine.h>
+#include <asm/yamon-dt.h>
 
 #define SEAD_CONFIG			CKSEG1ADDR(0x1b100110)
 #define SEAD_CONFIG_GIC_PRESENT		BIT(1)
@@ -33,98 +34,6 @@ static __init bool sead3_detect(void)
 	return (rev & MIPS_REVISION_MACHINE) == MIPS_REVISION_MACHINE_SEAD3;
 }
 
-static __init int append_cmdline(void *fdt)
-{
-	int err, chosen_off;
-
-	/* find or add chosen node */
-	chosen_off = fdt_path_offset(fdt, "/chosen");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_path_offset(fdt, "/chosen@0");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
-	if (chosen_off < 0) {
-		pr_err("Unable to find or add DT chosen node: %d\n",
-		       chosen_off);
-		return chosen_off;
-	}
-
-	err = fdt_setprop_string(fdt, chosen_off, "bootargs", fw_getcmdline());
-	if (err) {
-		pr_err("Unable to set bootargs property: %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
-static __init int append_memory(void *fdt)
-{
-	unsigned long phys_memsize, memsize;
-	__be32 mem_array[2];
-	int err, mem_off;
-	char *var;
-
-	/* find memory size from the bootloader environment */
-	var = fw_getenv("memsize");
-	if (var) {
-		err = kstrtoul(var, 0, &phys_memsize);
-		if (err) {
-			pr_err("Failed to read memsize env variable '%s'\n",
-			       var);
-			return -EINVAL;
-		}
-	} else {
-		pr_warn("The bootloader didn't provide memsize: defaulting to 32MB\n");
-		phys_memsize = 32 << 20;
-	}
-
-	/* default to using all available RAM */
-	memsize = phys_memsize;
-
-	/* allow the user to override the usable memory */
-	var = strstr(arcs_cmdline, "memsize=");
-	if (var)
-		memsize = memparse(var + strlen("memsize="), NULL);
-
-	/* if the user says there's more RAM than we thought, believe them */
-	phys_memsize = max_t(unsigned long, phys_memsize, memsize);
-
-	/* find or add a memory node */
-	mem_off = fdt_path_offset(fdt, "/memory");
-	if (mem_off == -FDT_ERR_NOTFOUND)
-		mem_off = fdt_add_subnode(fdt, 0, "memory");
-	if (mem_off < 0) {
-		pr_err("Unable to find or add memory DT node: %d\n", mem_off);
-		return mem_off;
-	}
-
-	err = fdt_setprop_string(fdt, mem_off, "device_type", "memory");
-	if (err) {
-		pr_err("Unable to set memory node device_type: %d\n", err);
-		return err;
-	}
-
-	mem_array[0] = 0;
-	mem_array[1] = cpu_to_be32(phys_memsize);
-	err = fdt_setprop(fdt, mem_off, "reg", mem_array, sizeof(mem_array));
-	if (err) {
-		pr_err("Unable to set memory regs property: %d\n", err);
-		return err;
-	}
-
-	mem_array[0] = 0;
-	mem_array[1] = cpu_to_be32(memsize);
-	err = fdt_setprop(fdt, mem_off, "linux,usable-memory",
-			  mem_array, sizeof(mem_array));
-	if (err) {
-		pr_err("Unable to set linux,usable-memory property: %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
 static __init int remove_gic(void *fdt)
 {
 	const unsigned int cpu_ehci_int = 2;
@@ -214,85 +123,6 @@ static __init int remove_gic(void *fdt)
 	return 0;
 }
 
-static __init int serial_config(void *fdt)
-{
-	const char *yamontty, *mode_var;
-	char mode_var_name[9], path[18], parity;
-	unsigned int uart, baud, stop_bits;
-	bool hw_flow;
-	int chosen_off, err;
-
-	yamontty = fw_getenv("yamontty");
-	if (!yamontty || !strcmp(yamontty, "tty0")) {
-		uart = 0;
-	} else if (!strcmp(yamontty, "tty1")) {
-		uart = 1;
-	} else {
-		pr_warn("yamontty environment variable '%s' invalid\n",
-			yamontty);
-		uart = 0;
-	}
-
-	baud = stop_bits = 0;
-	parity = 0;
-	hw_flow = false;
-
-	snprintf(mode_var_name, sizeof(mode_var_name), "modetty%u", uart);
-	mode_var = fw_getenv(mode_var_name);
-	if (mode_var) {
-		while (mode_var[0] >= '0' && mode_var[0] <= '9') {
-			baud *= 10;
-			baud += mode_var[0] - '0';
-			mode_var++;
-		}
-		if (mode_var[0] == ',')
-			mode_var++;
-		if (mode_var[0])
-			parity = mode_var[0];
-		if (mode_var[0] == ',')
-			mode_var++;
-		if (mode_var[0])
-			stop_bits = mode_var[0] - '0';
-		if (mode_var[0] == ',')
-			mode_var++;
-		if (!strcmp(mode_var, "hw"))
-			hw_flow = true;
-	}
-
-	if (!baud)
-		baud = 38400;
-
-	if (parity != 'e' && parity != 'n' && parity != 'o')
-		parity = 'n';
-
-	if (stop_bits != 7 && stop_bits != 8)
-		stop_bits = 8;
-
-	WARN_ON(snprintf(path, sizeof(path), "uart%u:%u%c%u%s",
-			 uart, baud, parity, stop_bits,
-			 hw_flow ? "r" : "") >= sizeof(path));
-
-	/* find or add chosen node */
-	chosen_off = fdt_path_offset(fdt, "/chosen");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_path_offset(fdt, "/chosen@0");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
-	if (chosen_off < 0) {
-		pr_err("Unable to find or add DT chosen node: %d\n",
-		       chosen_off);
-		return chosen_off;
-	}
-
-	err = fdt_setprop_string(fdt, chosen_off, "stdout-path", path);
-	if (err) {
-		pr_err("Unable to set stdout-path property: %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
 static __init const void *sead3_fixup_fdt(const void *fdt,
 					  const void *match_data)
 {
@@ -311,11 +141,11 @@ static __init const void *sead3_fixup_fdt(const void *fdt,
 	if (err)
 		panic("Unable to open FDT: %d", err);
 
-	err = append_cmdline(fdt_buf);
+	err = yamon_dt_append_cmdline(fdt_buf);
 	if (err)
 		panic("Unable to patch FDT: %d", err);
 
-	err = append_memory(fdt_buf);
+	err = yamon_dt_append_memory(fdt_buf);
 	if (err)
 		panic("Unable to patch FDT: %d", err);
 
@@ -323,7 +153,7 @@ static __init const void *sead3_fixup_fdt(const void *fdt,
 	if (err)
 		panic("Unable to patch FDT: %d", err);
 
-	err = serial_config(fdt_buf);
+	err = yamon_dt_serial_config(fdt_buf);
 	if (err)
 		panic("Unable to patch FDT: %d", err);
 
diff --git a/arch/mips/generic/yamon-dt.c b/arch/mips/generic/yamon-dt.c
new file mode 100644
index 000000000000..9a0c8da5a796
--- /dev/null
+++ b/arch/mips/generic/yamon-dt.c
@@ -0,0 +1,190 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) "yamon-dt: " fmt
+
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <linux/printk.h>
+
+#include <asm/fw/fw.h>
+
+__init int yamon_dt_append_cmdline(void *fdt)
+{
+	int err, chosen_off;
+
+	/* find or add chosen node */
+	chosen_off = fdt_path_offset(fdt, "/chosen");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_path_offset(fdt, "/chosen@0");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
+	if (chosen_off < 0) {
+		pr_err("Unable to find or add DT chosen node: %d\n",
+		       chosen_off);
+		return chosen_off;
+	}
+
+	err = fdt_setprop_string(fdt, chosen_off, "bootargs", fw_getcmdline());
+	if (err) {
+		pr_err("Unable to set bootargs property: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+__init int yamon_dt_append_memory(void *fdt)
+{
+	unsigned long phys_memsize, memsize;
+	__be32 mem_array[2];
+	int err, mem_off;
+	char *var;
+
+	/* find memory size from the bootloader environment */
+	var = fw_getenv("memsize");
+	if (var) {
+		err = kstrtoul(var, 0, &phys_memsize);
+		if (err) {
+			pr_err("Failed to read memsize env variable '%s'\n",
+			       var);
+			return -EINVAL;
+		}
+	} else {
+		pr_warn("The bootloader didn't provide memsize: defaulting to 32MB\n");
+		phys_memsize = 32 << 20;
+	}
+
+	/* default to using all available RAM */
+	memsize = phys_memsize;
+
+	/* allow the user to override the usable memory */
+	var = strstr(arcs_cmdline, "memsize=");
+	if (var)
+		memsize = memparse(var + strlen("memsize="), NULL);
+
+	/* if the user says there's more RAM than we thought, believe them */
+	phys_memsize = max_t(unsigned long, phys_memsize, memsize);
+
+	/* find or add a memory node */
+	mem_off = fdt_path_offset(fdt, "/memory");
+	if (mem_off == -FDT_ERR_NOTFOUND)
+		mem_off = fdt_add_subnode(fdt, 0, "memory");
+	if (mem_off < 0) {
+		pr_err("Unable to find or add memory DT node: %d\n", mem_off);
+		return mem_off;
+	}
+
+	err = fdt_setprop_string(fdt, mem_off, "device_type", "memory");
+	if (err) {
+		pr_err("Unable to set memory node device_type: %d\n", err);
+		return err;
+	}
+
+	mem_array[0] = 0;
+	mem_array[1] = cpu_to_be32(phys_memsize);
+	err = fdt_setprop(fdt, mem_off, "reg", mem_array, sizeof(mem_array));
+	if (err) {
+		pr_err("Unable to set memory regs property: %d\n", err);
+		return err;
+	}
+
+	mem_array[0] = 0;
+	mem_array[1] = cpu_to_be32(memsize);
+	err = fdt_setprop(fdt, mem_off, "linux,usable-memory",
+			  mem_array, sizeof(mem_array));
+	if (err) {
+		pr_err("Unable to set linux,usable-memory property: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+__init int yamon_dt_serial_config(void *fdt)
+{
+	const char *yamontty, *mode_var;
+	char mode_var_name[9], path[18], parity;
+	unsigned int uart, baud, stop_bits;
+	bool hw_flow;
+	int chosen_off, err;
+
+	yamontty = fw_getenv("yamontty");
+	if (!yamontty || !strcmp(yamontty, "tty0")) {
+		uart = 0;
+	} else if (!strcmp(yamontty, "tty1")) {
+		uart = 1;
+	} else {
+		pr_warn("yamontty environment variable '%s' invalid\n",
+			yamontty);
+		uart = 0;
+	}
+
+	baud = stop_bits = 0;
+	parity = 0;
+	hw_flow = false;
+
+	snprintf(mode_var_name, sizeof(mode_var_name), "modetty%u", uart);
+	mode_var = fw_getenv(mode_var_name);
+	if (mode_var) {
+		while (mode_var[0] >= '0' && mode_var[0] <= '9') {
+			baud *= 10;
+			baud += mode_var[0] - '0';
+			mode_var++;
+		}
+		if (mode_var[0] == ',')
+			mode_var++;
+		if (mode_var[0])
+			parity = mode_var[0];
+		if (mode_var[0] == ',')
+			mode_var++;
+		if (mode_var[0])
+			stop_bits = mode_var[0] - '0';
+		if (mode_var[0] == ',')
+			mode_var++;
+		if (!strcmp(mode_var, "hw"))
+			hw_flow = true;
+	}
+
+	if (!baud)
+		baud = 38400;
+
+	if (parity != 'e' && parity != 'n' && parity != 'o')
+		parity = 'n';
+
+	if (stop_bits != 7 && stop_bits != 8)
+		stop_bits = 8;
+
+	WARN_ON(snprintf(path, sizeof(path), "uart%u:%u%c%u%s",
+			 uart, baud, parity, stop_bits,
+			 hw_flow ? "r" : "") >= sizeof(path));
+
+	/* find or add chosen node */
+	chosen_off = fdt_path_offset(fdt, "/chosen");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_path_offset(fdt, "/chosen@0");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
+	if (chosen_off < 0) {
+		pr_err("Unable to find or add DT chosen node: %d\n",
+		       chosen_off);
+		return chosen_off;
+	}
+
+	err = fdt_setprop_string(fdt, chosen_off, "stdout-path", path);
+	if (err) {
+		pr_err("Unable to set stdout-path property: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/arch/mips/include/asm/yamon-dt.h b/arch/mips/include/asm/yamon-dt.h
new file mode 100644
index 000000000000..3f3367de4836
--- /dev/null
+++ b/arch/mips/include/asm/yamon-dt.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_YAMON_DT_H__
+#define __MIPS_ASM_YAMON_DT_H__
+
+/**
+ * yamon_dt_append_cmdline() - Append YAMON-provided command line to /chosen
+ * @fdt: the FDT blob
+ *
+ * Write the YAMON-provided command line to the bootargs property of the
+ * /chosen node in @fdt.
+ *
+ * Return: 0 on success, else -errno
+ */
+extern __init int yamon_dt_append_cmdline(void *fdt);
+
+/**
+ * yamon_dt_append_memory() - Append YAMON-provided memory info to /memory
+ * @fdt: the FDT blob
+ *
+ * Generate a /memory node in @fdt based upon memory size information provided
+ * by YAMON in its environment.
+ *
+ * Return: 0 on success, else -errno
+ */
+extern __init int yamon_dt_append_memory(void *fdt);
+
+/**
+ * yamon_dt_serial_config() - Append YAMON-provided serial config to /chosen
+ * @fdt: the FDT blob
+ *
+ * Generate a stdout-path property in the /chosen node of @fdt, based upon
+ * information provided in the YAMON environment about the UART configuration
+ * of the system.
+ *
+ * Return: 0 on success, else -errno
+ */
+extern __init int yamon_dt_serial_config(void *fdt);
+
+#endif /* __MIPS_ASM_YAMON_DT_H__ */
-- 
2.13.0
