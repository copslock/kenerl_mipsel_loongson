Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2005 08:41:38 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:16000 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225242AbVCAIlV>; Tue, 1 Mar 2005 08:41:21 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D62wk-0000Xz-00; Tue, 01 Mar 2005 08:41:38 +0000
Date:	Tue, 1 Mar 2005 08:41:38 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6] Cobalt 2/2: add support for Qube2700
Message-ID: <20050301084138.GB2017@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Qube2700 Galileo hangs if we access slot #6.

Make console serial port initialisation dependent on unit type.

P.

--

diff -urpN linux-wip/arch/mips/cobalt/setup.c linux-qube1/arch/mips/cobalt/setup.c
--- linux-wip/arch/mips/cobalt/setup.c	2005-02-27 17:21:23.000000000 +0000
+++ linux-qube1/arch/mips/cobalt/setup.c	2005-02-27 16:25:20.000000000 +0000
@@ -13,6 +13,8 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
 
 #include <asm/bootinfo.h>
 #include <asm/time.h>
@@ -21,6 +23,7 @@
 #include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/gt64120.h>
+#include <asm/serial.h>
 
 #include <asm/cobalt/cobalt.h>
 
@@ -89,6 +92,7 @@ static struct pci_controller cobalt_pci_
 
 static int __init cobalt_setup(void)
 {
+	static struct uart_port uart;
 	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
 	int i;
 
@@ -127,6 +131,21 @@ static int __init cobalt_setup(void)
 	register_pci_controller(&cobalt_pci_controller);
 #endif
 
+#ifdef CONFIG_SERIAL_8250
+	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
+
+		uart.line	= 0;
+		uart.type	= PORT_UNKNOWN;
+		uart.uartclk	= 18432000;
+		uart.irq	= COBALT_SERIAL_IRQ;
+		uart.flags	= STD_COM_FLAGS;
+		uart.iobase	= 0xc800000;
+		uart.iotype	= UPIO_PORT;
+
+		early_serial_setup(&uart);
+	}
+#endif
+
 	return 0;
 }
 
diff -urpN linux-wip/arch/mips/pci/fixup-cobalt.c linux-qube1/arch/mips/pci/fixup-cobalt.c
--- linux-wip/arch/mips/pci/fixup-cobalt.c	2005-02-27 17:21:23.000000000 +0000
+++ linux-qube1/arch/mips/pci/fixup-cobalt.c	2005-02-27 16:44:57.000000000 +0000
@@ -109,6 +109,15 @@ static void qube_raq_galileo_fixup(struc
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 	 qube_raq_galileo_fixup);
 
