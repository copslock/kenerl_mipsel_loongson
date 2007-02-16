Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 22:25:33 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:37763 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039263AbXBPWZ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 22:25:26 +0000
Received: (qmail 11726 invoked by uid 101); 16 Feb 2007 22:24:11 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 16 Feb 2007 22:24:11 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1GMOAMo014727
	for <linux-mips@linux-mips.org>; Fri, 16 Feb 2007 14:24:10 -0800
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l1GMOAHT022096
	for linux-mips@linux-mips.org; Fri, 16 Feb 2007 16:24:10 -0600
Date:	Fri, 16 Feb 2007 16:24:10 -0600
Message-Id: <200702162224.l1GMOAHT022096@pasqua.pmc-sierra.bc.ca>
To:	linux-mips@linux-mips.org
Subject: [PATCH] PMC MSP71xx PCI patch, kernel linux-mips.git master
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

PCI patch for the PMC-Sierra MSP71xx devices. This patch
only contains code living in arch/mips.

Please provide any initial feedback. I will update and repost
for consideration in the linux-mips.org repository.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
---

 arch/mips/pci/Makefile                        |    3 
 arch/mips/pci/fixup-pmcmsp.c                  |  219 +++++
 arch/mips/pci/ops-pmcmsp.c                    | 1007 ++++++++++++++++++++++++++
 arch/mips/pmc-sierra/msp71xx/msp_pci.c        |   49 +
 include/asm-mips/pmc-sierra/msp71xx/msp_pci.h |  207 +++++
 5 files changed, 1485 insertions(+)

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 82b20c2..3daab62 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -36,6 +36,9 @@ obj-$(CONFIG_MOMENCO_OCELOT)	+= fixup-oc
 obj-$(CONFIG_MOMENCO_OCELOT_3)	+= fixup-ocelot3.o
 obj-$(CONFIG_MOMENCO_OCELOT_C)	+= fixup-ocelot-c.o pci-ocelot-c.o
 obj-$(CONFIG_MOMENCO_OCELOT_G)	+= fixup-ocelot-g.o pci-ocelot-g.o
+obj-$(CONFIG_PMC_MSP7120_GW)  += fixup-pmcmsp.o ops-pmcmsp.o
+obj-$(CONFIG_PMC_MSP7120_EVAL)  += fixup-pmcmsp.o ops-pmcmsp.o
+obj-$(CONFIG_PMC_MSP7120_FPGA)   += fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_YOSEMITE)	+= fixup-yosemite.o ops-titan.o ops-titan-ht.o \
 				   pci-yosemite.o
 obj-$(CONFIG_SGI_IP27)		+= ops-bridge.o pci-ip27.o
