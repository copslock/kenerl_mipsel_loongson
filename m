Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 20:17:37 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:7411 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225206AbUKBURY>; Tue, 2 Nov 2004 20:17:24 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iA2KHLdh026681
	for <linux-mips@linux-mips.org>; Tue, 2 Nov 2004 12:17:21 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iA2KHK4v026679
	for linux-mips@linux-mips.org; Tue, 2 Nov 2004 12:17:20 -0800
Date: Tue, 2 Nov 2004 12:17:20 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Subject: [PATCH] Support for PMC-Sierra Ocelot-3 in 2.6
Message-ID: <20041102201720.GB24674@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello !

Attached patch adds support for PMC-Sierra Ocelot-3 in 2.6. This includes
both 32-bit and 64-bit support. The patch for PCI will be sent next.

Thanks
Manish Lachwani


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_ocelot3.patch"

Source: MontaVista Software, Inc. | Manish Lachwani <mlachwani@mvista.com>
Description:
	Support for PMC-Sierra Ocelot-3 in 2.6 (32-bit and 64-bit)

Index: linux/arch/mips/Makefile
===================================================================
--- linux.orig/arch/mips/Makefile
+++ linux/arch/mips/Makefile
@@ -436,6 +436,13 @@
 load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
 
 #
+# Momentum Ocelot-3
+#
+core-$(CONFIG_MOMENCO_OCELOT_3) 	+= arch/mips/momentum/ocelot_3/
+cflags-$(CONFIG_MOMENCO_OCELOT_3)	+= -Iinclude/asm-mips/mach-ocelot3
+load-$(CONFIG_MOMENCO_OCELOT_3) 	+= 0xffffffff80100000
+
+#
 # Momentum Jaguar ATX
 #
 core-$(CONFIG_MOMENCO_JAGUAR_ATX)	+= arch/mips/momentum/jaguar_atx/
Index: linux/include/asm-mips/mach-ocelot3/cpu-feature-overrides.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/mach-ocelot3/cpu-feature-overrides.h
@@ -0,0 +1,40 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ */
+#ifndef __ASM_MACH_JA_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_JA_CPU_FEATURE_OVERRIDES_H
+
+/*
+ * Momentum Ocelot-3 is based on Rm7900 processor which
+ * is based on the E9000 core. 
+ */
+#define cpu_has_watch		1
+#define cpu_has_mips16		0
+#define cpu_has_divec		0
+#define cpu_has_vce		0
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_prefetch	1
+#define cpu_has_mcheck		0
+#define cpu_has_ejtag		0
+
+#define cpu_has_llsc		1
+#define cpu_has_vtag_icache	0
+#define cpu_has_dc_aliases	0
+#define cpu_has_ic_fills_f_dc	0
+
+#define cpu_has_nofpuex 	0
+#define cpu_has_64bits		1
+
+#define cpu_has_subset_pcaches	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+#define cpu_scache_line_size()	32
+
+#endif /* __ASM_MACH_JA_CPU_FEATURE_OVERRIDES_H */
Index: linux/include/asm-mips/serial.h
===================================================================
--- linux.orig/include/asm-mips/serial.h
+++ linux/include/asm-mips/serial.h
@@ -319,6 +319,27 @@
 #define MOMENCO_JAGUAR_ATX_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_MOMENCO_OCELOT_3
+#define OCELOT_3_BASE_BAUD	( 20000000 / 16 )
+#define OCELOT_3_SERIAL_IRQ	6
+#ifdef CONFIG_MIPS64
+#define OCELOT_3_SERIAL_BASE	0xfffffffffd000020
+#else
+#define OCELOT_3_SERIAL_BASE	0xfd000020
+#endif
+
+#define _OCELOT_3_SERIAL_INIT(int, base)				\
+	{ baud_base: OCELOT_3_BASE_BAUD, irq: int, 			\
+	  flags: STD_COM_FLAGS,						\
+	  iomem_base: (u8 *) base, iomem_reg_shift: 2,			\
+	  io_type: SERIAL_IO_MEM }
+
+#define MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS				\
+	_OCELOT_3_SERIAL_INIT(OCELOT_3_SERIAL_IRQ, OCELOT_3_SERIAL_BASE)
+#else
+#define MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS
+#endif
+
 #ifdef CONFIG_MOMENCO_OCELOT
 /* Ordinary NS16552 duart with a 20MHz crystal.  */
 #define OCELOT_BASE_BAUD ( 20000000 / 16 )
@@ -420,6 +441,7 @@
 	MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
+	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
 	TXX927_SERIAL_PORT_DEFNS                        \
 	AU1000_SERIAL_PORT_DEFNS
 
Index: linux/drivers/net/Kconfig
===================================================================
--- linux.orig/drivers/net/Kconfig
+++ linux/drivers/net/Kconfig
@@ -2170,7 +2170,7 @@
 
 config MV643XX_ETH
 	tristate "MV-643XX Ethernet support"
