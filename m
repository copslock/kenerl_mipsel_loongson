Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2009 02:35:01 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:57448 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493392AbZLXBez (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Dec 2009 02:34:55 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAF9TMkurRN+J/2dsb2JhbAC/YZZxhDMEgWU
X-IronPort-AV: E=Sophos;i="4.47,446,1257120000"; 
   d="scan'208";a="124620048"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 24 Dec 2009 01:34:46 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBO1Yk8g021213;
        Thu, 24 Dec 2009 01:34:46 GMT
Date:   Wed, 23 Dec 2009 17:34:46 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] powertv: streamline access to platform device registers
Message-ID: <20091224013446.GA10835@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Pre-compute addresses for the basic ASIC registers. This speeds up access
and allows memory for unused configurations to be freed. In addition,
uninitialized register addresses will be returned as NULL to catch bad
usage quickly.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
diff --git a/arch/mips/include/asm/mach-powertv/asic_reg_map.h b/arch/mips/include/asm/mach-powertv/asic_reg_map.h
new file mode 100644
index 0000000..6f26cb0
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/asic_reg_map.h
@@ -0,0 +1,90 @@
+/*
+ *				asic_reg_map.h
+ *
+ * A macro-enclosed list of the elements for the register_map structure for
+ * use in defining and manipulating the structure.
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+REGISTER_MAP_ELEMENT(eic_slow0_strt_add)
+REGISTER_MAP_ELEMENT(eic_cfg_bits)
+REGISTER_MAP_ELEMENT(eic_ready_status)
+REGISTER_MAP_ELEMENT(chipver3)
+REGISTER_MAP_ELEMENT(chipver2)
+REGISTER_MAP_ELEMENT(chipver1)
+REGISTER_MAP_ELEMENT(chipver0)
+REGISTER_MAP_ELEMENT(uart1_intstat)
+REGISTER_MAP_ELEMENT(uart1_inten)
+REGISTER_MAP_ELEMENT(uart1_config1)
+REGISTER_MAP_ELEMENT(uart1_config2)
+REGISTER_MAP_ELEMENT(uart1_divisorhi)
+REGISTER_MAP_ELEMENT(uart1_divisorlo)
+REGISTER_MAP_ELEMENT(uart1_data)
+REGISTER_MAP_ELEMENT(uart1_status)
+REGISTER_MAP_ELEMENT(int_stat_3)
+REGISTER_MAP_ELEMENT(int_stat_2)
+REGISTER_MAP_ELEMENT(int_stat_1)
+REGISTER_MAP_ELEMENT(int_stat_0)
+REGISTER_MAP_ELEMENT(int_config)
+REGISTER_MAP_ELEMENT(int_int_scan)
+REGISTER_MAP_ELEMENT(ien_int_3)
+REGISTER_MAP_ELEMENT(ien_int_2)
+REGISTER_MAP_ELEMENT(ien_int_1)
+REGISTER_MAP_ELEMENT(ien_int_0)
+REGISTER_MAP_ELEMENT(int_level_3_3)
+REGISTER_MAP_ELEMENT(int_level_3_2)
+REGISTER_MAP_ELEMENT(int_level_3_1)
+REGISTER_MAP_ELEMENT(int_level_3_0)
+REGISTER_MAP_ELEMENT(int_level_2_3)
+REGISTER_MAP_ELEMENT(int_level_2_2)
+REGISTER_MAP_ELEMENT(int_level_2_1)
+REGISTER_MAP_ELEMENT(int_level_2_0)
+REGISTER_MAP_ELEMENT(int_level_1_3)
+REGISTER_MAP_ELEMENT(int_level_1_2)
+REGISTER_MAP_ELEMENT(int_level_1_1)
+REGISTER_MAP_ELEMENT(int_level_1_0)
+REGISTER_MAP_ELEMENT(int_level_0_3)
+REGISTER_MAP_ELEMENT(int_level_0_2)
+REGISTER_MAP_ELEMENT(int_level_0_1)
+REGISTER_MAP_ELEMENT(int_level_0_0)
+REGISTER_MAP_ELEMENT(int_docsis_en)
+REGISTER_MAP_ELEMENT(mips_pll_setup)
+REGISTER_MAP_ELEMENT(usb_fs)
+REGISTER_MAP_ELEMENT(test_bus)
+REGISTER_MAP_ELEMENT(crt_spare)
+REGISTER_MAP_ELEMENT(usb2_ohci_int_mask)
+REGISTER_MAP_ELEMENT(usb2_strap)
+REGISTER_MAP_ELEMENT(ehci_hcapbase)
+REGISTER_MAP_ELEMENT(ohci_hc_revision)
+REGISTER_MAP_ELEMENT(bcm1_bs_lmi_steer)
+REGISTER_MAP_ELEMENT(usb2_control)
+REGISTER_MAP_ELEMENT(usb2_stbus_obc)
+REGISTER_MAP_ELEMENT(usb2_stbus_mess_size)
+REGISTER_MAP_ELEMENT(usb2_stbus_chunk_size)
+REGISTER_MAP_ELEMENT(pcie_regs)
+REGISTER_MAP_ELEMENT(tim_ch)
+REGISTER_MAP_ELEMENT(tim_cl)
+REGISTER_MAP_ELEMENT(gpio_dout)
+REGISTER_MAP_ELEMENT(gpio_din)
+REGISTER_MAP_ELEMENT(gpio_dir)
+REGISTER_MAP_ELEMENT(watchdog)
+REGISTER_MAP_ELEMENT(front_panel)
+REGISTER_MAP_ELEMENT(misc_clk_ctl1)
+REGISTER_MAP_ELEMENT(misc_clk_ctl2)
+REGISTER_MAP_ELEMENT(crt_ext_ctl)
+REGISTER_MAP_ELEMENT(register_maps)
diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
index 9a65c93..1e11236 100644
--- a/arch/mips/include/asm/mach-powertv/asic_regs.h
+++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
@@ -35,11 +35,12 @@ enum asic_type {
 #define CRONUS_11	0x0B4C1C21
 #define CRONUSLITE_10	0x0B4C1C40
 
-#define NAND_FLASH_BASE	0x03000000
-#define ZEUS_IO_BASE	0x09000000
+#define NAND_FLASH_BASE		0x03000000
 #define CALLIOPE_IO_BASE	0x08000000
-#define CRONUS_IO_BASE	0x09000000
-#define ASIC_IO_SIZE	0x01000000
+#define CRONUS_IO_BASE		0x09000000
+#define ZEUS_IO_BASE		0x09000000
+
+#define ASIC_IO_SIZE		0x01000000
 
 /* Definitions for backward compatibility */
 #define UART1_INTSTAT	uart1_intstat
