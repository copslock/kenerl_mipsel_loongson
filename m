Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 19:52:34 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:58353 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224793AbUKRTwW>; Thu, 18 Nov 2004 19:52:22 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAIJqJdh004346;
	Thu, 18 Nov 2004 11:52:19 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAIJqJ9Y004344;
	Thu, 18 Nov 2004 11:52:19 -0800
Date: Thu, 18 Nov 2004 11:52:19 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Support for NEC VR4133 in 2.6
Message-ID: <20041118195219.GA4337@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf

Attached patch implements support for NEC VR4133 and NEC Rockhopper in
2.6. Currently there is no ethernet driver for the ports on the CMB-VR4133.

The board has been booted with the Onboard PcNet32 network interface and with
an Intel EEPRO100 PCI NIC card.

Please review ...

Thanks
Manish Lachwani

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_NEC_vr4133_MR9056.patch"

Source: MontaVista Software, Inc. | http://www.mvista.com | Manish Lachwani <mlachwani@mvista.com>
Type: Enhancement
Disposition: Submitted to Linux-MIPS
Description:
	Support for NEC VR4133 and NEC CMB-VR4133 in 2.6.10 kernel

Index: linux/arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c
===================================================================
--- /dev/null
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c
@@ -0,0 +1,256 @@
+/*
+ * arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c
+ *
+ * Initialize for ALi M1535+(included M5229 and M5237).
+ *
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
+ *         Alex Sapkov <asapkov@ru.mvista.com>
+ *
+ * 2003-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for NEC-CMBVR4133 in 2.6
+ * Author: Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/serial.h>
+
+#include <asm/vr41xx/cmbvr4133.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+
+#define CONFIG_PORT(port)	((port) ? 0x3f0 : 0x370)
+#define DATA_PORT(port)		((port) ? 0x3f1 : 0x371)
+#define INDEX_PORT(port)	CONFIG_PORT(port)
+
+#define ENTER_CONFIG_MODE(port)				\
+	do {						\
+		outb_p(0x51, CONFIG_PORT(port));	\
+		outb_p(0x23, CONFIG_PORT(port));	\
+	} while(0)
+
+#define SELECT_LOGICAL_DEVICE(port, dev_no)		\
+	do {						\
+		outb_p(0x07, INDEX_PORT(port));		\
+		outb_p((dev_no), DATA_PORT(port));	\
+	} while(0)
+
+#define WRITE_CONFIG_DATA(port,index,data)		\
+	do {						\
+		outb_p((index), INDEX_PORT(port));	\
+		outb_p((data), DATA_PORT(port));	\
+	} while(0)
+
+#define EXIT_CONFIG_MODE(port)	outb(0xbb, CONFIG_PORT(port))
+
+#define PCI_CONFIG_ADDR	KSEG1ADDR(0x0f000c18)
+#define PCI_CONFIG_DATA	KSEG1ADDR(0x0f000c14)
+
+#ifdef CONFIG_BLK_DEV_FD
+
+void __devinit ali_m1535plus_fdc_init(int port)
+{
+	ENTER_CONFIG_MODE(port);
+	SELECT_LOGICAL_DEVICE(port, 0);		/* FDC */
+	WRITE_CONFIG_DATA(port, 0x30, 0x01);	/* FDC: enable */
+	WRITE_CONFIG_DATA(port, 0x60, 0x03);	/* I/O port base: 0x3f0 */
+	WRITE_CONFIG_DATA(port, 0x61, 0xf0);
+	WRITE_CONFIG_DATA(port, 0x70, 0x06);	/* IRQ: 6 */
+	WRITE_CONFIG_DATA(port, 0x74, 0x02);	/* DMA: channel 2 */
+	WRITE_CONFIG_DATA(port, 0xf0, 0x08);
+	WRITE_CONFIG_DATA(port, 0xf1, 0x00);
+	WRITE_CONFIG_DATA(port, 0xf2, 0xff);
+	WRITE_CONFIG_DATA(port, 0xf4, 0x00);
+	EXIT_CONFIG_MODE(port);
+}
+
+#endif
+
+void __devinit ali_m1535plus_parport_init(int port)
+{
+	ENTER_CONFIG_MODE(port);
+	SELECT_LOGICAL_DEVICE(port, 3);		/* Parallel Port */
+	WRITE_CONFIG_DATA(port, 0x30, 0x01);
+	WRITE_CONFIG_DATA(port, 0x60, 0x03);	/* I/O port base: 0x378 */
+	WRITE_CONFIG_DATA(port, 0x61, 0x78);
+	WRITE_CONFIG_DATA(port, 0x70, 0x07);	/* IRQ: 7 */
+	WRITE_CONFIG_DATA(port, 0x74, 0x04);	/* DMA: None */
+	WRITE_CONFIG_DATA(port, 0xf0, 0x8c);	/* IRQ polarity: Active Low */
+	WRITE_CONFIG_DATA(port, 0xf1, 0xc5);
+	EXIT_CONFIG_MODE(port);
+}
+
+#ifdef CONFIG_PC_KEYB
+
+void __devinit ali_m1535plus_keyboard_init(int port)
+{
+	ENTER_CONFIG_MODE(port);
+	SELECT_LOGICAL_DEVICE(port, 7);		/* KEYBOARD */
+	WRITE_CONFIG_DATA(port, 0x30, 0x01);	/* KEYBOARD: eable */
+	WRITE_CONFIG_DATA(port, 0x70, 0x01);	/* IRQ: 1 */
+	WRITE_CONFIG_DATA(port, 0x72, 0x0c);	/* PS/2 Mouse IRQ: 12 */
+	WRITE_CONFIG_DATA(port, 0xf0, 0x00);
+	EXIT_CONFIG_MODE(port);
+}
+
+#endif
+
+void __devinit ali_m1535plus_hotkey_init(int port)
+{
+	ENTER_CONFIG_MODE(port);
+	SELECT_LOGICAL_DEVICE(port, 0xc);	/* HOTKEY */
+	WRITE_CONFIG_DATA(port, 0x30, 0x00);
+	WRITE_CONFIG_DATA(port, 0xf0, 0x35);
+	WRITE_CONFIG_DATA(port, 0xf1, 0x14);
+	WRITE_CONFIG_DATA(port, 0xf2, 0x11);
+	WRITE_CONFIG_DATA(port, 0xf3, 0x71);
+	WRITE_CONFIG_DATA(port, 0xf5, 0x05);
+	EXIT_CONFIG_MODE(port);
+}
+
+void ali_m1535plus_init(struct pci_dev *dev)
+{
+	pci_write_config_byte(dev, 0x40, 0x18); /* PCI Interface Control */
+	pci_write_config_byte(dev, 0x41, 0xc0); /* PS2 keyb & mouse enable */
+	pci_write_config_byte(dev, 0x42, 0x41); /* ISA bus cycle control */
+	pci_write_config_byte(dev, 0x43, 0x00); /* ISA bus cycle control 2 */
+	pci_write_config_byte(dev, 0x44, 0x5d); /* IDE enable & IRQ 14 */
+	pci_write_config_byte(dev, 0x45, 0x0b); /* PCI int polling mode */
+	pci_write_config_byte(dev, 0x47, 0x00); /* BIOS chip select control */
+
+	/* IRQ routing */
+	pci_write_config_byte(dev, 0x48, 0x03); /* INTA IRQ10, INTB disable */
+	pci_write_config_byte(dev, 0x49, 0x00); /* INTC and INTD disable */
+	pci_write_config_byte(dev, 0x4a, 0x00); /* INTE and INTF disable */
+	pci_write_config_byte(dev, 0x4b, 0x90); /* Audio IRQ11, Modem disable */
+
+	pci_write_config_word(dev, 0x50, 0x4000); /* Parity check IDE enable */
+	pci_write_config_word(dev, 0x52, 0x0000); /* USB & RTC disable */
+	pci_write_config_word(dev, 0x54, 0x0002); /* ??? no info */
+	pci_write_config_word(dev, 0x56, 0x0002); /* PCS1J signal disable */
+
+	pci_write_config_byte(dev, 0x59, 0x00); /* PCSDS */
+	pci_write_config_byte(dev, 0x5a, 0x00);
+	pci_write_config_byte(dev, 0x5b, 0x00);
+	pci_write_config_word(dev, 0x5c, 0x0000);
+	pci_write_config_byte(dev, 0x5e, 0x00);
+	pci_write_config_byte(dev, 0x5f, 0x00);
+	pci_write_config_word(dev, 0x60, 0x0000);
+
+	pci_write_config_byte(dev, 0x6c, 0x00);
+	pci_write_config_byte(dev, 0x6d, 0x48); /* ROM address mapping */
+	pci_write_config_byte(dev, 0x6e, 0x00); /* ??? what for? */
+
+	pci_write_config_byte(dev, 0x70, 0x12); /* Serial IRQ control */
+	pci_write_config_byte(dev, 0x71, 0xEF); /* DMA channel select */
+	pci_write_config_byte(dev, 0x72, 0x03); /* USB IDSEL */
+	pci_write_config_byte(dev, 0x73, 0x00); /* ??? no info */
+
+	/*
+	 * IRQ setup ALi M5237 USB Host Controller
+	 * IRQ: 9
+	 */
+	pci_write_config_byte(dev, 0x74, 0x01); /* USB IRQ9 */
+
+	pci_write_config_byte(dev, 0x75, 0x1f); /* IDE2 IRQ 15  */
+	pci_write_config_byte(dev, 0x76, 0x80); /* ACPI disable */
+	pci_write_config_byte(dev, 0x77, 0x40); /* Modem disable */
+	pci_write_config_dword(dev, 0x78, 0x20000000); /* Pin select 2 */
+	pci_write_config_byte(dev, 0x7c, 0x00); /* Pin select 3 */
+	pci_write_config_byte(dev, 0x81, 0x00); /* ID read/write control */
+	pci_write_config_byte(dev, 0x90, 0x00); /* PCI PM block control */
+	pci_write_config_word(dev, 0xa4, 0x0000); /* PMSCR */
+
+#ifdef CONFIG_BLK_DEV_FD
+	ali_m1535plus_fdc_init(1);
+#endif
+
+#ifdef CONFIG_PC_KEYB
+	ali_m1535plus_keyboard_init(1);
+	ali_m1535plus_hotkey_init(1);
+#endif
+}
+
+static inline void ali_config_writeb(u8 reg, u8 val, int devfn)
+{
+	u32 data;
+	int shift;
+
+	writel((1 << 16) | (devfn << 8) | (reg & 0xfc) | 1UL, PCI_CONFIG_ADDR);
+        data = readl(PCI_CONFIG_DATA);
+
+	shift = (reg & 3) << 3;
+	data &= ~(0xff << shift);
+	data |= (((u32)val) << shift);
+
+	writel(data, PCI_CONFIG_DATA);
+}
+
+static inline u8 ali_config_readb(u8 reg, int devfn)
+{
+	u32 data;
+
+	writel((1 << 16) | (devfn << 8) | (reg & 0xfc) | 1UL, PCI_CONFIG_ADDR);
+	data = readl(PCI_CONFIG_DATA);
+
+	return (u8)(data >> ((reg & 3) << 3));
+}
+
+static inline u16 ali_config_readw(u8 reg, int devfn)
+{
+	u32 data;
+
+	writel((1 << 16) | (devfn << 8) | (reg & 0xfc) | 1UL, PCI_CONFIG_ADDR);
+	data = readl(PCI_CONFIG_DATA);
+
+	return (u16)(data >> ((reg & 2) << 3));
+}
+
+int vr4133_rockhopper = 0;
+void __init ali_m5229_preinit(void)
+{
+	if (ali_config_readw(PCI_VENDOR_ID,16) == PCI_VENDOR_ID_AL &&
+	    ali_config_readw(PCI_DEVICE_ID,16) == PCI_DEVICE_ID_AL_M1533) {
+		printk(KERN_INFO "Found an NEC Rockhopper \n");
+		vr4133_rockhopper = 1;
+		/*
+		 * Enable ALi M5229 IDE Controller (both channels)
+		 * IDSEL: A27
+		 */
+		ali_config_writeb(0x58, 0x4c, 16);
+	}
+}
+
+void __init ali_m5229_init(struct pci_dev *dev)
+{
+	/*
+	 * Enable Primary/Secondary Channel Cable Detect 40-Pin
+	 */
+	pci_write_config_word(dev, 0x4a, 0xc023);
+
+	/*
+	 * Set only the 3rd byteis for the master IDE's cycle and
+	 * enable Internal IDE Function
+	 */
+	pci_write_config_byte(dev, 0x50, 0x23); /* Class code attr register */
+
+	pci_write_config_byte(dev, 0x09, 0xff); /* Set native mode & stuff */
+	pci_write_config_byte(dev, 0x52, 0x00); /* use timing registers */
+	pci_write_config_byte(dev, 0x58, 0x02); /* Primary addr setup timing */
+	pci_write_config_byte(dev, 0x59, 0x22); /* Primary cmd block timing */
+	pci_write_config_byte(dev, 0x5a, 0x22); /* Pr drv 0 R/W timing */
+	pci_write_config_byte(dev, 0x5b, 0x22); /* Pr drv 1 R/W timing */
+	pci_write_config_byte(dev, 0x5c, 0x02); /* Sec addr setup timing */
+	pci_write_config_byte(dev, 0x5d, 0x22); /* Sec cmd block timing */
+	pci_write_config_byte(dev, 0x5e, 0x22); /* Sec drv 0 R/W timing */
+	pci_write_config_byte(dev, 0x5f, 0x22); /* Sec drv 1 R/W timing */
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
+	pci_write_config_word(dev, PCI_COMMAND,
+	                           PCI_COMMAND_PARITY | PCI_COMMAND_MASTER |
+				   PCI_COMMAND_IO);
+}
+
Index: linux/arch/mips/vr41xx/nec-cmbvr4133/init.c
===================================================================
--- /dev/null
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/init.c
@@ -0,0 +1,81 @@
+/*
+ * arch/mips/vr41xx/nec-cmbvr4133/init.c
+ *
+ * PROM library initialisation code for NEC CMB-VR4133 board.
+ *
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
+ *         Jun Sun <jsun@mvista.com, or source@mvista.com> and
+ *         Alex Sapkov <asapkov@ru.mvista.com>
+ *
+ * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for NEC-CMBVR4133 in 2.6 
+ * Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+
+#ifdef CONFIG_ROCKHOPPER
+#include <asm/io.h>
+#include <linux/pci.h>
+
+#define PCICONFDREG	0xaf000c14
+#define PCICONFAREG	0xaf000c18
+#endif
+
+const char *get_system_type(void)
+{
+	return "NEC CMB-VR4133";
+}
+
+void __init bus_error_init(void)
+{
+	/* Do Nothing */
+}
+
+#ifdef CONFIG_ROCKHOPPER
+void disable_pcnet(void)
+{
+	u32 data;
+
+	/* Workaround for the bug in PMON on VR4133. PMON leaves
+	AMD PCNet controller (on Rockhopper) initialized and running in
+	bus master mode. We have do disable it before doing any
+	further initialization. Or we get problems with PCI bus 2
+	and random lockups and crashes.*/
+
+	writel((2 << 16)		|
+	       (PCI_DEVFN(1,0) << 8)	|
+	       (0 & 0xfc)		|
+               1UL,
+	       PCICONFAREG);
+
+	data = readl(PCICONFDREG);
+
+	writel((2 << 16)		|
+	       (PCI_DEVFN(1,0) << 8)	|
+	       (4 & 0xfc)		|
+               1UL,
+	       PCICONFAREG);
+
+	data = readl(PCICONFDREG);
+
+	writel((2 << 16)		|
+	       (PCI_DEVFN(1,0) << 8)	|
+	       (4 & 0xfc)		|
+               1UL,
+	       PCICONFAREG);
+	
+	data &= ~4;
+
+	writel(data, PCICONFDREG);
+}
+#endif
+
Index: linux/arch/mips/vr41xx/nec-cmbvr4133/setup.c
===================================================================
--- /dev/null
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/setup.c
@@ -0,0 +1,127 @@
+/*
+ * arch/mips/vr41xx/nec-cmbvr4133/setup.c
+ *
+ * Setup for the NEC CMB-VR4133.
+ *
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
+ *         Alex Sapkov <asapkov@ru.mvista.com>
+ *
+ * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for CMBVR4133 board in 2.6
+ * Author: Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/ide.h>
+#include <linux/ioport.h>
+
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/vr41xx/cmbvr4133.h>
+#include <asm/bootinfo.h>
+
+#ifdef CONFIG_MTD
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+
+static struct mtd_partition cmbvr4133_mtd_parts[] = {
+	{
+		.name =		"User FS",
+		.size =		0x1be0000,
+		.offset =	0,
+		.mask_flags = 	0,
+	}, 
+	{
+		.name =		"PMON",
+		.size =		0x140000,
+		.offset =	MTDPART_OFS_APPEND,
+		.mask_flags =	MTD_WRITEABLE,  /* force read-only */
+	}, 
+	{
+		.name =		"User FS2",
+		.size =		MTDPART_SIZ_FULL,
+		.offset =	MTDPART_OFS_APPEND,
+		.mask_flags = 	0,
+	}
+};
+
+#define number_partitions (sizeof(cmbvr4133_mtd_parts)/sizeof(struct mtd_partition))
+#endif
+
+void vr41xx_restart(char *command)
+{
+	change_c0_status((ST0_BEV | ST0_ERL), (ST0_BEV | ST0_ERL));
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+	flush_cache_all();
+	write_c0_wired(0);
+	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+}
+                                                                                             
+void vr41xx_halt(void)
+{
+	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
+	while (1);
+}
+                                                                                             
+void vr41xx_power_off(void)
+{
+	vr41xx_halt();
+}
+
+extern void (*late_time_init)(void);
+
+static void __init vr4133_serial_init(void)
+{
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
+	vr41xx_siu_init();
+	vr41xx_dsiu_init();
+}
+
+static int __init nec_cmbvr4133_setup(void)
+{
+#ifdef CONFIG_ROCKHOPPER
+	extern void disable_pcnet(void);
+
+	disable_pcnet();
+#endif
+	set_io_port_base(IO_PORT_BASE);
+
+	mips_machgroup = MACH_GROUP_NEC_VR41XX;
+	mips_machtype = MACH_NEC_CMBVR4133;
+
+	_machine_restart = vr41xx_restart;
+	_machine_halt = vr41xx_halt;
+	_machine_power_off = vr41xx_power_off;
+
+	late_time_init = vr4133_serial_init;
+
+#ifdef CONFIG_PCI
+#ifdef CONFIG_ROCKHOPPER
+	ali_m5229_preinit();
+#endif
+#endif
+
+#ifdef CONFIG_ROCKHOPPER
+	rockhopper_init_irq();
+#endif
+
+#ifdef CONFIG_MTD
+	/* we use generic physmap mapping driver and we use partitions */
+	physmap_configure(0x1C000000, 0x02000000, 4, NULL);
+	physmap_set_partitions(cmbvr4133_mtd_parts, number_partitions);
+#endif
+
+	/* 128 MB memory support */
+	add_memory_region(0, 0x08000000, BOOT_MEM_RAM);
+
+	return 0;
+}
+
+early_initcall(nec_cmbvr4133_setup);
Index: linux/arch/mips/vr41xx/nec-cmbvr4133/irq.c
===================================================================
--- /dev/null
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/irq.c
@@ -0,0 +1,114 @@
+/*
+ * arch/mips/vr41xx/nec-cmbvr4133/irq.c
+ *
+ * Interrupt routines for the NEC CMB-VR4133 board.
+ *
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
+ *         Alex Sapkov <asapkov@ru.mvista.com>
+ *
+ * 2003-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for NEC-CMBVR4133 in 2.6
+ * Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/vr41xx/cmbvr4133.h>
+
+extern void enable_8259A_irq(unsigned int irq);
+extern void disable_8259A_irq(unsigned int irq);
+extern void mask_and_ack_8259A(unsigned int irq);
+extern void init_8259A(int hoge);
+                                                                                                    
+extern int vr4133_rockhopper;
+                                                                                                    
+static unsigned int startup_i8259_irq(unsigned int irq)
+{
+	enable_8259A_irq(irq - I8259_IRQ_BASE);
+	 return 0;
+}
+
+static void shutdown_i8259_irq(unsigned int irq)
+{
+	disable_8259A_irq(irq - I8259_IRQ_BASE);
+}
+
+static void enable_i8259_irq(unsigned int irq)
+{
+	enable_8259A_irq(irq - I8259_IRQ_BASE);
+}
+
+static void disable_i8259_irq(unsigned int irq)
+{
+	disable_8259A_irq(irq - I8259_IRQ_BASE);
+}
+
+static void ack_i8259_irq(unsigned int irq)
+{
+	mask_and_ack_8259A(irq - I8259_IRQ_BASE);
+}
+
+static void end_i8259_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_8259A_irq(irq - I8259_IRQ_BASE);
+}
+
+static struct hw_interrupt_type i8259_irq_type = {
+	.typename       = "XT-PIC",
+	.startup        = startup_i8259_irq,
+	.shutdown       = shutdown_i8259_irq,
+	.enable         = enable_i8259_irq,
+	.disable        = disable_i8259_irq,
+	.ack            = ack_i8259_irq,
+	.end            = end_i8259_irq,
+};
+
+static int i8259_get_irq_number(int irq)
+{
+	unsigned long isr;
+
+	isr = inb(0x20);
+	irq = ffz(~isr);
+	if (irq == 2) {
+		isr = inb(0xa0);
+		irq = 8 + ffz(~isr);
+	}
+
+	if (irq < 0 || irq > 15)
+		return -EINVAL;
+
+	return I8259_IRQ_BASE + irq;
+}
+
+static struct irqaction i8259_slave_cascade = {
+	.handler        = &no_action,
+	.name           = "cascade",
+};
+
+void __init rockhopper_init_irq(void)
+{
+	int i;
+
+	if(!vr4133_rockhopper) {
+		printk(KERN_ERR "Not a Rockhopper Board \n");
+		return;
+	}
+
+	for (i = I8259_IRQ_BASE; i <= I8259_IRQ_LAST; i++)
+		irq_desc[i].handler = &i8259_irq_type;
+
+	setup_irq(I8259_SLAVE_IRQ, &i8259_slave_cascade);
+
+	vr41xx_set_irq_trigger(CMBVR41XX_INTC_PIN, TRIGGER_LEVEL, SIGNAL_THROUGH);
+	vr41xx_set_irq_level(CMBVR41XX_INTC_PIN, LEVEL_HIGH);
+	vr41xx_cascade_irq(CMBVR41XX_INTC_IRQ, i8259_get_irq_number);
+}
Index: linux/arch/mips/vr41xx/nec-cmbvr4133/Makefile
===================================================================
--- /dev/null
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the NEC-CMBVR4133
+#
+
+obj-y				:= init.o setup.o
+
+obj-$(CONFIG_PCI)		+= m1535plus.o
+obj-$(CONFIG_ROCKHOPPER)	+= irq.o
Index: linux/arch/mips/Makefile
===================================================================
--- linux.orig/arch/mips/Makefile
+++ linux/arch/mips/Makefile
@@ -486,6 +486,12 @@
 cflags-$(CONFIG_MACH_VR41XX)	+= -Iinclude/asm-mips/mach-vr41xx
 
 #
+# NEC VR4133
+#
+core-$(CONFIG_NEC_CMBVR4133)	+= arch/mips/vr41xx/nec-cmbvr4133/
+load-$(CONFIG_NEC_CMBVR4133)	+= 0xffffffff80100000
+
+#
 # ZAO Networks Capcella (VR4131)
 #
 core-$(CONFIG_ZAO_CAPCELLA)	+= arch/mips/vr41xx/zao-capcella/
Index: linux/include/asm-mips/vr41xx/cmbvr4133.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/vr41xx/cmbvr4133.h
@@ -0,0 +1,93 @@
+/*
+ * include/asm-mips/vr41xx/cmbvr4133.h
+ *
+ * Include file for NEC CMB-VR4133.
+ *
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
+ *         Jun Sun <jsun@mvista.com, or source@mvista.com> and
+ *         Alex Sapkov <asapkov@ru.mvista.com>
+ *
+ * 2002-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __NEC_CMBVR4133_H
+#define __NEC_CMBVR4133_H
+
+#include <linux/config.h>
+
+#include <asm/addrspace.h>
+#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/vr4133.h>
+
+/*
+ * Board specific address mapping
+ */
+#define VR41XX_PCI_MEM1_BASE		0x10000000
+#define VR41XX_PCI_MEM1_SIZE		0x04000000
+#define VR41XX_PCI_MEM1_MASK		0x7c000000
+
+#define VR41XX_PCI_MEM2_BASE		0x14000000
+#define VR41XX_PCI_MEM2_SIZE		0x02000000
+#define VR41XX_PCI_MEM2_MASK		0x7e000000
+
+#define VR41XX_PCI_IO_BASE		0x16000000
+#define VR41XX_PCI_IO_SIZE		0x02000000
+#define VR41XX_PCI_IO_MASK		0x7e000000
+
+#define VR41XX_PCI_IO_START		0x01000000
+#define VR41XX_PCI_IO_END		0x01ffffff
+
+#define VR41XX_PCI_MEM_START		0x12000000
+#define VR41XX_PCI_MEM_END		0x15ffffff
+
+#define IO_PORT_BASE			KSEG1ADDR(VR41XX_PCI_IO_BASE)
+#define IO_PORT_RESOURCE_START		0
+#define IO_PORT_RESOURCE_END		VR41XX_PCI_IO_SIZE
+#define IO_MEM1_RESOURCE_START		VR41XX_PCI_MEM1_BASE
+#define IO_MEM1_RESOURCE_END		(VR41XX_PCI_MEM1_BASE + VR41XX_PCI_MEM1_SIZE)
+#define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
+#define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
+
+/*
+ * General-Purpose I/O Pin Number
+ */
+#define CMBVR41XX_INTA_PIN		1
+#define CMBVR41XX_INTB_PIN		1
+#define CMBVR41XX_INTC_PIN		3
+#define CMBVR41XX_INTD_PIN		1
+#define CMBVR41XX_INTE_PIN		1
+
+/*
+ * Interrupt Number
+ */
+#define CMBVR41XX_INTA_IRQ		GIU_IRQ(CMBVR41XX_INTA_PIN)
+#define CMBVR41XX_INTB_IRQ		GIU_IRQ(CMBVR41XX_INTB_PIN)
+#define CMBVR41XX_INTC_IRQ		GIU_IRQ(CMBVR41XX_INTC_PIN)
+#define CMBVR41XX_INTD_IRQ		GIU_IRQ(CMBVR41XX_INTD_PIN)
+#define CMBVR41XX_INTE_IRQ		GIU_IRQ(CMBVR41XX_INTE_PIN)
+
+#define I8259_IRQ_BASE			72
+#define I8259_IRQ(x)			(I8259_IRQ_BASE + (x))
+#define TIMER_IRQ			I8259_IRQ(0)
+#define KEYBOARD_IRQ			I8259_IRQ(1)
+#define I8259_SLAVE_IRQ			I8259_IRQ(2)
+#define UART3_IRQ			I8259_IRQ(3)
+#define UART1_IRQ			I8259_IRQ(4)
+#define UART2_IRQ			I8259_IRQ(5)
+#define FDC_IRQ				I8259_IRQ(6)
+#define PARPORT_IRQ			I8259_IRQ(7)
+#define RTC_IRQ				I8259_IRQ(8)
+#define USB_IRQ				I8259_IRQ(9)
+#define I8259_INTA_IRQ			I8259_IRQ(10)
+#define AUDIO_IRQ			I8259_IRQ(11)
+#define AUX_IRQ				I8259_IRQ(12)
+#define IDE_PRIMARY_IRQ			I8259_IRQ(14)
+#define IDE_SECONDARY_IRQ		I8259_IRQ(15)
+#define I8259_IRQ_LAST			IDE_SECONDARY_IRQ
+
+#define RTC_PORT(x)	(0xaf000100 + (x))
+#define RTC_IO_EXTENT	0x140
+
+#endif /* __NEC_CMBVR4133_H */
Index: linux/arch/mips/vr41xx/common/vr4133.c
===================================================================
--- /dev/null
+++ linux/arch/mips/vr41xx/common/vr4133.c
@@ -0,0 +1,75 @@
+/*
+ * arch/mips/vr41xx/common/vr4133.c
+ *
+ * NEC VR4133 specific routines.
+ *
+ * Author: Alex Sapkov <asapkov@ru.mvista.com> or <source@mvista.com>
+ *
+ * 2001-2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include <asm/cpu.h>
+#include <asm/io.h>
+
+#define VR4133_CMUCLKMSK2	KSEG1ADDR(0x0f000064)
+
+#define VR4133_CMU_CEU 		0x0001
+#define VR4133_CMU_MSKMAC0	0x0002
+#define VR4133_CMU_MSKMAC1	0x0004
+
+/* Clock Mask Unit primitives */
+
+void vr4133_clock_ceu_supply(void)
+{
+	u16 cmuclkmsk2;
+
+	cmuclkmsk2 = readw(VR4133_CMUCLKMSK2) | VR4133_CMU_CEU;
+	writew(cmuclkmsk2, VR4133_CMUCLKMSK2);
+}
+
+void vr4133_clock_ceu_mask(void)
+{
+	u16 cmuclkmsk2;
+
+	cmuclkmsk2 = readw(VR4133_CMUCLKMSK2) & ~VR4133_CMU_CEU;
+	writew(cmuclkmsk2, VR4133_CMUCLKMSK2);
+}
+
+void vr4133_clock_ether0_supply(void)
+{
+	u16 cmuclkmsk2;
+
+	cmuclkmsk2 = readw(VR4133_CMUCLKMSK2) | VR4133_CMU_MSKMAC0;
+	writew(cmuclkmsk2, VR4133_CMUCLKMSK2);
+}
+
+void vr4133_clock_ether0_mask(void)
+{
+	u16 cmuclkmsk2;
+
+	cmuclkmsk2 = readw(VR4133_CMUCLKMSK2) & ~VR4133_CMU_MSKMAC0;
+	writew(cmuclkmsk2, VR4133_CMUCLKMSK2);
+}
+
+void vr4133_clock_ether1_supply(void)
+{
+	u16 cmuclkmsk2;
+
+	cmuclkmsk2 = readw(VR4133_CMUCLKMSK2) | VR4133_CMU_MSKMAC1;
+	writew(cmuclkmsk2, VR4133_CMUCLKMSK2);
+}
+
+void vr4133_clock_ether1_mask(void)
+{
+	u16 cmuclkmsk2;
+
+	cmuclkmsk2 = readw(VR4133_CMUCLKMSK2) & ~VR4133_CMU_MSKMAC1;
+	writew(cmuclkmsk2, VR4133_CMUCLKMSK2);
+}
+
+
Index: linux/include/asm-mips/vr41xx/vr4133.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/vr41xx/vr4133.h
@@ -0,0 +1,25 @@
+/*
+ * include/asm-mips/vr41xx/vr4133.h
+ *
+ * Include file for NEC VR4133.
+ *
+ * Author: Alex Sapkov <asapkov@ru.mvista.com> or <source@mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __NEC_VR4133_H
+#define __NEC_VR4133_H
+/*
+ * Clock Mask Unit
+ */
+extern void vr4133_clock_ether0_supply(void);
+extern void vr4133_clock_ether1_supply(void);
+extern void vr4133_clock_ceu_supply(void);
+extern void vr4133_clock_ether0_mask(void);
+extern void vr4133_clock_ether1_mask(void);
+extern void vr4133_clock_ceu_mask(void);
+
+#endif /* __NEC_VR4133_H */
Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig
+++ linux/arch/mips/Kconfig
@@ -69,6 +69,21 @@
 config MACH_VR41XX
 	bool "Support for NEC VR41XX-based machines"
 
