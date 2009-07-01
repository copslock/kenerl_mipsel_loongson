Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:10:53 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by ftp.linux-mips.org id S1491878AbZGARHL
	for <"|/home/ecartis/ecartis -s linux-mips">;
	Wed, 1 Jul 2009 19:07:11 +0200
Message-Id: <20090701120940.183856745@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Wed, 01 Jul 2009 12:29:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Cc:	Maxime Bizon <mbizon@freebox.fr>,
	Florian Fainelli <florian@openwrt.org>
Subject: [patch 11/12] MIPS: BCM63XX: Add board support code.
References: <20090701112926.825088732@linux-mips.org>
Content-Disposition: inline; filename=0011.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-archive-position: 23577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From:	Maxime Bizon <mbizon@freebox.fr>

BCM6348-based:
 - 96348R
 - 96348gw
 - 96348GW-10
 - 96348GW-11
 - 96348GW-A
 - Sagem F@2404
 - Davolink DV201AMR

BCM6358-based:
 - 96358vw
 - 96358vw2
 - Pirelli/Alice AGPFS0

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/bcm63xx/Kconfig                           |    2 
 arch/mips/bcm63xx/Makefile                          |    2 
 arch/mips/bcm63xx/boards/Kconfig                    |   11 
 arch/mips/bcm63xx/boards/Makefile                   |    3 
 arch/mips/bcm63xx/boards/board_bcm963xx.c           |  532 ++++++++++++++++++++
 arch/mips/bcm63xx/prom.c                            |    4 
 arch/mips/bcm63xx/setup.c                           |   16 
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_board.h  |   12 
 arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h |   50 +
 9 files changed, 630 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/bcm63xx/boards/Kconfig
 create mode 100644 arch/mips/bcm63xx/boards/Makefile
 create mode 100644 arch/mips/bcm63xx/boards/board_bcm963xx.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_board.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h

--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -17,3 +17,5 @@ config BCM63XX_CPU_6358
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_MMIO
 endmenu
+
+source "arch/mips/bcm63xx/boards/Kconfig"
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -6,4 +6,6 @@ obj-y		+= dev-usb-ehci.o
 obj-y		+= dev-enet.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-y		+= boards/
+
 EXTRA_CFLAGS += -Werror