@@ -52,96 +53,62 @@ enum asic_type {
 #define UART1_STATUS	uart1_status
 
 /* ASIC register enumeration */
+union register_map_entry {
+	unsigned long phys;
+	u32 *virt;
+};
+
+#define REGISTER_MAP_ELEMENT(x) union register_map_entry x;
 struct register_map {
-	u32 eic_slow0_strt_add;
-	u32 eic_cfg_bits;
-	u32 eic_ready_status;
-
-	u32 chipver3;
-	u32 chipver2;
-	u32 chipver1;
-	u32 chipver0;
-
-	u32 uart1_intstat;
-	u32 uart1_inten;
-	u32 uart1_config1;
-	u32 uart1_config2;
-	u32 uart1_divisorhi;
-	u32 uart1_divisorlo;
-	u32 uart1_data;
-	u32 uart1_status;
-
-	u32 int_stat_3;
-	u32 int_stat_2;
-	u32 int_stat_1;
-	u32 int_stat_0;
-	u32 int_config;
-	u32 int_int_scan;
-	u32 ien_int_3;
-	u32 ien_int_2;
-	u32 ien_int_1;
-	u32 ien_int_0;
-	u32 int_level_3_3;
-	u32 int_level_3_2;
-	u32 int_level_3_1;
-	u32 int_level_3_0;
-	u32 int_level_2_3;
-	u32 int_level_2_2;
-	u32 int_level_2_1;
-	u32 int_level_2_0;
-	u32 int_level_1_3;
-	u32 int_level_1_2;
-	u32 int_level_1_1;
-	u32 int_level_1_0;
-	u32 int_level_0_3;
-	u32 int_level_0_2;
-	u32 int_level_0_1;
-	u32 int_level_0_0;
-	u32 int_docsis_en;
-
-	u32 mips_pll_setup;
-	u32 usb_fs;
-	u32 test_bus;
-	u32 crt_spare;
-	u32 usb2_ohci_int_mask;
-	u32 usb2_strap;
-	u32 ehci_hcapbase;
-	u32 ohci_hc_revision;
-	u32 bcm1_bs_lmi_steer;
-	u32 usb2_control;
-	u32 usb2_stbus_obc;
-	u32 usb2_stbus_mess_size;
-	u32 usb2_stbus_chunk_size;
-
-	u32 pcie_regs;
-	u32 tim_ch;
-	u32 tim_cl;
-	u32 gpio_dout;
-	u32 gpio_din;
-	u32 gpio_dir;
-	u32 watchdog;
-	u32 front_panel;
-
-	u32 register_maps;
+#include <asm/mach-powertv/asic_reg_map.h>
 };
+#undef REGISTER_MAP_ELEMENT
+
+/**
+ * register_map_offset_phys - add an offset to the physical address
+ * @map:	Pointer to the &struct register_map
+ * @offset:	Value to add
+ *
+ * Only adds the base to non-zero physical addresses
+ */
+static inline void register_map_offset_phys(struct register_map *map,
+	unsigned long offset)
+{
+#define REGISTER_MAP_ELEMENT(x)		do {				\
+		if (map->x.phys != 0)					\
+			map->x.phys += offset;				\
+	} while (false);
+
+#include <asm/mach-powertv/asic_reg_map.h>
+#undef REGISTER_MAP_ELEMENT
+}
+
+/**
+ * register_map_virtualize - Convert &register_map to virtual addresses
+ * @map:	Pointer to &register_map to virtualize
+ */
+static inline void register_map_virtualize(struct register_map *map)
+{
+#define REGISTER_MAP_ELEMENT(x)		do {				\
+		map->x.virt = (!map->x.phys) ? NULL :			\
+			UNCAC_ADDR(phys_to_virt(map->x.phys));		\
+	} while (false);
+
+#include <asm/mach-powertv/asic_reg_map.h>
+#undef REGISTER_MAP_ELEMENT
+}
 
-extern enum asic_type asic;
-extern const struct register_map *register_map;
-extern unsigned long asic_phy_base;	/* Physical address of ASIC */
-extern unsigned long asic_base;		/* Virtual address of ASIC */
+extern struct register_map _asic_register_map;
 
 /*
  * Macros to interface to registers through their ioremapped address
- * asic_reg_offset	Returns the offset of a given register from the start
- *			of the ASIC address space
  * asic_reg_phys_addr	Returns the physical address of the given register
  * asic_reg_addr	Returns the iomapped virtual address of the given
  *			register.
  */