+config NEC_CMBVR4133
+	bool "Support for NEC CMB-VR4133"
+	depends on MACH_VR41XX
+	select CPU_VR41XX
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select HW_HAS_PCI
+	select PCI_VR41XX
+
+config ROCKHOPPER
+	bool "Support for Rockhopper baseboard"
+	depends on NEC_CMBVR4133
+	select I8259
+	select HAVE_STD_PC_SERIAL_PORT
+
 config CASIO_E55
 	bool "Support for CASIO CASSIOPEIA E-10/15/55/65"
 	depends on MACH_VR41XX
Index: linux/include/asm-mips/bootinfo.h
===================================================================
--- linux.orig/include/asm-mips/bootinfo.h
+++ linux/include/asm-mips/bootinfo.h
@@ -195,6 +195,7 @@
 #define  MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
 #define  MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (Mbase) */
 #define  MACH_TANBAC_TB0229	7	/* TANBAC TB0229 (VR4131DIMM) */
+#define  MACH_NEC_CMBVR4133	8	/* CMB VR4133 Board */
 
 #define MACH_GROUP_HP_LJ	20	/* Hewlett Packard LaserJet	*/
 #define  MACH_HP_LASERJET	1
Index: linux/arch/mips/pci/Makefile
===================================================================
--- linux.orig/arch/mips/pci/Makefile
+++ linux/arch/mips/pci/Makefile
@@ -17,6 +17,7 @@
 obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
 obj-$(CONFIG_MIPS_TX3927)	+= ops-jmr3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