--- /dev/null
+++ b/arch/mips/bcm63xx/boards/Kconfig
@@ -0,0 +1,11 @@
+choice
+	prompt "Board support"
+	depends on BCM63XX
+	default BOARD_BCM963XX
+
+config BOARD_BCM963XX
+       bool "Generic Broadcom 963xx boards"
+	select SSB
+       help
+
+endchoice
--- /dev/null
+++ b/arch/mips/bcm63xx/boards/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_BOARD_BCM963XX)		+= board_bcm963xx.o
+
+EXTRA_CFLAGS += -Werror
--- /dev/null
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -0,0 +1,532 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/ssb/ssb.h>
+#include <asm/addrspace.h>
+#include <bcm63xx_board.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_board.h>
+#include <bcm63xx_dev_pci.h>
+#include <bcm63xx_dev_uart.h>
+#include <bcm63xx_dev_enet.h>
+#include <bcm63xx_dev_pcmcia.h>
+#include <bcm63xx_dev_usb_ohci.h>
+#include <bcm63xx_dev_usb_ehci.h>
+#include <board_bcm963xx.h>
+
+#define PFX	"board_bcm963xx: "
+
+static struct bcm963xx_nvram nvram;
+static unsigned int mac_addr_used;
+static struct board_info board;
+
+/*
+ * known 6348 boards
+ */
+#ifdef CONFIG_BCM63XX_CPU_6348
+static struct board_info __initdata board_96348r = {
+	.name				= "96348R",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+};
+
+static struct board_info __initdata board_96348gw_10 = {
+	.name				= "96348GW-10",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.has_ohci0			= 1,
+	.has_pccard			= 1,
+	.has_ehci0			= 1,
+};
+
+static struct board_info __initdata board_96348gw_11 = {
+	.name				= "96348GW-11",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+
+	.has_ohci0 = 1,
+	.has_pccard = 1,
+	.has_ehci0 = 1,
+};
+
+static struct board_info __initdata board_96348gw = {
+	.name				= "96348GW",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.has_ohci0 = 1,
+};
+
+static struct board_info __initdata board_FAST2404 = {
+        .name                           = "F@ST2404",
+        .expected_cpu_id                = 0x6348,
+
+        .has_enet0                      = 1,
+        .has_enet1                      = 1,
+        .has_pci                        = 1,
+
+        .enet0 = {
+                .has_phy                = 1,
+                .use_internal_phy       = 1,
+        },
+
+        .enet1 = {
+                .force_speed_100        = 1,
+                .force_duplex_full      = 1,
+        },
+
+
+        .has_ohci0 = 1,
+        .has_pccard = 1,
+        .has_ehci0 = 1,
+};
+
+static struct board_info __initdata board_DV201AMR = {
+	.name				= "DV201AMR",
+	.expected_cpu_id		= 0x6348,
+
+	.has_pci			= 1,
+	.has_ohci0			= 1,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+};
+
+static struct board_info __initdata board_96348gw_a = {
+	.name				= "96348GW-A",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.has_ohci0 = 1,
+};
+#endif
+
+/*
+ * known 6358 boards
+ */
+#ifdef CONFIG_BCM63XX_CPU_6358
+static struct board_info __initdata board_96358vw = {
+	.name				= "96358VW",
+	.expected_cpu_id		= 0x6358,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+
+	.has_ohci0 = 1,
+	.has_pccard = 1,
+	.has_ehci0 = 1,
+};
+
+static struct board_info __initdata board_96358vw2 = {
+	.name				= "96358VW2",
+	.expected_cpu_id		= 0x6358,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+
+	.has_ohci0 = 1,
+	.has_pccard = 1,
+	.has_ehci0 = 1,
+};
+
+static struct board_info __initdata board_AGPFS0 = {
+	.name                           = "AGPF-S0",
+	.expected_cpu_id                = 0x6358,
+
+	.has_enet0                      = 1,
+	.has_enet1                      = 1,
+	.has_pci                        = 1,
+
+	.enet0 = {
+		.has_phy                = 1,
+		.use_internal_phy       = 1,
+	},
+
+	.enet1 = {
+		.force_speed_100        = 1,
+		.force_duplex_full      = 1,
+	},
+
+	.has_ohci0 = 1,
+	.has_ehci0 = 1,
+};
+#endif
+
+/*
+ * all boards
+ */
+static const struct board_info __initdata *bcm963xx_boards[] = {
+#ifdef CONFIG_BCM63XX_CPU_6348
+	&board_96348r,
+	&board_96348gw,
+	&board_96348gw_10,
+	&board_96348gw_11,
+	&board_FAST2404,
+	&board_DV201AMR,
+	&board_96348gw_a,
+#endif
+
+#ifdef CONFIG_BCM63XX_CPU_6358
+	&board_96358vw,
+	&board_96358vw2,
+	&board_AGPFS0,
+#endif
+};
+
+/*
+ * early init callback, read nvram data from flash and checksum it
+ */
+void __init board_prom_init(void)
+{
+	unsigned int check_len, i;
+	u8 *boot_addr, *cfe, *p;
+	char cfe_version[32];
+	u32 val;
+
+	/* read base address of boot chip select (0) */
+	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+	val &= MPI_CSBASE_BASE_MASK;
+	boot_addr = (u8 *)KSEG1ADDR(val);
+
+	/* dump cfe version */
+	cfe = boot_addr + BCM963XX_CFE_VERSION_OFFSET;
+	if (!memcmp(cfe, "cfe-v", 5))
+		snprintf(cfe_version, sizeof(cfe_version), "%u.%u.%u-%u.%u",
+			 cfe[5], cfe[6], cfe[7], cfe[8], cfe[9]);
+	else
+		strcpy(cfe_version, "unknown");
+	printk(KERN_INFO PFX "CFE version: %s\n", cfe_version);
+
+	/* extract nvram data */
+	memcpy(&nvram, boot_addr + BCM963XX_NVRAM_OFFSET, sizeof(nvram));
+
+	/* check checksum before using data */
+	if (nvram.version <= 4)
+		check_len = offsetof(struct bcm963xx_nvram, checksum_old);
+	else
+		check_len = sizeof(nvram);
+	val = 0;
+	p = (u8 *)&nvram;
+	while (check_len--)
+		val += *p;
+	if (val) {
+		printk(KERN_ERR PFX "invalid nvram checksum\n");
+		return;
+	}
+
+	/* find board by name */
+	for (i = 0; i < ARRAY_SIZE(bcm963xx_boards); i++) {
+		if (strncmp(nvram.name, bcm963xx_boards[i]->name,
+			    sizeof(nvram.name)))
+			continue;
+		/* copy, board desc array is marked initdata */
+		memcpy(&board, bcm963xx_boards[i], sizeof(board));
+		break;
+	}
+
+	/* bail out if board is not found, will complain later */
+	if (!board.name[0]) {
+		char name[17];
+		memcpy(name, nvram.name, 16);
+		name[16] = 0;
+		printk(KERN_ERR PFX "unknown bcm963xx board: %s\n",
+		       name);
+		return;
+	}
+
+	/* setup pin multiplexing depending on board enabled device,
+	 * this has to be done this early since PCI init is done
+	 * inside arch_initcall */
+	val = 0;
+
+	if (board.has_pci) {
+		bcm63xx_pci_enabled = 1;
+		if (BCMCPU_IS_6348())
+			val |= GPIO_MODE_6348_G2_PCI;
+	}
+
+	if (board.has_pccard) {
+		if (BCMCPU_IS_6348())
+			val |= GPIO_MODE_6348_G1_MII_PCCARD;
+	}
+
+	if (board.has_enet0 && !board.enet0.use_internal_phy) {
+		if (BCMCPU_IS_6348())
+			val |= GPIO_MODE_6348_G3_EXT_MII |
+				GPIO_MODE_6348_G0_EXT_MII;
+	}
+
+	if (board.has_enet1 && !board.enet1.use_internal_phy) {
+		if (BCMCPU_IS_6348())
+			val |= GPIO_MODE_6348_G3_EXT_MII |
+				GPIO_MODE_6348_G0_EXT_MII;
+	}
+
+	bcm_gpio_writel(val, GPIO_MODE_REG);
+}
+
+/*
+ * second stage init callback, good time to panic if we couldn't
+ * identify on which board we're running since early printk is working
+ */
+void __init board_setup(void)
+{
+	if (!board.name[0])
+		panic("unable to detect bcm963xx board");
+	printk(KERN_INFO PFX "board name: %s\n", board.name);
+
+	/* make sure we're running on expected cpu */
+	if (bcm63xx_get_cpu_id() != board.expected_cpu_id)
+		panic("unexpected CPU for bcm963xx board");
+}
+
+/*
+ * return board name for /proc/cpuinfo
+ */
+const char *board_get_name(void)
+{
+	return board.name;
+}
+
+/*
+ * register & return a new board mac address
+ */
+static int board_get_mac_address(u8 *mac)
+{
+	u8 *p;
+	int count;
+
+	if (mac_addr_used >= nvram.mac_addr_count) {
+		printk(KERN_ERR PFX "not enough mac address\n");
+		return -ENODEV;
+	}
+
+	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
+	p = mac + ETH_ALEN - 1;
+	count = mac_addr_used;
+
+	while (count--) {
+		do {
+			(*p)++;
+			if (*p != 0)
+				break;
+			p--;
+		} while (p != mac);
+	}
+
+	if (p == mac) {
+		printk(KERN_ERR PFX "unable to fetch mac address\n");
+		return -ENODEV;
+	}
+
+	mac_addr_used++;
+	return 0;
+}
+
+static struct mtd_partition mtd_partitions[] = {
+	{
+		.name		= "cfe",
+		.offset		= 0x0,
+		.size		= 0x40000,
+	}
+};
+
+static struct physmap_flash_data flash_data = {
+	.width			= 2,
+	.nr_parts		= ARRAY_SIZE(mtd_partitions),
+	.parts			= mtd_partitions,
+};
+
+static struct resource mtd_resources[] = {
+	{
+		.start		= 0,	/* filled at runtime */
+		.end		= 0,	/* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device mtd_dev = {
+	.name			= "physmap-flash",
+	.resource		= mtd_resources,
+	.num_resources		= ARRAY_SIZE(mtd_resources),
+	.dev			= {
+		.platform_data	= &flash_data,
+	},
+};
+
+/*
+ * Register a sane SPROMv2 to make the on-board
+ * bcm4318 WLAN work
+ */
+static struct ssb_sprom bcm63xx_sprom = {
+	.revision		= 0x02,
+	.board_rev		= 0x17,
+	.country_code		= 0x0,
+	.ant_available_bg 	= 0x3,
+	.pa0b0			= 0x15ae,
+	.pa0b1			= 0xfa85,
+	.pa0b2			= 0xfe8d,
+	.pa1b0			= 0xffff,
+	.pa1b1			= 0xffff,
+	.pa1b2			= 0xffff,
+	.gpio0			= 0xff,
+	.gpio1			= 0xff,
+	.gpio2			= 0xff,
+	.gpio3			= 0xff,
+	.maxpwr_bg		= 0x004c,
+	.itssi_bg		= 0x00,
+	.boardflags_lo		= 0x2848,
+	.boardflags_hi		= 0x0000,
+};
+
+/*
+ * third stage init callback, register all board devices.
+ */
+int __init board_register_devices(void)
+{
+	u32 val;
+
+	bcm63xx_uart_register();
+
+	if (board.has_pccard)
+		bcm63xx_pcmcia_register();
+
+	if (board.has_enet0 &&
+	    !board_get_mac_address(board.enet0.mac_addr))
+		bcm63xx_enet_register(0, &board.enet0);
+
+	if (board.has_enet1 &&
+	    !board_get_mac_address(board.enet1.mac_addr))
+		bcm63xx_enet_register(1, &board.enet1);
+
+	if (board.has_ohci0)
+		bcm63xx_ohci_register();
+
+	if (board.has_ehci0)
+		bcm63xx_ehci_register();
+
+	/* Generate MAC address for WLAN and
+	 * register our SPROM */
+	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
+		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		if (ssb_arch_set_fallback_sprom(&bcm63xx_sprom) < 0)
+			printk(KERN_ERR "failed to register fallback SPROM\n");
+	}
+
+	/* read base address of boot chip select (0) */
+	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+	val &= MPI_CSBASE_BASE_MASK;
+	mtd_resources[0].start = val;
+	mtd_resources[0].end = 0x1FFFFFFF;
+
+	platform_device_register(&mtd_dev);
+
+	return 0;
+}
+
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <asm/bootinfo.h>
+#include <bcm63xx_board.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
@@ -36,6 +37,9 @@ void __init prom_init(void)
 
 	/* assign command line from kernel config */
 	strcpy(arcs_cmdline, CONFIG_CMDLINE);
+
+	/* do low level board init */
+	board_prom_init();
 }
 
 void __init prom_free_prom_memory(void)
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -16,6 +16,7 @@
 #include <asm/time.h>
 #include <asm/reboot.h>
 #include <asm/cacheflush.h>