+static char irq_tab_qube1[] __initdata = {
+  [COBALT_PCICONF_CPU]     = 0,
+  [COBALT_PCICONF_ETH0]    = COBALT_QUBE1_ETH0_IRQ,
+  [COBALT_PCICONF_RAQSCSI] = COBALT_SCSI_IRQ,
+  [COBALT_PCICONF_VIA]     = 0,
+  [COBALT_PCICONF_PCISLOT] = COBALT_QUBE_SLOT_IRQ,
+  [COBALT_PCICONF_ETH1]    = 0
+};
+
 static char irq_tab_cobalt[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
   [COBALT_PCICONF_ETH0]    = COBALT_ETH0_IRQ,
@@ -129,6 +138,9 @@ static char irq_tab_raq2[] __initdata = 
 
 int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
+	if (cobalt_board_id < COBALT_BRD_ID_QUBE2)
+		return irq_tab_qube1[slot];
+
 	if (cobalt_board_id == COBALT_BRD_ID_RAQ2)
 		return irq_tab_raq2[slot];
 
diff -urpN linux-wip/arch/mips/pci/ops-gt64111.c linux-qube1/arch/mips/pci/ops-gt64111.c
--- linux-wip/arch/mips/pci/ops-gt64111.c	2003-11-13 16:55:07.000000000 +0000
+++ linux-qube1/arch/mips/pci/ops-gt64111.c	2005-02-27 16:42:29.000000000 +0000
@@ -20,13 +20,21 @@
 /*
  * Accessing device 31 hangs the GT64120.  Not sure if this will also hang
  * the GT64111, let's be paranoid for now.
+ *
+ * Accessing device COBALT_PCICONF_CPU hangs early units.
  */
 static inline int pci_range_ck(struct pci_bus *bus, unsigned int devfn)
 {
-	if (bus->number == 0 && devfn == PCI_DEVFN(31, 0))
-		return -1;
+	unsigned slot;
 
-	return 0;
+	if (bus->number == 0) {
+
+		slot = PCI_SLOT(devfn);
+		if (slot != COBALT_PCICONF_CPU && slot < 31)
+			return 0;
+	}
+
+	return -1;
 }
 
 static int gt64111_pci_read_config(struct pci_bus *bus, unsigned int devfn,
diff -urpN linux-wip/drivers/net/tulip/de2104x.c linux-qube1/drivers/net/tulip/de2104x.c
--- linux-wip/drivers/net/tulip/de2104x.c	2005-02-07 02:54:50.000000000 +0000
+++ linux-qube1/drivers/net/tulip/de2104x.c	2005-02-27 17:03:09.000000000 +0000
@@ -1787,10 +1787,15 @@ static void __init de21041_get_srom_info
 	/* DEC now has a specification but early board makers
 	   just put the address in the first EEPROM locations. */
 	/* This does  memcmp(eedata, eedata+16, 8) */
+
+#ifndef CONFIG_MIPS_COBALT
+
 	for (i = 0; i < 8; i ++)
 		if (ee_data[i] != ee_data[16+i])
 			sa_offset = 20;
 
+#endif
+
 	/* store MAC address */
 	for (i = 0; i < 6; i ++)
 		de->dev->dev_addr[i] = ee_data[i + sa_offset];
diff -urpN linux-wip/include/asm-mips/cobalt/cobalt.h linux-qube1/include/asm-mips/cobalt/cobalt.h
--- linux-wip/include/asm-mips/cobalt/cobalt.h	2005-02-21 16:18:36.000000000 +0000
+++ linux-qube1/include/asm-mips/cobalt/cobalt.h	2005-02-27 16:44:36.000000000 +0000
@@ -29,6 +29,7 @@
 #define COBALT_SCC_IRQ          19		/* pre-production has 85C30 */
 #define COBALT_RAQ_SCSI_IRQ	19
 #define COBALT_ETH0_IRQ		19
+#define COBALT_QUBE1_ETH0_IRQ	20
 #define COBALT_ETH1_IRQ		20
 #define COBALT_SERIAL_IRQ	21
 #define COBALT_SCSI_IRQ         21
diff -urpN linux-wip/include/asm-mips/serial.h linux-qube1/include/asm-mips/serial.h
--- linux-wip/include/asm-mips/serial.h	2004-11-09 18:28:25.000000000 +0000
+++ linux-qube1/include/asm-mips/serial.h	2005-02-27 16:23:11.000000000 +0000
@@ -78,16 +78,6 @@
 #define JAZZ_SERIAL_PORT_DEFNS
 #endif
 
-#ifdef CONFIG_MIPS_COBALT
-#include <asm/cobalt/cobalt.h>
-#define COBALT_BASE_BAUD  (18432000 / 16)
-#define COBALT_SERIAL_PORT_DEFNS		\
-	/* UART CLK   PORT  IRQ  FLAGS    */ 		\
-	{ 0, COBALT_BASE_BAUD, 0xc800000, COBALT_SERIAL_IRQ, STD_COM_FLAGS },   /* ttyS0 */
-#else
-#define COBALT_SERIAL_PORT_DEFNS
-#endif
-
 /*
  * Both Galileo boards have the same UART mappings.
  */
@@ -424,7 +414,6 @@
 #endif /* CONFIG_SGI_IP32 */
 
 #define SERIAL_PORT_DFNS				\
-	COBALT_SERIAL_PORT_DEFNS			\
 	DDB5477_SERIAL_PORT_DEFNS			\
 	EV96100_SERIAL_PORT_DEFNS			\
 	EXTRA_SERIAL_PORT_DEFNS				\