+obj-$(CONFIG_NEC_CMBVR4133)	+= fixup-vr4133.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
Index: linux/arch/mips/vr41xx/common/Makefile
===================================================================
--- linux.orig/arch/mips/vr41xx/common/Makefile
+++ linux/arch/mips/vr41xx/common/Makefile
@@ -6,5 +6,6 @@
 obj-$(CONFIG_SERIAL_8250)	+= serial.o
 obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
+obj-$(NEC_CMBVR4133)		+= vr4133.o
 
 EXTRA_AFLAGS := $(CFLAGS)
Index: linux/arch/mips/pci/fixup-vr4133.c
===================================================================
--- /dev/null
+++ linux/arch/mips/pci/fixup-vr4133.c
@@ -0,0 +1,214 @@
+/*
+ * arch/mips/vr41xx/nec-cmbvr4133/pci_fixup.c
+ *
+ * The NEC CMB-VR4133 Board specific PCI fixups.
+ *
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
+ *         Alex Sapkov <asapkov@ru.mvista.com>
+ *
+ * 2003-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Modified for support in 2.6 
+ * Author: Manish Lachwani (mlachwani@mvista.com)
+ * 
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+#include <asm/vr41xx/cmbvr4133.h>
+
+extern int vr4133_rockhopper;
+extern void ali_m1535plus_init(struct pci_dev *dev);
+extern void ali_m5229_init(struct pci_dev *dev);
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	if (dev->vendor ==  PCI_VENDOR_ID_AL) {
+		switch (dev->device) {
+		case PCI_DEVICE_ID_AL_M1533:
+			ali_m1535plus_init(dev);
+			break;
+		case PCI_DEVICE_ID_AL_M5229:
+			ali_m5229_init(dev);
+			break;
+		case PCI_DEVICE_ID_AL_M5237:
+			break;
+		}
+	}
+
+	/* 
+	 * We have to reset AMD PCnet adapter on Rockhopper since
+	 * PMON leaves it enabled and generating interrupts. This leads
+	 * to a lock if some PCI device driver later enables the IRQ line
+	 * shared with PCnet and there is no AMD PCnet driver to catch its
+	 * interrupts. 
+	 */
+#ifdef CONFIG_ROCKHOPPER
+	if (dev->vendor == PCI_VENDOR_ID_AMD && 
+		dev->device == PCI_DEVICE_ID_AMD_LANCE) {
+		inl(pci_resource_start(dev, 0) + 0x18);
+	}
+#endif
+
+	/* 
+	 * we have to open the bridges' windows down to 0 because otherwise
+ 	 * we cannot access ISA south bridge I/O registers that get mapped from
+	 * 0. for example, 8259 PIC would be unaccessible without that
+	 */
+	if(dev->vendor == 0x8086 && dev->device == 0xb152) {
+		pci_write_config_byte(dev, PCI_IO_BASE, 0);
+		if(dev->bus->number == 0) {
+			pci_write_config_word(dev, PCI_IO_BASE_UPPER16, 0);
+		} else {
+			pci_write_config_word(dev, PCI_IO_BASE_UPPER16, 1);
+		}
+	}
+
+	return 0;
+}
+
+/* 
+ * M1535 IRQ mapping 
+ * Feel free to change this, although it shouldn't be needed
+ */
+#define M1535_IRQ_INTA  7
+#define M1535_IRQ_INTB  9
+#define M1535_IRQ_INTC  10
+#define M1535_IRQ_INTD  11
+
+#define M1535_IRQ_USB   9
+#define M1535_IRQ_IDE   14
+#define M1535_IRQ_IDE2  15
+#define M1535_IRQ_PS2   12
+#define M1535_IRQ_RTC   8
+#define M1535_IRQ_FDC   6
+#define M1535_IRQ_AUDIO 5
+#define M1535_IRQ_COM1  4
+#define M1535_IRQ_COM2  4
+#define M1535_IRQ_IRDA  3
+#define M1535_IRQ_KBD   1
+#define M1535_IRQ_TMR   0
+
+/* Rockhopper "slots" assignment; this is hard-coded ... */
+#define ROCKHOPPER_M5451_SLOT  1
+#define ROCKHOPPER_M1535_SLOT  2
+#define ROCKHOPPER_M5229_SLOT  11
+#define ROCKHOPPER_M5237_SLOT  15
+#define ROCKHOPPER_PMU_SLOT    12
+/* ... and hard-wired. */
+#define ROCKHOPPER_PCI1_SLOT   3
+#define ROCKHOPPER_PCI2_SLOT   4
+#define ROCKHOPPER_PCI3_SLOT   5
+#define ROCKHOPPER_PCI4_SLOT   6
+#define ROCKHOPPER_PCNET_SLOT  1
+
+#define M1535_IRQ_MASK(n) (1 << (n))
+
+#define M1535_IRQ_EDGE  (M1535_IRQ_MASK(M1535_IRQ_TMR)  | \
+                         M1535_IRQ_MASK(M1535_IRQ_KBD)  | \
+                         M1535_IRQ_MASK(M1535_IRQ_COM1) | \
+                         M1535_IRQ_MASK(M1535_IRQ_COM2) | \
+                         M1535_IRQ_MASK(M1535_IRQ_IRDA) | \
+                         M1535_IRQ_MASK(M1535_IRQ_RTC)  | \
+                         M1535_IRQ_MASK(M1535_IRQ_FDC)  | \
+                         M1535_IRQ_MASK(M1535_IRQ_PS2))
+
+#define M1535_IRQ_LEVEL (M1535_IRQ_MASK(M1535_IRQ_IDE)  | \
+                         M1535_IRQ_MASK(M1535_IRQ_USB)  | \
+                         M1535_IRQ_MASK(M1535_IRQ_INTA) | \
+                         M1535_IRQ_MASK(M1535_IRQ_INTB) | \
+                         M1535_IRQ_MASK(M1535_IRQ_INTC) | \
+                         M1535_IRQ_MASK(M1535_IRQ_INTD))
+
+struct irq_map_entry {
+	u16 bus;
+	u8 slot;
+	u8 irq;
+};
+static struct irq_map_entry int_map[] = {
+	{1, ROCKHOPPER_M5451_SLOT, M1535_IRQ_AUDIO},	/* Audio controller */
+	{1, ROCKHOPPER_PCI1_SLOT, M1535_IRQ_INTD},	/* PCI slot #1 */
+	{1, ROCKHOPPER_PCI2_SLOT, M1535_IRQ_INTC},	/* PCI slot #2 */
+	{1, ROCKHOPPER_M5237_SLOT, M1535_IRQ_USB},	/* USB host controller */
+	{1, ROCKHOPPER_M5229_SLOT, IDE_PRIMARY_IRQ},	/* IDE controller */
+	{2, ROCKHOPPER_PCNET_SLOT, M1535_IRQ_INTD},	/* AMD Am79c973 on-board 
+							   ethernet */
+	{2, ROCKHOPPER_PCI3_SLOT, M1535_IRQ_INTB},	/* PCI slot #3 */
+	{2, ROCKHOPPER_PCI4_SLOT, M1535_IRQ_INTC}	/* PCI slot #4 */
+};
+
+static int pci_intlines[] =
+    { M1535_IRQ_INTA, M1535_IRQ_INTB, M1535_IRQ_INTC, M1535_IRQ_INTD };
+
+/* Determine the Rockhopper IRQ line number for the PCI device */
+int rockhopper_get_irq(struct pci_dev *dev, u8 pin, u8 slot)
+{
+	struct pci_bus *bus;
+	int i;
+
+	bus = dev->bus;
+	if (bus == NULL)
+		return -1;
+
+	for (i = 0; i < sizeof (int_map) / sizeof (int_map[0]); i++) {
+		if (int_map[i].bus == bus->number && int_map[i].slot == slot) {
+			int line;
+			for (line = 0; line < 4; line++)
+				if (pci_intlines[line] == int_map[i].irq)
+					break;
+			if (line < 4)
+				return pci_intlines[(line + (pin - 1)) % 4];
+			else
+				return int_map[i].irq;
+		}
+	}
+	return -1;
+}
+
+#ifdef CONFIG_ROCKHOPPER
+static void i8259_init(void)
+{
+	outb(0x11, 0x20);		/* Master ICW1 */
+	outb(I8259_IRQ_BASE, 0x21);	/* Master ICW2 */
+	outb(0x04, 0x21);		/* Master ICW3 */
+	outb(0x01, 0x21);		/* Master ICW4 */
+	outb(0xff, 0x21);		/* Master IMW */
+
+	outb(0x11, 0xa0);		/* Slave ICW1 */
+	outb(I8259_IRQ_BASE + 8, 0xa1);	/* Slave ICW2 */
+	outb(0x02, 0xa1);		/* Slave ICW3 */
+	outb(0x01, 0xa1);		/* Slave ICW4 */
+	outb(0xff, 0xa1);		/* Slave IMW */
+
+	outb(0x00, 0x4d0);
+	outb(0x02, 0x4d1);	/* USB IRQ9 is level */
+}
+#endif
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	extern int pci_probe_only;
+	pci_probe_only = 1;
+
+#ifdef CONFIG_ROCKHOPPER
+	i8259_init();
+	if( dev->bus->number == 1 && vr4133_rockhopper )  {
+		if(slot == ROCKHOPPER_PCI1_SLOT || slot == ROCKHOPPER_PCI2_SLOT)
+			dev->irq = CMBVR41XX_INTA_IRQ;
+		else
+			dev->irq = rockhopper_get_irq(dev, pin, slot);
+	} else
+		dev->irq = CMBVR41XX_INTA_IRQ;
+#else
+	dev->irq = CMBVR41XX_INTA_IRQ;
+#endif
+
+	return dev->irq;
+}
+
Index: linux/arch/mips/pci/pci-vr41xx.h
===================================================================
--- linux.orig/arch/mips/pci/pci-vr41xx.h
+++ linux/arch/mips/pci/pci-vr41xx.h
@@ -18,6 +18,8 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Support for NEC VR4133 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
  */
 #ifndef __PCI_VR41XX_H
 #define __PCI_VR41XX_H