-	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX
+	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MOMENCO_OCELOT_3
 	help
 	  This driver supports the gigabit Ethernet on the Marvell MV643XX
 	  chipset which is used in the Momenco Ocelot C and Jaguar ATX.
Index: linux/arch/mips/momentum/ocelot_3/ocelot_3_fpga.h
===================================================================
--- /dev/null
+++ linux/arch/mips/momentum/ocelot_3/ocelot_3_fpga.h
@@ -0,0 +1,61 @@
+/*
+ * Ocelot-3 Board Register Definitions
+ *
+ * (C) 2002 Momentum Computer Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Louis Hamilton, Red Hat, Inc.
+ *    hamilton@redhat.com  [MIPS64 modifications]
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ */
+
+#ifndef __OCELOT_3_FPGA_H__
+#define __OCELOT_3_FPGA_H__
+
+#ifdef CONFIG_MIPS64
+#define OCELOT_3_CS0_ADDR		0xfffffffffc000000
+#else
+#define OCELOT_3_CS0_ADDR		0xfc000000
+#endif
+
+#define OCELOT_3_REG_BOARDREV		0x0
+#define OCELOT_3_REG_FPGA_REV		0x1
+#define OCELOT_3_REG_FPGA_TYPE		0x2
+#define OCELOT_3_REG_RESET_STATUS	0x3
+#define OCELOT_3_REG_BOARD_STATUS	0x4
+#define OCELOT_3_REG_CPCI_ID		0x5
+#define OCELOT_3_REG_SET		0x6
+#define OCELOT_3_REG_CLR		0x7
+#define OCELOT_3_REG_EEPROM_MODE	0x9
+#define OCELOT_3_REG_INTMASK		0xa
+#define OCELOT_3_REG_INTSTAT		0xb
+#define OCELOT_3_REG_UART_INTMASK	0xc
+#define OCELOT_3_REG_UART_INTSTAT	0xd
+#define OCELOT_3_REG_INTSET		0xe
+#define OCELOT_3_REG_INTCLR		0xf
+
+#define OCELOT_FPGA_WRITE(x, y) writeb(x, OCELOT_3_CS0_ADDR + OCELOT_3_REG_##y)
+#define OCELOT_FPGA_READ(x) readb(OCELOT_3_CS0_ADDR + OCELOT_3_REG_##x)
+
+#endif
Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig
+++ linux/arch/mips/Kconfig
@@ -329,6 +329,18 @@
 	  The Ocelot is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
 
+config MOMENCO_OCELOT_3
+	bool "Support for Momentum Ocelot-3 board"
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select IRQ_CPU_RM7K
+	select IRQ_MV64340
+	select RM7000_CPU_SCACHE
+	select SWAP_IO_SPACE
+	help
+	  The Ocelot-3 is based off Discovery III System Controller and 
+	  PMC-Sierra Rm79000 core.
+
 config MOMENCO_JAGUAR_ATX
 	bool "Support for Momentum Jaguar board"
 	select DMA_NONCOHERENT
@@ -1004,7 +1016,7 @@
 
 config BOOT_ELF32
 	bool
-	depends on MACH_DECSTATION || MIPS_ATLAS || MIPS_MALTA || MOMENCO_JAGUAR_ATX || SIBYTE_SB1xxx_SOC || SGI_IP32 || SGI_IP22 || SNI_RM200_PCI
+	depends on MACH_DECSTATION || MIPS_ATLAS || MIPS_MALTA || MOMENCO_JAGUAR_ATX || MOMENCO_OCELOT_3 || SIBYTE_SB1xxx_SOC || SGI_IP32 || SGI_IP22 || SNI_RM200_PCI
 	default y
 
 config MIPS_L1_CACHE_SHIFT
Index: linux/include/asm-mips/bootinfo.h
===================================================================
--- linux.orig/include/asm-mips/bootinfo.h
+++ linux/include/asm-mips/bootinfo.h
@@ -122,6 +122,7 @@
 #define  MACH_MOMENCO_OCELOT_G	1
 #define  MACH_MOMENCO_OCELOT_C	2
 #define  MACH_MOMENCO_JAGUAR_ATX 3