diff --git a/arch/mips/pci/fixup-pmcmsp.c b/arch/mips/pci/fixup-pmcmsp.c
new file mode 100644
index 0000000..7f97e68
--- /dev/null
+++ b/arch/mips/pci/fixup-pmcmsp.c
@@ -0,0 +1,219 @@
+/* $Id$ */
+/*
+ * BRIEF MODULE DESCRIPTION
+ *	Board specific pci fixups.
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *         	ppopov@mvista.com or source@mvista.com
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
+ */
+
+#ifdef CONFIG_PCI
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm-mips/pmc-sierra/msp71xx/msp_pci.h>
+#include <asm-mips/pmc-sierra/msp71xx/msp_cic_int.h>
+#include <asm/byteorder.h>
+
+/* PCI interrupt pins */
+#define IRQ4	(MSP_INT_EXT4)
+#define IRQ5	(MSP_INT_EXT5)
+#define IRQ6	(MSP_INT_EXT6)
+
+#if defined(CONFIG_PMC_MSP7120_GW)
+
+/* Garibaldi Board IRQ wiring to PCI slots */
+static char irq_tab[][5] __initdata = {
+	/* INTA    INTB    INTC    INTD */
+	{0,     0,      0,      0,      0 },    /*    (AD[0]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[1]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[2]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[3]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[4]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[5]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[6]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[7]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[8]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[9]): Unused */
+	{0,     0,      0,      0,      0 },    /*  0 (AD[10]): Unused */ 
+	{0,     0,      0,      0,      0 },    /*  1 (AD[11]): Unused */
+	{0,     0,      0,      0,      0 },    /*  2 (AD[12]): Unused */
+	{0,     0,      0,      0,      0 },    /*  3 (AD[13]): Unused */
+	{0,     0,      0,      0,      0 },    /*  4 (AD[14]): Unused */
+	{0,     0,      0,      0,      0 },    /*  5 (AD[15]): Unused */
+	{0,     0,      0,      0,      0 },    /*  6 (AD[16]): Unused */
+	{0,     0,      0,      0,      0 },    /*  7 (AD[17]): Unused */
+	{0,     0,      0,      0,      0 },    /*  8 (AD[18]): Unused */
+	{0,     0,      0,      0,      0 },    /*  9 (AD[19]): Unused */
+	{0,     0,      0,      0,      0 },    /* 10 (AD[20]): Unused */
+	{0,     0,      0,      0,      0 },    /* 11 (AD[21]): Unused */
+	{0,     0,      0,      0,      0 },    /* 12 (AD[22]): Unused */
+	{0,     0,      0,      0,      0 },    /* 13 (AD[23]): Unused */
+	{0,     0,      0,      0,      0 },    /* 14 (AD[24]): Unused */
+	{0,     0,      0,      0,      0 },    /* 15 (AD[25]): Unused */
+	{0,     0,      0,      0,      0 },    /* 16 (AD[26]): Unused */
+	{0,     0,      0,      0,      0 },    /* 17 (AD[27]): Unused */
+	{0,     IRQ4,   IRQ4,   0,      0 },    /* 18 (AD[28]): slot 0 */
+	{0,     0,      0,      0,      0 },    /* 19 (AD[29]): Unused */
+	{0,     IRQ5,   IRQ5,   0,      0 },    /* 20 (AD[30]): slot 1 */
+	{0,     IRQ6,   IRQ6,   0,      0 }     /* 21 (AD[31]): slot 2 */
+};
+
+#elif defined(CONFIG_PMC_MSP7120_EVAL)
+
+/* MSP7120 Eval Board IRQ wiring to PCI slots */
+static char irq_tab[][5] __initdata = {
+	/* INTA    INTB    INTC    INTD */
+	{0,     0,      0,      0,      0 },    /*    (AD[0]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[1]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[2]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[3]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[4]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[5]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[6]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[7]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[8]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[9]): Unused */
+	{0,     0,      0,      0,      0 },    /*  0 (AD[10]): Unused */
+	{0,     0,      0,      0,      0 },    /*  1 (AD[11]): Unused */
+	{0,     0,      0,      0,      0 },    /*  2 (AD[12]): Unused */
+	{0,     0,      0,      0,      0 },    /*  3 (AD[13]): Unused */
+	{0,     0,      0,      0,      0 },    /*  4 (AD[14]): Unused */
+	{0,     0,      0,      0,      0 },    /*  5 (AD[15]): Unused */
+	{0,     IRQ6,   IRQ6,   0,      0 },    /*  6 (AD[16]): slot 3 (mini-PCI) */
+	{0,     IRQ5,   IRQ5,   0,      0 },    /*  7 (AD[17]): slot 2 (mini-PCI) */
+	{0,     IRQ4,   IRQ4,   IRQ4,   IRQ4},  /*  8 (AD[18]): slot 0 (PCI)      */
+	{0,     IRQ5,   IRQ5,   IRQ5,   IRQ5},  /*  9 (AD[19]): slot 1 (PCI)      */
+	{0,     0,      0,      0,      0 },    /* 10 (AD[20]): Unused */
+	{0,     0,      0,      0,      0 },    /* 11 (AD[21]): Unused */
+	{0,     0,      0,      0,      0 },    /* 12 (AD[22]): Unused */
+	{0,     0,      0,      0,      0 },    /* 13 (AD[23]): Unused */
+	{0,     0,      0,      0,      0 },    /* 14 (AD[24]): Unused */
+	{0,     0,      0,      0,      0 },    /* 15 (AD[25]): Unused */
+	{0,     0,      0,      0,      0 },    /* 16 (AD[26]): Unused */
+	{0,     0,      0,      0,      0 },    /* 17 (AD[27]): Unused */
+	{0,     0,      0,      0,      0 },    /* 18 (AD[28]): Unused */
+	{0,     0,      0,      0,      0 },    /* 19 (AD[29]): Unused */
+	{0,     0,      0,      0,      0 },    /* 20 (AD[30]): Unused */
+	{0,     0,      0,      0,      0 }     /* 21 (AD[31]): Unused */
+};
+
+#else
+
+/* Unknown board -- don't assign any IRQs */
+static char irq_tab[][5] __initdata = {
+	/* INTA    INTB    INTC    INTD */
+	{0,     0,      0,      0,      0 },    /*    (AD[0]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[1]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[2]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[3]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[4]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[5]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[6]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[7]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[8]): Unused */
+	{0,     0,      0,      0,      0 },    /*    (AD[9]): Unused */
+	{0,     0,      0,      0,      0 },    /*  0 (AD[10]): Unused */
+	{0,     0,      0,      0,      0 },    /*  1 (AD[11]): Unused */
+	{0,     0,      0,      0,      0 },    /*  2 (AD[12]): Unused */
+	{0,     0,      0,      0,      0 },    /*  3 (AD[13]): Unused */
+	{0,     0,      0,      0,      0 },    /*  4 (AD[14]): Unused */
+	{0,     0,      0,      0,      0 },    /*  5 (AD[15]): Unused */
+	{0,     0,      0,      0,      0 },    /*  6 (AD[16]): Unused */
+	{0,     0,      0,      0,      0 },    /*  7 (AD[17]): Unused */
+	{0,     0,      0,      0,      0 },    /*  8 (AD[18]): Unused */
+	{0,     0,      0,      0,      0 },    /*  9 (AD[19]): Unused */
+	{0,     0,      0,      0,      0 },    /* 10 (AD[20]): Unused */
+	{0,     0,      0,      0,      0 },    /* 11 (AD[21]): Unused */
+	{0,     0,      0,      0,      0 },    /* 12 (AD[22]): Unused */
+	{0,     0,      0,      0,      0 },    /* 13 (AD[23]): Unused */
+	{0,     0,      0,      0,      0 },    /* 14 (AD[24]): Unused */
+	{0,     0,      0,      0,      0 },    /* 15 (AD[25]): Unused */
+	{0,     0,      0,      0,      0 },    /* 16 (AD[26]): Unused */
+	{0,     0,      0,      0,      0 },    /* 17 (AD[27]): Unused */
+	{0,     0,      0,      0,      0 },    /* 18 (AD[28]): Unused */
+	{0,     0,      0,      0,      0 },    /* 19 (AD[29]): Unused */
+	{0,     0,      0,      0,      0 },    /* 20 (AD[30]): Unused */
+	{0,     0,      0,      0,      0 }     /* 21 (AD[31]): Unused */
+};
+#endif
+
+
+/*****************************************************************************
+**
+**  FUNCTION: pcibios_plat_dev_init
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Perform platform specific device initialization at
+**               pci_enable_device() time.
+**               None are needed for the MSP7120 PCI Controller.
+**
+**  INPUTS:      dev     - structure describing the PCI device
+**
+**  OUTPUTS:     none
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL
+**
+*****************************************************************************/
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: pcibios_map_irq
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Perform board supplied PCI IRQ mapping routine.
+**
+**  INPUTS:      dev     - unused
+**               slot    - PCI slot. Identified by which bit of the AD[] bus
+**                         drives the IDSEL line. AD[10] is 0, AD[31] is
+**                         slot 21.
+**               pin     - numbered using the scheme of the PCI_INTERRUPT_PIN
+**                         field of the config header.
+**
+**  OUTPUTS:     none
+**
+**  RETURNS:     IRQ number 
+**
+*****************************************************************************/
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+#if !defined(CONFIG_PMC_MSP7120_GW) && !defined(CONFIG_PMC_MSP7120_EVAL)
+	printk(KERN_WARNING "PCI: unknown board, no PCI IRQs assigned.\n");
+#endif
+	printk(KERN_WARNING "PCI: irq_tab returned %d for slot=%d pin=%d\n", irq_tab[slot][pin], slot, pin);
+
+	return irq_tab[slot][pin];
+}
+
+
+#endif	/* CONFIG_PCI */
+
diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
new file mode 100644
index 0000000..6734db4
--- /dev/null
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -0,0 +1,1007 @@
+/* $Id$ */
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ * arch/mips/pci/ops-pmcmsp.c
+ *     Define the pci_ops for PMC MSP PCI.
+ *
+ * Much of the code is derived from the original DDB5074 port by 
+ * Geert Uytterhoeven <geert@sonycom.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#define PCI_COUNTERS 1
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+
+#if defined(CONFIG_PROC_FS) && defined(PCI_COUNTERS)
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#endif /* CONFIG_PROC_FS && PCI_COUNTERS */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm-mips/pmc-sierra/msp71xx/msp_prom.h>
+#include <asm-mips/pmc-sierra/msp71xx/msp_cic_int.h>
+#include <asm-mips/pmc-sierra/msp71xx/msp_pci.h>
+#include <asm-mips/pmc-sierra/msp71xx/msp_regs.h>
+#include <asm/byteorder.h>
+
+#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+#include <asm-mips/mipsmtregs.h>
+#endif
+
+
+#define PCI_ACCESS_READ		0
+#define PCI_ACCESS_WRITE	1
+
+
+#if defined(CONFIG_PROC_FS) && defined(PCI_COUNTERS)
+static char proc_init;
+extern struct proc_dir_entry *proc_bus_pci_dir;
+unsigned int pci_int_count[32];
+
+static void pci_proc_init(void);
+
+/*****************************************************************************
+**
+**  FUNCTION: read_msp_pci_counts
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Prints the count of how many times each PCI
+**               interrupt has asserted. Can be invoked by the
+**               /proc filesystem.
+**
+**  INPUTS:      page    - part of STDOUT calculation
+**               off     - part of STDOUT calculation
+**               count   - part of STDOUT calculation
+**               data    - unused
+**
+**  OUTPUTS:     start   - new start location
+**               eof     - end of file pointer
+**
+**  RETURNS:     len     - STDOUT length
+**
+*****************************************************************************/
+static int read_msp_pci_counts(char *page, char **start, off_t off,
+								int count, int *eof, void *data)
+{
+	int i;
+	int len = 0;
+	unsigned int intcount, total = 0;
+
+	for (i = 0; i < 32; ++i) {
+		intcount = pci_int_count[i];
+		if (intcount != 0) {
+			len += sprintf(page + len, "[%d] = %u\n", i, intcount);
+			total += intcount;
+		}
+	}
+	
+	len += sprintf(page + len, "total = %u\n", total);
+	if (len <= off+count)
+		*eof = 1;
+		
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+		
+	return len;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: gen_pci_cfg_wr
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Generates a configuration write cycle for debug purposes.
+**               The IDSEL line asserted and location and data written are
+**               immaterial. Just want to be able to prove that a 
+**               configuration write can be correctly generated on the 
+**               PCI bus.  Intent is that this function by invocable from
+**               the /proc filesystem.
+**
+**  INPUTS:      page    - part of STDOUT calculation
+**               off     - part of STDOUT calculation
+**               count   - part of STDOUT calculation
+**               data    - unused
+**
+**  OUTPUTS:     start   - new start location
+**               eof     - end of file pointer
+**
+**  RETURNS:     len     - STDOUT length
+**
+*****************************************************************************/
+static int gen_pci_cfg_wr(char *page, char **start, off_t off,
+							int count, int *eof, void *data)
+{
+	unsigned char where	= 0;	/* Write to static Device/Vendor ID */
+	unsigned char bus_num = 0;	/* Bus 0 */
+	unsigned char dev_fn = 0xF; /* Arbitrary device number */
+	u32			wr_data = 0xFF00AA00; /* Arbitrary data */
+	mspPciRegs	*preg	= (void *)PCI_BASE_REG;
+	int			len	 = 0;
+	unsigned long value;
+	volatile unsigned long *pcispace = (void *)PCI_CONFIG_SPACE_REG;
+	int			intr;
+	
+	len += sprintf(page + len, "PMC MSP PCI: Beginning\n");
+
+	if (proc_init == 0) {
+		pci_proc_init();
+		proc_init = ~0;
+	}
+ 
+	len += sprintf(page + len, "PMC MSP PCI: Before Cfg Wr\n");
+ 
+	/*
+	 * Generate PCI Configuration Write Cycle 
+	 */
+	
+	/* Clear cause register bits */
+	preg->if_status = ~(BPCI_IFSTATUS_BC0F | BPCI_IFSTATUS_BC1F);
+ 
+	/* Setup address that is to appear on PCI bus */
+	preg->config_addr = BPCI_CFGADDR_ENABLE |
+		(bus_num << BPCI_CFGADDR_BUSNUM_SHF) |
+		(dev_fn << BPCI_CFGADDR_FUNCTNUM_SHF) |
+		(where & 0xFC);
+
+	value = cpu_to_le32(wr_data);
+
+	/* Launch the PCI configuration write cycle */
+	*pcispace = value;
+
+
+	/* 
+	 * Check if the PCI configuration cycle (rd or wr) succeeded, by
+	 * checking the status bits for errors like master or target abort.
+	 */
+	intr = preg->if_status;
+
+	len += sprintf(page + len, "PMC MSP PCI: After Cfg Wr\n");
+
+	/* Handle STDOUT calculations */
+	if (len <= off+count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+	
+	return len;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: pci_proc_init
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Create entries in the /proc filesystem for debug access.
+**
+**  INPUTS:      none
+**
+**  OUTPUTS:     none
+**
+**  RETURNS:     none
+**
+*****************************************************************************/
+static void pci_proc_init(void)
+{
+	create_proc_read_entry("pmc_msp_pci_rd_cnt", 0, NULL,
+							read_msp_pci_counts, NULL);
+	create_proc_read_entry("pmc_msp_pci_cfg_wr", 0, NULL,
+							gen_pci_cfg_wr, NULL);
+}
+#endif /* CONFIG_PROC_FS && PCI_COUNTERS */
+
+
+spinlock_t bpci_lock = SPIN_LOCK_UNLOCKED;
+
+
+/*****************************************************************************
+**
+**  STRUCT: pci_io_resource
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Defines the address range that pciauto() will use to
+**               assign to the I/O BARs of PCI devices.
+**
+**               Use the start and end addresses of the MSP7120 PCI Host
+**               Controller I/O space, in the form that they appear on the
+**               PCI bus AFTER MSP7120 has performed address translation.
+**
+**               For I/O accesses, MSP7120 ignores OATRAN and maps I/O
+**               accesses into the bottom 0xFFF region of address space,
+**               so that is the range to put into the pci_io_resource
+**               struct.
+**
+**               In MSP4200, the start address was 0x04 instead of the expected
+**               0x00. Will just assume there was a good reason for this!
+**
+**  NOTES:       Linux, by default, will assign I/O space to the lowest
+**               region of address space. Since MSP7120 and Linux,
+**               by default, have no offset in between how they map, the
+**               io_offset element of pci_controller struct should be set
+**               to zero.
+**  ELEMENTS:
+**    name       - String used for a meaningful name.
+**
+**    start      - Start address of MSP7120's I/O space, as MSP7120 presents
+**                 the address on the PCI bus.
+**
+**    end        - End address of MSP7120's I/O space, as MSP7120 presents
+**                 the address on the PCI bus.
+**
+**    flags      - Attributes indicating the type of resource. In this case,
+**                 indicate I/O space.
+**
+*****************************************************************************/
+static struct resource pci_io_resource = {
+	.name	= "pci IO space", 
+	.start	= 0x04,
+	.end	= 0x0FFF,
+	.flags	= IORESOURCE_IO	/* I/O space */
+};
+
+
+/*****************************************************************************
+**
+**  STRUCT: pci_mem_resource
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Defines the address range that pciauto() will use to
+**               assign to the memory BARs of PCI devices.
+**
+**               The .start and .end values are dependent upon how address
+**               translation is performed by the OATRAN regiser.
+**
+**               The values to use for .start and .end are the values
+**               in the form they appear on the PCI bus AFTER MSP7120 has
+**               performed OATRAN address translation.
+**
+**  ELEMENTS:
+**    name       - String used for a meaningful name.
+**
+**    start      - Start address of MSP7120's memory space, as MSP7120 presents
+**                 the address on the PCI bus.
+**
+**    end        - End address of MSP7120's memory space, as MSP7120 presents
+**                 the address on the PCI bus.
+**
+**    flags      - Attributes indicating the type of resource. In this case,
+**                 indicate memory space.
+**
+*****************************************************************************/
+static struct resource pci_mem_resource = {
+	.name	= "pci memory space", 
+	.start	= MSP_PCI_SPACE_BASE,
+	.end	= MSP_PCI_SPACE_END,
+	.flags	= IORESOURCE_MEM	 /* memory space */
+};
+
+
+/*****************************************************************************
+**
+**  FUNCTION: bpci_interrupt
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: PCI status interrupt handler. Updates the count of how
+**               many times each status bit has been set, then clears
+**               the status bits. If the appropriate macros are defined,
+**               these counts can be viewed via the /proc filesystem.
+**
+**  INPUTS:      irq     - unused
+**               dev_id  - unused
+**               pt_regs - unused 
+**
+**  OUTPUTS:     none
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL  - success
+**
+*****************************************************************************/
+static int bpci_interrupt(int irq, void *dev_id)
+{
+	mspPciRegs *preg = (void *)PCI_BASE_REG;
+	unsigned int stat = preg->if_status;
+
+#if defined(CONFIG_PROC_FS) && defined(PCI_COUNTERS)
+	int i;
+	for (i = 0; i < 32; ++i) {
+		if ((1 << i) & stat)
+			++pci_int_count[i];
+	}
+#endif /* PROC_FS && PCI_COUNTERS */
+
+	/* printk("PCI ISR: Status=%08X\n", stat); */
+
+	/* write to clear all asserted interrupts */
+	preg->if_status = stat;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_config_access
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Performs a PCI configuration access (rd or wr), then
+**               checks that the access succeeded by querying MSP7120's
+**               PCI status bits.
+**
+**  INPUTS:
+**               access_type  - kind of PCI configuration cycle to perform
+**                              (read or write). Legal values are 
+**                              PCI_ACCESS_WRITE and PCI_ACCESS_READ.
+**
+**               bus          - pointer to the bus number of the device to
+**                              be targetted for the configuration cycle.
+**                              The only element of the pci_bus structure
+**                              used is bus->number. This argument determines
+**                              if the configuration access will be Type 0 or
+**                              Type 1. Since MSP7120 assumes itself to be the
+**                              PCI Host, any non-zero bus->number generates
+**                              a Type 1 access.
+**
+**               devfn        - this is an 8-bit field. The lower three bits
+**                              specify the function number of the device to 
+**                              be targetted for the configuration cycle, with
+**                              all three-bit combinations being legal. The
+**                              upper five bits specify the device number,
+**                              with legal values being 10 to 31.
+**
+**               where        - address within the Configuration Header 
+**                              space to access.
+**
+**               data         - for write accesses, contains the data to
+**                              write. 
+**
+**  OUTPUTS:     
+**               data         - for read accesses, contains the value read.
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL  - success
+**               -1                  - access failure
+**
+*****************************************************************************/
+int msp_pcibios_config_access(unsigned char	access_type,
+								struct pci_bus *bus,
+								unsigned int	devfn,
+								unsigned char	where,
+								u32			 	*data)
+{
+	volatile unsigned long *pcispace = (void *)PCI_CONFIG_SPACE_REG;
+	mspPciRegs *preg				= (void *)PCI_BASE_REG;
+	unsigned char bus_num			= bus->number;
+	unsigned char dev_fn			= (unsigned char)devfn;
+	unsigned long flags;
+	unsigned long intr;
+	unsigned long value;
+	static char pciirqflag;
+#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+	unsigned int	vpe_status;
+#endif
+
+#if defined(CONFIG_PROC_FS) && defined(PCI_COUNTERS)
+	if (proc_init == 0) {
+		pci_proc_init();
+		proc_init = ~0;
+	}
+#endif /* CONFIG_PROC_FS && PCI_COUNTERS */
+
+	/*
+	 * Just the first time this function invokes, allocate
+	 * an interrupt line for PCI host status interrupts. The
+	 * allocation assigns an interrupt handler to the interrupt.
+	 */
+	if (pciirqflag == 0) {
+		request_irq(MSP_INT_PCI,		/* Hardcoded internal MSP7120 wiring */
+					bpci_interrupt,	/* Function to call when the IRQ occurs */
+					SA_SHIRQ | SA_INTERRUPT, /* Bit mask interrupt type flags */
+					"PMC MSP PCI Host", /* An ascii name for the claiming device */
+					preg);				/* PCI Device ID from Config Header reg */
+		pciirqflag = ~0;
+	}
+
+#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+	local_irq_save(flags);
+	vpe_status = dvpe(); 
+#else
+	spin_lock_irqsave(&bpci_lock, flags);
+#endif
+
+	/*
+	 * Clear PCI cause register bits.
+	 *
+	 * In Polo, the PCI Host had a dedicated DMA called the 
+	 * Block Copy (not to be confused with the general purpose Block
+	 * Copy Engine block). There appear to have been special interrupts
+	 * for this Block Copy, called Block Copy 0 Fault (BC0F) and Block Copy 1
+	 * Fault (BC1F). MSP4200 and MSP7120 don't have this dedicated Block Copy
+	 * block, so these two interrupts are now marked reserved. In case the 
+	 * Block Copy is resurrected in a future design, maintain the code that
+	 * treats these two interrupts specially.
+	 *
+	 * Write to clear all interrupts in the PCI status register, aside from
+	 * BC0F and BC1F.
+	 */
+	preg->if_status = ~(BPCI_IFSTATUS_BC0F | BPCI_IFSTATUS_BC1F);
+
+	/* Setup address that is to appear on PCI bus */
+	preg->config_addr = BPCI_CFGADDR_ENABLE	|
+		(bus_num << BPCI_CFGADDR_BUSNUM_SHF) |
+		(dev_fn << BPCI_CFGADDR_FUNCTNUM_SHF) |
+		(where & 0xFC);
+
+	/* IF access is a PCI configuration write */
+	if (access_type == PCI_ACCESS_WRITE) {
+		value = cpu_to_le32(*data);
+		*pcispace = value;
+	} else {
+		/* ELSE access is a PCI configuration read */
+		value = le32_to_cpu(*pcispace);
+		*data = value;
+	}
+
+	/* 
+	 * Check if the PCI configuration cycle (rd or wr) succeeded, by
+	 * checking the status bits for errors like master or target abort.
+	 */
+	intr = preg->if_status;
+
+	/* Clear config access */
+	preg->config_addr = 0;
+
+	/* IF error occurred */
+	if (intr & ~(BPCI_IFSTATUS_BC0F | BPCI_IFSTATUS_BC1F)) {
+		/* Clear status bits */
+		preg->if_status = ~(BPCI_IFSTATUS_BC0F | BPCI_IFSTATUS_BC1F);
+
+#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+		evpe(vpe_status);
+		local_irq_restore(flags);
+#else
+		spin_unlock_irqrestore(&bpci_lock, flags);
+#endif
+
+		return -1;
+	}
+
+#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+	evpe(vpe_status);
+	local_irq_restore(flags);
+#else
+	spin_unlock_irqrestore(&bpci_lock, flags);
+#endif
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_read_config_byte
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Read a byte from PCI configuration address spac	*               Since the hardware can't address 8 bit chunks
+**               directly, read a 32-bit chunk, then mask off extraneous
+**               bits. 
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus
+**                        that the read is destined for.
+**               devfn  - device/function combination that the read is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**
+**  OUTPUTS      val    - read data
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL  - success
+**               -1                  - read access failure
+**
+*****************************************************************************/
+static int
+msp_pcibios_read_config_byte(struct pci_bus *bus,
+							 unsigned int	devfn,
+							 int			 where,
+							 u32			 *val)
+{
+	u32 data = 0;
+
+	/* 
+	 * If the config access did not complete normally (e.g., underwent master
+	 * abort) do the PCI compliant thing, which is to supply an all ones value.
+	 */
+	if (msp_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data)) {
+		*val = 0xFFFFFFFF;
+		return -1;
+	}
+
+	*val = (data >> ((where & 3) << 3)) & 0x0ff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_read_config_word
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Read a word (16 bits) from PCI configuration address space.	
+**               Since the hardware can't address 16 bit chunks
+**               directly, read a 32-bit chunk, then mask off extraneous
+**               bits.
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus
+**                        that the read is destined for.
+**               devfn  - device/function combination that the read is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**
+**  OUTPUTS      val    - read data
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL           - success
+**               PCIBIOS_BAD_REGISTER_NUMBER  - bad register address
+**               -1                           - read access failure
+**
+*****************************************************************************/
+static int 
+msp_pcibios_read_config_word(struct pci_bus *bus,
+							 unsigned int	devfn,
+							 int			 where,
+							 u32			 *val)
+{
+	u32 data = 0;
+
+	/* if (where & 1) */	/* Michael Penner, Nov 24, 2005 commented out
+							 * non-compliant code. Should allow word access
+							 * to configuration registers, with only exception
+							 * being when the word access would wrap around
+							 * into the next dword.
+							 */
+	if ((where & 3) == 3) {
+		*val = 0xFFFFFFFF;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	/* 
+	 * If the config access did not complete normally (e.g., underwent master
+	 * abort) do the PCI compliant thing, which is to supply an all ones value.
+	 */
+	if (msp_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data)) {
+		*val = 0xFFFFFFFF;
+		return -1;
+	}
+
+	*val = (data >> ((where & 3) << 3)) & 0x0ffff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_read_config_dword
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Read a double word (32 bits) from PCI configuration
+**               address space.
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus
+**                        that the read is destined for.
+**               devfn  - device/function combination that the read is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**
+**  OUTPUTS      val    - read data
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL           - success
+**               PCIBIOS_BAD_REGISTER_NUMBER  - bad register address
+**               -1                           - read access failure
+**
+*****************************************************************************/
+static int
+msp_pcibios_read_config_dword(struct pci_bus *bus,
+								unsigned int	devfn,
+								int			 where,
+								u32			 *val)
+{
+	u32 data = 0;
+
+	/* 
+	 * Address must be dword aligned.
+	 */
+	if (where & 3) {
+		*val = 0xFFFFFFFF;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	/* 
+	 * If the config access did not complete normally (e.g., underwent master
+	 * abort) do the PCI compliant thing, which is to supply an all ones value.
+	 */
+	if (msp_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data)) {
+		*val = 0xFFFFFFFF;
+		return -1;
+	}
+
+	*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_write_config_byte
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Write a byte to PCI configuration address space.
+**               Since the hardware can't address 8 bit chunks
+**               directly, a read-modify-write is performed.
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus
+**                        that the write is destined for.
+**               devfn  - device/function combination that the write is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**               val    - value to write
+**
+**  OUTPUTS      none
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL  - success
+**               -1                  - write access failure
+**
+*****************************************************************************/
+static int
+msp_pcibios_write_config_byte(struct pci_bus *bus,
+								unsigned int devfn,
+								int			 where, 
+								u8			 val)
+{
+	u32 data = 0;
+	
+	/* read config space */
+	if (msp_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
+		return -1;
+
+	/* modify the byte within the dword */
+	data = (data & ~(0xff << ((where & 3) << 3))) |
+			(val << ((where & 3) << 3));
+
+	/* write back the full dword */
+	if (msp_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_write_config_word
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Write a word (16-bits) to PCI configuration address space.
+**               Since the hardware can't address 16 bit chunks
+**               directly, a read-modify-write is performed.
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus
+**                        that the write is destined for.
+**               devfn  - device/function combination that the write is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**               val    - value to write
+**
+**  OUTPUTS      none
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL           - success
+**               PCIBIOS_BAD_REGISTER_NUMBER  - bad register address
+**               -1                           - write access failure
+**
+*****************************************************************************/
+static int
+msp_pcibios_write_config_word(struct pci_bus *bus,
+								unsigned int devfn,
+								int			 where, 
+								u16			 val)
+{
+	u32 data = 0;
+
+	/* MBGP Nov 24, 2005, fixed non-compliance: if (where & 1) */
+	if ((where & 3) == 3)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	/* read config space */
+	if (msp_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
+		return -1;
+ 
+	/* modify the word within the dword */
+	data = (data & ~(0xffff << ((where & 3) << 3))) | 
+			(val << ((where & 3) << 3));
+
+	/* write back the full dword */
+	if (msp_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_write_config_dword
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Write a double word (32-bits) to PCI configuration address
+**               space.
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus 
+**                        that the write is destined for.
+**               devfn  - device/function combination that the write is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**               val    - value to write
+**
+**  OUTPUTS      none
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL           - success
+**               PCIBIOS_BAD_REGISTER_NUMBER  - bad register address
+**               -1                           - write access failure
+**
+*****************************************************************************/
+static int
+msp_pcibios_write_config_dword(struct pci_bus *bus,
+								unsigned int	devfn,
+								int			 where,
+								u32			 val)
+{
+	/* check that address is dword aligned */
+	if (where & 3)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	/* perform write */
+	if (msp_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where, &val))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_read_config
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Interface the PCI configuration read request with
+**               the appropriate function, based on how many bytes
+**               the read request is.
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus 
+**                        that the write is destined for.
+**               devfn  - device/function combination that the write is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**               size   - in units of bytes, should be 1, 2, or 4.
+**
+**  OUTPUTS      val    - value read, with any extraneous bytes masked
+**                        to zero.
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL   - success
+**               -1                   - failure
+**
+*****************************************************************************/
+int
+msp_pcibios_read_config(struct pci_bus *bus,
+						unsigned int	devfn,
+						int			 where,
+						int			 size,
+						u32			*val)
+{
+	if (size == 1) {
+		if (msp_pcibios_read_config_byte(bus, devfn, where, val)) {
+			return -1;
+		}
+	} else if (size == 2) {
+		if (msp_pcibios_read_config_word(bus, devfn, where, val)) {
+			return -1;
+		}
+	} else if (size == 4) {
+		if (msp_pcibios_read_config_dword(bus, devfn, where, val)) {
+			return -1;
+		}
+	} else {
+		*val = 0xFFFFFFFF;
+		return -1;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pcibios_write_config
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Interface the PCI configuration write request with
+**               the appropriate function, based on how many bytes
+**               the read request is.
+**
+**  INPUTS       bus    - structure containing attributes for the PCI bus 
+**                        that the write is destined for.
+**               devfn  - device/function combination that the write is
+**                        destined for.
+**               where  - register within the Configuration Header space
+**                        to access.
+**               size   - in units of bytes, should be 1, 2, or 4.
+**               val    - value to write
+**
+**  OUTPUTS:     none
+**
+**  RETURNS:     PCIBIOS_SUCCESSFUL   - success
+**               -1                   - failure
+**
+*****************************************************************************/
+int
+msp_pcibios_write_config(struct pci_bus *bus, 
+						 unsigned int	devfn,
+						 int			 where, 
+						 int			 size,
+						 u32			 val)
+{
+	if (size == 1) {
+		if (msp_pcibios_write_config_byte(bus, devfn, where, (u8)(0xFF & val))) {
+			return -1;
+		}
+	} else if (size == 2) {
+		if (msp_pcibios_write_config_word(bus, devfn, where, (u16)(0xFFFF & val))) {
+			return -1;
+		}
+	} else if (size == 4) {
+		if (msp_pcibios_write_config_dword(bus, devfn, where, val)) {
+			return -1;
+		}
+	} else {
+		return -1;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+/*****************************************************************************
+**
+**  STRUCTURE: msp_pci_ops
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: structure to abstract the hardware specific PCI
+**               configuration accesses.
+**
+**  ELEMENTS:
+**    read      - function for Linux to generate PCI Configuration reads.
+**    write     - function for Linux to generate PCI Configuration writes.
+**
+*****************************************************************************/
+struct pci_ops msp_pci_ops = {
+	.read = msp_pcibios_read_config,
+	.write = msp_pcibios_write_config
+};
+
+
+/*****************************************************************************
+**
+**  STRUCTURE: msp_pci_controller
+**  _________________________________________________________________________
+**
+**  Describes the attributes of the MSP7120 PCI Host Controller
+**               
+**  ELEMENTS:
+**    pci_ops      - abstracts the hardware specific PCI configuration
+**                   accesses.
+**
+**    mem_resource - address range pciauto() uses to assign to PCI device
+**                   memory BARs.
+**    
+**    mem_offset   - offset between how MSP7120 outbound PCI memory
+**                   transaction addresses appear on the PCI bus and how Linux
+**                   wants to configure memory BARs of the PCI devices.
+**                   MSP7120 does nothing funky, so just set to zero.
+**
+**    io_resource  - address range pciauto() uses to assign to PCI device
+**                   I/O BARs.
+**
+**    io_offset    - offset between how MSP7120 outbound PCI I/O
+**                   transaction addresses appear on the PCI bus and how
+**                   Linux defaults to configure I/O BARs of the PCI devices.
+**                   MSP7120 maps outbound I/O accesses into the bottom
+**                   bottom 4K of PCI address space (and ignores OATRAN). 
+**                   Since the Linux default is to configure I/O BARs to the
+**                   bottom 4K, no special offset is needed. Just set to zero.
+**
+*****************************************************************************/
+static struct pci_controller msp_pci_controller = {
+	.pci_ops		= &msp_pci_ops,
+	.mem_resource	= &pci_mem_resource,
+	.mem_offset	 	= 0,
+	.io_resource	= &pci_io_resource,
+	.io_offset		= 0
+};
+
+
+/*****************************************************************************
+**
+**  FUNCTION: msp_pci_init
+**  _________________________________________________________________________
+**
+**  DESCRIPTION: Initialize the PCI Host Controller and register it with
+**               Linux so Linux can seize control of the PCI bus.
+**
+*****************************************************************************/
+void __init msp_pci_init(void)
+{
+	mspPciRegs *preg = (void *)PCI_BASE_REG;
+	u32 id;
+
+	/* Extract Device ID */
+	id = (MSP_PCI_READ_REG32(PCI_JTAG_DEVID_REG, 0) >> 12) & 0x0FFFF;
+ 
+	/*
+	 * Check if JTAG ID identifies MSP7120 
+	 */
+	if (!MSP_HAS_PCI(id)) {
+		printk("PCI: No PCI; id reads as %x\n", id);
+		goto no_pci;
+	}
+ 
+	/*
+	* Enable flushing of the PCI-SDRAM queue upon a read
+	* of the SDRAM's Memory Configuration Register.
+	*/
+	*(unsigned long *)QFLUSH_REG_1 = 3;
+
+	/*
+	 * Configure PCI Host Controller.
+	 */
+	preg->if_status	= ~0;			 /* Clear cause register bits		*/ 
+	preg->config_addr = 0;			/* Clear config access				*/
+	preg->oatran	= MSP_PCI_OATRAN; /* PCI outbound addr translation	*/
+	preg->if_mask	= 0xF8BF87C0;	 /* Enable all PCI status interrupts */
+
+	/* configure so inb(), outb(), and family are functional */
+	set_io_port_base(MSP_PCI_IOSPACE_BASE);
+	
+	/* Tell Linux the details of the MSP7120 PCI Host Controller */
+	register_pci_controller(&msp_pci_controller);
+
+	return;
+
+no_pci:
+	/* Disable PCI channel */
+	printk("PCI: no host PCI bus detected\n");
+	return;
+}
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_pci.c b/arch/mips/pmc-sierra/msp71xx/msp_pci.c
new file mode 100644
index 0000000..664e643
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_pci.c
@@ -0,0 +1,49 @@
+/*
+ * The setup file for PCI related hardware on PMC-Sierra MSP processors.
+ *
+ * Copyright 2005 PMC-Sierra, Inc.
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
+ */
+
+#include <linux/init.h>
+
+#include <msp_prom.h>
+#include <msp_regs.h>
+
+extern void msp_pci_init(void);
+
+static int __init msp_pci_setup(void)
+{
+#if 0 /* Linux 2.6 initialization code to be completed */
+	if (getdeviceid() & DEV_ID_SINGLE_PC) {	/* If single card mode */
+		slmRegs	*sreg = (slmRegs *) SREG_BASE;
+
+		sreg->single_pc_enable = SINGLE_PCCARD;
+	}
+#endif
+
+	msp_pci_init();
+
+	return 0;
+}
+
+subsys_initcall(msp_pci_setup);
diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_pci.h b/include/asm-mips/pmc-sierra/msp71xx/msp_pci.h
new file mode 100644
index 0000000..571c7a5
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_pci.h
@@ -0,0 +1,207 @@
+/******************************************************************
+ * Copyright (c) 2000-2006 PMC-Sierra INC.
+ *
+ *     This program is free software; you can redistribute it
+ *     and/or modify it under the terms of the GNU General
+ *     Public License as published by the Free Software
+ *     Foundation; either version 2 of the License, or (at your
+ *     option) any later version.
+ *
+ *     This program is distributed in the hope that it will be
+ *     useful, but WITHOUT ANY WARRANTY; without even the implied
+ *     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ *     PURPOSE.  See the GNU General Public License for more
+ *     details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this program; if not, write to the Free
+ *     Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
+ *     02139, USA.
+ *
+ * PMC-SIERRA INC. DISCLAIMS ANY LIABILITY OF ANY KIND
+ * FOR ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS
+ * SOFTWARE.
+ */
+
+
+#ifndef _MSP_PCI_H_
+#define _MSP_PCI_H_
+
+#define MSP_HAS_PCI(ID) (((u32)(ID) <= (0x4236)) && \
+                               ((u32)(ID) >= (0x4220)))
+
+/*
+ * It is convenient to program the OATRAN register so that
+ * Athena virtual address space and PCI address space are
+ * the same. This is not a requirement, just a convenience.
+ *
+ * The only hard restrictions on the value of OATRAN is that
+ * OATRAN must not be programmed to allow translated memory
+ * addresses to fall within the lowest 512MB of
+ * PCI address space. This region is hardcoded
+ * for use as Athena PCI Host Controller target
+ * access memory space to the Athena's SDRAM.
+ *
+ * Note that OATRAN applies only to memory accesses, not
+ * to I/O accesses.
+ *
+ * To program OATRAN to make Athena virtual address space
+ * and PCI address space have the same values, OATRAN
+ * is to be programmed to 0xB8000000. The top seven
+ * bits of the value mimic the seven bits clipped off
+ * by the PCI Host controller.
+ * 
+ * With OATRAN at the said value, when the CPU does
+ * an access to its virtual address at, say 0xB900_5000,
+ * the address appearing on the PCI bus will be
+ * 0xB900_5000.
+ *    - Michael Penner
+ */
+#define  MSP_PCI_OATRAN       0xB8000000UL
+
+#define  MSP_PCI_SPACE_BASE   (MSP_PCI_OATRAN + 0x1002000UL)
+#define  MSP_PCI_SPACE_SIZE   (0x3000000UL - 0x2000)
+#define  MSP_PCI_SPACE_END    (MSP_PCI_SPACE_BASE + MSP_PCI_SPACE_SIZE - 1)
+#define  MSP_PCI_IOSPACE_BASE (MSP_PCI_OATRAN + 0x1001000UL)
+#define  MSP_PCI_IOSPACE_SIZE (0x1000)
+#define  MSP_PCI_IOSPACE_END  (MSP_PCI_IOSPACE_BASE + MSP_PCI_IOSPACE_SIZE - 1)
+
+/* IRQ for PCI status interrupts */
+#define PCI_STAT_IRQ 20
+
+#define  QFLUSH_REG_1   0xB7F40000
+
+typedef volatile unsigned int pcireg;
+typedef void * volatile ppcireg;
+
+typedef struct blockCopy_st
+{
+    pcireg   unused1; /* +0x00 */
+    pcireg   unused2; /* +0x04 */
+    ppcireg  unused3; /* +0x08 */
+    ppcireg  unused4; /* +0x0C */
+    pcireg   unused5; /* +0x10 */
+    pcireg   unused6; /* +0x14 */
+    pcireg   unused7; /* +0x18 */
+    ppcireg  unused8; /* +0x1C */
+    ppcireg  unused9; /* +0x20 */
+    pcireg   unusedA; /* +0x24 */
+    ppcireg  unusedB; /* +0x28 */
+    ppcireg  unusedC; /* +0x2C */
+} pciBlockCopy;
+
+enum
+{
+    config_device_vendor,  /* 0 */
+    config_status_command, /* 1 */
+    config_class_revision, /* 2 */
+    config_BIST_header_latency_cache, /* 3 */
+    config_BAR0,           /* 4 */
+    config_BAR1,           /* 5 */
+    config_BAR2,           /* 6 */
+    config_not_used7,      /* 7 */
+    config_not_used8,      /* 8 */
+    config_not_used9,      /* 9 */
+    config_CIS,            /* 10 */
+    config_subsystem,      /* 11 */
+    config_not_used12,     /* 12 */
+    config_capabilities,   /* 13 */
+    config_not_used14,     /* 14 */
+    config_lat_grant_irq,  /* 15 */
+    config_message_control,/* 16 */
+    config_message_addr,   /* 17 */
+    config_message_data,   /* 18 */
+    config_VPD_addr,       /* 19 */
+    config_VPD_data,       /* 20 */
+    config_maxregs         /* 21 - number of registers */
+};
+    
+typedef struct mspPci_st
+{
+    pcireg hop_unused_00; /* +0x00 */
+    pcireg hop_unused_04; /* +0x04 */
+    pcireg hop_unused_08; /* +0x08 */
+    pcireg hop_unused_0C; /* +0x0C */
+    pcireg hop_unused_10; /* +0x10 */
+    pcireg hop_unused_14; /* +0x14 */
+    pcireg hop_unused_18; /* +0x18 */
+    pcireg hop_unused_1C; /* +0x1C */
+    pcireg hop_unused_20; /* +0x20 */
+    pcireg hop_unused_24; /* +0x24 */
+    pcireg hop_unused_28; /* +0x28 */
+    pcireg hop_unused_2C; /* +0x2C */
+    pcireg hop_unused_30; /* +0x30 */
+    pcireg hop_unused_34; /* +0x34 */
+    pcireg if_control;    /* +0x38 */
+    pcireg oatran;        /* +0x3C */
+    pcireg reset_ctl;     /* +0x40 */
+    pcireg config_addr;   /* +0x44 */
+    pcireg hop_unused_48; /* +0x48 */
+    pcireg msg_signaled_int_status; /* +0x4C */
+    pcireg msg_signaled_int_mask;   /* +0x50 */
+    pcireg if_status;     /* +0x54 */
+    pcireg if_mask;       /* +0x58 */
+    pcireg hop_unused_5C; /* +0x5C */
+    pcireg hop_unused_60; /* +0x60 */
+    pcireg hop_unused_64; /* +0x64 */
+    pcireg hop_unused_68; /* +0x68 */
+    pcireg hop_unused_6C; /* +0x6C */
+    pcireg hop_unused_70; /* +0x70 */
+
+    pciBlockCopy pci_bc[2] __attribute__((aligned(64)));
+
+    pcireg error_hdr1; /* +0xE0 */
+    pcireg error_hdr2; /* +0xE4 */
+
+    pcireg config[config_maxregs] __attribute__((aligned(256)));
+
+} mspPciRegs;
+
+
+#define BPCI_CFGADDR_BUSNUM_SHF 16
+#define BPCI_CFGADDR_FUNCTNUM_SHF 8
+#define BPCI_CFGADDR_REGNUM_SHF 2
+#define BPCI_CFGADDR_ENABLE (1<<31)
+
+#define BPCI_IFCONTROL_RTO (1<<20) /* Retry timeout */
+#define BPCI_IFCONTROL_HCE (1<<16) /* Host configuration enable */
+#define BPCI_IFCONTROL_CTO_SHF 12  /* Shift count for CTO bits */
+#define BPCI_IFCONTROL_SE  (1<<5)  /* Enable exceptions on errors */
+#define BPCI_IFCONTROL_BIST (1<<4) /* Use BIST in per. mode */
+#define BPCI_IFCONTROL_CAP (1<<3)  /* Enable capabilities */
+#define BPCI_IFCONTROL_MMC_SHF 0   /* Shift count for MMC bits */
+
+#define BPCI_IFSTATUS_MGT  (1<<8)  /* Master Grant timeout */
+#define BPCI_IFSTATUS_MTT  (1<<9)  /* Master TRDY timeout */
+#define BPCI_IFSTATUS_MRT  (1<<10) /* Master retry timeout */
+#define BPCI_IFSTATUS_BC0F (1<<13) /* Block copy 0 fault */
+#define BPCI_IFSTATUS_BC1F (1<<14) /* Block copy 1 fault */
+#define BPCI_IFSTATUS_PCIU (1<<15) /* PCI unable to respond */
+#define BPCI_IFSTATUS_BSIZ (1<<16) /* PCI access with illegal size */
+#define BPCI_IFSTATUS_BADD (1<<17) /* PCI access with illegal addr */
+#define BPCI_IFSTATUS_RTO  (1<<18) /* Retry time out */
+#define BPCI_IFSTATUS_SER  (1<<19) /* System error */
+#define BPCI_IFSTATUS_PER  (1<<20) /* Parity error */
+#define BPCI_IFSTATUS_LCA  (1<<21) /* Local CPU abort */
+#define BPCI_IFSTATUS_MEM  (1<<22) /* Memory prot. violation */
+#define BPCI_IFSTATUS_ARB  (1<<23) /* Arbiter timed out */
+#define BPCI_IFSTATUS_STA  (1<<27) /* Signaled target abort */
+#define BPCI_IFSTATUS_TA   (1<<28) /* Target abort */
+#define BPCI_IFSTATUS_MA   (1<<29) /* Master abort */
+#define BPCI_IFSTATUS_PEI  (1<<30) /* Parity error as initiator */
+#define BPCI_IFSTATUS_PET  (1<<31) /* Parity error as target */
+
+#define BPCI_RESETCTL_PR (1<<0)    /* True if reset asserted */
+#define BPCI_RESETCTL_RT (1<<4)    /* Release time */
+#define BPCI_RESETCTL_CT (1<<8)    /* Config time */
+#define BPCI_RESETCTL_PE (1<<12)   /* PCI enabled */
+#define BPCI_RESETCTL_HM (1<<13)   /* PCI host mode */
+#define BPCI_RESETCTL_RI (1<<14)   /* PCI reset in */
+
+extern mspPciRegs msp_pci_regs __attribute__((section(".register")));
+extern unsigned long msp_pci_config_space __attribute__((section(".register")));
+
+#define MSP_PCI_READ_REG32(base, byte_offset) \
+   *((volatile u32 *)((u8 *)(base) + (byte_offset)))
+
+#endif /* _MSP_PCI_H_ */
