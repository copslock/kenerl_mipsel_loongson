Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 13:18:24 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:44913 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994689AbeCFMRMvuKhr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 13:17:12 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F10A9207DA; Tue,  6 Mar 2018 13:17:00 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C2D74209F7;
        Tue,  6 Mar 2018 13:16:20 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 4/5] MIPS: generic: Add support for Microsemi Ocelot
Date:   Tue,  6 Mar 2018 13:16:06 +0100
Message-Id: <20180306121607.1567-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Introduce support for the MIPS based Microsemi Ocelot SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/Makefile                            |  4 ++
 arch/mips/configs/generic/board-ocelot.config | 36 ++++++++++++++
 arch/mips/generic/Kconfig                     | 16 +++++++
 arch/mips/generic/Makefile                    |  1 +
 arch/mips/generic/board-ocelot.c              | 67 +++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 arch/mips/configs/generic/board-ocelot.config
 create mode 100644 arch/mips/generic/board-ocelot.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d1ca839c3981..d2882244cf1f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -543,6 +543,10 @@ generic_defconfig:
 # now that the boards have been converted to use the generic kernel they are
 # wrappers around the generic rules above.
 #
+.PHONY: ocelot_defconfig
+ocelot_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=ocelot
+
 .PHONY: sead3_defconfig
 sead3_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=sead-3
diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
new file mode 100644
index 000000000000..fa4e8988ebc8
--- /dev/null
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -0,0 +1,36 @@
+# require CONFIG_32BIT=y
+# require CONFIG_CPU_MIPS32_R2=y
+
+CONFIG_LEGACY_BOARD_OCELOT=y
+
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
+
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+
+CONFIG_GPIO_SYSFS=y
+
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+
+CONFIG_SPI=y
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_SPIDEV=y
+
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_OCELOT_RESET=y
+
+CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 2ff3b17bfab1..ba9b2c8cce68 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -27,6 +27,22 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
 
+comment "MSCC Ocelot doesn't work with SEAD3 enabled"
+	depends on LEGACY_BOARD_SEAD3
+
+config LEGACY_BOARD_OCELOT
+	bool "Support MSCC Ocelot boards"
+	depends on LEGACY_BOARD_SEAD3=n
+	select LEGACY_BOARDS
+	select MSCC_OCELOT
+
+config MSCC_OCELOT
+	bool
+	select GPIOLIB
+	select MSCC_OCELOT_IRQ
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+
 comment "FIT/UHI Boards"
 
 config FIT_IMAGE_FDT_BOSTON
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index 5c31e0c4697d..d03a36f869a4 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -14,5 +14,6 @@ obj-y += proc.o
 
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
+obj-$(CONFIG_LEGACY_BOARD_OCELOT)	+= board-ocelot.o
 obj-$(CONFIG_KEXEC)			+= kexec.o
 obj-$(CONFIG_VIRT_BOARD_RANCHU)		+= board-ranchu.o
diff --git a/arch/mips/generic/board-ocelot.c b/arch/mips/generic/board-ocelot.c
new file mode 100644
index 000000000000..44b5fdcc2ba0
--- /dev/null
+++ b/arch/mips/generic/board-ocelot.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi MIPS SoC support
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <asm/machine.h>
+#include <asm/prom.h>
+
+#define DEVCPU_GCB_CHIP_REGS_CHIP_ID	0x71070000
+#define CHIP_ID_PART_ID			GENMASK(27, 12)
+
+#define OCELOT_PART_ID			(0x7514 << 12)
+
+#define UART_UART			0x70100000
+
+static __init bool ocelot_detect(void)
+{
+	u32 rev;
+
+	rev = __raw_readl((void *)DEVCPU_GCB_CHIP_REGS_CHIP_ID);
+
+	if ((rev & CHIP_ID_PART_ID) != OCELOT_PART_ID)
+		return 0;
+
+	/* Copy command line from bootloader early for Initrd detection */
+	if (fw_arg0 < 10 && (fw_arg1 & 0xFFF00000) == 0x80000000) {
+		unsigned int prom_argc = fw_arg0;
+		const char **prom_argv = (const char **)fw_arg1;
+
+		if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
+			/* ignore all built-in args if any f/w args given */
+			strcpy(arcs_cmdline, prom_argv[1]);
+	}
+
+	return 1;
+}
+
+static void __init ocelot_earlyprintk_init(void)
+{
+	void __iomem *uart_base;
+
+	uart_base = ioremap_nocache(UART_UART, 0x20);
+	setup_8250_early_printk_port((unsigned long)uart_base, 2, 50000);
+}
+
+static void __init ocelot_late_init(void)
+{
+	ocelot_earlyprintk_init();
+}
+
+static __init const void *ocelot_fixup_fdt(const void *fdt,
+					   const void *match_data)
+{
+	/* This has to be done so late because ioremap needs to work */
+	late_time_init = ocelot_late_init;
+
+	return fdt;
+}
+
+extern char __dtb_ocelot_pcb123_begin[];
+
+MIPS_MACHINE(ocelot) = {
+	.fdt = __dtb_ocelot_pcb123_begin,
+	.fixup_fdt = ocelot_fixup_fdt,
+	.detect = ocelot_detect,
+};
-- 
2.16.2