+#include <bcm63xx_board.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
@@ -90,8 +91,9 @@ static void __bcm63xx_machine_reboot(cha
 const char *get_system_type(void)
 {
 	static char buf[128];
-	sprintf(buf, "bcm963xx (0x%04x/0x%04X)",
-		bcm63xx_get_cpu_id(), bcm63xx_get_cpu_rev());
+	snprintf(buf, sizeof(buf), "bcm63xx/%s (0x%04x/0x%04X)",
+		 board_get_name(),
+		 bcm63xx_get_cpu_id(), bcm63xx_get_cpu_rev());
 	return buf;
 }
 
@@ -99,6 +101,7 @@ void __init plat_time_init(void)
 {
 	mips_hpt_frequency = bcm63xx_get_cpu_freq() / 2;
 }
+
 void __init plat_mem_setup(void)
 {
 	add_memory_region(0, bcm63xx_get_memory_size(), BOOT_MEM_RAM);
@@ -110,4 +113,13 @@ void __init plat_mem_setup(void)
 	set_io_port_base(0);
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
+
+	board_setup();
+}
+
+int __init bcm63xx_register_devices(void)
+{
+	return board_register_devices();
 }
+
+arch_initcall(bcm63xx_register_devices);
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_board.h
@@ -0,0 +1,12 @@
+#ifndef BCM63XX_BOARD_H_
+#define BCM63XX_BOARD_H_
+
+const char *board_get_name(void);
+
+void board_prom_init(void);
+
+void board_setup(void);
+
+int board_register_devices(void);
+
+#endif /* ! BCM63XX_BOARD_H_ */
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -0,0 +1,50 @@
+#ifndef BOARD_BCM963XX_H_
+#define BOARD_BCM963XX_H_
+
+#include <linux/types.h>
+#include <bcm63xx_dev_enet.h>
+
+/*
+ * flash mapping
+ */
+#define BCM963XX_CFE_VERSION_OFFSET	0x570
+#define BCM963XX_NVRAM_OFFSET		0x580
+
+/*
+ * nvram structure
+ */
+struct bcm963xx_nvram {
+	u32	version;
+	u8	reserved1[256];
+	u8	name[16];
+	u32	main_tp_number;
+	u32	psi_size;
+	u32	mac_addr_count;
+	u8	mac_addr_base[6];
+	u8	reserved2[2];
+	u32	checksum_old;
+	u8	reserved3[720];
+	u32	checksum_high;
+};
+
+/*
+ * board definition
+ */
+struct board_info {
+	u8		name[16];
+	unsigned int	expected_cpu_id;
+
+	/* enabled feature/device */
+	unsigned int	has_enet0:1;
+	unsigned int	has_enet1:1;
+	unsigned int	has_pci:1;
+	unsigned int	has_pccard:1;
+	unsigned int	has_ohci0:1;
+	unsigned int	has_ehci0:1;
+
+	/* ethernet config */
+	struct bcm63xx_enet_platform_data enet0;
+	struct bcm63xx_enet_platform_data enet1;
+};
+
+#endif /* ! BOARD_BCM963XX_H_ */
