Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:47:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40555 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992622AbcHZPnpC6x9I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:43:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 79CA63165275D;
        Fri, 26 Aug 2016 16:43:24 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:43:26 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 22/26] MIPS: generic: Introduce generic DT-based board support
Date:   Fri, 26 Aug 2016 16:37:21 +0100
Message-ID: <20160826153725.11629-23-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54806
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

Introduce a "generic" platform, which aims to be board-agnostic by
making use of device trees passed by the boot protocol defined in the
MIPS UHI (Universal Hosting Interface) specification. Provision is made
for supporting boards which use a legacy boot protocol that can't be
changed, but adding support for such boards or any others is left to
followon patches.

Right now the built kernels expect to be loaded to 0x80100000, ie. in
kseg0. This is fine for the vast majority of MIPS platforms, but
nevertheless it would be good to remove this limitation in the future by
mapping the kernel via the TLB such that it can be loaded anywhere & map
itself appropriately.

Configuration is handled by dynamically generating configs using
scripts/kconfig/merge_config.sh, somewhat similar to the way powerpc
makes use of it. This allows for variations upon the configuration, eg.
differing architecture revisions or subsets of driver support for
differing boards, to be handled without having a large number of
defconfig files.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kbuild.platforms                 |   1 +
 arch/mips/Kconfig                          |  51 +++++++++
 arch/mips/Makefile                         |  51 +++++++++
 arch/mips/boot/Makefile                    |  11 +-
 arch/mips/configs/generic/32r1.config      |   2 +
 arch/mips/configs/generic/32r2.config      |   3 +
 arch/mips/configs/generic/32r6.config      |   2 +
 arch/mips/configs/generic/64r1.config      |   1 +
 arch/mips/configs/generic/64r2.config      |   2 +
 arch/mips/configs/generic/64r6.config      |   1 +
 arch/mips/configs/generic/eb.config        |   1 +
 arch/mips/configs/generic/el.config        |   1 +
 arch/mips/configs/generic/micro32r2.config |   4 +
 arch/mips/configs/generic_defconfig        |   2 +
 arch/mips/generic/Kconfig                  |  12 ++
 arch/mips/generic/Makefile                 |  13 +++
 arch/mips/generic/Platform                 |  14 +++
 arch/mips/generic/init.c                   | 174 +++++++++++++++++++++++++++++
 arch/mips/generic/irq.c                    |  64 +++++++++++
 arch/mips/generic/proc.c                   |  29 +++++
 arch/mips/generic/vmlinux.its.S            |  31 +++++
 arch/mips/include/asm/machine.h            |  63 +++++++++++
 22 files changed, 532 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/configs/generic/32r1.config
 create mode 100644 arch/mips/configs/generic/32r2.config
 create mode 100644 arch/mips/configs/generic/32r6.config
 create mode 100644 arch/mips/configs/generic/64r1.config
 create mode 100644 arch/mips/configs/generic/64r2.config
 create mode 100644 arch/mips/configs/generic/64r6.config
 create mode 100644 arch/mips/configs/generic/eb.config
 create mode 100644 arch/mips/configs/generic/el.config
 create mode 100644 arch/mips/configs/generic/micro32r2.config
 create mode 100644 arch/mips/configs/generic_defconfig
 create mode 100644 arch/mips/generic/Kconfig
 create mode 100644 arch/mips/generic/Makefile
 create mode 100644 arch/mips/generic/Platform
 create mode 100644 arch/mips/generic/init.c
 create mode 100644 arch/mips/generic/irq.c
 create mode 100644 arch/mips/generic/proc.c
 create mode 100644 arch/mips/generic/vmlinux.its.S
 create mode 100644 arch/mips/include/asm/machine.h

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index c5cd63a..9c1e8f9 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -11,6 +11,7 @@ platforms += cavium-octeon
 platforms += cobalt
 platforms += dec
 platforms += emma
+platforms += generic
 platforms += jazz
 platforms += jz4740
 platforms += lantiq
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 49eb902..2884d80 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -72,6 +72,56 @@ choice
 	prompt "System type"
 	default SGI_IP22
 