+#define  MACH_MOMENCO_OCELOT_3	4	
 
 /*
  * Valid machtype for group ITE
Index: linux/arch/mips/momentum/ocelot_3/reset.c
===================================================================
--- /dev/null
+++ linux/arch/mips/momentum/ocelot_3/reset.c
@@ -0,0 +1,64 @@
+/*
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 1997, 2001 Ralf Baechle
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright (C) 2002 Momentum Computer Inc.
+ * Author: Matthew Dharm <mdharm@momenco.com>
+ *
+ * Louis Hamilton, Red Hat, Inc.
+ * hamilton@redhat.com  [MIPS64 modifications]
+ *
+ * Copyright 2004 PMC-Sierra
+ * Author: Manish Lachwani (lachwani@pmc-sierra.com)
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+
+void momenco_ocelot_restart(char *command)
+{
+	/* base address of timekeeper portion of part */
+	void *nvram = (void *)
+#ifdef CONFIG_MIPS64
+		0xfffffffffc807000;
+#else
+		0xfc807000;
+#endif
+
+ 	/* Ask the NVRAM/RTC/watchdog chip to assert reset in 1/16 second */
+	writeb(0x84, nvram + 0xff7);
+
+	/* wait for the watchdog to go off */
+	mdelay(100+(1000/16));
+
+	/* if the watchdog fails for some reason, let people know */
+	printk(KERN_NOTICE "Watchdog reset failed\n");
+}
+
+void momenco_ocelot_halt(void)
+{
+	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
+	while (1)
+		__asm__(".set\tmips3\n\t"
+	                "wait\n\t"
+			".set\tmips0");
+}
+
+void momenco_ocelot_power_off(void)
+{
+	momenco_ocelot_halt();
+}
Index: linux/arch/mips/momentum/ocelot_3/prom.c
===================================================================
--- /dev/null
+++ linux/arch/mips/momentum/ocelot_3/prom.c
@@ -0,0 +1,259 @@
+/*
+ * Copyright 2002 Momentum Computer Inc.
+ * Author: Matthew Dharm <mdharm@momenco.com>
+ *
+ * Louis Hamilton, Red Hat, Inc.
+ *   hamilton@redhat.com  [MIPS64 modifications]
+ *
+ * Copyright 2004 PMC-Sierra
+ * Author: Manish Lachwani (lachwani@pmc-sierra.com)
+ *
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ * 
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mv643xx.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/mv64340.h>
+#include "ocelot_3_fpga.h"
+
+struct callvectors {
+	int	(*open) (char*, int, int);
+	int	(*close) (int);
+	int	(*read) (int, void*, int);
+	int	(*write) (int, void*, int);
+	off_t	(*lseek) (int, off_t, int);
+	int	(*printf) (const char*, ...);
+	void	(*cacheflush) (void);
+	char*	(*gets) (char*);
+};
+
+struct callvectors* debug_vectors;
+extern unsigned long marvell_base;
+extern unsigned long cpu_clock;
+
+#ifdef CONFIG_MV64340_ETH
+extern unsigned char prom_mac_addr_base[6];
+#endif
+
+const char *get_system_type(void)
+{
+	return "Momentum Ocelot-3";
+}
+
+#ifdef CONFIG_MV64340_ETH
+void burn_clocks(void)
+{
+	int i;
+
+	/* this loop should burn at least 1us -- this should be plenty */
+	for (i = 0; i < 0x10000; i++)
+		;
+}
+
+u8 exchange_bit(u8 val, u8 cs)
+{
+	/* place the data */
+	OCELOT_FPGA_WRITE((val << 2) | cs, EEPROM_MODE);
+	burn_clocks();
+
+	/* turn the clock on */
+	OCELOT_FPGA_WRITE((val << 2) | cs | 0x2, EEPROM_MODE);
+	burn_clocks();
+
+	/* turn the clock off and read-strobe */
+	OCELOT_FPGA_WRITE((val << 2) | cs | 0x10, EEPROM_MODE);
+	
+	/* return the data */
+	return ((OCELOT_FPGA_READ(EEPROM_MODE) >> 3) & 0x1);
+}
+
+void get_mac(char dest[6])
+{
+	u8 read_opcode[12] = {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+	int i,j;
+
+	for (i = 0; i < 12; i++)
+		exchange_bit(read_opcode[i], 1);
+
+	for (j = 0; j < 6; j++) {
+		dest[j] = 0;
+		for (i = 0; i < 8; i++) {
+			dest[j] <<= 1;
+			dest[j] |= exchange_bit(0, 1);
+		}
+	}
+
+	/* turn off CS */
+	exchange_bit(0,0);
+}
+#endif
+
+
+#ifdef CONFIG_MIPS64
+
+unsigned long signext(unsigned long addr)
+{
+	addr &= 0xffffffff;
+	return (unsigned long)((int)addr);
+}
+
+void *get_arg(unsigned long args, int arc)
+{
+	unsigned long ul;
+	unsigned char *puc, uc;
+
+	args += (arc * 4);
+	ul = (unsigned long)signext(args);
+	puc = (unsigned char *)ul;
+	if (puc == 0)
+		return (void *)0;
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	uc = *puc++;
+	ul = (unsigned long)uc;
+	uc = *puc++;
+	ul |= (((unsigned long)uc) << 8);
+	uc = *puc++;
+	ul |= (((unsigned long)uc) << 16);
+	uc = *puc++;
+	ul |= (((unsigned long)uc) << 24);
+#else  /* CONFIG_CPU_LITTLE_ENDIAN */
+	uc = *puc++;
+	ul = ((unsigned long)uc) << 24;
+	uc = *puc++;
+	ul |= (((unsigned long)uc) << 16);
+	uc = *puc++;
+	ul |= (((unsigned long)uc) << 8);
+	uc = *puc++;
+	ul |= ((unsigned long)uc);
+#endif  /* CONFIG_CPU_LITTLE_ENDIAN */
+	ul = signext(ul);
+	return (void *)ul;
+}
+
+char *arg64(unsigned long addrin, int arg_index)
+{
+	unsigned long args;
+	char *p;
+
+	args = signext(addrin);
+	p = (char *)get_arg(args, arg_index);
+
+	return p;
+}
+#endif  /* CONFIG_MIPS64 */
+
+void __init prom_init(void)
+{
+	int argc = fw_arg0;
+	char **arg = (char **) fw_arg1;
+	char **env = (char **) fw_arg2;
+	struct callvectors *cv = (struct callvectors *) fw_arg3;
+	int i;
+
+#ifdef CONFIG_MIPS64
+	char *ptr;
+	printk("prom_init - MIPS64\n");
+
+	/* save the PROM vectors for debugging use */
+	debug_vectors = (struct callvectors *)signext((unsigned long)cv);
+
+	/* arg[0] is "g", the rest is boot parameters */
+	arcs_cmdline[0] = '\0';
+
+	for (i = 1; i < argc; i++) {
+		ptr = (char *)arg64((unsigned long)arg, i);
+		if ((strlen(arcs_cmdline) + strlen(ptr) + 1) >=
+		    sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, ptr);
+		strcat(arcs_cmdline, " ");
+	}
+	i = 0;
+
+	while (1) {
+		ptr = (char *)arg64((unsigned long)env, i);
+		if (! ptr)
+			break;
+
+		if (strncmp("gtbase", ptr, strlen("gtbase")) == 0) {
+			marvell_base = simple_strtol(ptr + strlen("gtbase="),
+							NULL, 16);
+
+			if ((marvell_base & 0xffffffff00000000) == 0)
+				marvell_base |= 0xffffffff00000000;
+
+			printk("marvell_base set to 0x%016lx\n", marvell_base);
+		}
+		if (strncmp("cpuclock", ptr, strlen("cpuclock")) == 0) {
+			cpu_clock = simple_strtol(ptr + strlen("cpuclock="),
+							NULL, 10);
+			printk("cpu_clock set to %d\n", cpu_clock);
+		}
+		i++;
+	}
+	printk("arcs_cmdline: %s\n", arcs_cmdline);
+
+#else   /* CONFIG_MIPS64 */
+
+	/* save the PROM vectors for debugging use */
+	debug_vectors = cv;
+
+	/* arg[0] is "g", the rest is boot parameters */
+	arcs_cmdline[0] = '\0';
+	for (i = 1; i < argc; i++) {
+		if (strlen(arcs_cmdline) + strlen(arg[i] + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, arg[i]);
+		strcat(arcs_cmdline, " ");
+	}
+
+	while (*env) {
+		if (strncmp("gtbase", *env, strlen("gtbase")) == 0) {
+			marvell_base = simple_strtol(*env + strlen("gtbase="),
+							NULL, 16);
+		}
+		if (strncmp("cpuclock", *env, strlen("cpuclock")) == 0) {
+			cpu_clock = simple_strtol(*env + strlen("cpuclock="),
+							NULL, 10);
+		}
+		env++;
+	}
+#endif /* CONFIG_MIPS64 */
+
+	mips_machgroup = MACH_GROUP_MOMENCO;
+	mips_machtype = MACH_MOMENCO_OCELOT_3;
+
+#ifdef CONFIG_MV64340_ETH
+	/* get the base MAC address for on-board ethernet ports */
+	get_mac(prom_mac_addr_base);
+#endif
+
+#ifndef CONFIG_MIPS64
+	debug_vectors->printf("Booting Linux kernel...\n");
+#endif
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
+{
+}
Index: linux/arch/mips/momentum/ocelot_3/Makefile
===================================================================
--- /dev/null
+++ linux/arch/mips/momentum/ocelot_3/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for Momentum Computer's Ocelot-3 board.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+obj-y	 += int-handler.o irq.o prom.o reset.o setup.o
Index: linux/arch/mips/momentum/ocelot_3/int-handler.S
===================================================================
--- /dev/null
+++ linux/arch/mips/momentum/ocelot_3/int-handler.S
@@ -0,0 +1,138 @@
+/*
+ * Copyright 2002 Momentum Computer Inc.
+ * Author: Matthew Dharm <mdharm@momenco.com>
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2004 PMC-Sierra
+ * Author: Manish Lachwani (lachwani@pmc-sierra.com)
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ *
+ * First-level interrupt dispatcher for Ocelot-3 board.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include "ocelot_3_fpga.h"
+
+/*
+ * First level interrupt dispatcher for Ocelot-3 board
+ */
+		.align	5
+		NESTED(ocelot3_handle_int, PT_SIZE, sp)
+		SAVE_ALL
+		CLI
+		.set	at
+
+		mfc0	t0, CP0_CAUSE  
+		mfc0	t2, CP0_STATUS
+
+		and	t0, t2
+        
+		andi	t1, t0, STATUSF_IP0	/* sw0 software interrupt (IRQ0) */
+		bnez	t1, ll_sw0_irq
+
+		andi	t1, t0, STATUSF_IP1	/* sw1 software interrupt (IRQ1) */
+		bnez	t1, ll_sw1_irq
+
+		andi	t1, t0, STATUSF_IP2	/* int0 hardware line (IRQ2) */
+		bnez	t1, ll_pci0slot1_irq
+
+		andi	t1, t0, STATUSF_IP3	/* int1 hardware line (IRQ3) */
+		bnez	t1, ll_pci0slot2_irq
+
+		andi	t1, t0, STATUSF_IP4	/* int2 hardware line (IRQ4) */
+		bnez	t1, ll_pci1slot1_irq
+
+		andi	t1, t0, STATUSF_IP5	/* int3 hardware line (IRQ5) */
+		bnez	t1, ll_pci1slot2_irq
+
+		andi	t1, t0, STATUSF_IP6	/* int4 hardware line (IRQ6) */
+		bnez	t1, ll_uart_irq
+
+		andi	t1, t0, STATUSF_IP7	/* cpu timer (IRQ7) */
+		bnez	t1, ll_cputimer_irq
+
+                /* now look at extended interrupts */
+                mfc0    t0, CP0_CAUSE
+                cfc0    t1, CP0_S1_INTCONTROL
+                                                                                
+                /* shift the mask 8 bits left to line up the bits */
+                sll     t2, t1, 8
+                                                                                
+                and     t0, t2
+                srl     t0, t0, 16
+                                                                                
+                andi    t1, t0, STATUSF_IP8     /* int6 hardware line (IRQ9) */
+                bnez    t1, ll_mv64340_decode_irq
+
+		.set	reorder
+
+		/* wrong alarm or masked ... */
+		j	spurious_interrupt
+		nop
+		END(ocelot3_handle_int)
+
+		.align	5
+ll_sw0_irq:
+		li	a0, 0		/* IRQ 1 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+ll_sw1_irq:
+		li	a0, 1		/* IRQ 2 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_pci0slot1_irq:
+		li	a0, 2		/* IRQ 3 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_pci0slot2_irq:
+		li	a0, 3		/* IRQ 4 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_pci1slot1_irq:
+		li	a0, 4		/* IRQ 5 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_pci1slot2_irq:
+		li	a0, 5		/* IRQ 6 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_uart_irq:
+		li	a0, 6		/* IRQ 7 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+	
+ll_cputimer_irq:
+		li	a0, 7		/* IRQ 8 */
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_mv64340_decode_irq:
+		move	a0, sp
+		jal	ll_mv64340_irq
+		j	ret_from_irq
+
Index: linux/arch/mips/momentum/ocelot_3/irq.c
===================================================================
--- /dev/null
+++ linux/arch/mips/momentum/ocelot_3/irq.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2000 RidgeRun, Inc.
+ * Author: RidgeRun, Inc.
+ *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright 2004 PMC-Sierra
+ * Author: Manish Lachwani (lachwani@pmc-sierra.com)
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Copyright (C) 2004 MontaVista Software Inc.
+ *  Author: Manish Lachwani, mlachwani@mvista.com
+ *
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <asm/bitops.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+
+extern asmlinkage void ocelot3_handle_int(void);
+
+static struct irqaction cascade_mv64340 = {
+	no_action, SA_INTERRUPT, CPU_MASK_NONE, "MV64340-Cascade", NULL, NULL
+};
+
+void __init arch_init_irq(void)
+{
+	/*
+	 * Clear all of the interrupts while we change the able around a bit.
+	 * int-handler is not on bootstrap
+	 */
+	clear_c0_status(ST0_IM | ST0_BEV);
+
+	/* Sets the first-level interrupt dispatcher. */
+	set_except_vector(0, ocelot3_handle_int);
+	mips_cpu_irq_init(0);
+	rm7k_cpu_irq_init(8);
+
+	/* set up the cascading interrupts */
+	setup_irq(8, &cascade_mv64340);		/* unmask intControl IM8, IRQ 9 */
+	mv64340_irq_init(16);
+
+	set_c0_status(ST0_IM); /* IE in the status register */
+
+}
Index: linux/arch/mips/momentum/ocelot_3/setup.c
===================================================================
--- /dev/null
+++ linux/arch/mips/momentum/ocelot_3/setup.c
@@ -0,0 +1,312 @@
+/*
+ * setup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ * Momentum Computer Ocelot-3 board dependent boot routines
+ *
+ * Copyright (C) 1996, 1997, 2001  Ralf Baechle
+ * Copyright (C) 2000 RidgeRun, Inc.
+ * Copyright (C) 2001 Red Hat, Inc.
+ * Copyright (C) 2002 Momentum Computer
+ *
+ * Author: Matthew Dharm, Momentum Computer
+ *   mdharm@momenco.com
+ *
+ * Louis Hamilton, Red Hat, Inc.
+ *   hamilton@redhat.com  [MIPS64 modifications]
+ *
+ * Author: RidgeRun, Inc.
+ *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2004 PMC-Sierra
+ * Author: Manish Lachwani (lachwani@pmc-sierra.com)
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mc146818rtc.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/timex.h>
+#include <linux/bootmem.h>
+#include <linux/mv643xx.h>
+#include <asm/time.h>
+#include <asm/page.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pci.h>
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/reboot.h>
+#include <asm/mc146818rtc.h>
+#include <asm/tlbflush.h>
+#include "ocelot_3_fpga.h"
+
+/* Marvell Discovery Register Base */
+unsigned long marvell_base;
+/* Serial */
+unsigned long uart_base;
+/* CPU clock */
+unsigned long cpu_clock;
+/* RTC/NVRAM */
+unsigned char* rtc_base;
+
+/* 
+ * Marvell Discovery SRAM. This is one place where Ethernet
+ * Tx and Rx descriptors can be placed to improve performance
+ */
+extern unsigned long mv64340_sram_base;
+
+
+/* These functions are used for rebooting or halting the machine*/
+extern void momenco_ocelot_restart(char *command);
+extern void momenco_ocelot_halt(void);
+extern void momenco_ocelot_power_off(void);
+
+void momenco_time_init(void);
+static char reset_reason;
+
+void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
+		     unsigned long entryhi, unsigned long pagemask);
+
+#define ENTRYLO(x) (((x & PAGE_MASK) | (_PAGE_PRESENT | __READABLE | 	\
+		   __WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)) >> 6)
+
+void __init bus_error_init(void) 
+{ 
+	/* nothing */ 
+}
+
+/* 
+ * setup code for a handoff from a version 2 PMON 2000 PROM 
+ */
+void setup_wired_tlb_entries(void)
+{
+#ifdef CONFIG_MIPS64
+	/* marvell and extra space */
+	add_wired_entry(ENTRYLO(0xf4000000), ENTRYLO(0xf4010000),
+			0xfffffffff4000000, PM_64K);
+
+	/* fpga, rtc, and uart */
+	add_wired_entry(ENTRYLO(0xfc000000), ENTRYLO(0xfd000000),
+			0xfffffffffc000000, PM_16M);
+
+	marvell_base = 0xfffffffff4000000;
+	uart_base = 0xfffffffffd000000;
+	rtc_base = (unsigned char*)0xfffffffffc800000;
+#else
+	write_c0_wired(0);
+	local_flush_tlb_all();
+
+	/* marvell and extra space */
+	add_wired_entry(ENTRYLO(0xf4000000), ENTRYLO(0xf4010000), 0xf4000000, PM_64K);
+
+	/* fpga, rtc, and uart */
+	add_wired_entry(ENTRYLO(0xfc000000), ENTRYLO(0xfd000000), 0xfc000000, PM_16M);
+
+	marvell_base = 0xf4000000;
+	uart_base = 0xfd000000;
+	rtc_base = (unsigned char*)0xfc800000;
+#endif
+}
+
+#define CONV_BCD_TO_BIN(val)	(((val) & 0xf) + (((val) >> 4) * 10))
+#define CONV_BIN_TO_BCD(val)	(((val) % 10) + (((val) / 10) << 4))
+
+unsigned long m48t37y_get_time(void)
+{
+	unsigned int year, month, day, hour, min, sec;
+
+	/* stop the update */
+	rtc_base[0x7ff8] = 0x40;
+
+	year = CONV_BCD_TO_BIN(rtc_base[0x7fff]);
+	year += CONV_BCD_TO_BIN(rtc_base[0x7ff1]) * 100;
+
+	month = CONV_BCD_TO_BIN(rtc_base[0x7ffe]);
+
+	day = CONV_BCD_TO_BIN(rtc_base[0x7ffd]);
+
+	hour = CONV_BCD_TO_BIN(rtc_base[0x7ffb]);
+	min = CONV_BCD_TO_BIN(rtc_base[0x7ffa]);
+	sec = CONV_BCD_TO_BIN(rtc_base[0x7ff9]);
+
+	/* start the update */
+	rtc_base[0x7ff8] = 0x00;
+
+	return mktime(year, month, day, hour, min, sec);
+}
+
+int m48t37y_set_time(unsigned long sec)
+{
+	struct rtc_time tm;
+
+	/* convert to a more useful format -- note months count from 0 */
+	to_tm(sec, &tm);
+	tm.tm_mon += 1;
+
+	/* enable writing */
+	rtc_base[0x7ff8] = 0x80;
+
+	/* year */
+	rtc_base[0x7fff] = CONV_BIN_TO_BCD(tm.tm_year % 100);
+	rtc_base[0x7ff1] = CONV_BIN_TO_BCD(tm.tm_year / 100);
+
+	/* month */
+	rtc_base[0x7ffe] = CONV_BIN_TO_BCD(tm.tm_mon);
+
+	/* day */
+	rtc_base[0x7ffd] = CONV_BIN_TO_BCD(tm.tm_mday);
+
+	/* hour/min/sec */
+	rtc_base[0x7ffb] = CONV_BIN_TO_BCD(tm.tm_hour);
+	rtc_base[0x7ffa] = CONV_BIN_TO_BCD(tm.tm_min);
+	rtc_base[0x7ff9] = CONV_BIN_TO_BCD(tm.tm_sec);
+
+	/* day of week -- not really used, but let's keep it up-to-date */
+	rtc_base[0x7ffc] = CONV_BIN_TO_BCD(tm.tm_wday + 1);
+
+	/* disable writing */
+	rtc_base[0x7ff8] = 0x00;
+
+	return 0;
+}
+
+void momenco_timer_setup(struct irqaction *irq)
+{
+	setup_irq(7, irq);	/* Timer interrupt, unmask status IM7 */
+}
+
+void momenco_time_init(void)
+{
+	setup_wired_tlb_entries();
+
+	/* 
+	 * Ocelot-3 board has been built with both 
+	 * the Rm7900 and the Rm7065C 
+	 */
+	mips_hpt_frequency = cpu_clock / 2;
+	board_timer_setup = momenco_timer_setup;
+
+	rtc_get_time = m48t37y_get_time;
+	rtc_set_time = m48t37y_set_time;
+}
+
+static int __init momenco_ocelot_3_setup(void)
+{
+	unsigned int tmpword;
+
+	board_time_init = momenco_time_init;
+
+	_machine_restart = momenco_ocelot_restart;
+	_machine_halt = momenco_ocelot_halt;
+	_machine_power_off = momenco_ocelot_power_off;
+
+	/* Wired TLB entries */
+	setup_wired_tlb_entries();
+
+	/* shut down ethernet ports, just to be sure our memory doesn't get
+	 * corrupted by random ethernet traffic.
+	 */
+	MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(0), 0xff << 8);
+	MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(1), 0xff << 8);
+	MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(0), 0xff << 8);
+	MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(1), 0xff << 8);
+	do {}
+	  while (MV_READ(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(0)) & 0xff);
+	do {}
+	  while (MV_READ(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(1)) & 0xff);
+	do {}
+	  while (MV_READ(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(0)) & 0xff);
+	do {}
+	  while (MV_READ(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(1)) & 0xff);
+	MV_WRITE(MV64340_ETH_PORT_SERIAL_CONTROL_REG(0),
+		 MV_READ(MV64340_ETH_PORT_SERIAL_CONTROL_REG(0)) & ~1);
+	MV_WRITE(MV64340_ETH_PORT_SERIAL_CONTROL_REG(1),
+		 MV_READ(MV64340_ETH_PORT_SERIAL_CONTROL_REG(1)) & ~1);
+
+	/* Turn off the Bit-Error LED */
+	OCELOT_FPGA_WRITE(0x80, CLR);
+
+	tmpword = OCELOT_FPGA_READ(BOARDREV);
+	if (tmpword < 26)
+		printk("Momenco Ocelot-3: Board Assembly Rev. %c\n",
+			'A'+tmpword);
+	else
+		printk("Momenco Ocelot-3: Board Assembly Revision #0x%x\n",
+			tmpword);
+
+	tmpword = OCELOT_FPGA_READ(FPGA_REV);
+	printk("FPGA Rev: %d.%d\n", tmpword>>4, tmpword&15);
+	tmpword = OCELOT_FPGA_READ(RESET_STATUS);
+	printk("Reset reason: 0x%x\n", tmpword);
+	switch (tmpword) {
+		case 0x1:
+			printk("  - Power-up reset\n");
+			break;
+		case 0x2:
+			printk("  - Push-button reset\n");
+			break;
+		case 0x4:
+			printk("  - cPCI bus reset\n");
+			break;
+		case 0x8:
+			printk("  - Watchdog reset\n");
+			break;
+		case 0x10:
+			printk("  - Software reset\n");
+			break;
+		default:
+			printk("  - Unknown reset cause\n");
+	}
+	reset_reason = tmpword;
+	OCELOT_FPGA_WRITE(0xff, RESET_STATUS);
+
+	tmpword = OCELOT_FPGA_READ(CPCI_ID);
+	printk("cPCI ID register: 0x%02x\n", tmpword);
+	printk("  - Slot number: %d\n", tmpword & 0x1f);
+	printk("  - PCI bus present: %s\n", tmpword & 0x40 ? "yes" : "no");
+	printk("  - System Slot: %s\n", tmpword & 0x20 ? "yes" : "no");
+
+	tmpword = OCELOT_FPGA_READ(BOARD_STATUS);
+	printk("Board Status register: 0x%02x\n", tmpword);
+	printk("  - User jumper: %s\n", (tmpword & 0x80)?"installed":"absent");
+	printk("  - Boot flash write jumper: %s\n", (tmpword&0x40)?"installed":"absent");
+	printk("  - L3 cache size: %d MB\n", (1<<((tmpword&12) >> 2))&~1);
+
+	/* Support for 128 MB memory */	
+	add_memory_region(0x0, 0x08000000, BOOT_MEM_RAM);
+
+	return 0;
+}
+
+early_initcall(momenco_ocelot_3_setup);
Index: linux/arch/mips/configs/ocelot_3_defconfig
===================================================================
--- /dev/null
+++ linux/arch/mips/configs/ocelot_3_defconfig
@@ -0,0 +1,719 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1
+# Tue Nov  2 12:08:59 2004
+#
+CONFIG_MIPS=y
+# CONFIG_MIPS64 is not set
+# CONFIG_64BIT is not set
+CONFIG_MIPS32=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Machine selection
+#
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_BAGET_MIPS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_LASAT is not set
+# CONFIG_MIPS_ITE8172 is not set
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MOMENCO_OCELOT is not set
+# CONFIG_MOMENCO_OCELOT_G is not set
+# CONFIG_MOMENCO_OCELOT_C is not set
+CONFIG_MOMENCO_OCELOT_3=y
+# CONFIG_MOMENCO_JAGUAR_ATX is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+# CONFIG_NEC_OSPREY is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SOC_AU1X00 is not set
+# CONFIG_SIBYTE_SB1xxx_SOC is not set
+# CONFIG_SNI_RM200_PCI is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_DMA_NONCOHERENT=y
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_IRQ_CPU=y
+CONFIG_IRQ_CPU_RM7K=y
+CONFIG_IRQ_MV64340=y
+CONFIG_SWAP_IO_SPACE=y
+CONFIG_BOOT_ELF32=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+CONFIG_FB=y
+
+#
+# CPU selection
+#
+# CONFIG_CPU_MIPS32 is not set
+# CONFIG_CPU_MIPS64 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+CONFIG_CPU_RM9000=y
+# CONFIG_CPU_SB1 is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_BOARD_SCACHE=y
+CONFIG_RM7000_CPU_SCACHE=y
+CONFIG_CPU_HAS_PREFETCH=y
+# CONFIG_64BIT_PHYS_ADDR is not set
+# CONFIG_CPU_ADVANCED is not set
+CONFIG_CPU_HAS_LLSC=y
+CONFIG_CPU_HAS_LLDSCD=y
+CONFIG_CPU_HAS_SYNC=y
+# CONFIG_HIGHMEM is not set
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_MMU=y
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=m
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+# CONFIG_BLK_DEV_SD is not set
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_QLOGIC_1280_1040 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_NETLINK_DEV=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=m
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_IPV6_TUNNEL is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
+# CONFIG_IP_NF_COMPAT_IPFWADM is not set
+
+#
+# IPv6: Netfilter Configuration
+#
+# CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=m
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+
+#
+# Ethernet (1000 Mbit)
+#
+CONFIG_MV643XX_ETH=y
+CONFIG_MV643XX_ETH_0=y
+CONFIG_MV643XX_ETH_1=y
+CONFIG_MV643XX_ETH_2=y
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+CONFIG_PPP=m
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+# CONFIG_PPP_BSDCOMP is not set
+CONFIG_PPPOE=m
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_RTC=y
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+CONFIG_FB_MODE_HELPERS=y
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+
+#
+# Logo configuration
+#
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=m
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+CONFIG_REISERFS_FS=m
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+# CONFIG_REISERFS_FS_XATTR is not set
+# CONFIG_JFS_FS is not set
+CONFIG_XFS_FS=m
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_SECURITY is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+CONFIG_AUTOFS_FS=y
+CONFIG_AUTOFS4_FS=m
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_DEVFS_FS=y
+CONFIG_DEVFS_MOUNT=y
+# CONFIG_DEVFS_DEBUG is not set
+CONFIG_DEVPTS_FS_XATTR=y
+CONFIG_DEVPTS_FS_SECURITY=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+CONFIG_EFS_FS=y
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V4 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=m
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_CROSSCOMPILE=y
+CONFIG_CMDLINE="ip=any root=nfs"
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=m
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=m
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y

--p4qYPpj5QlsIQJ0K--