@@ -127,6 +129,10 @@
 #define PCI_MASTER_MEM1_ADDRESS_MASK		0x7c000000U
 #define PCI_MASTER_MEM1_PCI_BASE_ADDRESS	0x10000000U
 
+#define PCI_MASTER_MEM2_BUS_BASE_ADDRESS	0x14000000U
+#define PCI_MASTER_MEM2_ADDRESS_MASK		0x7e000000U
+#define PCI_MASTER_MEM2_PCI_BASE_ADDRESS	0x14000000U
+
 #define PCI_TARGET_MEM1_ADDRESS_MASK		0x08000000U
 #define PCI_TARGET_MEM1_BUS_BASE_ADDRESS	0x00000000U
 
Index: linux/arch/mips/pci/pci-vr41xx.c
===================================================================
--- linux.orig/arch/mips/pci/pci-vr41xx.c
+++ linux/arch/mips/pci/pci-vr41xx.c
@@ -19,6 +19,8 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Support for NEC VR4133 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
  */
 /*
  * Changes:
@@ -43,6 +45,12 @@
 	.pci_base_address	= PCI_MASTER_MEM1_PCI_BASE_ADDRESS,
 };
 
+static struct pci_master_address_conversion pci_master_memory2 = {
+	.bus_base_address	= PCI_MASTER_MEM2_BUS_BASE_ADDRESS,
+	.address_mask		= PCI_MASTER_MEM2_ADDRESS_MASK,
+	.pci_base_address	= PCI_MASTER_MEM2_PCI_BASE_ADDRESS,
+};
+
 static struct pci_target_address_conversion pci_target_memory1 = {
 	.address_mask		= PCI_TARGET_MEM1_ADDRESS_MASK,
 	.bus_base_address	= PCI_TARGET_MEM1_BUS_BASE_ADDRESS,
@@ -76,6 +84,22 @@
 	.flags  = IORESOURCE_IO,
 };
 
+#ifdef CONFIG_ROCKHOPPER
+static struct pci_controller_unit_setup vr41xx_pci_controller_unit_setup = {
+	.master_memory1				= &pci_master_memory1,
+	.master_memory2				= &pci_master_memory2,
+	.target_memory1				= &pci_target_memory1,
+	.master_io				= &pci_master_io,
+	.exclusive_access			= CANNOT_LOCK_FROM_DEVICE,
+	.wait_time_limit_from_irdy_to_trdy	= 0,
+	.mailbox				= &pci_mailbox,
+	.target_window1				= &pci_target_window1,
+	.master_latency_timer			= 0x80,
+	.retry_limit				= 0,
+	.arbiter_priority_control		= PCI_ARBITRATION_MODE_FAIR,
+	.take_away_gnt_mode			= PCI_TAKE_AWAY_GNT_DISABLE,
+};
+#else
 static struct pci_controller_unit_setup vr41xx_pci_controller_unit_setup = {
 	.master_memory1				= &pci_master_memory1,
 	.target_memory1				= &pci_target_memory1,
@@ -89,6 +113,7 @@
 	.arbiter_priority_control		= PCI_ARBITRATION_MODE_FAIR,
 	.take_away_gnt_mode			= PCI_TAKE_AWAY_GNT_DISABLE,
 };
+#endif
 
 static struct pci_controller vr41xx_pci_controller = {
 	.pci_ops        = &vr41xx_pci_ops,
Index: linux/arch/mips/vr41xx/common/serial.c
===================================================================
--- linux.orig/arch/mips/vr41xx/common/serial.c
+++ linux/arch/mips/vr41xx/common/serial.c
@@ -52,17 +52,17 @@
  #define TMICTX			0x10
  #define TMICMODE		0x20
 
-#define SIU_BASE_TYPE1		0x0c000000UL	/* VR4111 and VR4121 */
-#define SIU_BASE_TYPE2		0x0f000800UL	/* VR4122, VR4131 and VR4133 */
+#define SIU_BASE_TYPE1		KSEG1ADDR(0x0c000000)	/* VR4111 and VR4121 */
+#define SIU_BASE_TYPE2		KSEG1ADDR(0x0f000800)	/* VR4122, VR4131 and VR4133 */
 #define SIU_SIZE		0x8UL
 