+config MIPS_GENERIC
+	bool "Generic board-agnostic MIPS kernel"
+	select BOOT_RAW
+	select BUILTIN_DTB
+	select CEVT_R4K
+	select CLKSRC_MIPS_GIC
+	select COMMON_CLK
+	select CPU_MIPSR2_IRQ_VI
+	select CPU_MIPSR2_IRQ_EI
+	select CSRC_R4K
+	select DMA_PERDEV_COHERENT
+	select HW_HAS_PCI
+	select IRQ_MIPS_CPU
+	select LIBFDT
+	select MIPS_CPU_SCACHE
+	select MIPS_GIC
+	select NO_EXCEPT_FILL
+	select PCI_DRIVERS_GENERIC
+	select PINCTRL
+	select SMP_UP if SMP
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS32_R6
+	select SYS_HAS_CPU_MIPS64_R1
+	select SYS_HAS_CPU_MIPS64_R2
+	select SYS_HAS_CPU_MIPS64_R6
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_MICROMIPS
+	select SYS_SUPPORTS_MIPS_CPS
+	select SYS_SUPPORTS_MIPS16
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_RELOCATABLE
+	select SYS_SUPPORTS_SMARTMIPS
+	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
+	select USE_OF
+	help
+	  Select this to build a kernel which aims to support multiple boards,
+	  generally using a flattened device tree passed from the bootloader
+	  using the boot protocol defined in the UHI (Unified Hosting
+	  Interface) specification.
+
 config MIPS_ALCHEMY
 	bool "Alchemy processor based machines"
 	select ARCH_PHYS_ADDR_T_64BIT
@@ -987,6 +1037,7 @@ source "arch/mips/ath79/Kconfig"
 source "arch/mips/bcm47xx/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/bmips/Kconfig"
+source "arch/mips/generic/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
 source "arch/mips/lantiq/Kconfig"
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d968ec0..1add1e7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -268,6 +268,12 @@ KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
 		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
 		  PLATFORM=$(platform-y)
+ifdef CONFIG_32BIT
+bootvars-y	+= ADDR_BITS=32
+endif
+ifdef CONFIG_64BIT
+bootvars-y	+= ADDR_BITS=64
+endif
 
 LDFLAGS			+= -m $(ld-emul)
 
@@ -435,4 +441,49 @@ define archhelp
 	echo '  dtbs_install         - Install dtbs to $(INSTALL_DTBS_PATH)'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
+	echo
+	echo '  If you are targetting a system supported by generic kernels you may'
+	echo '  configure the kernel for a given architecture target like so:'
+	echo
+	echo '  {micro32,32,64}{r1,r2,r6}{el,}_defconfig <BOARDS="list of boards">'
+	echo
+	echo '  Otherwise, the following default configurations are available:'
+endef
+
+generic_config_dir = $(srctree)/arch/$(ARCH)/configs/generic
+generic_defconfigs :=
+
+#
+# If the user generates a generic kernel configuration without specifying a
+# list of boards to include the config fragments for, default to including all
+# available board config fragments.
+#
+ifeq ($(BOARDS),)
+BOARDS = $(patsubst board-%.config,%,$(notdir $(wildcard $(generic_config_dir)/board-*.config)))
+endif
+
+#
+# Generic kernel configurations which merge generic_defconfig with the
+# appropriate config fragments from arch/mips/configs/generic/, resulting in
+# the ability to easily configure the kernel for a given architecture,
+# endianness & set of boards without duplicating the needed configuration in
+# hundreds of defconfig files.
+#
+define gen_generic_defconfigs
+$(foreach bits,$(1),$(foreach rev,$(2),$(foreach endian,$(3),
+target := $(bits)$(rev)$(filter el,$(endian))_defconfig
+generic_defconfigs += $$(target)
+$$(target): $(generic_config_dir)/$(bits)$(rev).config
+$$(target): $(generic_config_dir)/$(endian).config
+)))
 endef