-#define asic_reg_offset(x)	(register_map->x)
-#define asic_reg_phys_addr(x)	(asic_phy_base + asic_reg_offset(x))
-#define asic_reg_addr(x) \
-	((unsigned int *) (asic_base + asic_reg_offset(x)))
+#define asic_reg_addr(x)	(_asic_register_map.x.virt)
+#define asic_reg_phys_addr(x)	(virt_to_phys((void *) CAC_ADDR(	\
+					(unsigned long) asic_reg_addr(x))))
 
 /*
  * The asic_reg macro is gone. It should be replaced by either asic_read or
diff --git a/arch/mips/powertv/asic/asic-calliope.c b/arch/mips/powertv/asic/asic-calliope.c
index 03d3884..1ae6623 100644
--- a/arch/mips/powertv/asic/asic-calliope.c
+++ b/arch/mips/powertv/asic/asic-calliope.c
@@ -23,76 +23,79 @@
  * Description:  Defines the platform resources for the SA settop.
  */
 
+#include <linux/init.h>
 #include <asm/mach-powertv/asic.h>
 
-const struct register_map calliope_register_map = {
-	.eic_slow0_strt_add = 0x800000,
-	.eic_cfg_bits = 0x800038,
-	.eic_ready_status = 0x80004c,
+#define CALLIOPE_ADDR(x)	(CALLIOPE_IO_BASE + (x))
 
-	.chipver3 = 0xA00800,
-	.chipver2 = 0xA00804,
-	.chipver1 = 0xA00808,
-	.chipver0 = 0xA0080c,
+const struct register_map calliope_register_map __initdata = {
+	.eic_slow0_strt_add = {.phys = CALLIOPE_ADDR(0x800000)},
+	.eic_cfg_bits = {.phys = CALLIOPE_ADDR(0x800038)},
+	.eic_ready_status = {.phys = CALLIOPE_ADDR(0x80004c)},
+
+	.chipver3 = {.phys = CALLIOPE_ADDR(0xA00800)},
+	.chipver2 = {.phys = CALLIOPE_ADDR(0xA00804)},
+	.chipver1 = {.phys = CALLIOPE_ADDR(0xA00808)},
+	.chipver0 = {.phys = CALLIOPE_ADDR(0xA0080c)},
 
 	/* The registers of IRBlaster */
-	.uart1_intstat = 0xA01800,
-	.uart1_inten = 0xA01804,
-	.uart1_config1 = 0xA01808,
-	.uart1_config2 = 0xA0180C,
-	.uart1_divisorhi = 0xA01810,
-	.uart1_divisorlo = 0xA01814,
-	.uart1_data = 0xA01818,
-	.uart1_status = 0xA0181C,
+	.uart1_intstat = {.phys = CALLIOPE_ADDR(0xA01800)},
+	.uart1_inten = {.phys = CALLIOPE_ADDR(0xA01804)},
+	.uart1_config1 = {.phys = CALLIOPE_ADDR(0xA01808)},
+	.uart1_config2 = {.phys = CALLIOPE_ADDR(0xA0180C)},
+	.uart1_divisorhi = {.phys = CALLIOPE_ADDR(0xA01810)},
+	.uart1_divisorlo = {.phys = CALLIOPE_ADDR(0xA01814)},
+	.uart1_data = {.phys = CALLIOPE_ADDR(0xA01818)},
+	.uart1_status = {.phys = CALLIOPE_ADDR(0xA0181C)},
 
-	.int_stat_3 = 0xA02800,
-	.int_stat_2 = 0xA02804,
-	.int_stat_1 = 0xA02808,
-	.int_stat_0 = 0xA0280c,
-	.int_config = 0xA02810,
-	.int_int_scan = 0xA02818,
-	.ien_int_3 = 0xA02830,
-	.ien_int_2 = 0xA02834,
-	.ien_int_1 = 0xA02838,
-	.ien_int_0 = 0xA0283c,
-	.int_level_3_3 = 0xA02880,
-	.int_level_3_2 = 0xA02884,
-	.int_level_3_1 = 0xA02888,
-	.int_level_3_0 = 0xA0288c,
-	.int_level_2_3 = 0xA02890,
-	.int_level_2_2 = 0xA02894,
-	.int_level_2_1 = 0xA02898,
-	.int_level_2_0 = 0xA0289c,
-	.int_level_1_3 = 0xA028a0,
-	.int_level_1_2 = 0xA028a4,
-	.int_level_1_1 = 0xA028a8,
-	.int_level_1_0 = 0xA028ac,
-	.int_level_0_3 = 0xA028b0,
-	.int_level_0_2 = 0xA028b4,
-	.int_level_0_1 = 0xA028b8,
-	.int_level_0_0 = 0xA028bc,
-	.int_docsis_en = 0xA028F4,
+	.int_stat_3 = {.phys = CALLIOPE_ADDR(0xA02800)},
+	.int_stat_2 = {.phys = CALLIOPE_ADDR(0xA02804)},
+	.int_stat_1 = {.phys = CALLIOPE_ADDR(0xA02808)},
+	.int_stat_0 = {.phys = CALLIOPE_ADDR(0xA0280c)},
+	.int_config = {.phys = CALLIOPE_ADDR(0xA02810)},
+	.int_int_scan = {.phys = CALLIOPE_ADDR(0xA02818)},
+	.ien_int_3 = {.phys = CALLIOPE_ADDR(0xA02830)},
+	.ien_int_2 = {.phys = CALLIOPE_ADDR(0xA02834)},
+	.ien_int_1 = {.phys = CALLIOPE_ADDR(0xA02838)},
+	.ien_int_0 = {.phys = CALLIOPE_ADDR(0xA0283c)},
+	.int_level_3_3 = {.phys = CALLIOPE_ADDR(0xA02880)},
+	.int_level_3_2 = {.phys = CALLIOPE_ADDR(0xA02884)},
+	.int_level_3_1 = {.phys = CALLIOPE_ADDR(0xA02888)},
+	.int_level_3_0 = {.phys = CALLIOPE_ADDR(0xA0288c)},
+	.int_level_2_3 = {.phys = CALLIOPE_ADDR(0xA02890)},
+	.int_level_2_2 = {.phys = CALLIOPE_ADDR(0xA02894)},
+	.int_level_2_1 = {.phys = CALLIOPE_ADDR(0xA02898)},
+	.int_level_2_0 = {.phys = CALLIOPE_ADDR(0xA0289c)},
+	.int_level_1_3 = {.phys = CALLIOPE_ADDR(0xA028a0)},
+	.int_level_1_2 = {.phys = CALLIOPE_ADDR(0xA028a4)},
+	.int_level_1_1 = {.phys = CALLIOPE_ADDR(0xA028a8)},
+	.int_level_1_0 = {.phys = CALLIOPE_ADDR(0xA028ac)},
+	.int_level_0_3 = {.phys = CALLIOPE_ADDR(0xA028b0)},
+	.int_level_0_2 = {.phys = CALLIOPE_ADDR(0xA028b4)},
+	.int_level_0_1 = {.phys = CALLIOPE_ADDR(0xA028b8)},
+	.int_level_0_0 = {.phys = CALLIOPE_ADDR(0xA028bc)},
+	.int_docsis_en = {.phys = CALLIOPE_ADDR(0xA028F4)},
 
-	.mips_pll_setup = 0x980000,
-	.usb_fs = 0x980030,     	/* -default 72800028- */
-	.test_bus = 0x9800CC,
-	.crt_spare = 0x9800d4,
-	.usb2_ohci_int_mask = 0x9A000c,
-	.usb2_strap = 0x9A0014,
-	.ehci_hcapbase = 0x9BFE00,
-	.ohci_hc_revision = 0x9BFC00,
-	.bcm1_bs_lmi_steer = 0x9E0004,
-	.usb2_control = 0x9E0054,
-	.usb2_stbus_obc = 0x9BFF00,
-	.usb2_stbus_mess_size = 0x9BFF04,
-	.usb2_stbus_chunk_size = 0x9BFF08,
+	.mips_pll_setup = {.phys = CALLIOPE_ADDR(0x980000)},
+	.usb_fs = {.phys = CALLIOPE_ADDR(0x980030)},
+	.test_bus = {.phys = CALLIOPE_ADDR(0x9800CC)},
+	.crt_spare = {.phys = CALLIOPE_ADDR(0x9800d4)},
+	.usb2_ohci_int_mask = {.phys = CALLIOPE_ADDR(0x9A000c)},
+	.usb2_strap = {.phys = CALLIOPE_ADDR(0x9A0014)},
+	.ehci_hcapbase = {.phys = CALLIOPE_ADDR(0x9BFE00)},
+	.ohci_hc_revision = {.phys = CALLIOPE_ADDR(0x9BFC00)},
+	.bcm1_bs_lmi_steer = {.phys = CALLIOPE_ADDR(0x9E0004)},
+	.usb2_control = {.phys = CALLIOPE_ADDR(0x9E0054)},
+	.usb2_stbus_obc = {.phys = CALLIOPE_ADDR(0x9BFF00)},
+	.usb2_stbus_mess_size = {.phys = CALLIOPE_ADDR(0x9BFF04)},
+	.usb2_stbus_chunk_size = {.phys = CALLIOPE_ADDR(0x9BFF08)},
 
-	.pcie_regs = 0x000000,      	/* -doesn't exist- */
-	.tim_ch = 0xA02C10,
-	.tim_cl = 0xA02C14,
-	.gpio_dout = 0xA02c20,
-	.gpio_din = 0xA02c24,
-	.gpio_dir = 0xA02c2C,
-	.watchdog = 0xA02c30,
-	.front_panel = 0x000000,    	/* -not used- */
+	.pcie_regs = {.phys = 0x000000},      	/* -doesn't exist- */
+	.tim_ch = {.phys = CALLIOPE_ADDR(0xA02C10)},
+	.tim_cl = {.phys = CALLIOPE_ADDR(0xA02C14)},
+	.gpio_dout = {.phys = CALLIOPE_ADDR(0xA02c20)},
+	.gpio_din = {.phys = CALLIOPE_ADDR(0xA02c24)},
+	.gpio_dir = {.phys = CALLIOPE_ADDR(0xA02c2C)},
+	.watchdog = {.phys = CALLIOPE_ADDR(0xA02c30)},
+	.front_panel = {.phys = 0x000000},    	/* -not used- */
 };
diff --git a/arch/mips/powertv/asic/asic-cronus.c b/arch/mips/powertv/asic/asic-cronus.c
index 5f4589c..5bb64bf 100644
--- a/arch/mips/powertv/asic/asic-cronus.c
+++ b/arch/mips/powertv/asic/asic-cronus.c
@@ -23,76 +23,79 @@
  * Description:  Defines the platform resources for the SA settop.
  */
 
+#include <linux/init.h>
 #include <asm/mach-powertv/asic.h>
 
-const struct register_map cronus_register_map = {
-	.eic_slow0_strt_add = 0x000000,
-	.eic_cfg_bits = 0x000038,
-	.eic_ready_status = 0x00004C,
+#define CRONUS_ADDR(x)	(CRONUS_IO_BASE + (x))
 
-	.chipver3 = 0x2A0800,
-	.chipver2 = 0x2A0804,
-	.chipver1 = 0x2A0808,
-	.chipver0 = 0x2A080C,
+const struct register_map cronus_register_map __initdata = {
+	.eic_slow0_strt_add = {.phys = CRONUS_ADDR(0x000000)},
+	.eic_cfg_bits = {.phys = CRONUS_ADDR(0x000038)},
+	.eic_ready_status = {.phys = CRONUS_ADDR(0x00004C)},
+
+	.chipver3 = {.phys = CRONUS_ADDR(0x2A0800)},
+	.chipver2 = {.phys = CRONUS_ADDR(0x2A0804)},
+	.chipver1 = {.phys = CRONUS_ADDR(0x2A0808)},
+	.chipver0 = {.phys = CRONUS_ADDR(0x2A080C)},
 
 	/* The registers of IRBlaster */
-	.uart1_intstat = 0x2A1800,
-	.uart1_inten = 0x2A1804,
-	.uart1_config1 = 0x2A1808,
-	.uart1_config2 = 0x2A180C,
-	.uart1_divisorhi = 0x2A1810,
-	.uart1_divisorlo = 0x2A1814,
-	.uart1_data = 0x2A1818,
-	.uart1_status = 0x2A181C,
+	.uart1_intstat = {.phys = CRONUS_ADDR(0x2A1800)},
+	.uart1_inten = {.phys = CRONUS_ADDR(0x2A1804)},
+	.uart1_config1 = {.phys = CRONUS_ADDR(0x2A1808)},
+	.uart1_config2 = {.phys = CRONUS_ADDR(0x2A180C)},
+	.uart1_divisorhi = {.phys = CRONUS_ADDR(0x2A1810)},
+	.uart1_divisorlo = {.phys = CRONUS_ADDR(0x2A1814)},
+	.uart1_data = {.phys = CRONUS_ADDR(0x2A1818)},
+	.uart1_status = {.phys = CRONUS_ADDR(0x2A181C)},
 
-	.int_stat_3 = 0x2A2800,
-	.int_stat_2 = 0x2A2804,
-	.int_stat_1 = 0x2A2808,
-	.int_stat_0 = 0x2A280C,
-	.int_config = 0x2A2810,
-	.int_int_scan = 0x2A2818,
-	.ien_int_3 = 0x2A2830,
-	.ien_int_2 = 0x2A2834,
-	.ien_int_1 = 0x2A2838,
-	.ien_int_0 = 0x2A283C,
-	.int_level_3_3 = 0x2A2880,
-	.int_level_3_2 = 0x2A2884,
-	.int_level_3_1 = 0x2A2888,
-	.int_level_3_0 = 0x2A288C,
-	.int_level_2_3 = 0x2A2890,
-	.int_level_2_2 = 0x2A2894,
-	.int_level_2_1 = 0x2A2898,
-	.int_level_2_0 = 0x2A289C,
-	.int_level_1_3 = 0x2A28A0,
-	.int_level_1_2 = 0x2A28A4,
-	.int_level_1_1 = 0x2A28A8,
-	.int_level_1_0 = 0x2A28AC,
-	.int_level_0_3 = 0x2A28B0,
-	.int_level_0_2 = 0x2A28B4,
-	.int_level_0_1 = 0x2A28B8,
-	.int_level_0_0 = 0x2A28BC,
-	.int_docsis_en = 0x2A28F4,
+	.int_stat_3 = {.phys = CRONUS_ADDR(0x2A2800)},
+	.int_stat_2 = {.phys = CRONUS_ADDR(0x2A2804)},
+	.int_stat_1 = {.phys = CRONUS_ADDR(0x2A2808)},
+	.int_stat_0 = {.phys = CRONUS_ADDR(0x2A280C)},
+	.int_config = {.phys = CRONUS_ADDR(0x2A2810)},
+	.int_int_scan = {.phys = CRONUS_ADDR(0x2A2818)},
+	.ien_int_3 = {.phys = CRONUS_ADDR(0x2A2830)},
+	.ien_int_2 = {.phys = CRONUS_ADDR(0x2A2834)},
+	.ien_int_1 = {.phys = CRONUS_ADDR(0x2A2838)},
+	.ien_int_0 = {.phys = CRONUS_ADDR(0x2A283C)},
+	.int_level_3_3 = {.phys = CRONUS_ADDR(0x2A2880)},
+	.int_level_3_2 = {.phys = CRONUS_ADDR(0x2A2884)},
+	.int_level_3_1 = {.phys = CRONUS_ADDR(0x2A2888)},
+	.int_level_3_0 = {.phys = CRONUS_ADDR(0x2A288C)},
+	.int_level_2_3 = {.phys = CRONUS_ADDR(0x2A2890)},
+	.int_level_2_2 = {.phys = CRONUS_ADDR(0x2A2894)},
+	.int_level_2_1 = {.phys = CRONUS_ADDR(0x2A2898)},
+	.int_level_2_0 = {.phys = CRONUS_ADDR(0x2A289C)},
+	.int_level_1_3 = {.phys = CRONUS_ADDR(0x2A28A0)},
+	.int_level_1_2 = {.phys = CRONUS_ADDR(0x2A28A4)},
+	.int_level_1_1 = {.phys = CRONUS_ADDR(0x2A28A8)},
+	.int_level_1_0 = {.phys = CRONUS_ADDR(0x2A28AC)},
+	.int_level_0_3 = {.phys = CRONUS_ADDR(0x2A28B0)},
+	.int_level_0_2 = {.phys = CRONUS_ADDR(0x2A28B4)},
+	.int_level_0_1 = {.phys = CRONUS_ADDR(0x2A28B8)},
+	.int_level_0_0 = {.phys = CRONUS_ADDR(0x2A28BC)},
+	.int_docsis_en = {.phys = CRONUS_ADDR(0x2A28F4)},
 
-	.mips_pll_setup = 0x1C0000,
-	.usb_fs = 0x1C0018,
-	.test_bus = 0x1C00CC,
-	.crt_spare = 0x1c00d4,
-	.usb2_ohci_int_mask = 0x20000C,
-	.usb2_strap = 0x200014,
-	.ehci_hcapbase = 0x21FE00,
-	.ohci_hc_revision = 0x1E0000,
-	.bcm1_bs_lmi_steer = 0x2E0008,
-	.usb2_control = 0x2E004C,
-	.usb2_stbus_obc = 0x21FF00,
-	.usb2_stbus_mess_size = 0x21FF04,
-	.usb2_stbus_chunk_size = 0x21FF08,
+	.mips_pll_setup = {.phys = CRONUS_ADDR(0x1C0000)},
+	.usb_fs = {.phys = CRONUS_ADDR(0x1C0018)},
+	.test_bus = {.phys = CRONUS_ADDR(0x1C00CC)},
+	.crt_spare = {.phys = CRONUS_ADDR(0x1c00d4)},
+	.usb2_ohci_int_mask = {.phys = CRONUS_ADDR(0x20000C)},
+	.usb2_strap = {.phys = CRONUS_ADDR(0x200014)},
+	.ehci_hcapbase = {.phys = CRONUS_ADDR(0x21FE00)},
+	.ohci_hc_revision = {.phys = CRONUS_ADDR(0x1E0000)},
+	.bcm1_bs_lmi_steer = {.phys = CRONUS_ADDR(0x2E0008)},
+	.usb2_control = {.phys = CRONUS_ADDR(0x2E004C)},
+	.usb2_stbus_obc = {.phys = CRONUS_ADDR(0x21FF00)},
+	.usb2_stbus_mess_size = {.phys = CRONUS_ADDR(0x21FF04)},
+	.usb2_stbus_chunk_size = {.phys = CRONUS_ADDR(0x21FF08)},
 
-	.pcie_regs = 0x220000,
-	.tim_ch = 0x2A2C10,
-	.tim_cl = 0x2A2C14,
-	.gpio_dout = 0x2A2C20,
-	.gpio_din = 0x2A2C24,
-	.gpio_dir = 0x2A2C2C,
-	.watchdog = 0x2A2C30,
-	.front_panel = 0x2A3800,
+	.pcie_regs = {.phys = CRONUS_ADDR(0x220000)},
+	.tim_ch = {.phys = CRONUS_ADDR(0x2A2C10)},
+	.tim_cl = {.phys = CRONUS_ADDR(0x2A2C14)},
+	.gpio_dout = {.phys = CRONUS_ADDR(0x2A2C20)},
+	.gpio_din = {.phys = CRONUS_ADDR(0x2A2C24)},
+	.gpio_dir = {.phys = CRONUS_ADDR(0x2A2C2C)},
+	.watchdog = {.phys = CRONUS_ADDR(0x2A2C30)},
+	.front_panel = {.phys = CRONUS_ADDR(0x2A3800)},
 };
diff --git a/arch/mips/powertv/asic/asic-zeus.c b/arch/mips/powertv/asic/asic-zeus.c
index 1469daa..095cbe1 100644
--- a/arch/mips/powertv/asic/asic-zeus.c
+++ b/arch/mips/powertv/asic/asic-zeus.c
@@ -23,76 +23,79 @@
  * Description:  Defines the platform resources for the SA settop.
  */
 
+#include <linux/init.h>
 #include <asm/mach-powertv/asic.h>
 
-const struct register_map zeus_register_map = {
-	.eic_slow0_strt_add = 0x000000,
-	.eic_cfg_bits = 0x000038,
-	.eic_ready_status = 0x00004c,
+#define ZEUS_ADDR(x)	(ZEUS_IO_BASE + (x))
 
-	.chipver3 = 0x280800,
-	.chipver2 = 0x280804,
-	.chipver1 = 0x280808,
-	.chipver0 = 0x28080c,
+const struct register_map zeus_register_map __initdata = {
+	.eic_slow0_strt_add = {.phys = ZEUS_ADDR(0x000000)},
+	.eic_cfg_bits = {.phys = ZEUS_ADDR(0x000038)},
+	.eic_ready_status = {.phys = ZEUS_ADDR(0x00004c)},
+
+	.chipver3 = {.phys = ZEUS_ADDR(0x280800)},
+	.chipver2 = {.phys = ZEUS_ADDR(0x280804)},
+	.chipver1 = {.phys = ZEUS_ADDR(0x280808)},
+	.chipver0 = {.phys = ZEUS_ADDR(0x28080c)},
 
 	/* The registers of IRBlaster */
-	.uart1_intstat = 0x281800,
-	.uart1_inten = 0x281804,
-	.uart1_config1 = 0x281808,
-	.uart1_config2 = 0x28180C,
-	.uart1_divisorhi = 0x281810,
-	.uart1_divisorlo = 0x281814,
-	.uart1_data = 0x281818,
-	.uart1_status = 0x28181C,
+	.uart1_intstat = {.phys = ZEUS_ADDR(0x281800)},
+	.uart1_inten = {.phys = ZEUS_ADDR(0x281804)},
+	.uart1_config1 = {.phys = ZEUS_ADDR(0x281808)},
+	.uart1_config2 = {.phys = ZEUS_ADDR(0x28180C)},
+	.uart1_divisorhi = {.phys = ZEUS_ADDR(0x281810)},
+	.uart1_divisorlo = {.phys = ZEUS_ADDR(0x281814)},
+	.uart1_data = {.phys = ZEUS_ADDR(0x281818)},
+	.uart1_status = {.phys = ZEUS_ADDR(0x28181C)},
 
-	.int_stat_3 = 0x282800,
-	.int_stat_2 = 0x282804,
-	.int_stat_1 = 0x282808,
-	.int_stat_0 = 0x28280c,
-	.int_config = 0x282810,
-	.int_int_scan = 0x282818,
-	.ien_int_3 = 0x282830,
-	.ien_int_2 = 0x282834,
-	.ien_int_1 = 0x282838,
-	.ien_int_0 = 0x28283c,
-	.int_level_3_3 = 0x282880,
-	.int_level_3_2 = 0x282884,
-	.int_level_3_1 = 0x282888,
-	.int_level_3_0 = 0x28288c,
-	.int_level_2_3 = 0x282890,
-	.int_level_2_2 = 0x282894,
-	.int_level_2_1 = 0x282898,
-	.int_level_2_0 = 0x28289c,
-	.int_level_1_3 = 0x2828a0,
-	.int_level_1_2 = 0x2828a4,
-	.int_level_1_1 = 0x2828a8,
-	.int_level_1_0 = 0x2828ac,
-	.int_level_0_3 = 0x2828b0,
-	.int_level_0_2 = 0x2828b4,
-	.int_level_0_1 = 0x2828b8,
-	.int_level_0_0 = 0x2828bc,
-	.int_docsis_en = 0x2828F4,
+	.int_stat_3 = {.phys = ZEUS_ADDR(0x282800)},
+	.int_stat_2 = {.phys = ZEUS_ADDR(0x282804)},
+	.int_stat_1 = {.phys = ZEUS_ADDR(0x282808)},
+	.int_stat_0 = {.phys = ZEUS_ADDR(0x28280c)},
+	.int_config = {.phys = ZEUS_ADDR(0x282810)},
+	.int_int_scan = {.phys = ZEUS_ADDR(0x282818)},
+	.ien_int_3 = {.phys = ZEUS_ADDR(0x282830)},
+	.ien_int_2 = {.phys = ZEUS_ADDR(0x282834)},
+	.ien_int_1 = {.phys = ZEUS_ADDR(0x282838)},
+	.ien_int_0 = {.phys = ZEUS_ADDR(0x28283c)},
+	.int_level_3_3 = {.phys = ZEUS_ADDR(0x282880)},
+	.int_level_3_2 = {.phys = ZEUS_ADDR(0x282884)},
+	.int_level_3_1 = {.phys = ZEUS_ADDR(0x282888)},
+	.int_level_3_0 = {.phys = ZEUS_ADDR(0x28288c)},
+	.int_level_2_3 = {.phys = ZEUS_ADDR(0x282890)},
+	.int_level_2_2 = {.phys = ZEUS_ADDR(0x282894)},
+	.int_level_2_1 = {.phys = ZEUS_ADDR(0x282898)},
+	.int_level_2_0 = {.phys = ZEUS_ADDR(0x28289c)},
+	.int_level_1_3 = {.phys = ZEUS_ADDR(0x2828a0)},
+	.int_level_1_2 = {.phys = ZEUS_ADDR(0x2828a4)},
+	.int_level_1_1 = {.phys = ZEUS_ADDR(0x2828a8)},
+	.int_level_1_0 = {.phys = ZEUS_ADDR(0x2828ac)},
+	.int_level_0_3 = {.phys = ZEUS_ADDR(0x2828b0)},
+	.int_level_0_2 = {.phys = ZEUS_ADDR(0x2828b4)},
+	.int_level_0_1 = {.phys = ZEUS_ADDR(0x2828b8)},
+	.int_level_0_0 = {.phys = ZEUS_ADDR(0x2828bc)},
+	.int_docsis_en = {.phys = ZEUS_ADDR(0x2828F4)},
 
-	.mips_pll_setup = 0x1a0000,
-	.usb_fs = 0x1a0018,
-	.test_bus = 0x1a0238,
-	.crt_spare = 0x1a0090,
-	.usb2_ohci_int_mask = 0x1e000c,
-	.usb2_strap = 0x1e0014,
-	.ehci_hcapbase = 0x1FFE00,
-	.ohci_hc_revision = 0x1FFC00,
-	.bcm1_bs_lmi_steer = 0x2C0008,
-	.usb2_control = 0x2c01a0,
-	.usb2_stbus_obc = 0x1FFF00,
-	.usb2_stbus_mess_size = 0x1FFF04,
-	.usb2_stbus_chunk_size = 0x1FFF08,
+	.mips_pll_setup = {.phys = ZEUS_ADDR(0x1a0000)},
+	.usb_fs = {.phys = ZEUS_ADDR(0x1a0018)},
+	.test_bus = {.phys = ZEUS_ADDR(0x1a0238)},
+	.crt_spare = {.phys = ZEUS_ADDR(0x1a0090)},
+	.usb2_ohci_int_mask = {.phys = ZEUS_ADDR(0x1e000c)},
+	.usb2_strap = {.phys = ZEUS_ADDR(0x1e0014)},
+	.ehci_hcapbase = {.phys = ZEUS_ADDR(0x1FFE00)},
+	.ohci_hc_revision = {.phys = ZEUS_ADDR(0x1FFC00)},
+	.bcm1_bs_lmi_steer = {.phys = ZEUS_ADDR(0x2C0008)},
+	.usb2_control = {.phys = ZEUS_ADDR(0x2c01a0)},
+	.usb2_stbus_obc = {.phys = ZEUS_ADDR(0x1FFF00)},
+	.usb2_stbus_mess_size = {.phys = ZEUS_ADDR(0x1FFF04)},
+	.usb2_stbus_chunk_size = {.phys = ZEUS_ADDR(0x1FFF08)},
 
-	.pcie_regs = 0x200000,
-	.tim_ch = 0x282C10,
-	.tim_cl = 0x282C14,
-	.gpio_dout = 0x282c20,
-	.gpio_din = 0x282c24,
-	.gpio_dir = 0x282c2C,
-	.watchdog = 0x282c30,
-	.front_panel = 0x283800,
+	.pcie_regs = {.phys = ZEUS_ADDR(0x200000)},
+	.tim_ch = {.phys = ZEUS_ADDR(0x282C10)},
+	.tim_cl = {.phys = ZEUS_ADDR(0x282C14)},
+	.gpio_dout = {.phys = ZEUS_ADDR(0x282c20)},
+	.gpio_din = {.phys = ZEUS_ADDR(0x282c24)},
+	.gpio_dir = {.phys = ZEUS_ADDR(0x282c2C)},
+	.watchdog = {.phys = ZEUS_ADDR(0x282c30)},
+	.front_panel = {.phys = ZEUS_ADDR(0x283800)},
 };
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index bae8288..6a88219 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -67,8 +67,8 @@ enum asic_type asic;
 
 unsigned int platform_features;
 unsigned int platform_family;
-const struct register_map  *register_map;
-EXPORT_SYMBOL(register_map);			/* Exported for testing */
+struct register_map _asic_register_map;
+EXPORT_SYMBOL(_asic_register_map);		/* Exported for testing */
 unsigned long asic_phy_base;
 unsigned long asic_base;
 EXPORT_SYMBOL(asic_base);			/* Exported for testing */
@@ -418,6 +418,15 @@ void platform_unconfigure_usb_ohci()
 {
 }
 
+static void __init set_register_map(unsigned long phys_base,
+	const struct register_map *map)
+{
+	asic_phy_base = phys_base;
+	_asic_register_map = *map;
+	register_map_virtualize(&_asic_register_map);
+	asic_base = (unsigned long)ioremap_nocache(phys_base, ASIC_IO_SIZE);
+}
+
 /**
  * configure_platform - configuration based on platform type.
  */
@@ -431,10 +440,7 @@ void __init configure_platform(void)
 	case FAMILY_1500VZF:
 		platform_features = FFS_CAPABLE;
 		asic = ASIC_CALLIOPE;
-		asic_phy_base = CALLIOPE_IO_BASE;
-		register_map = &calliope_register_map;
-		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
-			ASIC_IO_SIZE);
+		set_register_map(CALLIOPE_IO_BASE, &calliope_register_map);
 
 		if (platform_family == FAMILY_1500VZE) {
 			gp_resources = non_dvr_vze_calliope_resources;
@@ -455,10 +461,7 @@ void __init configure_platform(void)
 		platform_features = FFS_CAPABLE | PCIE_CAPABLE |
 			DISPLAY_CAPABLE;
 		asic = ASIC_ZEUS;
-		asic_phy_base = ZEUS_IO_BASE;
-		register_map = &zeus_register_map;
-		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
-			ASIC_IO_SIZE);
+		set_register_map(ZEUS_IO_BASE, &zeus_register_map);
 		gp_resources = non_dvr_zeus_resources;
 
 		pr_info("Platform: 4500 - ZEUS, NON_DVR_CAPABLE\n");
@@ -471,11 +474,6 @@ void __init configure_platform(void)
 		/* The settop has PCIE but it isn't used, so don't advertise
 		 * it*/
 		platform_features = FFS_CAPABLE | DISPLAY_CAPABLE;
-		asic_phy_base = CRONUS_IO_BASE;   /* same as Cronus */
-		register_map = &cronus_register_map;   /* same as Cronus */
-		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
-			ASIC_IO_SIZE);
-		gp_resources = non_dvr_cronuslite_resources;
 
 		/* ASIC version will determine if this is a real CronusLite or
 		 * Castrati(Cronus) */
@@ -489,6 +487,9 @@ void __init configure_platform(void)
 		else
 			asic = ASIC_CRONUSLITE;
 
+		/* Cronus and Cronus Lite have the same register map */
+		set_register_map(CRONUS_IO_BASE, &cronus_register_map);
+		gp_resources = non_dvr_cronuslite_resources;
 		pr_info("Platform: 4600 - %s, NON_DVR_CAPABLE, "
 			"chipversion=0x%08X\n",
 			(asic == ASIC_CRONUS) ? "CRONUS" : "CRONUS LITE",
@@ -498,10 +499,7 @@ void __init configure_platform(void)
 	case FAMILY_4600VZA:
 		platform_features = FFS_CAPABLE | DISPLAY_CAPABLE;
 		asic = ASIC_CRONUS;
-		asic_phy_base = CRONUS_IO_BASE;
-		register_map = &cronus_register_map;
-		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
-			ASIC_IO_SIZE);
+		set_register_map(CRONUS_IO_BASE, &cronus_register_map);
 		gp_resources = non_dvr_cronus_resources;
 
 		pr_info("Platform: Vz Class A - CRONUS, NON_DVR_CAPABLE\n");
@@ -512,10 +510,7 @@ void __init configure_platform(void)
 		platform_features = DVR_CAPABLE | PCIE_CAPABLE |
 			DISPLAY_CAPABLE;
 		asic = ASIC_ZEUS;
-		asic_phy_base = ZEUS_IO_BASE;
-		register_map = &zeus_register_map;
-		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
-			ASIC_IO_SIZE);
+		set_register_map(ZEUS_IO_BASE, &zeus_register_map);
 		gp_resources = dvr_zeus_resources;
 
 		pr_info("Platform: 8500/RNG200 - ZEUS, DVR_CAPABLE\n");
@@ -526,10 +521,7 @@ void __init configure_platform(void)
 		platform_features = DVR_CAPABLE | PCIE_CAPABLE |
 			DISPLAY_CAPABLE;
 		asic = ASIC_CRONUS;
-		asic_phy_base = CRONUS_IO_BASE;
-		register_map = &cronus_register_map;
-		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
-			ASIC_IO_SIZE);
+		set_register_map(CRONUS_IO_BASE, &cronus_register_map);
 		gp_resources = dvr_cronus_resources;
 
 		pr_info("Platform: 8600/Vz Class B - CRONUS, "