-#define SIU_BASE_BAUD		1152000
+#define SIU_BASE_BAUD		115200
 
 /* VR4122, VR4131 and VR4133 DSIU Registers */
-#define DSIU_BASE		0x0f000820UL
+#define DSIU_BASE		KSEG1ADDR(0x0f000820)
 #define DSIU_SIZE		0x8UL
 
-#define DSIU_BASE_BAUD		1152000
+#define DSIU_BASE_BAUD	 	115200
 
 int vr41xx_serial_ports = 0;
 
@@ -132,7 +132,7 @@
 	}
 	port.regshift = 0;
 	port.iotype = UPIO_MEM;
-	port.membase = ioremap(port.mapbase, SIU_SIZE);
+	port.membase = (unsigned char *)port.mapbase;
 	if (port.membase != NULL) {
 		if (early_serial_setup(&port) == 0) {
 			vr41xx_supply_clock(SIU_CLOCK);
@@ -164,7 +164,7 @@
 	port.mapbase = DSIU_BASE;
 	port.regshift = 0;
 	port.iotype = UPIO_MEM;
-	port.membase = ioremap(port.mapbase, DSIU_SIZE);
+	port.membase = (unsigned char *)port.mapbase;
 	if (port.membase != NULL) {
 		if (early_serial_setup(&port) == 0) {
 			vr41xx_supply_clock(DSIU_CLOCK);

--0F1p//8PRICkK4MW--