+
+$(eval $(call gen_generic_defconfigs,32 64,r1 r2 r6,eb el))
+$(eval $(call gen_generic_defconfigs,micro32,r2,eb el))
+
+PHONY += $(generic_defconfigs)
+$(generic_defconfigs):
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
+		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/generic_defconfig $^ \
+		$(foreach board,$(BOARDS),$(generic_config_dir)/board-$(board).config)
+	$(Q)$(MAKE) olddefconfig
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index ed65663..2728a9a 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -111,13 +111,22 @@ targets += vmlinux.bz2.itb
 targets += vmlinux.lzma.itb
 targets += vmlinux.lzo.itb
 
+ifeq ($(ADDR_BITS),32)
+	itb_addr_cells = 1
+endif
+ifeq ($(ADDR_BITS),64)
+	itb_addr_cells = 2
+endif
+
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
 			-DVMLINUX_LOAD_ADDRESS=$(VMLINUX_LOAD_ADDRESS) \
-			-DVMLINUX_ENTRY_ADDRESS=$(VMLINUX_ENTRY_ADDRESS)
+			-DVMLINUX_ENTRY_ADDRESS=$(VMLINUX_ENTRY_ADDRESS) \
+			-DADDR_BITS=$(ADDR_BITS) \
+			-DADDR_CELLS=$(itb_addr_cells)
 
 $(obj)/vmlinux.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
 	$(call if_changed_dep,cpp_its_S,none,vmlinux.bin)
diff --git a/arch/mips/configs/generic/32r1.config b/arch/mips/configs/generic/32r1.config
new file mode 100644
index 0000000..a11cd87
--- /dev/null
+++ b/arch/mips/configs/generic/32r1.config
@@ -0,0 +1,2 @@
+CONFIG_CPU_MIPS32_R1=y
+CONFIG_HIGHMEM=y
diff --git a/arch/mips/configs/generic/32r2.config b/arch/mips/configs/generic/32r2.config
new file mode 100644
index 0000000..9570672
--- /dev/null
+++ b/arch/mips/configs/generic/32r2.config
@@ -0,0 +1,3 @@
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_MIPS_O32_FP64_SUPPORT=y
+CONFIG_HIGHMEM=y
diff --git a/arch/mips/configs/generic/32r6.config b/arch/mips/configs/generic/32r6.config
new file mode 100644
index 0000000..ca606e7
--- /dev/null
+++ b/arch/mips/configs/generic/32r6.config
@@ -0,0 +1,2 @@
+CONFIG_CPU_MIPS32_R6=y
+CONFIG_HIGHMEM=y
diff --git a/arch/mips/configs/generic/64r1.config b/arch/mips/configs/generic/64r1.config
new file mode 100644
index 0000000..96ac0d7
--- /dev/null
+++ b/arch/mips/configs/generic/64r1.config
@@ -0,0 +1 @@
+CONFIG_CPU_MIPS64_R1=y
diff --git a/arch/mips/configs/generic/64r2.config b/arch/mips/configs/generic/64r2.config
new file mode 100644
index 0000000..fa9cab0
--- /dev/null
+++ b/arch/mips/configs/generic/64r2.config
@@ -0,0 +1,2 @@
+CONFIG_CPU_MIPS64_R2=y
+CONFIG_MIPS_O32_FP64_SUPPORT=y
diff --git a/arch/mips/configs/generic/64r6.config b/arch/mips/configs/generic/64r6.config
new file mode 100644
index 0000000..51a9ebb
--- /dev/null
+++ b/arch/mips/configs/generic/64r6.config
@@ -0,0 +1 @@
+CONFIG_CPU_MIPS64_R6=y
diff --git a/arch/mips/configs/generic/eb.config b/arch/mips/configs/generic/eb.config
new file mode 100644
index 0000000..c5cdc99
--- /dev/null
+++ b/arch/mips/configs/generic/eb.config
@@ -0,0 +1 @@
+CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/generic/el.config b/arch/mips/configs/generic/el.config
new file mode 100644
index 0000000..ee43fdb
--- /dev/null
+++ b/arch/mips/configs/generic/el.config
@@ -0,0 +1 @@
+CONFIG_CPU_LITTLE_ENDIAN=y
diff --git a/arch/mips/configs/generic/micro32r2.config b/arch/mips/configs/generic/micro32r2.config
new file mode 100644
index 0000000..b701fe7
--- /dev/null
+++ b/arch/mips/configs/generic/micro32r2.config
@@ -0,0 +1,4 @@
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_CPU_MICROMIPS=y
+CONFIG_MIPS_O32_FP64_SUPPORT=y
+CONFIG_HIGHMEM=y
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
new file mode 100644
index 0000000..419d263
--- /dev/null
+++ b/arch/mips/configs/generic_defconfig
@@ -0,0 +1,2 @@
+CONFIG_MIPS=y
+CONFIG_MIPS_GENERIC=y
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
new file mode 100644
index 0000000..baddb06
--- /dev/null
+++ b/arch/mips/generic/Kconfig
@@ -0,0 +1,12 @@
+if MIPS_GENERIC
+
+config LEGACY_BOARDS
+	bool
+	help
+	  Select this from your board if the board must use a legacy, non-UHI,
+	  boot protocol. This will cause the kernel to scan through the list of
+	  supported machines calling their detect functions in turn if the
+	  kernel is booted without being provided with an FDT via the UHI
+	  boot protocol.
+
+endif
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
new file mode 100644
index 0000000..26e6420
--- /dev/null
+++ b/arch/mips/generic/Makefile
@@ -0,0 +1,13 @@
+#
+# Copyright (C) 2016 Imagination Technologies
+# Author: Paul Burton <paul.burton@imgtec.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the
+# Free Software Foundation;  either version 2 of the  License, or (at your
+# option) any later version.
+#
+
+obj-y += init.o
+obj-y += irq.o
+obj-y += proc.o
diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
new file mode 100644
index 0000000..9a30d69
--- /dev/null
+++ b/arch/mips/generic/Platform
@@ -0,0 +1,14 @@
+#
+# Copyright (C) 2016 Imagination Technologies
+# Author: Paul Burton <paul.burton@imgtec.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the
+# Free Software Foundation;  either version 2 of the  License, or (at your
+# option) any later version.
+#
+
+platform-$(CONFIG_MIPS_GENERIC)	+= generic/
+cflags-$(CONFIG_MIPS_GENERIC)	+= -I$(srctree)/arch/mips/include/asm/mach-generic
+load-$(CONFIG_MIPS_GENERIC)	+= 0xffffffff80100000
+all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
new file mode 100644
index 0000000..a591ab9
--- /dev/null
+++ b/arch/mips/generic/init.c
@@ -0,0 +1,174 @@
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
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+#include <asm/fw/fw.h>
+#include <asm/irq_cpu.h>
+#include <asm/machine.h>
+#include <asm/mips-cpc.h>
+#include <asm/prom.h>
+#include <asm/smp-ops.h>
+#include <asm/time.h>
+
+static __initdata const void *fdt;
+static __initdata const struct mips_machine *mach;
+static __initdata const void *mach_match_data;
+
+void __init prom_init(void)
+{
+	const struct mips_machine *check_mach;
+	const struct of_device_id *match;
+
+	if ((fw_arg0 == -2) && !fdt_check_header((void *)fw_arg1)) {
+		/*
+		 * We booted using the UHI boot protocol, so we have been
+		 * provided with the appropriate device tree for the board.
+		 * Make use of it & search for any machine struct based upon
+		 * the root compatible string.
+		 */
+		fdt = (void *)fw_arg1;
+
+		for_each_mips_machine(check_mach) {
+			match = mips_machine_is_compatible(check_mach, fdt);
+			if (match) {
+				mach = check_mach;
+				mach_match_data = match->data;
+				break;
+			}
+		}
+	} else if (IS_ENABLED(CONFIG_LEGACY_BOARDS)) {
+		/*
+		 * We weren't booted using the UHI boot protocol, but do
+		 * support some number of boards with legacy boot protocols.
+		 * Attempt to find the right one.
+		 */
+		for_each_mips_machine(check_mach) {
+			if (!check_mach->detect)
+				continue;
+
+			if (!check_mach->detect())
+				continue;
+
+			mach = check_mach;
+		}
+
+		/*
+		 * If we don't recognise the machine then we can't continue, so
+		 * die here.
+		 */
+		BUG_ON(!mach);
+
+		/* Retrieve the machine's FDT */
+		fdt = mach->fdt;
+	}
+
+	BUG_ON(!fdt);
+}
+
+void __init *plat_get_fdt(void)
+{
+	return (void *)fdt;
+}
+
+void __init plat_mem_setup(void)
+{
+	if (mach && mach->fixup_fdt)
+		fdt = mach->fixup_fdt(fdt, mach_match_data);
+
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	__dt_setup_arch((void *)fdt);
+}
+
+void __init device_tree_init(void)
+{
+	int err;
+
+	unflatten_and_copy_device_tree();
+	mips_cpc_probe();
+
+	err = register_cps_smp_ops();
+	if (err)
+		err = register_up_smp_ops();
+	if (err)
+		pr_err("Failed to register any SMP implementation\n");
+}
+
+void __init plat_time_init(void)
+{
+	struct device_node *np;
+	struct clk *clk;
+
+	of_clk_init(NULL);
+
+	if (!cpu_has_counter) {
+		mips_hpt_frequency = 0;
+	} else if (mach && mach->measure_hpt_freq) {
+		mips_hpt_frequency = mach->measure_hpt_freq();
+	} else {
+		np = of_get_cpu_node(0, NULL);
+		if (!np) {
+			pr_err("Failed to get CPU node\n");
+			return;
+		}
+
+		clk = of_clk_get(np, 0);
+		if (IS_ERR(clk)) {
+			pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+			return;
+		}
+
+		mips_hpt_frequency = clk_get_rate(clk);
+		clk_put(clk);
+
+		switch (boot_cpu_type()) {
+		case CPU_20KC:
+		case CPU_25KF:
+			/* The counter runs at the CPU clock rate */
+			break;
+		default:
+			/* The counter runs at half the CPU clock rate */
+			mips_hpt_frequency /= 2;
+			break;
+		}
+	}
+
+	clocksource_probe();
+}
+
+void __init arch_init_irq(void)
+{
+	if (!cpu_has_veic)
+		mips_cpu_irq_init();
+
+	irqchip_init();
+}
+
+static int __init publish_devices(void)
+{
+	if (!of_have_populated_dt())
+		panic("Device-tree not present");
+
+	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
+		panic("Failed to populate DT");
+
+	return 0;
+}
+arch_initcall(publish_devices);
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
new file mode 100644
index 0000000..14064bd
--- /dev/null
+++ b/arch/mips/generic/irq.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/types.h>
+
+#include <asm/irq.h>
+
+int get_c0_fdc_int(void)
+{
+	int mips_cpu_fdc_irq;
+
+	if (cpu_has_veic)
+		panic("Unimplemented!");
+	else if (gic_present)
+		mips_cpu_fdc_irq = gic_get_c0_fdc_int();
+	else if (cp0_fdc_irq >= 0)
+		mips_cpu_fdc_irq = MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
+	else
+		mips_cpu_fdc_irq = -1;
+
+	return mips_cpu_fdc_irq;
+}
+
+int get_c0_perfcount_int(void)
+{
+	int mips_cpu_perf_irq;
+
+	if (cpu_has_veic)
+		panic("Unimplemented!");
+	else if (gic_present)
+		mips_cpu_perf_irq = gic_get_c0_perfcount_int();
+	else if (cp0_perfcount_irq >= 0)
+		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	else
+		mips_cpu_perf_irq = -1;
+
+	return mips_cpu_perf_irq;
+}
+
+unsigned int get_c0_compare_int(void)
+{
+	int mips_cpu_timer_irq;
+
+	if (cpu_has_veic)
+		panic("Unimplemented!");
+	else if (gic_present)
+		mips_cpu_timer_irq = gic_get_c0_compare_int();
+	else
+		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+
+	return mips_cpu_timer_irq;
+}
diff --git a/arch/mips/generic/proc.c b/arch/mips/generic/proc.c
new file mode 100644
index 0000000..42b3325
--- /dev/null
+++ b/arch/mips/generic/proc.c
@@ -0,0 +1,29 @@
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
+#include <linux/of.h>
+
+#include <asm/bootinfo.h>
+
+const char *get_system_type(void)
+{
+	const char *str;
+	int err;
+
+	err = of_property_read_string(of_root, "model", &str);
+	if (!err)
+		return str;
+
+	err = of_property_read_string_index(of_root, "compatible", 0, &str);
+	if (!err)
+		return str;
+
+	return "Unknown";
+}
diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
new file mode 100644
index 0000000..f67fbf1
--- /dev/null
+++ b/arch/mips/generic/vmlinux.its.S
@@ -0,0 +1,31 @@
+/dts-v1/;
+
+/ {
+	description = KERNEL_NAME;
+	#address-cells = <ADDR_CELLS>;
+
+	images {
+		kernel@0 {
+			description = KERNEL_NAME;
+			data = /incbin/(VMLINUX_BINARY);
+			type = "kernel";
+			arch = "mips";
+			os = "linux";
+			compression = VMLINUX_COMPRESSION;
+			load = /bits/ ADDR_BITS <VMLINUX_LOAD_ADDRESS>;
+			entry = /bits/ ADDR_BITS <VMLINUX_ENTRY_ADDRESS>;
+			hash@0 {
+				algo = "sha1";
+			};
+		};
+	};
+
+	configurations {
+		default = "conf@default";
+
+		conf@default {
+			description = "Generic Linux kernel";
+			kernel = "kernel@0";
+		};
+	};
+};
diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machine.h
new file mode 100644
index 0000000..6b444cd
--- /dev/null
+++ b/arch/mips/include/asm/machine.h
@@ -0,0 +1,63 @@
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
+#ifndef __MIPS_ASM_MACHINE_H__
+#define __MIPS_ASM_MACHINE_H__
+
+#include <linux/libfdt.h>
+#include <linux/of.h>
+
+struct mips_machine {
+	const struct of_device_id *matches;
+	const void *fdt;
+	bool (*detect)(void);
+	const void *(*fixup_fdt)(const void *fdt, const void *match_data);
+	unsigned int (*measure_hpt_freq)(void);
+};
+
+extern long __mips_machines_start;
+extern long __mips_machines_end;
+
+#define MIPS_MACHINE(name)						\
+	static const struct mips_machine __mips_mach_##name		\
+		__used __section(.mips.machines.init)
+
+#define for_each_mips_machine(mach)					\
+	for ((mach) = (struct mips_machine *)&__mips_machines_start;	\
+	     (mach) < (struct mips_machine *)&__mips_machines_end;	\
+	     (mach)++)
+
+/**
+ * mips_machine_is_compatible() - check if a machine is compatible with an FDT
+ * @mach: the machine struct to check
+ * @fdt: the FDT to check for compatibility with
+ *
+ * Check whether the given machine @mach is compatible with the given flattened
+ * device tree @fdt, based upon the compatibility property of the root node.
+ *
+ * Return: the device id matched if any, else NULL
+ */
+static inline const struct of_device_id *
+mips_machine_is_compatible(const struct mips_machine *mach, const void *fdt)
+{
+	const struct of_device_id *match;
+
+	if (!mach->matches)
+		return NULL;
+
+	for (match = mach->matches; match->compatible; match++) {
+		if (fdt_node_check_compatible(fdt, 0, match->compatible) == 0)
+			return match;
+	}
+
+	return NULL;
+}
+
+#endif /* __MIPS_ASM_MACHINE_H__ */
-- 
2.9.3
