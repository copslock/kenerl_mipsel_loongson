Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2008 16:31:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:7897 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026554AbYGJPba (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2008 16:31:30 +0100
Received: from localhost (p7221-ipad210funabasi.chiba.ocn.ne.jp [58.88.126.221])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8FD38AABB; Fri, 11 Jul 2008 00:31:22 +0900 (JST)
Date:	Fri, 11 Jul 2008 00:33:08 +0900 (JST)
Message-Id: <20080711.003308.108121397.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/3] reorganize txx9 pci code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Split out PCIC dependent code and SoC dependent code from board
dependent code.  Now TX4927 PCIC code is independent from
TX4927/TX4938 SoC code.  Also fix some build problems on CONFIG_PCI=n.

As a bonus, "FPCIB0 Backplane Support" is available for all TX39/TX49
boards and PCI66 support is available for all TX49 boards.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                  |    3 +-
 arch/mips/pci/Makefile             |    8 +-
 arch/mips/pci/fixup-jmr3927.c      |   25 +-
 arch/mips/pci/fixup-rbtx4927.c     |  112 ++-----
 arch/mips/pci/fixup-rbtx4938.c     |   52 +---
 arch/mips/pci/ops-tx3927.c         |   87 +++++-
 arch/mips/pci/ops-tx4927.c         |  514 +++++++++++++++++++---------
 arch/mips/pci/ops-tx4938.c         |  214 ------------
 arch/mips/pci/pci-jmr3927.c        |   58 ---
 arch/mips/pci/pci-tx4927.c         |   83 +++++
 arch/mips/pci/pci-tx4938.c         |  134 +++++++
 arch/mips/txx9/Kconfig             |   11 +-
 arch/mips/txx9/generic/Makefile    |    2 +
 arch/mips/txx9/generic/pci.c       |  377 ++++++++++++++++++++
 arch/mips/txx9/generic/setup.c     |   51 +++
 arch/mips/txx9/jmr3927/irq.c       |    2 +
 arch/mips/txx9/jmr3927/setup.c     |  108 ++-----
 arch/mips/txx9/rbtx4927/irq.c      |   20 +-
 arch/mips/txx9/rbtx4927/setup.c    |  499 +++++++--------------------
 arch/mips/txx9/rbtx4938/setup.c    |  667 ++++++------------------------------
 include/asm-mips/txx9/generic.h    |   23 ++
 include/asm-mips/txx9/pci.h        |   36 ++
 include/asm-mips/txx9/rbtx4927.h   |   29 ++-
 include/asm-mips/txx9/tx3927.h     |    4 +
 include/asm-mips/txx9/tx4927.h     |  318 +++++++----------
 include/asm-mips/txx9/tx4927pcic.h |  199 +++++++++++
 include/asm-mips/txx9/tx4938.h     |  226 ++-----------
 27 files changed, 1851 insertions(+), 2011 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3202960..2ea6fff 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -575,7 +575,7 @@ config TOSHIBA_RBTX4927
 	select HW_HAS_PCI
 	select IRQ_CPU
 	select IRQ_TXX9
-	select I8259 if TOSHIBA_FPCIB0
+	select PCI_TX4927
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -598,6 +598,7 @@ config TOSHIBA_RBTX4938
 	select HW_HAS_PCI
 	select IRQ_CPU
 	select IRQ_TXX9
+	select PCI_TX4927
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 4608e43..9087648 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -15,6 +15,8 @@ obj-$(CONFIG_MIPS_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
 obj-$(CONFIG_NEC_CMBVR4133)	+= fixup-vr4133.o
 obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
+obj-$(CONFIG_PCI_TX3927)	+= ops-tx3927.o
+obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
@@ -41,9 +43,9 @@ obj-$(CONFIG_SNI_RM)		+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
-obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o pci-jmr3927.o
-obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
-obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o ops-tx4938.o
+obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o
+obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o pci-tx4927.o pci-tx4938.o
+obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o pci-tx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index 41dcd6a..d5edaf2 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -28,36 +28,31 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-
+#include <asm/txx9/pci.h>
 #include <asm/txx9/jmr3927.h>
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
-	/* SMSC SLC90E66 IDE uses irq 14, 15 (default) */
-	if (dev->vendor == PCI_VENDOR_ID_EFAR &&
-	    dev->device == PCI_DEVICE_ID_EFAR_SLC90E66_1)
-		return irq;
 	/* IRQ rotation (PICMG) */
 	irq--;			/* 0-3 */
-	if (dev->bus->parent == NULL &&
-	    slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(23)) {
+	if (slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(23)) {
 		/* PCI CardSlot (IDSEL=A23, DevNu=12) */
 		/* PCIA => PCIC (IDSEL=A23) */
 		/* NOTE: JMR3927 JP1 must be set to OPEN */
 		irq = (irq + 2) % 4;
-	} else if (dev->bus->parent == NULL &&
-		   slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(22)) {
+	} else if (slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(22)) {
 		/* PCI CardSlot (IDSEL=A22, DevNu=11) */
 		/* PCIA => PCIA (IDSEL=A22) */
 		/* NOTE: JMR3927 JP1 must be set to OPEN */
 		irq = (irq + 0) % 4;
 	} else {
 		/* PCI Backplane */
-		irq = (irq + 3 + slot) % 4;
+		if (txx9_pci_option & TXX9_PCI_OPT_PICMG)
+			irq = (irq + 33 - slot) % 4;
+		else
+			irq = (irq + 3 + slot) % 4;
 	}
 	irq++;			/* 1-4 */
 
@@ -66,15 +61,13 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		irq = JMR3927_IRQ_IOC_PCIA;
 		break;
 	case 2:
-		// wrong for backplane irq = JMR3927_IRQ_IOC_PCIB;
-		irq = JMR3927_IRQ_IOC_PCID;
+		irq = JMR3927_IRQ_IOC_PCIB;
 		break;
 	case 3:
 		irq = JMR3927_IRQ_IOC_PCIC;
 		break;
 	case 4:
-		// wrong for backplane irq = JMR3927_IRQ_IOC_PCID;
-		irq = JMR3927_IRQ_IOC_PCIB;
+		irq = JMR3927_IRQ_IOC_PCID;
 		break;
 	}
 
diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index 26013ba..abab485 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -33,102 +33,42 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
+#include <asm/txx9/pci.h>
+#include <asm/txx9/rbtx4927.h>
 
-#include <asm/txx9/tx4927.h>
-
-#undef  DEBUG
-#ifdef  DEBUG
-#define DBG(x...)       printk(x)
-#else
-#define DBG(x...)
-#endif
-
-/* look up table for backplane pci irq for slots 17-20 by pin # */
-static unsigned char backplane_pci_irq[4][4] = {
-	/* PJ6 SLOT:  17, PIN: 1 */ {TX4927_IRQ_IOC_PCIA,
-				     /* PJ6 SLOT:  17, PIN: 2 */
-				     TX4927_IRQ_IOC_PCIB,
-				     /* PJ6 SLOT:  17, PIN: 3 */
-				     TX4927_IRQ_IOC_PCIC,
-				     /* PJ6 SLOT:  17, PIN: 4 */
-				     TX4927_IRQ_IOC_PCID},
-	/* SB  SLOT:  18, PIN: 1 */ {TX4927_IRQ_IOC_PCIB,
-				     /* SB  SLOT:  18, PIN: 2 */
-				     TX4927_IRQ_IOC_PCIC,
-				     /* SB  SLOT:  18, PIN: 3 */
-				     TX4927_IRQ_IOC_PCID,
-				     /* SB  SLOT:  18, PIN: 4 */
-				     TX4927_IRQ_IOC_PCIA},
-	/* PJ5 SLOT:  19, PIN: 1 */ {TX4927_IRQ_IOC_PCIC,
-				     /* PJ5 SLOT:  19, PIN: 2 */
-				     TX4927_IRQ_IOC_PCID,
-				     /* PJ5 SLOT:  19, PIN: 3 */
-				     TX4927_IRQ_IOC_PCIA,
-				     /* PJ5 SLOT:  19, PIN: 4 */
-				     TX4927_IRQ_IOC_PCIB},
-	/* PJ4 SLOT:  20, PIN: 1 */ {TX4927_IRQ_IOC_PCID,
-				     /* PJ4 SLOT:  20, PIN: 2 */
-				     TX4927_IRQ_IOC_PCIA,
-				     /* PJ4 SLOT:  20, PIN: 3 */
-				     TX4927_IRQ_IOC_PCIB,
-				     /* PJ4 SLOT:  20, PIN: 4 */
-				     TX4927_IRQ_IOC_PCIC}
-};
-
-static int pci_get_irq(const struct pci_dev *dev, int pin)
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
-	DBG("pci_get_irq: pin is %d\n", pin);
 	/* IRQ rotation */
 	irq--;			/* 0-3 */
-	if (dev->bus->parent == NULL &&
-	    PCI_SLOT(dev->devfn) == TX4927_PCIC_IDSEL_AD_TO_SLOT(23)) {
-		printk("Onboard PCI_SLOT(dev->devfn) is %d\n",
-		       PCI_SLOT(dev->devfn));
-		/* IDSEL=A23 is tx4927 onboard pci slot */
-		irq = (irq + PCI_SLOT(dev->devfn)) % 4;
-		irq++;		/* 1-4 */
-		DBG("irq is now %d\n", irq);
-
-		switch (irq) {
-		case 1:
-			irq = TX4927_IRQ_IOC_PCIA;
-			break;
-		case 2:
-			irq = TX4927_IRQ_IOC_PCIB;
-			break;
-		case 3:
-			irq = TX4927_IRQ_IOC_PCIC;
-			break;
-		case 4:
-			irq = TX4927_IRQ_IOC_PCID;
-			break;
-		}
+	if (slot == TX4927_PCIC_IDSEL_AD_TO_SLOT(23)) {
+		/* PCI CardSlot (IDSEL=A23) */
+		/* PCIA => PCIA */
+		irq = (irq + 0 + slot) % 4;
 	} else {
 		/* PCI Backplane */
-		DBG("PCI Backplane PCI_SLOT(dev->devfn) is %d\n",
-		    PCI_SLOT(dev->devfn));
-		irq = backplane_pci_irq[PCI_SLOT(dev->devfn) - 17][irq];
+		if (txx9_pci_option & TXX9_PCI_OPT_PICMG)
+			irq = (irq + 33 - slot) % 4;
+		else
+			irq = (irq + 3 + slot) % 4;
 	}
-	DBG("assigned irq %d\n", irq);
-	return irq;
-}
-
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	unsigned char irq;
-
-	printk("PCI Setup for pin %d \n", pin);
-
-	if (dev->device == 0x9130) /* IDE */
-		irq = 14;
-	else
-		irq = pci_get_irq(dev, pin);
+	irq++;	/* 1-4 */
 
+	switch (irq) {
+	case 1:
+		irq = RBTX4927_IRQ_IOC_PCIA;
+		break;
+	case 2:
+		irq = RBTX4927_IRQ_IOC_PCIB;
+		break;
+	case 3:
+		irq = RBTX4927_IRQ_IOC_PCIC;
+		break;
+	case 4:
+		irq = RBTX4927_IRQ_IOC_PCID;
+		break;
+	}
 	return irq;
 }
 
diff --git a/arch/mips/pci/fixup-rbtx4938.c b/arch/mips/pci/fixup-rbtx4938.c
index 64d4510..39c9958 100644
--- a/arch/mips/pci/fixup-rbtx4938.c
+++ b/arch/mips/pci/fixup-rbtx4938.c
@@ -10,45 +10,28 @@
  * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
  */
 #include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
+#include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4938.h>
 
-extern struct pci_controller tx4938_pci_controller[];
-
-static int pci_get_irq(const struct pci_dev *dev, int pin)
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	int irq = pin;
-	u8 slot = PCI_SLOT(dev->devfn);
-	struct pci_controller *controller = (struct pci_controller *)dev->sysdata;
-
-	if (controller == &tx4938_pci_controller[1]) {
-		/* TX4938 PCIC1 */
-		switch (slot) {
-		case TX4938_PCIC_IDSEL_AD_TO_SLOT(31):
-			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH0_SEL)
-				return RBTX4938_IRQ_IRC + TX4938_IR_ETH0;
-			break;
-		case TX4938_PCIC_IDSEL_AD_TO_SLOT(30):
-			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH1_SEL)
-				return RBTX4938_IRQ_IRC + TX4938_IR_ETH1;
-			break;
-		}
-		return 0;
-	}
+	int irq = tx4938_pcic1_map_irq(dev, slot);
 
+	if (irq >= 0)
+		return irq;
+	irq = pin;
 	/* IRQ rotation */
 	irq--;	/* 0-3 */
-	if (dev->bus->parent == NULL &&
-	    (slot == TX4938_PCIC_IDSEL_AD_TO_SLOT(23))) {
+	if (slot == TX4927_PCIC_IDSEL_AD_TO_SLOT(23)) {
 		/* PCI CardSlot (IDSEL=A23) */
 		/* PCIA => PCIA (IDSEL=A23) */
 		irq = (irq + 0 + slot) % 4;
 	} else {
 		/* PCI Backplane */
-		irq = (irq + 33 - slot) % 4;
+		if (txx9_pci_option & TXX9_PCI_OPT_PICMG)
+			irq = (irq + 33 - slot) % 4;
+		else
+			irq = (irq + 3 + slot) % 4;
 	}
 	irq++;	/* 1-4 */
 
@@ -69,19 +52,6 @@ static int pci_get_irq(const struct pci_dev *dev, int pin)
 	return irq;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	unsigned char irq = 0;
-
-	irq = pci_get_irq(dev, pin);
-
-	printk(KERN_INFO "PCI: 0x%02x:0x%02x(0x%02x,0x%02x) IRQ=%d\n",
-	       dev->bus->number, dev->devfn, PCI_SLOT(dev->devfn),
-	       PCI_FUNC(dev->devfn), irq);
-
-	return irq;
-}
-
 /*
  * Do platform specific device initialization at pci_enable_device() time
  */
diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
index 5d398f6..8a17a39 100644
--- a/arch/mips/pci/ops-tx3927.c
+++ b/arch/mips/pci/ops-tx3927.c
@@ -8,7 +8,7 @@
  *
  * Based on arch/mips/ddb5xxx/ddb5477/pci_ops.c
  *
- *     Define the pci_ops for JMR3927.
+ *     Define the pci_ops for TX3927.
  *
  * Much of the code is derived from the original DDB5074 port by
  * Geert Uytterhoeven <geert@sonycom.com>
@@ -39,7 +39,7 @@
 #include <linux/init.h>
 
 #include <asm/addrspace.h>
-#include <asm/txx9/jmr3927.h>
+#include <asm/txx9/tx3927.h>
 
 static inline int mkaddr(unsigned char bus, unsigned char dev_fn,
 	unsigned char where)
@@ -68,7 +68,7 @@ static inline int check_abort(void)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int jmr3927_pci_read_config(struct pci_bus *bus, unsigned int devfn,
+static int tx3927_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	int where, int size, u32 * val)
 {
 	int ret;
@@ -94,7 +94,7 @@ static int jmr3927_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	return check_abort();
 }
 
-static int jmr3927_pci_write_config(struct pci_bus *bus, unsigned int devfn,
+static int tx3927_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	int where, int size, u32 val)
 {
 	int ret;
@@ -125,7 +125,80 @@ static int jmr3927_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	return check_abort();
 }
 
-struct pci_ops jmr3927_pci_ops = {
-	jmr3927_pci_read_config,
-	jmr3927_pci_write_config,
+static struct pci_ops tx3927_pci_ops = {
+	.read = tx3927_pci_read_config,
+	.write = tx3927_pci_write_config,
 };
+
+void __init tx3927_pcic_setup(struct pci_controller *channel,
+			      unsigned long sdram_size, int extarb)
+{
+	unsigned long flags;
+	unsigned long io_base =
+		channel->io_resource->start + mips_io_port_base - IO_BASE;
+	unsigned long io_size =
+		channel->io_resource->end - channel->io_resource->start;
+	unsigned long io_pciaddr =
+		channel->io_resource->start - channel->io_offset;
+	unsigned long mem_base =
+		channel->mem_resource->start;
+	unsigned long mem_size =
+		channel->mem_resource->end - channel->mem_resource->start;
+	unsigned long mem_pciaddr =
+		channel->mem_resource->start - channel->mem_offset;
+
+	printk(KERN_INFO "TX3927 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s",
+	       tx3927_pcicptr->did, tx3927_pcicptr->vid,
+	       tx3927_pcicptr->rid,
+	       extarb ? "External" : "Internal");
+	channel->pci_ops = &tx3927_pci_ops;
+
+	local_irq_save(flags);
+	/* Disable External PCI Config. Access */
+	tx3927_pcicptr->lbc = TX3927_PCIC_LBC_EPCAD;
+#ifdef __BIG_ENDIAN
+	tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_IBSE |
+		TX3927_PCIC_LBC_TIBSE |
+		TX3927_PCIC_LBC_TMFBSE | TX3927_PCIC_LBC_MSDSE;
+#endif
+	/* LB->PCI mappings */
+	tx3927_pcicptr->iomas = ~(io_size - 1);
+	tx3927_pcicptr->ilbioma = io_base;
+	tx3927_pcicptr->ipbioma = io_pciaddr;
+	tx3927_pcicptr->mmas = ~(mem_size - 1);
+	tx3927_pcicptr->ilbmma = mem_base;
+	tx3927_pcicptr->ipbmma = mem_pciaddr;
+	/* PCI->LB mappings */
+	tx3927_pcicptr->iobas = 0xffffffff;
+	tx3927_pcicptr->ioba = 0;
+	tx3927_pcicptr->tlbioma = 0;
+	tx3927_pcicptr->mbas = ~(sdram_size - 1);
+	tx3927_pcicptr->mba = 0;
+	tx3927_pcicptr->tlbmma = 0;
+	/* Enable Direct mapping Address Space Decoder */
+	tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_ILMDE | TX3927_PCIC_LBC_ILIDE;
+
+	/* Clear All Local Bus Status */
+	tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
+	/* Enable All Local Bus Interrupts */
+	tx3927_pcicptr->lbim = TX3927_PCIC_LBIM_ALL;
+	/* Clear All PCI Status Error */
+	tx3927_pcicptr->pcistat = TX3927_PCIC_PCISTATIM_ALL;
+	/* Enable All PCI Status Error Interrupts */
+	tx3927_pcicptr->pcistatim = TX3927_PCIC_PCISTATIM_ALL;
+
+	/* PCIC Int => IRC IRQ10 */
+	tx3927_pcicptr->il = TX3927_IR_PCI;
+	/* Target Control (per errata) */
+	tx3927_pcicptr->tc = TX3927_PCIC_TC_OF8E | TX3927_PCIC_TC_IF8E;
+
+	/* Enable Bus Arbiter */
+	if (!extarb)
+		tx3927_pcicptr->pbapmc = TX3927_PCIC_PBAPMC_PBAEN;
+
+	tx3927_pcicptr->pcicmd = PCI_COMMAND_MASTER |
+		PCI_COMMAND_MEMORY |
+		PCI_COMMAND_IO |
+		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	local_irq_restore(flags);
+}
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 54730ee..c6b49bc 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -1,206 +1,408 @@
 /*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
+ * Define the pci_ops for the PCIC on Toshiba TX4927, TX4938, etc.
  *
- * Copyright (C) 2000-2001 Toshiba Corporation
- * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
- *
- * Based on arch/mips/ddb5xxx/ddb5477/pci_ops.c
- *
- *     Define the pci_ops for the Toshiba rbtx4927
- *
- * Much of the code is derived from the original DDB5074 port by
- * Geert Uytterhoeven <geert@sonycom.com>
- *
- * Copyright 2004 MontaVista Software Inc.
- * Author: Manish Lachwani (mlachwani@mvista.com)
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
+ * Based on linux/arch/mips/pci/ops-tx4938.c,
+ *          linux/arch/mips/pci/fixup-rbtx4938.c,
+ *          linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
  *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ * 2003-2005 (c) MontaVista Software, Inc.
+ * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
  *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  */
-#include <linux/types.h>
-#include <linux/pci.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/txx9/tx4927.h>
-
-/* initialize in setup */
-struct resource pci_io_resource = {
-	.name	= "TX4927 PCI IO SPACE",
-	.start	= 0x1000,
-	.end	= (0x1000 + (TX4927_PCIIO_SIZE)) - 1,
-	.flags	= IORESOURCE_IO
-};
+#include <asm/txx9/tx4927pcic.h>
 
-/* initialize in setup */
-struct resource pci_mem_resource = {
-	.name	= "TX4927 PCI MEM SPACE",
-	.start	= TX4927_PCIMEM,
-	.end	= TX4927_PCIMEM + TX4927_PCIMEM_SIZE - 1,
-	.flags	= IORESOURCE_MEM
-};
+static struct {
+	struct pci_controller *channel;
+	struct tx4927_pcic_reg __iomem *pcicptr;
+} pcicptrs[2];	/* TX4938 has 2 pcic */
+
+static void __init set_tx4927_pcicptr(struct pci_controller *channel,
+				      struct tx4927_pcic_reg __iomem *pcicptr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcicptrs); i++) {
+		if (pcicptrs[i].channel == channel) {
+			pcicptrs[i].pcicptr = pcicptr;
+			return;
+		}
+	}
+	for (i = 0; i < ARRAY_SIZE(pcicptrs); i++) {
+		if (!pcicptrs[i].channel) {
+			pcicptrs[i].channel = channel;
+			pcicptrs[i].pcicptr = pcicptr;
+			return;
+		}
+	}
+	BUG();
+}
 
-static int mkaddr(int bus, int dev_fn, int where, int *flagsp)
+struct tx4927_pcic_reg __iomem *get_tx4927_pcicptr(
+	struct pci_controller *channel)
 {
-	if (bus > 0) {
-		/* Type 1 configuration */
-		tx4927_pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
-		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc) | 1;
-	} else {
-		if (dev_fn >= PCI_DEVFN(TX4927_PCIC_MAX_DEVNU, 0))
-			return -1;
+	int i;
 
-		/* Type 0 configuration */
-		tx4927_pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
-		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc);
+	for (i = 0; i < ARRAY_SIZE(pcicptrs); i++) {
+		if (pcicptrs[i].channel == channel)
+			return pcicptrs[i].pcicptr;
 	}
+	return NULL;
+}
+
+static int mkaddr(struct pci_bus *bus, unsigned int devfn, int where,
+		  struct tx4927_pcic_reg __iomem *pcicptr)
+{
+	if (bus->parent == NULL &&
+	    devfn >= PCI_DEVFN(TX4927_PCIC_MAX_DEVNU, 0))
+		return -1;
+	__raw_writel(((bus->number & 0xff) << 0x10)
+		     | ((devfn & 0xff) << 0x08) | (where & 0xfc)
+		     | (bus->parent ? 1 : 0),
+		     &pcicptr->g2pcfgadrs);
 	/* clear M_ABORT and Disable M_ABORT Int. */
-	tx4927_pcicptr->pcistatus =
-	    (tx4927_pcicptr->pcistatus & 0x0000ffff) |
-	    (PCI_STATUS_REC_MASTER_ABORT << 16);
-	tx4927_pcicptr->pcimask &= ~PCI_STATUS_REC_MASTER_ABORT;
+	__raw_writel((__raw_readl(&pcicptr->pcistatus) & 0x0000ffff)
+		     | (PCI_STATUS_REC_MASTER_ABORT << 16),
+		     &pcicptr->pcistatus);
 	return 0;
 }
 
-static int check_abort(int flags)
+static int check_abort(struct tx4927_pcic_reg __iomem *pcicptr)
 {
 	int code = PCIBIOS_SUCCESSFUL;
-	if (tx4927_pcicptr->
-	    pcistatus & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
-		tx4927_pcicptr->pcistatus =
-		    (tx4927_pcicptr->
-		     pcistatus & 0x0000ffff) | (PCI_STATUS_REC_MASTER_ABORT
-						<< 16);
-		tx4927_pcicptr->pcimask |= PCI_STATUS_REC_MASTER_ABORT;
+
+	/* wait write cycle completion before checking error status */
+	while (__raw_readl(&pcicptr->pcicstatus) & TX4927_PCIC_PCICSTATUS_IWB)
+		;
+	if (__raw_readl(&pcicptr->pcistatus)
+	    & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
+		__raw_writel((__raw_readl(&pcicptr->pcistatus) & 0x0000ffff)
+			     | (PCI_STATUS_REC_MASTER_ABORT << 16),
+			     &pcicptr->pcistatus);
 		code = PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return code;
 }
 
-static int tx4927_pcibios_read_config(struct pci_bus *bus, unsigned int devfn, int where,
-		int size, u32 * val)
+static u8 icd_readb(int offset, struct tx4927_pcic_reg __iomem *pcicptr)
+{
+#ifdef __BIG_ENDIAN
+	offset ^= 3;
+#endif
+	return __raw_readb((void __iomem *)&pcicptr->g2pcfgdata + offset);
+}
+static u16 icd_readw(int offset, struct tx4927_pcic_reg __iomem *pcicptr)
+{
+#ifdef __BIG_ENDIAN
+	offset ^= 2;
+#endif
+	return __raw_readw((void __iomem *)&pcicptr->g2pcfgdata + offset);
+}
+static u32 icd_readl(struct tx4927_pcic_reg __iomem *pcicptr)
+{
+	return __raw_readl(&pcicptr->g2pcfgdata);
+}
+static void icd_writeb(u8 val, int offset,
+		       struct tx4927_pcic_reg __iomem *pcicptr)
+{
+#ifdef __BIG_ENDIAN
+	offset ^= 3;
+#endif
+	__raw_writeb(val, (void __iomem *)&pcicptr->g2pcfgdata + offset);
+}
+static void icd_writew(u16 val, int offset,
+		       struct tx4927_pcic_reg __iomem *pcicptr)
+{
+#ifdef __BIG_ENDIAN
+	offset ^= 2;
+#endif
+	__raw_writew(val, (void __iomem *)&pcicptr->g2pcfgdata + offset);
+}
+static void icd_writel(u32 val, struct tx4927_pcic_reg __iomem *pcicptr)
 {
-	int flags, retval, dev, busno, func;
+	__raw_writel(val, &pcicptr->g2pcfgdata);
+}
 
-	busno = bus->number;
-        dev = PCI_SLOT(devfn);
-        func = PCI_FUNC(devfn);
+static struct tx4927_pcic_reg __iomem *pci_bus_to_pcicptr(struct pci_bus *bus)
+{
+	struct pci_controller *channel = bus->sysdata;
+	return get_tx4927_pcicptr(channel);
+}
 
-	/* check if the bus is top-level */
-	if (bus->parent != NULL) {
-		busno = bus->number;
-	} else {
-		busno = 0;
-	}
+static int tx4927_pci_config_read(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *val)
+{
+	struct tx4927_pcic_reg __iomem *pcicptr = pci_bus_to_pcicptr(bus);
 
-	if (mkaddr(busno, devfn, where, &flags))
+	if (mkaddr(bus, devfn, where, pcicptr)) {
+		*val = 0xffffffff;
 		return -1;
-
+	}
 	switch (size) {
 	case 1:
-		*val = *(volatile u8 *) ((unsigned long) & tx4927_pcicptr->
-                              g2pcfgdata |
-#ifdef __LITTLE_ENDIAN
-						(where & 3));
-#else
-						((where & 0x3) ^ 0x3));
-#endif
+		*val = icd_readb(where & 3, pcicptr);
 		break;
 	case 2:
-		*val = *(volatile u16 *) ((unsigned long) & tx4927_pcicptr->
-                               g2pcfgdata |
-#ifdef __LITTLE_ENDIAN
-						(where & 3));
-#else
-						((where & 0x3) ^ 0x2));
-#endif
-		break;
-	case 4:
-		*val = tx4927_pcicptr->g2pcfgdata;
+		*val = icd_readw(where & 3, pcicptr);
 		break;
+	default:
+		*val = icd_readl(pcicptr);
 	}
+	return check_abort(pcicptr);
+}
 
-	retval = check_abort(flags);
-	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
-		*val = 0xffffffff;
+static int tx4927_pci_config_write(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
+{
+	struct tx4927_pcic_reg __iomem *pcicptr = pci_bus_to_pcicptr(bus);
 
-	return retval;
+	if (mkaddr(bus, devfn, where, pcicptr))
+		return -1;
+	switch (size) {
+	case 1:
+		icd_writeb(val, where & 3, pcicptr);
+		break;
+	case 2:
+		icd_writew(val, where & 3, pcicptr);
+		break;
+	default:
+		icd_writel(val, pcicptr);
+	}
+	return check_abort(pcicptr);
 }
 
-static int tx4927_pcibios_write_config(struct pci_bus *bus, unsigned int devfn, int where,
-				int size, u32 val)
+static struct pci_ops tx4927_pci_ops = {
+	.read = tx4927_pci_config_read,
+	.write = tx4927_pci_config_write,
+};
+
+static struct {
+	u8 trdyto;
+	u8 retryto;
+	u16 gbwc;
+} tx4927_pci_opts __devinitdata = {
+	.trdyto = 0,
+	.retryto = 0,
+	.gbwc = 0xfe0,	/* 4064 GBUSCLK for CCFG.GTOT=0b11 */
+};
+
+void __init tx4927_pcic_setup(struct tx4927_pcic_reg __iomem *pcicptr,
+			      struct pci_controller *channel, int extarb)
 {
-	int flags, dev, busno, func;
-	busno = bus->number;
-        dev = PCI_SLOT(devfn);
-        func = PCI_FUNC(devfn);
+	int i;
+	unsigned long flags;
 
-	/* check if the bus is top-level */
-	if (bus->parent != NULL) {
-		busno = bus->number;
-	} else {
-		busno = 0;
-	}
+	set_tx4927_pcicptr(channel, pcicptr);
 
-	if (mkaddr(busno, devfn, where, &flags))
-		return -1;
+	if (!channel->pci_ops)
+		printk(KERN_INFO
+		       "PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
+		       __raw_readl(&pcicptr->pciid) >> 16,
+		       __raw_readl(&pcicptr->pciid) & 0xffff,
+		       __raw_readl(&pcicptr->pciccrev) & 0xff,
+			extarb ? "External" : "Internal");
+	channel->pci_ops = &tx4927_pci_ops;
 
-	switch (size) {
-	case 1:
-		 *(volatile u8 *) ((unsigned long) & tx4927_pcicptr->
-                          g2pcfgdata |
-#ifdef __LITTLE_ENDIAN
-					(where & 3)) = val;
+	local_irq_save(flags);
+
+	/* Disable All Initiator Space */
+	__raw_writel(__raw_readl(&pcicptr->pciccfg)
+		     & ~(TX4927_PCIC_PCICCFG_G2PMEN(0)
+			 | TX4927_PCIC_PCICCFG_G2PMEN(1)
+			 | TX4927_PCIC_PCICCFG_G2PMEN(2)
+			 | TX4927_PCIC_PCICCFG_G2PIOEN),
+		     &pcicptr->pciccfg);
+
+	/* GB->PCI mappings */
+	__raw_writel((channel->io_resource->end - channel->io_resource->start)
+		     >> 4,
+		     &pcicptr->g2piomask);
+	____raw_writeq((channel->io_resource->start +
+			channel->io_map_base - IO_BASE) |
+#ifdef __BIG_ENDIAN
+		       TX4927_PCIC_G2PIOGBASE_ECHG
 #else
-					((where & 0x3) ^ 0x3)) = val;
+		       TX4927_PCIC_G2PIOGBASE_BSDIS
 #endif
-		break;
-
-	case 2:
-		*(volatile u16 *) ((unsigned long) & tx4927_pcicptr->
-                           g2pcfgdata |
-#ifdef __LITTLE_ENDIAN
-					(where & 3)) = val;
+		       , &pcicptr->g2piogbase);
+	____raw_writeq(channel->io_resource->start - channel->io_offset,
+		       &pcicptr->g2piopbase);
+	for (i = 0; i < 3; i++) {
+		__raw_writel(0, &pcicptr->g2pmmask[i]);
+		____raw_writeq(0, &pcicptr->g2pmgbase[i]);
+		____raw_writeq(0, &pcicptr->g2pmpbase[i]);
+	}
+	if (channel->mem_resource->end) {
+		__raw_writel((channel->mem_resource->end
+			      - channel->mem_resource->start) >> 4,
+			     &pcicptr->g2pmmask[0]);
+		____raw_writeq(channel->mem_resource->start |
+#ifdef __BIG_ENDIAN
+			       TX4927_PCIC_G2PMnGBASE_ECHG
 #else
-					((where & 0x3) ^ 0x2)) = val;
+			       TX4927_PCIC_G2PMnGBASE_BSDIS
 #endif
-		break;
-	case 4:
-		tx4927_pcicptr->g2pcfgdata = val;
-		break;
+			       , &pcicptr->g2pmgbase[0]);
+		____raw_writeq(channel->mem_resource->start -
+			       channel->mem_offset,
+			       &pcicptr->g2pmpbase[0]);
+	}
+	/* PCI->GB mappings (I/O 256B) */
+	__raw_writel(0, &pcicptr->p2giopbase); /* 256B */
+	____raw_writeq(0, &pcicptr->p2giogbase);
+	/* PCI->GB mappings (MEM 512MB (64MB on R1.x)) */
+	__raw_writel(0, &pcicptr->p2gm0plbase);
+	__raw_writel(0, &pcicptr->p2gm0pubase);
+	____raw_writeq(TX4927_PCIC_P2GMnGBASE_TMEMEN |
+#ifdef __BIG_ENDIAN
+		       TX4927_PCIC_P2GMnGBASE_TECHG
+#else
+		       TX4927_PCIC_P2GMnGBASE_TBSDIS
+#endif
+		       , &pcicptr->p2gmgbase[0]);
+	/* PCI->GB mappings (MEM 16MB) */
+	__raw_writel(0xffffffff, &pcicptr->p2gm1plbase);
+	__raw_writel(0xffffffff, &pcicptr->p2gm1pubase);
+	____raw_writeq(0, &pcicptr->p2gmgbase[1]);
+	/* PCI->GB mappings (MEM 1MB) */
+	__raw_writel(0xffffffff, &pcicptr->p2gm2pbase); /* 1MB */
+	____raw_writeq(0, &pcicptr->p2gmgbase[2]);
+
+	/* Clear all (including IRBER) except for GBWC */
+	__raw_writel((tx4927_pci_opts.gbwc << 16)
+		     & TX4927_PCIC_PCICCFG_GBWC_MASK,
+		     &pcicptr->pciccfg);
+	/* Enable Initiator Memory Space */
+	if (channel->mem_resource->end)
+		__raw_writel(__raw_readl(&pcicptr->pciccfg)
+			     | TX4927_PCIC_PCICCFG_G2PMEN(0),
+			     &pcicptr->pciccfg);
+	/* Enable Initiator I/O Space */
+	if (channel->io_resource->end)
+		__raw_writel(__raw_readl(&pcicptr->pciccfg)
+			     | TX4927_PCIC_PCICCFG_G2PIOEN,
+			     &pcicptr->pciccfg);
+	/* Enable Initiator Config */
+	__raw_writel(__raw_readl(&pcicptr->pciccfg)
+		     | TX4927_PCIC_PCICCFG_ICAEN | TX4927_PCIC_PCICCFG_TCAR,
+		     &pcicptr->pciccfg);
+
+	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
+	__raw_writel(0, &pcicptr->pcicfg1);
+
+	__raw_writel((__raw_readl(&pcicptr->g2ptocnt) & ~0xffff)
+		     | (tx4927_pci_opts.trdyto & 0xff)
+		     | ((tx4927_pci_opts.retryto & 0xff) << 8),
+		     &pcicptr->g2ptocnt);
+
+	/* Clear All Local Bus Status */
+	__raw_writel(TX4927_PCIC_PCICSTATUS_ALL, &pcicptr->pcicstatus);
+	/* Enable All Local Bus Interrupts */
+	__raw_writel(TX4927_PCIC_PCICSTATUS_ALL, &pcicptr->pcicmask);
+	/* Clear All Initiator Status */
+	__raw_writel(TX4927_PCIC_G2PSTATUS_ALL, &pcicptr->g2pstatus);
+	/* Enable All Initiator Interrupts */
+	__raw_writel(TX4927_PCIC_G2PSTATUS_ALL, &pcicptr->g2pmask);
+	/* Clear All PCI Status Error */
+	__raw_writel((__raw_readl(&pcicptr->pcistatus) & 0x0000ffff)
+		     | (TX4927_PCIC_PCISTATUS_ALL << 16),
+		     &pcicptr->pcistatus);
+	/* Enable All PCI Status Error Interrupts */
+	__raw_writel(TX4927_PCIC_PCISTATUS_ALL, &pcicptr->pcimask);
+
+	if (!extarb) {
+		/* Reset Bus Arbiter */
+		__raw_writel(TX4927_PCIC_PBACFG_RPBA, &pcicptr->pbacfg);
+		__raw_writel(0, &pcicptr->pbabm);
+		/* Enable Bus Arbiter */
+		__raw_writel(TX4927_PCIC_PBACFG_PBAEN, &pcicptr->pbacfg);
 	}
 
-	return check_abort(flags);
+	__raw_writel(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
+		     | PCI_COMMAND_PARITY | PCI_COMMAND_SERR,
+		     &pcicptr->pcistatus);
+	local_irq_restore(flags);
+
+	printk(KERN_DEBUG
+	       "PCI: COMMAND=%04x,PCIMASK=%04x,"
+	       "TRDYTO=%02x,RETRYTO=%02x,GBWC=%03x\n",
+	       __raw_readl(&pcicptr->pcistatus) & 0xffff,
+	       __raw_readl(&pcicptr->pcimask) & 0xffff,
+	       __raw_readl(&pcicptr->g2ptocnt) & 0xff,
+	       (__raw_readl(&pcicptr->g2ptocnt) & 0xff00) >> 8,
+	       (__raw_readl(&pcicptr->pciccfg) >> 16) & 0xfff);
 }
 
-struct pci_ops tx4927_pci_ops = {
-	tx4927_pcibios_read_config,
-	tx4927_pcibios_write_config
-};
+static void tx4927_report_pcic_status1(struct tx4927_pcic_reg __iomem *pcicptr)
+{
+	__u16 pcistatus = (__u16)(__raw_readl(&pcicptr->pcistatus) >> 16);
+	__u32 g2pstatus = __raw_readl(&pcicptr->g2pstatus);
+	__u32 pcicstatus = __raw_readl(&pcicptr->pcicstatus);
+	static struct {
+		__u32 flag;
+		const char *str;
+	} pcistat_tbl[] = {
+		{ PCI_STATUS_DETECTED_PARITY,	"DetectedParityError" },
+		{ PCI_STATUS_SIG_SYSTEM_ERROR,	"SignaledSystemError" },
+		{ PCI_STATUS_REC_MASTER_ABORT,	"ReceivedMasterAbort" },
+		{ PCI_STATUS_REC_TARGET_ABORT,	"ReceivedTargetAbort" },
+		{ PCI_STATUS_SIG_TARGET_ABORT,	"SignaledTargetAbort" },
+		{ PCI_STATUS_PARITY,	"MasterParityError" },
+	}, g2pstat_tbl[] = {
+		{ TX4927_PCIC_G2PSTATUS_TTOE,	"TIOE" },
+		{ TX4927_PCIC_G2PSTATUS_RTOE,	"RTOE" },
+	}, pcicstat_tbl[] = {
+		{ TX4927_PCIC_PCICSTATUS_PME,	"PME" },
+		{ TX4927_PCIC_PCICSTATUS_TLB,	"TLB" },
+		{ TX4927_PCIC_PCICSTATUS_NIB,	"NIB" },
+		{ TX4927_PCIC_PCICSTATUS_ZIB,	"ZIB" },
+		{ TX4927_PCIC_PCICSTATUS_PERR,	"PERR" },
+		{ TX4927_PCIC_PCICSTATUS_SERR,	"SERR" },
+		{ TX4927_PCIC_PCICSTATUS_GBE,	"GBE" },
+		{ TX4927_PCIC_PCICSTATUS_IWB,	"IWB" },
+	};
+	int i, cont;
 
-/*
- * h/w only supports devices 0x00 to 0x14
- */
-struct pci_controller tx4927_controller = {
-	.pci_ops        = &tx4927_pci_ops,
-	.io_resource    = &pci_io_resource,
-	.mem_resource   = &pci_mem_resource,
-};
+	printk(KERN_ERR "");
+	if (pcistatus & TX4927_PCIC_PCISTATUS_ALL) {
+		printk(KERN_CONT "pcistat:%04x(", pcistatus);
+		for (i = 0, cont = 0; i < ARRAY_SIZE(pcistat_tbl); i++)
+			if (pcistatus & pcistat_tbl[i].flag)
+				printk(KERN_CONT "%s%s",
+				       cont++ ? " " : "", pcistat_tbl[i].str);
+		printk(KERN_CONT ") ");
+	}
+	if (g2pstatus & TX4927_PCIC_G2PSTATUS_ALL) {
+		printk(KERN_CONT "g2pstatus:%08x(", g2pstatus);
+		for (i = 0, cont = 0; i < ARRAY_SIZE(g2pstat_tbl); i++)
+			if (g2pstatus & g2pstat_tbl[i].flag)
+				printk(KERN_CONT "%s%s",
+				       cont++ ? " " : "", g2pstat_tbl[i].str);
+		printk(KERN_CONT ") ");
+	}
+	if (pcicstatus & TX4927_PCIC_PCICSTATUS_ALL) {
+		printk(KERN_CONT "pcicstatus:%08x(", pcicstatus);
+		for (i = 0, cont = 0; i < ARRAY_SIZE(pcicstat_tbl); i++)
+			if (pcicstatus & pcicstat_tbl[i].flag)
+				printk(KERN_CONT "%s%s",
+				       cont++ ? " " : "", pcicstat_tbl[i].str);
+		printk(KERN_CONT ")");
+	}
+	printk(KERN_CONT "\n");
+}
+
+void tx4927_report_pcic_status(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcicptrs); i++) {
+		if (pcicptrs[i].pcicptr)
+			tx4927_report_pcic_status1(pcicptrs[i].pcicptr);
+	}
+}
diff --git a/arch/mips/pci/ops-tx4938.c b/arch/mips/pci/ops-tx4938.c
deleted file mode 100644
index 34494b8..0000000
--- a/arch/mips/pci/ops-tx4938.c
+++ /dev/null
@@ -1,214 +0,0 @@
-/*
- * Define the pci_ops for the Toshiba rbtx4938
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <asm/addrspace.h>
-#include <asm/txx9/rbtx4938.h>
-
-/* initialize in setup */
-struct resource pci_io_resource = {
-	.name	= "pci IO space",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_IO
-};
-
-/* initialize in setup */
-struct resource pci_mem_resource = {
-	.name	= "pci memory space",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_MEM
-};
-
-struct resource tx4938_pcic1_pci_io_resource = {
-	.name	= "PCI1 IO",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_IO
-};
-struct resource tx4938_pcic1_pci_mem_resource = {
-	.name	= "PCI1 mem",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_MEM
-};
-
-static int mkaddr(int bus, int dev_fn, int where,
-		  struct tx4938_pcic_reg *pcicptr)
-{
-	if (bus > 0) {
-		/* Type 1 configuration */
-		pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
-		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc) | 1;
-	} else {
-		if (dev_fn >= PCI_DEVFN(TX4938_PCIC_MAX_DEVNU, 0))
-			return -1;
-
-		/* Type 0 configuration */
-		pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
-		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc);
-	}
-	/* clear M_ABORT and Disable M_ABORT Int. */
-	pcicptr->pcistatus =
-	    (pcicptr->pcistatus & 0x0000ffff) |
-	    (PCI_STATUS_REC_MASTER_ABORT << 16);
-	pcicptr->pcimask &= ~PCI_STATUS_REC_MASTER_ABORT;
-
-	return 0;
-}
-
-static int check_abort(struct tx4938_pcic_reg *pcicptr)
-{
-	int code = PCIBIOS_SUCCESSFUL;
-	/* wait write cycle completion before checking error status */
-	while (pcicptr->pcicstatus & TX4938_PCIC_PCICSTATUS_IWB)
-				;
-	if (pcicptr->pcistatus & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
-		pcicptr->pcistatus =
-		    (pcicptr->
-		     pcistatus & 0x0000ffff) | (PCI_STATUS_REC_MASTER_ABORT
-						<< 16);
-		pcicptr->pcimask |= PCI_STATUS_REC_MASTER_ABORT;
-		code = PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	return code;
-}
-
-extern struct pci_controller tx4938_pci_controller[];
-extern struct tx4938_pcic_reg *get_tx4938_pcicptr(int ch);
-
-static struct tx4938_pcic_reg *pci_bus_to_pcicptr(struct pci_bus *bus)
-{
-	struct pci_controller *channel = bus->sysdata;
-	return get_tx4938_pcicptr(channel - &tx4938_pci_controller[0]);
-}
-
-static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
-					int where, int size, u32 * val)
-{
-	int retval, dev, busno, func;
-	struct tx4938_pcic_reg *pcicptr = pci_bus_to_pcicptr(bus);
-	void __iomem *cfgdata =
-		(void __iomem *)(unsigned long)&pcicptr->g2pcfgdata;
-
-	dev = PCI_SLOT(devfn);
-	func = PCI_FUNC(devfn);
-
-	/* check if the bus is top-level */
-	if (bus->parent != NULL)
-		busno = bus->number;
-	else {
-		busno = 0;
-	}
-
-	if (mkaddr(busno, devfn, where, pcicptr))
-		return -1;
-
-	switch (size) {
-	case 1:
-#ifdef __BIG_ENDIAN
-		cfgdata += (where & 3) ^ 3;
-#else
-		cfgdata += where & 3;
-#endif
-		*val = __raw_readb(cfgdata);
-		break;
-	case 2:
-#ifdef __BIG_ENDIAN
-		cfgdata += (where & 2) ^ 2;
-#else
-		cfgdata += where & 2;
-#endif
-		*val = __raw_readw(cfgdata);
-		break;
-	case 4:
-		*val = __raw_readl(cfgdata);
-		break;
-	}
-
-	retval = check_abort(pcicptr);
-	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
-		*val = 0xffffffff;
-
-	return retval;
-}
-
-static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn, int where,
-						int size, u32 val)
-{
-	int dev, busno, func;
-	struct tx4938_pcic_reg *pcicptr = pci_bus_to_pcicptr(bus);
-	void __iomem *cfgdata =
-		(void __iomem *)(unsigned long)&pcicptr->g2pcfgdata;
-
-	busno = bus->number;
-	dev = PCI_SLOT(devfn);
-	func = PCI_FUNC(devfn);
-
-	/* check if the bus is top-level */
-	if (bus->parent != NULL) {
-		busno = bus->number;
-	} else {
-		busno = 0;
-	}
-
-	if (mkaddr(busno, devfn, where, pcicptr))
-		return -1;
-
-	switch (size) {
-	case 1:
-#ifdef __BIG_ENDIAN
-		cfgdata += (where & 3) ^ 3;
-#else
-		cfgdata += where & 3;
-#endif
-		__raw_writeb(val, cfgdata);
-		break;
-	case 2:
-#ifdef __BIG_ENDIAN
-		cfgdata += (where & 2) ^ 2;
-#else
-		cfgdata += where & 2;
-#endif
-		__raw_writew(val, cfgdata);
-		break;
-	case 4:
-		__raw_writel(val, cfgdata);
-		break;
-	}
-
-	return check_abort(pcicptr);
-}
-
-struct pci_ops tx4938_pci_ops = {
-	tx4938_pcibios_read_config,
-	tx4938_pcibios_write_config
-};
-
-struct pci_controller tx4938_pci_controller[] = {
-	/* h/w only supports devices 0x00 to 0x14 */
-	{
-		.pci_ops        = &tx4938_pci_ops,
-		.io_resource    = &pci_io_resource,
-		.mem_resource   = &pci_mem_resource,
-	},
-	/* h/w only supports devices 0x00 to 0x14 */
-	{
-		.pci_ops        = &tx4938_pci_ops,
-		.io_resource    = &tx4938_pcic1_pci_io_resource,
-		.mem_resource   = &tx4938_pcic1_pci_mem_resource,
-        }
-};
diff --git a/arch/mips/pci/pci-jmr3927.c b/arch/mips/pci/pci-jmr3927.c
deleted file mode 100644
index 7fb6bd7..0000000
--- a/arch/mips/pci/pci-jmr3927.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <asm/txx9/jmr3927.h>
-#include <asm/debug.h>
-
-struct resource pci_io_resource = {
-	.name	= "IO MEM",
-	.start	= 0x1000,			/* reserve regacy I/O space */
-	.end	= 0x1000 + JMR3927_PCIIO_SIZE - 1,
-	.flags	= IORESOURCE_IO
-};
-
-struct resource pci_mem_resource = {
-	.name	= "PCI MEM",
-	.start	= JMR3927_PCIMEM,
-	.end	= JMR3927_PCIMEM + JMR3927_PCIMEM_SIZE - 1,
-	.flags	= IORESOURCE_MEM
-};
-
-extern struct pci_ops jmr3927_pci_ops;
-
-struct pci_controller jmr3927_controller = {
-	.pci_ops	= &jmr3927_pci_ops,
-	.io_resource	= &pci_io_resource,
-	.mem_resource	= &pci_mem_resource,
-	.mem_offset	= JMR3927_PCIMEM
-};
diff --git a/arch/mips/pci/pci-tx4927.c b/arch/mips/pci/pci-tx4927.c
new file mode 100644
index 0000000..27e86a0
--- /dev/null
+++ b/arch/mips/pci/pci-tx4927.c
@@ -0,0 +1,83 @@
+/*
+ * linux/arch/mips/pci/pci-tx4927.c
+ *
+ * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * Copyright 2001, 2003-2005 MontaVista Software Inc.
+ * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx4927.h>
+
+int __init tx4927_report_pciclk(void)
+{
+	int pciclk = 0;
+
+	printk(KERN_INFO "PCIC --%s PCICLK:",
+	       (__raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_PCI66) ?
+	       " PCI66" : "");
+	if (__raw_readq(&tx4927_ccfgptr->pcfg) & TX4927_PCFG_PCICLKEN_ALL) {
+		u64 ccfg = __raw_readq(&tx4927_ccfgptr->ccfg);
+		switch ((unsigned long)ccfg &
+			TX4927_CCFG_PCIDIVMODE_MASK) {
+		case TX4927_CCFG_PCIDIVMODE_2_5:
+			pciclk = txx9_cpu_clock * 2 / 5; break;
+		case TX4927_CCFG_PCIDIVMODE_3:
+			pciclk = txx9_cpu_clock / 3; break;
+		case TX4927_CCFG_PCIDIVMODE_5:
+			pciclk = txx9_cpu_clock / 5; break;
+		case TX4927_CCFG_PCIDIVMODE_6:
+			pciclk = txx9_cpu_clock / 6; break;
+		}
+		printk("Internal(%u.%uMHz)",
+		       (pciclk + 50000) / 1000000,
+		       ((pciclk + 50000) / 100000) % 10);
+	} else {
+		printk("External");
+		pciclk = -1;
+	}
+	printk("\n");
+	return pciclk;
+}
+
+int __init tx4927_pciclk66_setup(void)
+{
+	int pciclk;
+
+	/* Assert M66EN */
+	tx4927_ccfg_set(TX4927_CCFG_PCI66);
+	/* Double PCICLK (if possible) */
+	if (__raw_readq(&tx4927_ccfgptr->pcfg) & TX4927_PCFG_PCICLKEN_ALL) {
+		unsigned int pcidivmode = 0;
+		u64 ccfg = __raw_readq(&tx4927_ccfgptr->ccfg);
+		pcidivmode = (unsigned long)ccfg &
+			TX4927_CCFG_PCIDIVMODE_MASK;
+		switch (pcidivmode) {
+		case TX4927_CCFG_PCIDIVMODE_5:
+		case TX4927_CCFG_PCIDIVMODE_2_5:
+			pcidivmode = TX4927_CCFG_PCIDIVMODE_2_5;
+			pciclk = txx9_cpu_clock * 2 / 5;
+			break;
+		case TX4927_CCFG_PCIDIVMODE_6:
+		case TX4927_CCFG_PCIDIVMODE_3:
+		default:
+			pcidivmode = TX4927_CCFG_PCIDIVMODE_3;
+			pciclk = txx9_cpu_clock / 3;
+		}
+		tx4927_ccfg_change(TX4927_CCFG_PCIDIVMODE_MASK,
+				   pcidivmode);
+		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
+		       (unsigned long)__raw_readq(&tx4927_ccfgptr->ccfg));
+	} else
+		pciclk = -1;
+	return pciclk;
+}
diff --git a/arch/mips/pci/pci-tx4938.c b/arch/mips/pci/pci-tx4938.c
new file mode 100644
index 0000000..e537551
--- /dev/null
+++ b/arch/mips/pci/pci-tx4938.c
@@ -0,0 +1,134 @@
+/*
+ * linux/arch/mips/pci/pci-tx4938.c
+ *
+ * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * Copyright 2001, 2003-2005 MontaVista Software Inc.
+ * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx4938.h>
+
+int __init tx4938_report_pciclk(void)
+{
+	int pciclk = 0;
+
+	printk(KERN_INFO "PCIC --%s PCICLK:",
+	       (__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCI66) ?
+	       " PCI66" : "");
+	if (__raw_readq(&tx4938_ccfgptr->pcfg) & TX4938_PCFG_PCICLKEN_ALL) {
+		u64 ccfg = __raw_readq(&tx4938_ccfgptr->ccfg);
+		switch ((unsigned long)ccfg &
+			TX4938_CCFG_PCIDIVMODE_MASK) {
+		case TX4938_CCFG_PCIDIVMODE_4:
+			pciclk = txx9_cpu_clock / 4; break;
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			pciclk = txx9_cpu_clock * 2 / 9; break;
+		case TX4938_CCFG_PCIDIVMODE_5:
+			pciclk = txx9_cpu_clock / 5; break;
+		case TX4938_CCFG_PCIDIVMODE_5_5:
+			pciclk = txx9_cpu_clock * 2 / 11; break;
+		case TX4938_CCFG_PCIDIVMODE_8:
+			pciclk = txx9_cpu_clock / 8; break;
+		case TX4938_CCFG_PCIDIVMODE_9:
+			pciclk = txx9_cpu_clock / 9; break;
+		case TX4938_CCFG_PCIDIVMODE_10:
+			pciclk = txx9_cpu_clock / 10; break;
+		case TX4938_CCFG_PCIDIVMODE_11:
+			pciclk = txx9_cpu_clock / 11; break;
+		}
+		printk("Internal(%u.%uMHz)",
+		       (pciclk + 50000) / 1000000,
+		       ((pciclk + 50000) / 100000) % 10);
+	} else {
+		printk("External");
+		pciclk = -1;
+	}
+	printk("\n");
+	return pciclk;
+}
+
+void __init tx4938_report_pci1clk(void)
+{
+	__u64 ccfg = __raw_readq(&tx4938_ccfgptr->ccfg);
+	unsigned int pciclk =
+		txx9_gbus_clock / ((ccfg & TX4938_CCFG_PCI1DMD) ? 4 : 2);
+
+	printk(KERN_INFO "PCIC1 -- %sPCICLK:%u.%uMHz\n",
+	       (ccfg & TX4938_CCFG_PCI1_66) ? "PCI66 " : "",
+	       (pciclk + 50000) / 1000000,
+	       ((pciclk + 50000) / 100000) % 10);
+}
+
+int __init tx4938_pciclk66_setup(void)
+{
+	int pciclk;
+
+	/* Assert M66EN */
+	tx4938_ccfg_set(TX4938_CCFG_PCI66);
+	/* Double PCICLK (if possible) */
+	if (__raw_readq(&tx4938_ccfgptr->pcfg) & TX4938_PCFG_PCICLKEN_ALL) {
+		unsigned int pcidivmode = 0;
+		u64 ccfg = __raw_readq(&tx4938_ccfgptr->ccfg);
+		pcidivmode = (unsigned long)ccfg &
+			TX4938_CCFG_PCIDIVMODE_MASK;
+		switch (pcidivmode) {
+		case TX4938_CCFG_PCIDIVMODE_8:
+		case TX4938_CCFG_PCIDIVMODE_4:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_4;
+			pciclk = txx9_cpu_clock / 4;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_9:
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_4_5;
+			pciclk = txx9_cpu_clock * 2 / 9;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_10:
+		case TX4938_CCFG_PCIDIVMODE_5:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_5;
+			pciclk = txx9_cpu_clock / 5;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_11:
+		case TX4938_CCFG_PCIDIVMODE_5_5:
+		default:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_5_5;
+			pciclk = txx9_cpu_clock * 2 / 11;
+			break;
+		}
+		tx4938_ccfg_change(TX4938_CCFG_PCIDIVMODE_MASK,
+				   pcidivmode);
+		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
+		       (unsigned long)__raw_readq(&tx4938_ccfgptr->ccfg));
+	} else
+		pciclk = -1;
+	return pciclk;
+}
+
+int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
+{
+	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4938_pcic1ptr) {
+		switch (slot) {
+		case TX4927_PCIC_IDSEL_AD_TO_SLOT(31):
+			if (__raw_readq(&tx4938_ccfgptr->pcfg) &
+			    TX4938_PCFG_ETH0_SEL)
+				return TXX9_IRQ_BASE + TX4938_IR_ETH0;
+			break;
+		case TX4927_PCIC_IDSEL_AD_TO_SLOT(30):
+			if (__raw_readq(&tx4938_ccfgptr->pcfg) &
+			    TX4938_PCFG_ETH1_SEL)
+				return TXX9_IRQ_BASE + TX4938_IR_ETH1;
+			break;
+		}
+		return 0;
+	}
+	return -1;
+}
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 98d1034..b8cdb19 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -1,6 +1,12 @@
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
-	depends on TOSHIBA_RBTX4927
+	depends on PCI && (SYS_HAS_CPU_TX49XX || SYS_HAS_CPU_TX39XX)
+	select I8259
+
+config PICMG_PCI_BACKPLANE_DEFAULT
+	bool "Support for PICMG PCI Backplane"
+	depends on PCI && (SYS_HAS_CPU_TX49XX || SYS_HAS_CPU_TX39XX)
+	default y if !TOSHIBA_FPCIB0
 
 if TOSHIBA_RBTX4938
 
@@ -26,3 +32,6 @@ config TX4938_NAND_BOOT
 	  Select this option if you need to use NAND boot.
 
 endif
+
+config PCI_TX4927
+	bool
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 8cb4a7e..b80b6e0 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -2,6 +2,8 @@
 # Makefile for common code for TXx9 based systems
 #
 
+obj-y	+= setup.o
+obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= mem_tx4927.o irq_tx4927.o
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+= mem_tx4938.o irq_tx4938.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
new file mode 100644
index 0000000..8173faa
--- /dev/null
+++ b/arch/mips/txx9/generic/pci.c
@@ -0,0 +1,377 @@
+/*
+ * linux/arch/mips/txx9/pci.c
+ *
+ * Based on linux/arch/mips/txx9/rbtx4927/setup.c,
+ *          linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * Copyright 2001-2005 MontaVista Software Inc.
+ * Copyright (C) 1996, 97, 2001, 04  Ralf Baechle (ralf@linux-mips.org)
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <asm/txx9/pci.h>
+#ifdef CONFIG_TOSHIBA_FPCIB0
+#include <linux/interrupt.h>
+#include <asm/i8259.h>
+#include <asm/txx9/smsc_fdc37m81x.h>
+#endif
+
+static int __init
+early_read_config_word(struct pci_controller *hose,
+		       int top_bus, int bus, int devfn, int offset, u16 *value)
+{
+	struct pci_dev fake_dev;
+	struct pci_bus fake_bus;
+
+	fake_dev.bus = &fake_bus;
+	fake_dev.sysdata = hose;
+	fake_dev.devfn = devfn;
+	fake_bus.number = bus;
+	fake_bus.sysdata = hose;
+	fake_bus.ops = hose->pci_ops;
+
+	if (bus != top_bus)
+		/* Fake a parent bus structure. */
+		fake_bus.parent = &fake_bus;
+	else
+		fake_bus.parent = NULL;
+
+	return pci_read_config_word(&fake_dev, offset, value);
+}
+
+int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
+			    int current_bus)
+{
+	u32 pci_devfn;
+	unsigned short vid;
+	int cap66 = -1;
+	u16 stat;
+
+	/* It seems SLC90E66 needs some time after PCI reset... */
+	mdelay(80);
+
+	printk(KERN_INFO "PCI: Checking 66MHz capabilities...\n");
+
+	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
+		if (PCI_FUNC(pci_devfn))
+			continue;
+		if (early_read_config_word(hose, top_bus, current_bus,
+					   pci_devfn, PCI_VENDOR_ID, &vid) !=
+		    PCIBIOS_SUCCESSFUL)
+			continue;
+		if (vid == 0xffff)
+			continue;
+
+		/* check 66MHz capability */
+		if (cap66 < 0)
+			cap66 = 1;
+		if (cap66) {
+			early_read_config_word(hose, top_bus, current_bus,
+					       pci_devfn, PCI_STATUS, &stat);
+			if (!(stat & PCI_STATUS_66MHZ)) {
+				printk(KERN_DEBUG
+				       "PCI: %02x:%02x not 66MHz capable.\n",
+				       current_bus, pci_devfn);
+				cap66 = 0;
+				break;
+			}
+		}
+	}
+	return cap66 > 0;
+}
+
+static struct resource primary_pci_mem_res[2] = {
+	{ .name = "PCI MEM" },
+	{ .name = "PCI MMIO" },
+};
+static struct resource primary_pci_io_res = { .name = "PCI IO" };
+struct pci_controller txx9_primary_pcic = {
+	.mem_resource = &primary_pci_mem_res[0],
+	.io_resource = &primary_pci_io_res,
+};
+
+#ifdef CONFIG_64BIT
+int txx9_pci_mem_high __initdata = 1;
+#else
+int txx9_pci_mem_high __initdata;
+#endif
+
+/*
+ * allocate pci_controller and resources.
+ * mem_base, io_base: physical addresss.  0 for auto assignment.
+ * mem_size and io_size means max size on auto assignment.
+ * pcic must be &txx9_primary_pcic or NULL.
+ */
+struct pci_controller *__init
+txx9_alloc_pci_controller(struct pci_controller *pcic,
+			  unsigned long mem_base, unsigned long mem_size,
+			  unsigned long io_base, unsigned long io_size)
+{
+	struct pcic {
+		struct pci_controller c;
+		struct resource r_mem[2];
+		struct resource r_io;
+	} *new = NULL;
+	int min_size = 0x10000;
+
+	if (!pcic) {
+		new = kzalloc(sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return NULL;
+		new->r_mem[0].name = "PCI mem";
+		new->r_mem[1].name = "PCI mmio";
+		new->r_io.name = "PCI io";
+		new->c.mem_resource = new->r_mem;
+		new->c.io_resource = &new->r_io;
+		pcic = &new->c;
+	} else
+		BUG_ON(pcic != &txx9_primary_pcic);
+	pcic->io_resource->flags = IORESOURCE_IO;
+
+	/*
+	 * for auto assignment, first search a (big) region for PCI
+	 * MEM, then search a region for PCI IO.
+	 */
+	if (mem_base) {
+		pcic->mem_resource[0].start = mem_base;
+		pcic->mem_resource[0].end = mem_base + mem_size - 1;
+		if (request_resource(&iomem_resource, &pcic->mem_resource[0]))
+			goto free_and_exit;
+	} else {
+		unsigned long min = 0, max = 0x20000000; /* low 512MB */
+		if (!mem_size) {
+			/* default size for auto assignment */
+			if (txx9_pci_mem_high)
+				mem_size = 0x20000000;	/* mem:512M(max) */
+			else
+				mem_size = 0x08000000;	/* mem:128M(max) */
+		}
+		if (txx9_pci_mem_high) {
+			min = 0x20000000;
+			max = 0xe0000000;
+		}
+		/* search free region for PCI MEM */
+		for (; mem_size >= min_size; mem_size /= 2) {
+			if (allocate_resource(&iomem_resource,
+					      &pcic->mem_resource[0],
+					      mem_size, min, max,
+					      mem_size, NULL, NULL) == 0)
+				break;
+		}
+		if (mem_size < min_size)
+			goto free_and_exit;
+	}
+
+	pcic->mem_resource[1].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	if (io_base) {
+		pcic->mem_resource[1].start = io_base;
+		pcic->mem_resource[1].end = io_base + io_size - 1;
+		if (request_resource(&iomem_resource, &pcic->mem_resource[1]))
+			goto release_and_exit;
+	} else {
+		if (!io_size)
+			/* default size for auto assignment */
+			io_size = 0x01000000;	/* io:16M(max) */
+		/* search free region for PCI IO in low 512MB */
+		for (; io_size >= min_size; io_size /= 2) {
+			if (allocate_resource(&iomem_resource,
+					      &pcic->mem_resource[1],
+					      io_size, 0, 0x20000000,
+					      io_size, NULL, NULL) == 0)
+				break;
+		}
+		if (io_size < min_size)
+			goto release_and_exit;
+		io_base = pcic->mem_resource[1].start;
+	}
+
+	pcic->mem_resource[0].flags = IORESOURCE_MEM;
+	if (pcic == &txx9_primary_pcic &&
+	    mips_io_port_base == (unsigned long)-1) {
+		/* map ioport 0 to PCI I/O space address 0 */
+		set_io_port_base(IO_BASE + pcic->mem_resource[1].start);
+		pcic->io_resource->start = 0;
+		pcic->io_offset = 0;	/* busaddr == ioaddr */
+		pcic->io_map_base = IO_BASE + pcic->mem_resource[1].start;
+	} else {
+		/* physaddr to ioaddr */
+		pcic->io_resource->start =
+			io_base - (mips_io_port_base - IO_BASE);
+		pcic->io_offset = io_base - (mips_io_port_base - IO_BASE);
+		pcic->io_map_base = mips_io_port_base;
+	}
+	pcic->io_resource->end = pcic->io_resource->start + io_size - 1;
+
+	pcic->mem_offset = 0;	/* busaddr == physaddr */
+
+	printk(KERN_INFO "PCI: IO 0x%08llx-0x%08llx MEM 0x%08llx-0x%08llx\n",
+	       (unsigned long long)pcic->mem_resource[1].start,
+	       (unsigned long long)pcic->mem_resource[1].end,
+	       (unsigned long long)pcic->mem_resource[0].start,
+	       (unsigned long long)pcic->mem_resource[0].end);
+
+	/* register_pci_controller() will request MEM resource */
+	release_resource(&pcic->mem_resource[0]);
+	return pcic;
+ release_and_exit:
+	release_resource(&pcic->mem_resource[0]);
+ free_and_exit:
+	kfree(new);
+	printk(KERN_ERR "PCI: Failed to allocate resources.\n");
+	return NULL;
+}
+
+static int __init
+txx9_arch_pci_init(void)
+{
+	PCIBIOS_MIN_IO = 0x8000;	/* reseve legacy I/O space */
+	return 0;
+}
+arch_initcall(txx9_arch_pci_init);
+
+/* IRQ/IDSEL mapping */
+int txx9_pci_option =
+#ifdef CONFIG_PICMG_PCI_BACKPLANE_DEFAULT
+	TXX9_PCI_OPT_PICMG |
+#endif
+	TXX9_PCI_OPT_CLK_AUTO;
+
+enum txx9_pci_err_action txx9_pci_err_action = TXX9_PCI_ERR_REPORT;
+
+#ifdef CONFIG_TOSHIBA_FPCIB0
+static irqreturn_t i8259_interrupt(int irq, void *dev_id)
+{
+	int isairq;
+
+	isairq = i8259_irq();
+	if (unlikely(isairq <= I8259A_IRQ_BASE))
+		return IRQ_NONE;
+	generic_handle_irq(isairq);
+	return IRQ_HANDLED;
+}
+
+static int __init
+txx9_i8259_irq_setup(int irq)
+{
+	int err;
+
+	init_i8259_irqs();
+	err = request_irq(irq, &i8259_interrupt, IRQF_DISABLED|IRQF_SHARED,
+			  "cascade(i8259)", (void *)(long)irq);
+	if (!err)
+		printk(KERN_INFO "PCI-ISA bridge PIC (irq %d)\n", irq);
+	return err;
+}
+
+static void __init quirk_slc90e66_bridge(struct pci_dev *dev)
+{
+	int irq;	/* PCI/ISA Bridge interrupt */
+	u8 reg_64;
+	u32 reg_b0;
+	u8 reg_e1;
+	irq = pcibios_map_irq(dev, PCI_SLOT(dev->devfn), 1); /* INTA */
+	if (!irq)
+		return;
+	txx9_i8259_irq_setup(irq);
+	pci_read_config_byte(dev, 0x64, &reg_64);
+	pci_read_config_dword(dev, 0xb0, &reg_b0);
+	pci_read_config_byte(dev, 0xe1, &reg_e1);
+	/* serial irq control */
+	reg_64 = 0xd0;
+	/* serial irq pin */
+	reg_b0 |= 0x00010000;
+	/* ide irq on isa14 */
+	reg_e1 &= 0xf0;
+	reg_e1 |= 0x0d;
+	pci_write_config_byte(dev, 0x64, reg_64);
+	pci_write_config_dword(dev, 0xb0, reg_b0);
+	pci_write_config_byte(dev, 0xe1, reg_e1);
+
+	smsc_fdc37m81x_init(0x3f0);
+	smsc_fdc37m81x_config_beg();
+	smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
+				  SMSC_FDC37M81X_KBD);
+	smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
+	smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
+	smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
+				  1);
+	smsc_fdc37m81x_config_end();
+}
+
+static void quirk_slc90e66_ide(struct pci_dev *dev)
+{
+	unsigned char dat;
+	int regs[2] = {0x41, 0x43};
+	int i;
+
+	/* SMSC SLC90E66 IDE uses irq 14, 15 (default) */
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &dat);
+	printk(KERN_INFO "PCI: %s: IRQ %02x", pci_name(dev), dat);
+	/* enable SMSC SLC90E66 IDE */
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		pci_read_config_byte(dev, regs[i], &dat);
+		pci_write_config_byte(dev, regs[i], dat | 0x80);
+		pci_read_config_byte(dev, regs[i], &dat);
+		printk(KERN_CONT " IDETIM%d %02x", i, dat);
+	}
+	pci_read_config_byte(dev, 0x5c, &dat);
+	/*
+	 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
+	 *
+	 * This line of code is intended to provide the user with a work
+	 * around solution to the anomalies cited in SMSC's anomaly sheet
+	 * entitled, "SLC90E66 Functional Rev.J_0.1 Anomalies"".
+	 *
+	 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
+	 */
+	dat |= 0x01;
+	pci_write_config_byte(dev, regs[i], dat);
+	pci_read_config_byte(dev, 0x5c, &dat);
+	printk(KERN_CONT " REG5C %02x", dat);
+	printk(KERN_CONT "\n");
+}
+#endif /* CONFIG_TOSHIBA_FPCIB0 */
+
+static void final_fixup(struct pci_dev *dev)
+{
+	unsigned char bist;
+
+	/* Do build-in self test */
+	if (pci_read_config_byte(dev, PCI_BIST, &bist) == PCIBIOS_SUCCESSFUL &&
+	    (bist & PCI_BIST_CAPABLE)) {
+		unsigned long timeout;
+		pci_set_power_state(dev, PCI_D0);
+		printk(KERN_INFO "PCI: %s BIST...", pci_name(dev));
+		pci_write_config_byte(dev, PCI_BIST, PCI_BIST_START);
+		timeout = jiffies + HZ * 2;	/* timeout after 2 sec */
+		do {
+			pci_read_config_byte(dev, PCI_BIST, &bist);
+			if (time_after(jiffies, timeout))
+				break;
+		} while (bist & PCI_BIST_START);
+		if (bist & (PCI_BIST_CODE_MASK | PCI_BIST_START))
+			printk(KERN_CONT "failed. (0x%x)\n", bist);
+		else
+			printk(KERN_CONT "OK.\n");
+	}
+}
+
+#ifdef CONFIG_TOSHIBA_FPCIB0
+#define PCI_DEVICE_ID_EFAR_SLC90E66_0 0x9460
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_0,
+	quirk_slc90e66_bridge);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1,
+	quirk_slc90e66_ide);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1,
+	quirk_slc90e66_ide);
+#endif
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, final_fixup);
+DECLARE_PCI_FIXUP_RESUME(PCI_ANY_ID, PCI_ANY_ID, final_fixup);
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
new file mode 100644
index 0000000..46a6311
--- /dev/null
+++ b/arch/mips/txx9/generic/setup.c
@@ -0,0 +1,51 @@
+/*
+ * linux/arch/mips/txx9/generic/setup.c
+ *
+ * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * 2003-2005 (c) MontaVista Software, Inc.
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/txx9/generic.h>
+
+/* EBUSC settings of TX4927, etc. */
+struct resource txx9_ce_res[8];
+static char txx9_ce_res_name[8][4];	/* "CEn" */
+
+/* pcode, internal register */
+char txx9_pcode_str[8];
+static struct resource txx9_reg_res = {
+	.name = txx9_pcode_str,
+	.flags = IORESOURCE_MEM,
+};
+void __init
+txx9_reg_res_init(unsigned int pcode, unsigned long base, unsigned long size)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(txx9_ce_res); i++) {
+		sprintf(txx9_ce_res_name[i], "CE%d", i);
+		txx9_ce_res[i].flags = IORESOURCE_MEM;
+		txx9_ce_res[i].name = txx9_ce_res_name[i];
+	}
+
+	sprintf(txx9_pcode_str, "TX%x", pcode);
+	if (base) {
+		txx9_reg_res.start = base & 0xfffffffffULL;
+		txx9_reg_res.end = (base & 0xfffffffffULL) + (size - 1);
+		request_resource(&iomem_resource, &txx9_reg_res);
+	}
+}
+
+/* clocks */
+unsigned int txx9_master_clock;
+unsigned int txx9_cpu_clock;
+unsigned int txx9_gbus_clock;
diff --git a/arch/mips/txx9/jmr3927/irq.c b/arch/mips/txx9/jmr3927/irq.c
index 85e1daf..b97d22e 100644
--- a/arch/mips/txx9/jmr3927/irq.c
+++ b/arch/mips/txx9/jmr3927/irq.c
@@ -109,6 +109,7 @@ static struct irqaction ioc_action = {
 	.name = "IOC",
 };
 
+#ifdef CONFIG_PCI
 static irqreturn_t jmr3927_pcierr_interrupt(int irq, void *dev_id)
 {
 	printk(KERN_WARNING "PCI error interrupt (irq 0x%x).\n", irq);
@@ -122,6 +123,7 @@ static struct irqaction pcierr_action = {
 	.mask = CPU_MASK_NONE,
 	.name = "PCI error",
 };
+#endif
 
 static void __init jmr3927_irq_init(void);
 
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 41e0f3b..baa8c8d 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -30,7 +30,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
@@ -44,6 +43,7 @@
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
 #include <asm/reboot.h>
+#include <asm/txx9/pci.h>
 #include <asm/txx9/jmr3927.h>
 #include <asm/mipsregs.h>
 
@@ -96,8 +96,6 @@ void __init plat_time_init(void)
 
 extern char * __init prom_getcmdline(void);
 static void jmr3927_board_init(void);
-extern struct resource pci_io_resource;
-extern struct resource pci_mem_resource;
 
 void __init plat_mem_setup(void)
 {
@@ -112,8 +110,8 @@ void __init plat_mem_setup(void)
 	/*
 	 * IO/MEM resources.
 	 */
-	ioport_resource.start = pci_io_resource.start;
-	ioport_resource.end = pci_io_resource.end;
+	ioport_resource.start = 0;
+	ioport_resource.end = 0xffffffff;
 	iomem_resource.start = 0;
 	iomem_resource.end = 0xffffffff;
 
@@ -191,9 +189,33 @@ void __init plat_mem_setup(void)
 
 static void tx3927_setup(void);
 
+static void __init jmr3927_pci_setup(void)
+{
+#ifdef CONFIG_PCI
+	int extarb = !(tx3927_ccfgptr->ccfg & TX3927_CCFG_PCIXARB);
+	struct pci_controller *c;
+
+	c = txx9_alloc_pci_controller(&txx9_primary_pcic,
+				      JMR3927_PCIMEM, JMR3927_PCIMEM_SIZE,
+				      JMR3927_PCIIO, JMR3927_PCIIO_SIZE);
+	register_pci_controller(c);
+	if (!extarb) {
+		/* Reset PCI Bus */
+		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
+		udelay(100);
+		jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI,
+				    JMR3927_IOC_RESET_ADDR);
+		udelay(100);
+		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
+	}
+	tx3927_pcic_setup(c, JMR3927_SDRAM_SIZE, extarb);
+#endif /* CONFIG_PCI */
+}
+
 static void __init jmr3927_board_init(void)
 {
 	tx3927_setup();
+	jmr3927_pci_setup();
 
 	/* SIO0 DTR on */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_DTR_ADDR);
@@ -210,14 +232,6 @@ static void __init jmr3927_board_init(void)
 static void __init tx3927_setup(void)
 {
 	int i;
-#ifdef CONFIG_PCI
-	unsigned long mips_pci_io_base = JMR3927_PCIIO;
-	unsigned long mips_pci_io_size = JMR3927_PCIIO_SIZE;
-	unsigned long mips_pci_mem_base = JMR3927_PCIMEM;
-	unsigned long mips_pci_mem_size = JMR3927_PCIMEM_SIZE;
-	/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
-	unsigned long mips_pci_io_pciaddr = 0;
-#endif
 
 	/* SDRAMC are configured by PROM */
 
@@ -272,74 +286,6 @@ static void __init tx3927_setup(void)
 	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN | TX3927_DMA_MCR_LE;
 #endif
 
-#ifdef CONFIG_PCI
-	/* PCIC */
-	printk("TX3927 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:",
-	       tx3927_pcicptr->did, tx3927_pcicptr->vid,
-	       tx3927_pcicptr->rid);
-	if (!(tx3927_ccfgptr->ccfg & TX3927_CCFG_PCIXARB)) {
-		printk("External\n");
-		/* XXX */
-	} else {
-		printk("Internal\n");
-
-		/* Reset PCI Bus */
-		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-		udelay(100);
-		jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI,
-				    JMR3927_IOC_RESET_ADDR);
-		udelay(100);
-		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-
-
-		/* Disable External PCI Config. Access */
-		tx3927_pcicptr->lbc = TX3927_PCIC_LBC_EPCAD;
-#ifdef __BIG_ENDIAN
-		tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_IBSE |
-			TX3927_PCIC_LBC_TIBSE |
-			TX3927_PCIC_LBC_TMFBSE | TX3927_PCIC_LBC_MSDSE;
-#endif
-		/* LB->PCI mappings */
-		tx3927_pcicptr->iomas = ~(mips_pci_io_size - 1);
-		tx3927_pcicptr->ilbioma = mips_pci_io_base;
-		tx3927_pcicptr->ipbioma = mips_pci_io_pciaddr;
-		tx3927_pcicptr->mmas = ~(mips_pci_mem_size - 1);
-		tx3927_pcicptr->ilbmma = mips_pci_mem_base;
-		tx3927_pcicptr->ipbmma = mips_pci_mem_base;
-		/* PCI->LB mappings */
-		tx3927_pcicptr->iobas = 0xffffffff;
-		tx3927_pcicptr->ioba = 0;
-		tx3927_pcicptr->tlbioma = 0;
-		tx3927_pcicptr->mbas = ~(mips_pci_mem_size - 1);
-		tx3927_pcicptr->mba = 0;
-		tx3927_pcicptr->tlbmma = 0;
-		/* Enable Direct mapping Address Space Decoder */
-		tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_ILMDE | TX3927_PCIC_LBC_ILIDE;
-
-		/* Clear All Local Bus Status */
-		tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
-		/* Enable All Local Bus Interrupts */
-		tx3927_pcicptr->lbim = TX3927_PCIC_LBIM_ALL;
-		/* Clear All PCI Status Error */
-		tx3927_pcicptr->pcistat = TX3927_PCIC_PCISTATIM_ALL;
-		/* Enable All PCI Status Error Interrupts */
-		tx3927_pcicptr->pcistatim = TX3927_PCIC_PCISTATIM_ALL;
-
-		/* PCIC Int => IRC IRQ10 */
-		tx3927_pcicptr->il = TX3927_IR_PCI;
-		/* Target Control (per errata) */
-		tx3927_pcicptr->tc = TX3927_PCIC_TC_OF8E | TX3927_PCIC_TC_IF8E;
-
-		/* Enable Bus Arbiter */
-		tx3927_pcicptr->pbapmc = TX3927_PCIC_PBAPMC_PBAEN;
-
-		tx3927_pcicptr->pcicmd = PCI_COMMAND_MASTER |
-			PCI_COMMAND_MEMORY |
-			PCI_COMMAND_IO |
-			PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-	}
-#endif /* CONFIG_PCI */
-
 	/* PIO */
 	/* PIO[15:12] connected to LEDs */
 	__raw_writel(0x0000f000, &tx3927_pioptr->dir);
diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
index 936e50e..bef1447 100644
--- a/arch/mips/txx9/rbtx4927/irq.c
+++ b/arch/mips/txx9/rbtx4927/irq.c
@@ -111,9 +111,6 @@ JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthB
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
-#ifdef CONFIG_TOSHIBA_FPCIB0
-#include <asm/i8259.h>
-#endif
 #include <asm/txx9/rbtx4927.h>
 
 #define TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG   0
@@ -125,8 +122,6 @@ JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthB
 #define TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC TX4927_IRQ_NEST_EXT_ON_PIC
 #define TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC (TOSHIBA_RBTX4927_IRQ_IOC_BEG+2)
 
-extern int tx4927_using_backplane;
-
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
 
@@ -146,17 +141,8 @@ int toshiba_rbtx4927_irq_nested(int sw_irq)
 	u8 level3;
 
 	level3 = readb(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
-	if (level3) {
+	if (level3)
 		sw_irq = TOSHIBA_RBTX4927_IRQ_IOC_BEG + fls(level3) - 1;
-#ifdef CONFIG_TOSHIBA_FPCIB0
-		if (sw_irq == TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC &&
-		    tx4927_using_backplane) {
-			int irq = i8259_irq();
-			if (irq >= 0)
-				sw_irq = irq;
-		}
-#endif
-	}
 	return (sw_irq);
 }
 
@@ -205,10 +191,6 @@ void __init arch_init_irq(void)
 
 	tx4927_irq_init();
 	toshiba_rbtx4927_irq_ioc_init();
-#ifdef CONFIG_TOSHIBA_FPCIB0
-	if (tx4927_using_backplane)
-		init_i8259_irqs();
-#endif
 	/* Onboard 10M Ether: High Active */
 	set_irq_type(RBTX4927_RTL_8019_IRQ, IRQF_TRIGGER_HIGH);
 }
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index df1b6e9..86b870a 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -47,10 +47,10 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 #include <asm/bootinfo.h>
 #include <asm/io.h>
@@ -58,10 +58,10 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/txx9tmr.h>
-#ifdef CONFIG_TOSHIBA_FPCIB0
-#include <asm/txx9/smsc_fdc37m81x.h>
-#endif
+#include <asm/txx9/generic.h>
+#include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4927.h>
+#include <asm/txx9/tx4938.h>	/* for TX4937 */
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/serial_core.h>
 #endif
@@ -70,356 +70,116 @@
 extern void toshiba_rbtx4927_restart(char *command);
 extern void toshiba_rbtx4927_halt(void);
 extern void toshiba_rbtx4927_power_off(void);
-
-int tx4927_using_backplane = 0;
-
 extern void toshiba_rbtx4927_irq_setup(void);
 
 char *prom_getcmdline(void);
 
-#ifdef CONFIG_PCI
-#undef TX4927_SUPPORT_COMMAND_IO
-#undef  TX4927_SUPPORT_PCI_66
-int tx4927_cpu_clock = 100000000;	/* 100MHz */
-unsigned long mips_pci_io_base;
-unsigned long mips_pci_io_size;
-unsigned long mips_pci_mem_base;
-unsigned long mips_pci_mem_size;
-/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
-unsigned long mips_pci_io_pciaddr = 0;
-unsigned long mips_memory_upper;
 static int tx4927_ccfg_toeon = 1;
-static int tx4927_pcic_trdyto = 0;	/* default: disabled */
-unsigned long tx4927_ce_base[8];
-int tx4927_pci66 = 0;		/* 0:auto */
-#endif
 
 char *toshiba_name = "";
 
 #ifdef CONFIG_PCI
-extern struct pci_controller tx4927_controller;
-
-static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
-				    int top_bus, int busnr, int devfn)
+static void __init tx4927_pci_setup(void)
 {
-	static struct pci_dev dev;
-	static struct pci_bus bus;
-
-	dev.sysdata = (void *)hose;
-	dev.devfn = devfn;
-	bus.number = busnr;
-	bus.ops = hose->pci_ops;
-	bus.parent = NULL;
-	dev.bus = &bus;
-
-	return &dev;
-}
-
-#define EARLY_PCI_OP(rw, size, type)                                    \
-static int early_##rw##_config_##size(struct pci_controller *hose,      \
-        int top_bus, int bus, int devfn, int offset, type value)        \
-{                                                                       \
-        return pci_##rw##_config_##size(                                \
-                fake_pci_dev(hose, top_bus, bus, devfn),                \
-                offset, value);                                         \
+	int extarb = !(__raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_PCIARB);
+	struct pci_controller *c = &txx9_primary_pcic;
+
+	register_pci_controller(c);
+
+	if (__raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_PCI66)
+		txx9_pci_option =
+			(txx9_pci_option & ~TXX9_PCI_OPT_CLK_MASK) |
+			TXX9_PCI_OPT_CLK_66; /* already configured */
+
+	/* Reset PCI Bus */
+	writeb(1, rbtx4927_pcireset_addr);
+	/* Reset PCIC */
+	txx9_set64(&tx4927_ccfgptr->clkctr, TX4927_CLKCTR_PCIRST);
+	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
+	    TXX9_PCI_OPT_CLK_66)
+		tx4927_pciclk66_setup();
+	mdelay(10);
+	/* clear PCIC reset */
+	txx9_clear64(&tx4927_ccfgptr->clkctr, TX4927_CLKCTR_PCIRST);
+	writeb(0, rbtx4927_pcireset_addr);
+	iob();
+
+	tx4927_report_pciclk();
+	tx4927_pcic_setup(tx4927_pcicptr, c, extarb);
+	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
+	    TXX9_PCI_OPT_CLK_AUTO &&
+	    txx9_pci66_check(c, 0, 0)) {
+		/* Reset PCI Bus */
+		writeb(1, rbtx4927_pcireset_addr);
+		/* Reset PCIC */
+		txx9_set64(&tx4927_ccfgptr->clkctr, TX4927_CLKCTR_PCIRST);
+		tx4927_pciclk66_setup();
+		mdelay(10);
+		/* clear PCIC reset */
+		txx9_clear64(&tx4927_ccfgptr->clkctr, TX4927_CLKCTR_PCIRST);
+		writeb(0, rbtx4927_pcireset_addr);
+		iob();
+		/* Reinitialize PCIC */
+		tx4927_report_pciclk();
+		tx4927_pcic_setup(tx4927_pcicptr, c, extarb);
+	}
 }
 
-EARLY_PCI_OP(read, byte, u8 *)
-EARLY_PCI_OP(read, dword, u32 *)
-EARLY_PCI_OP(write, byte, u8)
-EARLY_PCI_OP(write, dword, u32)
-
-static int __init tx4927_pcibios_init(void)
+static void __init tx4937_pci_setup(void)
 {
-	unsigned int id;
-	u32 pci_devfn;
-	int devfn_start = 0;
-	int devfn_stop = 0xff;
-	int busno = 0; /* One bus on the Toshiba */
-	struct pci_controller *hose = &tx4927_controller;
-
-	for (pci_devfn = devfn_start; pci_devfn < devfn_stop; pci_devfn++) {
-		early_read_config_dword(hose, busno, busno, pci_devfn,
-					PCI_VENDOR_ID, &id);
-
-		if (id == 0xffffffff) {
-			continue;
-		}
-
-		if (id == 0x94601055) {
-			u8 v08_64;
-			u32 v32_b0;
-			u8 v08_e1;
-
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x64, &v08_64);
-			early_read_config_dword(hose, busno, busno,
-						pci_devfn, 0xb0, &v32_b0);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0xe1, &v08_e1);
-
-			/* serial irq control */
-			v08_64 = 0xd0;
-
-			/* serial irq pin */
-			v32_b0 |= 0x00010000;
-
-			/* ide irq on isa14 */
-			v08_e1 &= 0xf0;
-			v08_e1 |= 0x0d;
-
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x64, v08_64);
-			early_write_config_dword(hose, busno, busno,
-						 pci_devfn, 0xb0, v32_b0);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0xe1, v08_e1);
-		}
-
-		if (id == 0x91301055) {
-			u8 v08_04;
-			u8 v08_09;
-			u8 v08_41;
-			u8 v08_43;
-			u8 v08_5c;
-
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x04, &v08_04);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x09, &v08_09);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x41, &v08_41);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x43, &v08_43);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x5c, &v08_5c);
-
-			/* enable ide master/io */
-			v08_04 |= (PCI_COMMAND_MASTER | PCI_COMMAND_IO);
-
-			/* enable ide native mode */
-			v08_09 |= 0x05;
-
-			/* enable primary ide */
-			v08_41 |= 0x80;
-
-			/* enable secondary ide */
-			v08_43 |= 0x80;
-
-			/*
-			 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
-			 *
-			 * This line of code is intended to provide the user with a work
-			 * around solution to the anomalies cited in SMSC's anomaly sheet
-			 * entitled, "SLC90E66 Functional Rev.J_0.1 Anomalies"".
-			 *
-			 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
-			 */
-			v08_5c |= 0x01;
-
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x5c, v08_5c);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x04, v08_04);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x09, v08_09);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x41, v08_41);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x43, v08_43);
-		}
-
+	int extarb = !(__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCIARB);
+	struct pci_controller *c = &txx9_primary_pcic;
+
+	register_pci_controller(c);
+
+	if (__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCI66)
+		txx9_pci_option =
+			(txx9_pci_option & ~TXX9_PCI_OPT_CLK_MASK) |
+			TXX9_PCI_OPT_CLK_66; /* already configured */
+
+	/* Reset PCI Bus */
+	writeb(1, rbtx4927_pcireset_addr);
+	/* Reset PCIC */
+	txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
+	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
+	    TXX9_PCI_OPT_CLK_66)
+		tx4938_pciclk66_setup();
+	mdelay(10);
+	/* clear PCIC reset */
+	txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
+	writeb(0, rbtx4927_pcireset_addr);
+	iob();
+
+	tx4938_report_pciclk();
+	tx4927_pcic_setup(tx4938_pcicptr, c, extarb);
+	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
+	    TXX9_PCI_OPT_CLK_AUTO &&
+	    txx9_pci66_check(c, 0, 0)) {
+		/* Reset PCI Bus */
+		writeb(1, rbtx4927_pcireset_addr);
+		/* Reset PCIC */
+		txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
+		tx4938_pciclk66_setup();
+		mdelay(10);
+		/* clear PCIC reset */
+		txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
+		writeb(0, rbtx4927_pcireset_addr);
+		iob();
+		/* Reinitialize PCIC */
+		tx4938_report_pciclk();
+		tx4927_pcic_setup(tx4938_pcicptr, c, extarb);
 	}
-
-	register_pci_controller(&tx4927_controller);
-	return 0;
 }
 
-arch_initcall(tx4927_pcibios_init);
-
-extern struct resource pci_io_resource;
-extern struct resource pci_mem_resource;
-
-void __init tx4927_pci_setup(void)
+static int __init rbtx4927_arch_init(void)
 {
-	static int called = 0;
-	extern unsigned int tx4927_get_mem_size(void);
-
-	mips_memory_upper = tx4927_get_mem_size() << 20;
-	mips_memory_upper += KSEG0;
-	mips_pci_io_base = TX4927_PCIIO;
-	mips_pci_io_size = TX4927_PCIIO_SIZE;
-	mips_pci_mem_base = TX4927_PCIMEM;
-	mips_pci_mem_size = TX4927_PCIMEM_SIZE;
-
-	if (!called) {
-		printk
-		    ("%s PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
-		     toshiba_name,
-		     (unsigned short) (tx4927_pcicptr->pciid >> 16),
-		     (unsigned short) (tx4927_pcicptr->pciid & 0xffff),
-		     (unsigned short) (tx4927_pcicptr->pciccrev & 0xff),
-		     (!(tx4927_ccfgptr->
-			ccfg & TX4927_CCFG_PCIXARB)) ? "External" :
-		     "Internal");
-		called = 1;
-	}
-	printk("%s PCIC --%s PCICLK:", toshiba_name,
-	       (tx4927_ccfgptr->ccfg & TX4927_CCFG_PCI66) ? " PCI66" : "");
-	if (tx4927_ccfgptr->pcfg & TX4927_PCFG_PCICLKEN_ALL) {
-		int pciclk = 0;
-		if (mips_machtype == MACH_TOSHIBA_RBTX4937)
-			switch ((unsigned long) tx4927_ccfgptr->
-				ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
-			case TX4937_CCFG_PCIDIVMODE_4:
-				pciclk = tx4927_cpu_clock / 4;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_4_5:
-				pciclk = tx4927_cpu_clock * 2 / 9;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_5:
-				pciclk = tx4927_cpu_clock / 5;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_5_5:
-				pciclk = tx4927_cpu_clock * 2 / 11;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_8:
-				pciclk = tx4927_cpu_clock / 8;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_9:
-				pciclk = tx4927_cpu_clock / 9;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_10:
-				pciclk = tx4927_cpu_clock / 10;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_11:
-				pciclk = tx4927_cpu_clock / 11;
-				break;
-			}
-
-		else
-			switch ((unsigned long) tx4927_ccfgptr->
-				ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
-			case TX4927_CCFG_PCIDIVMODE_2_5:
-				pciclk = tx4927_cpu_clock * 2 / 5;
-				break;
-			case TX4927_CCFG_PCIDIVMODE_3:
-				pciclk = tx4927_cpu_clock / 3;
-				break;
-			case TX4927_CCFG_PCIDIVMODE_5:
-				pciclk = tx4927_cpu_clock / 5;
-				break;
-			case TX4927_CCFG_PCIDIVMODE_6:
-				pciclk = tx4927_cpu_clock / 6;
-				break;
-			}
-
-		printk("Internal(%dMHz)", pciclk / 1000000);
-	} else
-		printk("External");
-	printk("\n");
-
-	/* GB->PCI mappings */
-	tx4927_pcicptr->g2piomask = (mips_pci_io_size - 1) >> 4;
-	tx4927_pcicptr->g2piogbase = mips_pci_io_base |
-#ifdef __BIG_ENDIAN
-	    TX4927_PCIC_G2PIOGBASE_ECHG
-#else
-	    TX4927_PCIC_G2PIOGBASE_BSDIS
-#endif
-	    ;
-
-	tx4927_pcicptr->g2piopbase = 0;
-
-	tx4927_pcicptr->g2pmmask[0] = (mips_pci_mem_size - 1) >> 4;
-	tx4927_pcicptr->g2pmgbase[0] = mips_pci_mem_base |
-#ifdef __BIG_ENDIAN
-	    TX4927_PCIC_G2PMnGBASE_ECHG
-#else
-	    TX4927_PCIC_G2PMnGBASE_BSDIS
-#endif
-	    ;
-	tx4927_pcicptr->g2pmpbase[0] = mips_pci_mem_base;
-
-	tx4927_pcicptr->g2pmmask[1] = 0;
-	tx4927_pcicptr->g2pmgbase[1] = 0;
-	tx4927_pcicptr->g2pmpbase[1] = 0;
-	tx4927_pcicptr->g2pmmask[2] = 0;
-	tx4927_pcicptr->g2pmgbase[2] = 0;
-	tx4927_pcicptr->g2pmpbase[2] = 0;
-
-
-	/* PCI->GB mappings (I/O 256B) */
-	tx4927_pcicptr->p2giopbase = 0;	/* 256B */
-
-	/* PCI->GB mappings (MEM 512MB) M0 gets all of memory */
-	tx4927_pcicptr->p2gm0plbase = 0;
-	tx4927_pcicptr->p2gm0pubase = 0;
-	tx4927_pcicptr->p2gmgbase[0] = 0 | TX4927_PCIC_P2GMnGBASE_TMEMEN |
-#ifdef __BIG_ENDIAN
-	    TX4927_PCIC_P2GMnGBASE_TECHG
-#else
-	    TX4927_PCIC_P2GMnGBASE_TBSDIS
-#endif
-	    ;
-
-	/* PCI->GB mappings (MEM 16MB) -not used */
-	tx4927_pcicptr->p2gm1plbase = 0xffffffff;
-	tx4927_pcicptr->p2gm1pubase = 0xffffffff;
-	tx4927_pcicptr->p2gmgbase[1] = 0;
-
-	/* PCI->GB mappings (MEM 1MB) -not used */
-	tx4927_pcicptr->p2gm2pbase = 0xffffffff;
-	tx4927_pcicptr->p2gmgbase[2] = 0;
-
-
-	/* Enable Initiator Memory 0 Space, I/O Space, Config */
-	tx4927_pcicptr->pciccfg &= TX4927_PCIC_PCICCFG_LBWC_MASK;
-	tx4927_pcicptr->pciccfg |=
-	    TX4927_PCIC_PCICCFG_IMSE0 | TX4927_PCIC_PCICCFG_IISE |
-	    TX4927_PCIC_PCICCFG_ICAE | TX4927_PCIC_PCICCFG_ATR;
-
-
-	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
-	tx4927_pcicptr->pcicfg1 = 0;
-
-	if (tx4927_pcic_trdyto >= 0) {
-		tx4927_pcicptr->g2ptocnt &= ~0xff;
-		tx4927_pcicptr->g2ptocnt |= (tx4927_pcic_trdyto & 0xff);
-	}
-
-	/* Clear All Local Bus Status */
-	tx4927_pcicptr->pcicstatus = TX4927_PCIC_PCICSTATUS_ALL;
-	/* Enable All Local Bus Interrupts */
-	tx4927_pcicptr->pcicmask = TX4927_PCIC_PCICSTATUS_ALL;
-	/* Clear All Initiator Status */
-	tx4927_pcicptr->g2pstatus = TX4927_PCIC_G2PSTATUS_ALL;
-	/* Enable All Initiator Interrupts */
-	tx4927_pcicptr->g2pmask = TX4927_PCIC_G2PSTATUS_ALL;
-	/* Clear All PCI Status Error */
-	tx4927_pcicptr->pcistatus =
-	    (tx4927_pcicptr->pcistatus & 0x0000ffff) |
-	    (TX4927_PCIC_PCISTATUS_ALL << 16);
-	/* Enable All PCI Status Error Interrupts */
-	tx4927_pcicptr->pcimask = TX4927_PCIC_PCISTATUS_ALL;
-
-	/* PCIC Int => IRC IRQ16 */
-	tx4927_pcicptr->pcicfg2 =
-	    (tx4927_pcicptr->pcicfg2 & 0xffffff00) | TX4927_IR_PCIC;
-
-	if (!(tx4927_ccfgptr->ccfg & TX4927_CCFG_PCIXARB)) {
-		/* XXX */
-	} else {
-		/* Reset Bus Arbiter */
-		tx4927_pcicptr->pbacfg = TX4927_PCIC_PBACFG_RPBA;
-		/* Enable Bus Arbiter */
-		tx4927_pcicptr->pbacfg = TX4927_PCIC_PBACFG_PBAEN;
-	}
-
-	tx4927_pcicptr->pcistatus = PCI_COMMAND_MASTER |
-	    PCI_COMMAND_MEMORY |
-	    PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
+		tx4937_pci_setup();
+	else
+		tx4927_pci_setup();
+	return 0;
 }
+arch_initcall(rbtx4927_arch_init);
 #endif /* CONFIG_PCI */
 
 static void __noreturn wait_forever(void)
@@ -479,8 +239,6 @@ void __init plat_mem_setup(void)
 	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
 	write_c0_config(cp0_config);
 
-	set_io_port_base(KSEG1 + TBTX4927_ISA_IO_OFFSET);
-
 	ioport_resource.end = 0xffffffff;
 	iomem_resource.end = 0xffffffff;
 
@@ -492,8 +250,13 @@ void __init plat_mem_setup(void)
 		txx9_tmr_init(TX4927_TMR_REG(0) & 0xfffffffffULL);
 
 #ifdef CONFIG_PCI
+	txx9_alloc_pci_controller(&txx9_primary_pcic,
+				  RBTX4927_PCIMEM, RBTX4927_PCIMEM_SIZE,
+				  RBTX4927_PCIIO, RBTX4927_PCIIO_SIZE);
+#else
+	set_io_port_base(KSEG1 + RBTX4927_ISA_IO_OFFSET);
+#endif
 
-	/* PCIC */
 	/*
 	   * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
 	   *
@@ -517,58 +280,38 @@ void __init plat_mem_setup(void)
 	   *
 	 */
 	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
-		switch ((unsigned long)tx4927_ccfgptr->
-			ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
-		case TX4937_CCFG_PCIDIVMODE_8:
-		case TX4937_CCFG_PCIDIVMODE_4:
-			tx4927_cpu_clock = 266666666;	/* 266MHz */
+		switch ((unsigned long)__raw_readq(&tx4938_ccfgptr->ccfg) &
+			TX4938_CCFG_PCIDIVMODE_MASK) {
+		case TX4938_CCFG_PCIDIVMODE_8:
+		case TX4938_CCFG_PCIDIVMODE_4:
+			txx9_cpu_clock = 266666666;	/* 266MHz */
 			break;
-		case TX4937_CCFG_PCIDIVMODE_9:
-		case TX4937_CCFG_PCIDIVMODE_4_5:
-			tx4927_cpu_clock = 300000000;	/* 300MHz */
+		case TX4938_CCFG_PCIDIVMODE_9:
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			txx9_cpu_clock = 300000000;	/* 300MHz */
 			break;
 		default:
-			tx4927_cpu_clock = 333333333;	/* 333MHz */
+			txx9_cpu_clock = 333333333;	/* 333MHz */
 		}
 	else
-		switch ((unsigned long)tx4927_ccfgptr->
-			ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
+		switch ((unsigned long)__raw_readq(&tx4927_ccfgptr->ccfg) &
+			TX4927_CCFG_PCIDIVMODE_MASK) {
 		case TX4927_CCFG_PCIDIVMODE_2_5:
 		case TX4927_CCFG_PCIDIVMODE_5:
-			tx4927_cpu_clock = 166666666;	/* 166MHz */
+			txx9_cpu_clock = 166666666;	/* 166MHz */
 			break;
 		default:
-			tx4927_cpu_clock = 200000000;	/* 200MHz */
+			txx9_cpu_clock = 200000000;	/* 200MHz */
 		}
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
 
 	/* CCFG */
 	/* do reset on watchdog */
-	tx4927_ccfgptr->ccfg |= TX4927_CCFG_WR;
+	tx4927_ccfg_set(TX4927_CCFG_WR);
 	/* enable Timeout BusError */
 	if (tx4927_ccfg_toeon)
-		tx4927_ccfgptr->ccfg |= TX4927_CCFG_TOE;
-
-	tx4927_pci_setup();
-	if (tx4927_using_backplane == 1)
-		printk("backplane board IS installed\n");
-	else
-		printk("No Backplane \n");
-
-	/* this is on ISA bus behind PCI bus, so need PCI up first */
-#ifdef CONFIG_TOSHIBA_FPCIB0
-	if (tx4927_using_backplane) {
-		smsc_fdc37m81x_init(0x3f0);
-		smsc_fdc37m81x_config_beg();
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
-					  SMSC_FDC37M81X_KBD);
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
-					  1);
-		smsc_fdc37m81x_config_end();
-	}
-#endif
-#endif /* CONFIG_PCI */
+		tx4927_ccfg_set(TX4927_CCFG_TOE);
 
 #ifdef CONFIG_SERIAL_TXX9
 	{
@@ -611,8 +354,8 @@ void __init plat_mem_setup(void)
 
 void __init plat_time_init(void)
 {
-	mips_hpt_frequency = tx4927_cpu_clock / 2;
-	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_TINTDIS)
+	mips_hpt_frequency = txx9_cpu_clock / 2;
+	if (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_TINTDIS)
 		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
 				     TXX9_IRQ_BASE + 17,
 				     50000000);
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index bbd572c..144d2ca 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/console.h>
-#include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
@@ -26,6 +25,8 @@
 #include <asm/txx9tmr.h>
 #include <asm/io.h>
 #include <asm/bootinfo.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4938.h>
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/serial_core.h>
@@ -35,37 +36,13 @@
 #include <asm/txx9pio.h>
 
 extern char * __init prom_getcmdline(void);
-static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr);
-
 /* These functions are used for rebooting or halting the machine*/
 extern void rbtx4938_machine_restart(char *command);
 extern void rbtx4938_machine_halt(void);
 extern void rbtx4938_machine_power_off(void);
 
-/* clocks */
-unsigned int txx9_master_clock;
-unsigned int txx9_cpu_clock;
-unsigned int txx9_gbus_clock;
-
-unsigned long rbtx4938_ce_base[8];
-unsigned long rbtx4938_ce_size[8];
-int txboard_pci66_mode;
-static int tx4938_pcic_trdyto;	/* default: disabled */
-static int tx4938_pcic_retryto;	/* default: disabled */
 static int tx4938_ccfg_toeon = 1;
 
-struct tx4938_pcic_reg *pcicptrs[4] = {
-       tx4938_pcicptr  /* default setting for TX4938 */
-};
-
-static struct {
-	unsigned long base;
-	unsigned long size;
-} phys_regions[16] __initdata;
-static int num_phys_regions  __initdata;
-
-#define PHYS_REGION_MINSIZE	0x10000
-
 void rbtx4938_machine_halt(void)
 {
         printk(KERN_NOTICE "System Halted\n");
@@ -95,473 +72,72 @@ void rbtx4938_machine_restart(char *command)
 		;
 }
 
-void __init
-txboard_add_phys_region(unsigned long base, unsigned long size)
-{
-	if (num_phys_regions >= ARRAY_SIZE(phys_regions)) {
-		printk("phys_region overflow\n");
-		return;
-	}
-	phys_regions[num_phys_regions].base = base;
-	phys_regions[num_phys_regions].size = size;
-	num_phys_regions++;
-}
-unsigned long __init
-txboard_find_free_phys_region(unsigned long begin, unsigned long end,
-			      unsigned long size)
-{
-	unsigned long base;
-	int i;
-
-	for (base = begin / size * size; base < end; base += size) {
-		for (i = 0; i < num_phys_regions; i++) {
-			if (phys_regions[i].size &&
-			    base <= phys_regions[i].base + (phys_regions[i].size - 1) &&
-			    base + (size - 1) >= phys_regions[i].base)
-				break;
-		}
-		if (i == num_phys_regions)
-			return base;
-	}
-	return 0;
-}
-unsigned long __init
-txboard_find_free_phys_region_shrink(unsigned long begin, unsigned long end,
-				     unsigned long *size)
-{
-	unsigned long sz, base;
-	for (sz = *size; sz >= PHYS_REGION_MINSIZE; sz /= 2) {
-		base = txboard_find_free_phys_region(begin, end, sz);
-		if (base) {
-			*size = sz;
-			return base;
-		}
-	}
-	return 0;
-}
-unsigned long __init
-txboard_request_phys_region_range(unsigned long begin, unsigned long end,
-				  unsigned long size)
-{
-	unsigned long base;
-	base = txboard_find_free_phys_region(begin, end, size);
-	if (base)
-		txboard_add_phys_region(base, size);
-	return base;
-}
-unsigned long __init
-txboard_request_phys_region(unsigned long size)
+static void __init rbtx4938_pci_setup(void)
 {
-	unsigned long base;
-	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
-	base = txboard_find_free_phys_region(begin, end, size);
-	if (base)
-		txboard_add_phys_region(base, size);
-	return base;
-}
-unsigned long __init
-txboard_request_phys_region_shrink(unsigned long *size)
-{
-	unsigned long base;
-	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
-	base = txboard_find_free_phys_region_shrink(begin, end, size);
-	if (base)
-		txboard_add_phys_region(base, *size);
-	return base;
-}
-
 #ifdef CONFIG_PCI
-void __init
-tx4938_pcic_setup(struct tx4938_pcic_reg *pcicptr,
-		  struct pci_controller *channel,
-		  unsigned long pci_io_base,
-		  int extarb)
-{
-	int i;
+	int extarb = !(__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCIARB);
+	struct pci_controller *c = &txx9_primary_pcic;
 
-	/* Disable All Initiator Space */
-	pcicptr->pciccfg &= ~(TX4938_PCIC_PCICCFG_G2PMEN(0)|
-			      TX4938_PCIC_PCICCFG_G2PMEN(1)|
-			      TX4938_PCIC_PCICCFG_G2PMEN(2)|
-			      TX4938_PCIC_PCICCFG_G2PIOEN);
-
-	/* GB->PCI mappings */
-	pcicptr->g2piomask = (channel->io_resource->end - channel->io_resource->start) >> 4;
-	pcicptr->g2piogbase = pci_io_base |
-#ifdef __BIG_ENDIAN
-		TX4938_PCIC_G2PIOGBASE_ECHG
-#else
-		TX4938_PCIC_G2PIOGBASE_BSDIS
-#endif
-		;
-	pcicptr->g2piopbase = 0;
-	for (i = 0; i < 3; i++) {
-		pcicptr->g2pmmask[i] = 0;
-		pcicptr->g2pmgbase[i] = 0;
-		pcicptr->g2pmpbase[i] = 0;
-	}
-	if (channel->mem_resource->end) {
-		pcicptr->g2pmmask[0] = (channel->mem_resource->end - channel->mem_resource->start) >> 4;
-		pcicptr->g2pmgbase[0] = channel->mem_resource->start |
-#ifdef __BIG_ENDIAN
-			TX4938_PCIC_G2PMnGBASE_ECHG
-#else
-			TX4938_PCIC_G2PMnGBASE_BSDIS
-#endif
-			;
-		pcicptr->g2pmpbase[0] = channel->mem_resource->start;
-	}
-	/* PCI->GB mappings (I/O 256B) */
-	pcicptr->p2giopbase = 0; /* 256B */
-	pcicptr->p2giogbase = 0;
-	/* PCI->GB mappings (MEM 512MB (64MB on R1.x)) */
-	pcicptr->p2gm0plbase = 0;
-	pcicptr->p2gm0pubase = 0;
-	pcicptr->p2gmgbase[0] = 0 |
-		TX4938_PCIC_P2GMnGBASE_TMEMEN |
-#ifdef __BIG_ENDIAN
-		TX4938_PCIC_P2GMnGBASE_TECHG
-#else
-		TX4938_PCIC_P2GMnGBASE_TBSDIS
-#endif
-		;
-	/* PCI->GB mappings (MEM 16MB) */
-	pcicptr->p2gm1plbase = 0xffffffff;
-	pcicptr->p2gm1pubase = 0xffffffff;
-	pcicptr->p2gmgbase[1] = 0;
-	/* PCI->GB mappings (MEM 1MB) */
-	pcicptr->p2gm2pbase = 0xffffffff; /* 1MB */
-	pcicptr->p2gmgbase[2] = 0;
-
-	pcicptr->pciccfg &= TX4938_PCIC_PCICCFG_GBWC_MASK;
-	/* Enable Initiator Memory Space */
-	if (channel->mem_resource->end)
-		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PMEN(0);
-	/* Enable Initiator I/O Space */
-	if (channel->io_resource->end)
-		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PIOEN;
-	/* Enable Initiator Config */
-	pcicptr->pciccfg |=
-		TX4938_PCIC_PCICCFG_ICAEN |
-		TX4938_PCIC_PCICCFG_TCAR;
-
-	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
-	pcicptr->pcicfg1 = 0;
-
-	pcicptr->g2ptocnt &= ~0xffff;
-
-	if (tx4938_pcic_trdyto >= 0) {
-		pcicptr->g2ptocnt &= ~0xff;
-		pcicptr->g2ptocnt |= (tx4938_pcic_trdyto & 0xff);
-	}
-
-	if (tx4938_pcic_retryto >= 0) {
-		pcicptr->g2ptocnt &= ~0xff00;
-		pcicptr->g2ptocnt |= ((tx4938_pcic_retryto<<8) & 0xff00);
-	}
-
-	/* Clear All Local Bus Status */
-	pcicptr->pcicstatus = TX4938_PCIC_PCICSTATUS_ALL;
-	/* Enable All Local Bus Interrupts */
-	pcicptr->pcicmask = TX4938_PCIC_PCICSTATUS_ALL;
-	/* Clear All Initiator Status */
-	pcicptr->g2pstatus = TX4938_PCIC_G2PSTATUS_ALL;
-	/* Enable All Initiator Interrupts */
-	pcicptr->g2pmask = TX4938_PCIC_G2PSTATUS_ALL;
-	/* Clear All PCI Status Error */
-	pcicptr->pcistatus =
-		(pcicptr->pcistatus & 0x0000ffff) |
-		(TX4938_PCIC_PCISTATUS_ALL << 16);
-	/* Enable All PCI Status Error Interrupts */
-	pcicptr->pcimask = TX4938_PCIC_PCISTATUS_ALL;
-
-	if (!extarb) {
-		/* Reset Bus Arbiter */
-		pcicptr->pbacfg = TX4938_PCIC_PBACFG_RPBA;
-		pcicptr->pbabm = 0;
-		/* Enable Bus Arbiter */
-		pcicptr->pbacfg = TX4938_PCIC_PBACFG_PBAEN;
-	}
-
-      /* PCIC Int => IRC IRQ16 */
-	pcicptr->pcicfg2 =
-		    (pcicptr->pcicfg2 & 0xffffff00) | TX4938_IR_PCIC;
-
-	pcicptr->pcistatus = PCI_COMMAND_MASTER |
-		PCI_COMMAND_MEMORY |
-		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-}
-
-int __init
-tx4938_report_pciclk(void)
-{
-	unsigned long pcode = TX4938_REV_PCODE();
-	int pciclk = 0;
-	printk("TX%lx PCIC --%s PCICLK:",
-	       pcode,
-	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) ? " PCI66" : "");
-	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
-
-		switch ((unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK) {
-		case TX4938_CCFG_PCIDIVMODE_4:
-			pciclk = txx9_cpu_clock / 4; break;
-		case TX4938_CCFG_PCIDIVMODE_4_5:
-			pciclk = txx9_cpu_clock * 2 / 9; break;
-		case TX4938_CCFG_PCIDIVMODE_5:
-			pciclk = txx9_cpu_clock / 5; break;
-		case TX4938_CCFG_PCIDIVMODE_5_5:
-			pciclk = txx9_cpu_clock * 2 / 11; break;
-		case TX4938_CCFG_PCIDIVMODE_8:
-			pciclk = txx9_cpu_clock / 8; break;
-		case TX4938_CCFG_PCIDIVMODE_9:
-			pciclk = txx9_cpu_clock / 9; break;
-		case TX4938_CCFG_PCIDIVMODE_10:
-			pciclk = txx9_cpu_clock / 10; break;
-		case TX4938_CCFG_PCIDIVMODE_11:
-			pciclk = txx9_cpu_clock / 11; break;
-		}
-		printk("Internal(%dMHz)", pciclk / 1000000);
-	} else {
-		printk("External");
-		pciclk = -1;
-	}
-	printk("\n");
-	return pciclk;
-}
-
-void __init set_tx4938_pcicptr(int ch, struct tx4938_pcic_reg *pcicptr)
-{
-	pcicptrs[ch] = pcicptr;
-}
-
-struct tx4938_pcic_reg *get_tx4938_pcicptr(int ch)
-{
-       return pcicptrs[ch];
-}
-
-static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
-                                    int top_bus, int busnr, int devfn)
-{
-	static struct pci_dev dev;
-	static struct pci_bus bus;
+	register_pci_controller(c);
 
-	dev.sysdata = bus.sysdata = hose;
-	dev.devfn = devfn;
-	bus.number = busnr;
-	bus.ops = hose->pci_ops;
-	bus.parent = NULL;
-	dev.bus = &bus;
-
-	return &dev;
-}
-
-#define EARLY_PCI_OP(rw, size, type)                                    \
-static int early_##rw##_config_##size(struct pci_controller *hose,      \
-        int top_bus, int bus, int devfn, int offset, type value)        \
-{                                                                       \
-        return pci_##rw##_config_##size(                                \
-                fake_pci_dev(hose, top_bus, bus, devfn),                \
-                offset, value);                                         \
-}
-
-EARLY_PCI_OP(read, word, u16 *)
-
-int txboard_pci66_check(struct pci_controller *hose, int top_bus, int current_bus)
-{
-	u32 pci_devfn;
-	unsigned short vid;
-	int devfn_start = 0;
-	int devfn_stop = 0xff;
-	int cap66 = -1;
-	u16 stat;
-
-	printk("PCI: Checking 66MHz capabilities...\n");
-
-	for (pci_devfn=devfn_start; pci_devfn<devfn_stop; pci_devfn++) {
-		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID,
-					   &vid) != PCIBIOS_SUCCESSFUL)
-			continue;
-
-		if (vid == 0xffff) continue;
-
-		/* check 66MHz capability */
-		if (cap66 < 0)
-			cap66 = 1;
-		if (cap66) {
-			early_read_config_word(hose, top_bus, current_bus, pci_devfn,
-					       PCI_STATUS, &stat);
-			if (!(stat & PCI_STATUS_66MHZ)) {
-				printk(KERN_DEBUG "PCI: %02x:%02x not 66MHz capable.\n",
-				       current_bus, pci_devfn);
-				cap66 = 0;
-				break;
-			}
-		}
-	}
-	return cap66 > 0;
-}
-
-int __init
-tx4938_pciclk66_setup(void)
-{
-	int pciclk;
-
-	/* Assert M66EN */
-	tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI66;
-	/* Double PCICLK (if possible) */
-	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
-		unsigned int pcidivmode =
-			tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK;
-		switch (pcidivmode) {
-		case TX4938_CCFG_PCIDIVMODE_8:
-		case TX4938_CCFG_PCIDIVMODE_4:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_4;
-			pciclk = txx9_cpu_clock / 4;
-			break;
-		case TX4938_CCFG_PCIDIVMODE_9:
-		case TX4938_CCFG_PCIDIVMODE_4_5:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_4_5;
-			pciclk = txx9_cpu_clock * 2 / 9;
-			break;
-		case TX4938_CCFG_PCIDIVMODE_10:
-		case TX4938_CCFG_PCIDIVMODE_5:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_5;
-			pciclk = txx9_cpu_clock / 5;
-			break;
-		case TX4938_CCFG_PCIDIVMODE_11:
-		case TX4938_CCFG_PCIDIVMODE_5_5:
-		default:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_5_5;
-			pciclk = txx9_cpu_clock * 2 / 11;
-			break;
-		}
-		tx4938_ccfgptr->ccfg =
-			(tx4938_ccfgptr->ccfg & ~TX4938_CCFG_PCIDIVMODE_MASK)
-			| pcidivmode;
-		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
-		       (unsigned long)tx4938_ccfgptr->ccfg);
-	} else {
-		pciclk = -1;
-	}
-	return pciclk;
-}
-
-extern struct pci_controller tx4938_pci_controller[];
-static int __init tx4938_pcibios_init(void)
-{
-	unsigned long mem_base[2];
-	unsigned long mem_size[2] = {TX4938_PCIMEM_SIZE_0, TX4938_PCIMEM_SIZE_1}; /* MAX 128M,64K */
-	unsigned long io_base[2];
-	unsigned long io_size[2] = {TX4938_PCIIO_SIZE_0, TX4938_PCIIO_SIZE_1}; /* MAX 16M,64K */
-	/* TX4938 PCIC1: 64K MEM/IO is enough for ETH0,ETH1 */
-	int extarb = !(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB);
-
-	PCIBIOS_MIN_IO = 0x00001000UL;
-
-	mem_base[0] = txboard_request_phys_region_shrink(&mem_size[0]);
-	io_base[0] = txboard_request_phys_region_shrink(&io_size[0]);
-
-	printk("TX4938 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
-	       (unsigned short)(tx4938_pcicptr->pciid >> 16),
-	       (unsigned short)(tx4938_pcicptr->pciid & 0xffff),
-	       (unsigned short)(tx4938_pcicptr->pciccrev & 0xff),
-	       extarb ? "External" : "Internal");
-
-	/* setup PCI area */
-	tx4938_pci_controller[0].io_resource->start = io_base[0];
-	tx4938_pci_controller[0].io_resource->end = (io_base[0] + io_size[0]) - 1;
-	tx4938_pci_controller[0].mem_resource->start = mem_base[0];
-	tx4938_pci_controller[0].mem_resource->end = mem_base[0] + mem_size[0] - 1;
-
-	set_tx4938_pcicptr(0, tx4938_pcicptr);
-
-	register_pci_controller(&tx4938_pci_controller[0]);
-
-	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) {
-		printk("TX4938_CCFG_PCI66 already configured\n");
-		txboard_pci66_mode = -1; /* already configured */
-	}
+	if (__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCI66)
+		txx9_pci_option =
+			(txx9_pci_option & ~TXX9_PCI_OPT_CLK_MASK) |
+			TXX9_PCI_OPT_CLK_66; /* already configured */
 
 	/* Reset PCI Bus */
 	writeb(0, rbtx4938_pcireset_addr);
 	/* Reset PCIC */
-	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
-	if (txboard_pci66_mode > 0)
+	txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
+	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
+	    TXX9_PCI_OPT_CLK_66)
 		tx4938_pciclk66_setup();
 	mdelay(10);
 	/* clear PCIC reset */
-	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
+	txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
 	writeb(1, rbtx4938_pcireset_addr);
-	mmiowb();
-	tx4938_report_pcic_status1(tx4938_pcicptr);
+	iob();
 
 	tx4938_report_pciclk();
-	tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
-	if (txboard_pci66_mode == 0 &&
-	    txboard_pci66_check(&tx4938_pci_controller[0], 0, 0)) {
+	tx4927_pcic_setup(tx4938_pcicptr, c, extarb);
+	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
+	    TXX9_PCI_OPT_CLK_AUTO &&
+	    txx9_pci66_check(c, 0, 0)) {
 		/* Reset PCI Bus */
 		writeb(0, rbtx4938_pcireset_addr);
 		/* Reset PCIC */
-		tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
+		txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
 		tx4938_pciclk66_setup();
 		mdelay(10);
 		/* clear PCIC reset */
-		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
+		txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
 		writeb(1, rbtx4938_pcireset_addr);
-		mmiowb();
+		iob();
 		/* Reinitialize PCIC */
 		tx4938_report_pciclk();
-		tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
+		tx4927_pcic_setup(tx4938_pcicptr, c, extarb);
 	}
 
-	mem_base[1] = txboard_request_phys_region_shrink(&mem_size[1]);
-	io_base[1] = txboard_request_phys_region_shrink(&io_size[1]);
-	/* Reset PCIC1 */
-	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIC1RST;
-	/* PCI1DMD==0 => PCI1CLK==GBUSCLK/2 => PCI66 */
-	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD))
-		tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI1_66;
-	else
-		tx4938_ccfgptr->ccfg &= ~TX4938_CCFG_PCI1_66;
-	mdelay(10);
-	/* clear PCIC1 reset */
-	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
-	tx4938_report_pcic_status1(tx4938_pcic1ptr);
-
-	printk("TX4938 PCIC1 -- DID:%04x VID:%04x RID:%02x",
-	       (unsigned short)(tx4938_pcic1ptr->pciid >> 16),
-	       (unsigned short)(tx4938_pcic1ptr->pciid & 0xffff),
-	       (unsigned short)(tx4938_pcic1ptr->pciccrev & 0xff));
-	printk("%s PCICLK:%dMHz\n",
-	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1_66) ? " PCI66" : "",
-	       txx9_gbus_clock /
-	       ((tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD) ? 4 : 2) /
-	       1000000);
-
-	/* assumption: CPHYSADDR(mips_io_port_base) == io_base[0] */
-	tx4938_pci_controller[1].io_resource->start =
-		io_base[1] - io_base[0];
-	tx4938_pci_controller[1].io_resource->end =
-		io_base[1] - io_base[0] + io_size[1] - 1;
-	tx4938_pci_controller[1].mem_resource->start = mem_base[1];
-	tx4938_pci_controller[1].mem_resource->end =
-		mem_base[1] + mem_size[1] - 1;
-	set_tx4938_pcicptr(1, tx4938_pcic1ptr);
-
-	register_pci_controller(&tx4938_pci_controller[1]);
-
-	tx4938_pcic_setup(tx4938_pcic1ptr, &tx4938_pci_controller[1], io_base[1], extarb);
-
-	/* map ioport 0 to PCI I/O space address 0 */
-	set_io_port_base(KSEG1 + io_base[0]);
-
-	return 0;
-}
-
-arch_initcall(tx4938_pcibios_init);
-
+	if (__raw_readq(&tx4938_ccfgptr->pcfg) &
+	    (TX4938_PCFG_ETH0_SEL|TX4938_PCFG_ETH1_SEL)) {
+		/* Reset PCIC1 */
+		txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIC1RST);
+		/* PCI1DMD==0 => PCI1CLK==GBUSCLK/2 => PCI66 */
+		if (!(__raw_readq(&tx4938_ccfgptr->ccfg)
+		      & TX4938_CCFG_PCI1DMD))
+			tx4938_ccfg_set(TX4938_CCFG_PCI1_66);
+		mdelay(10);
+		/* clear PCIC1 reset */
+		txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIC1RST);
+		tx4938_report_pci1clk();
+
+		/* mem:64K(max), io:64K(max) (enough for ETH0,ETH1) */
+		c = txx9_alloc_pci_controller(NULL, 0, 0x10000, 0, 0x10000);
+		register_pci_controller(c);
+		tx4927_pcic_setup(tx4938_pcic1ptr, c, 0);
+	}
 #endif /* CONFIG_PCI */
+}
 
 /* SPI support */
 
@@ -594,7 +170,7 @@ static int __init rbtx4938_ethaddr_init(void)
 		unsigned int id =
 			TXX9_IRQ_BASE + (i ? TX4938_IR_ETH1 : TX4938_IR_ETH0);
 		struct platform_device *pdev;
-		if (!(tx4938_ccfgptr->pcfg &
+		if (!(__raw_readq(&tx4938_ccfgptr->pcfg) &
 		      (i ? TX4938_PCFG_ETH1_SEL : TX4938_PCFG_ETH0_SEL)))
 			continue;
 		pdev = platform_device_alloc("tc35815-mac", id);
@@ -611,18 +187,12 @@ device_initcall(rbtx4938_ethaddr_init);
 static void __init rbtx4938_spi_setup(void)
 {
 	/* set SPI_SEL */
-	tx4938_ccfgptr->pcfg |= TX4938_PCFG_SPI_SEL;
+	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_SPI_SEL);
 }
 
 static struct resource rbtx4938_fpga_resource;
-
-static char pcode_str[8];
-static struct resource tx4938_reg_resource = {
-	.start	= TX4938_REG_BASE,
-	.end	= TX4938_REG_BASE + TX4938_REG_SIZE,
-	.name	= pcode_str,
-	.flags	= IORESOURCE_MEM
-};
+static struct resource tx4938_sdram_resource[4];
+static struct resource tx4938_sram_resource;
 
 void __init tx4938_board_setup(void)
 {
@@ -631,24 +201,28 @@ void __init tx4938_board_setup(void)
 	int cpuclk = 0;
 	unsigned long pcode = TX4938_REV_PCODE();
 
-	ioport_resource.start = 0x1000;
+	ioport_resource.start = 0;
 	ioport_resource.end = 0xffffffff;
-	iomem_resource.start = 0x1000;
+	iomem_resource.start = 0;
 	iomem_resource.end = 0xffffffff;	/* expand to 4GB */
 
-	sprintf(pcode_str, "TX%lx", pcode);
+	txx9_reg_res_init(pcode, TX4938_REG_BASE,
+			  TX4938_REG_SIZE);
 	/* SDRAMC,EBUSC are configured by PROM */
 	for (i = 0; i < 8; i++) {
-		if (!(tx4938_ebuscptr->cr[i] & 0x8))
+		if (!(TX4938_EBUSC_CR(i) & 0x8))
 			continue;	/* disabled */
-		rbtx4938_ce_base[i] = (unsigned long)TX4938_EBUSC_BA(i);
-		txboard_add_phys_region(rbtx4938_ce_base[i], TX4938_EBUSC_SIZE(i));
+		txx9_ce_res[i].start = (unsigned long)TX4938_EBUSC_BA(i);
+		txx9_ce_res[i].end =
+			txx9_ce_res[i].start + TX4938_EBUSC_SIZE(i) - 1;
+		request_resource(&iomem_resource, &txx9_ce_res[i]);
 	}
 
 	/* clocks */
 	if (txx9_master_clock) {
+		u64 ccfg = ____raw_readq(&tx4938_ccfgptr->ccfg);
 		/* calculate gbus_clock and cpu_clock_freq from master_clock */
-		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		divmode = (__u32)ccfg & TX4938_CCFG_DIVMODE_MASK;
 		switch (divmode) {
 		case TX4938_CCFG_DIVMODE_8:
 		case TX4938_CCFG_DIVMODE_10:
@@ -678,12 +252,13 @@ void __init tx4938_board_setup(void)
 		}
 		txx9_cpu_clock = cpuclk;
 	} else {
+		u64 ccfg = ____raw_readq(&tx4938_ccfgptr->ccfg);
 		if (txx9_cpu_clock == 0) {
 			txx9_cpu_clock = 300000000;	/* 300MHz */
 		}
 		/* calculate gbus_clock and master_clock from cpu_clock_freq */
 		cpuclk = txx9_cpu_clock;
-		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		divmode = (__u32)ccfg & TX4938_CCFG_DIVMODE_MASK;
 		switch (divmode) {
 		case TX4938_CCFG_DIVMODE_2:
 		case TX4938_CCFG_DIVMODE_8:
@@ -717,32 +292,32 @@ void __init tx4938_board_setup(void)
 
 	/* CCFG */
 	/* clear WatchDogReset,BusErrorOnWrite flag (W1C) */
-	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WDRST | TX4938_CCFG_BEOW;
+	tx4938_ccfg_set(TX4938_CCFG_WDRST | TX4938_CCFG_BEOW);
 	/* do reset on watchdog */
-	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WR;
+	tx4938_ccfg_set(TX4938_CCFG_WR);
 	/* clear PCIC1 reset */
-	if (tx4938_ccfgptr->clkctr & TX4938_CLKCTR_PCIC1RST)
-		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
+	txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIC1RST);
 
 	/* enable Timeout BusError */
 	if (tx4938_ccfg_toeon)
-		tx4938_ccfgptr->ccfg |= TX4938_CCFG_TOE;
+		tx4938_ccfg_set(TX4938_CCFG_TOE);
 
 	/* DMA selection */
-	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_DMASEL_ALL;
+	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_DMASEL_ALL);
 
 	/* Use external clock for external arbiter */
-	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB))
-		tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_PCICLKEN_ALL;
-
-	printk("%s -- %dMHz(M%dMHz) CRIR:%08lx CCFG:%Lx PCFG:%Lx\n",
-	       pcode_str,
-	       cpuclk / 1000000, txx9_master_clock / 1000000,
-	       (unsigned long)tx4938_ccfgptr->crir,
-	       tx4938_ccfgptr->ccfg,
-	       tx4938_ccfgptr->pcfg);
-
-	printk("%s SDRAMC --", pcode_str);
+	if (!(____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCIARB))
+		txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_PCICLKEN_ALL);
+
+	printk(KERN_INFO "%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
+	       txx9_pcode_str,
+	       (cpuclk + 500000) / 1000000,
+	       (txx9_master_clock + 500000) / 1000000,
+	       (__u32)____raw_readq(&tx4938_ccfgptr->crir),
+	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->ccfg),
+	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->pcfg));
+
+	printk(KERN_INFO "%s SDRAMC --", txx9_pcode_str);
 	for (i = 0; i < 4; i++) {
 		unsigned long long cr = tx4938_sdramcptr->cr[i];
 		unsigned long ram_base, ram_size;
@@ -753,16 +328,24 @@ void __init tx4938_board_setup(void)
 		if (ram_base >= 0x20000000)
 			continue;	/* high memory (ignore) */
 		printk(" CR%d:%016Lx", i, cr);
-		txboard_add_phys_region(ram_base, ram_size);
+		tx4938_sdram_resource[i].name = "SDRAM";
+		tx4938_sdram_resource[i].start = ram_base;
+		tx4938_sdram_resource[i].end = ram_base + ram_size - 1;
+		tx4938_sdram_resource[i].flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, &tx4938_sdram_resource[i]);
 	}
 	printk(" TR:%09Lx\n", tx4938_sdramcptr->tr);
 
 	/* SRAM */
-	if (pcode == 0x4938 && tx4938_sramcptr->cr & 1) {
+	if (tx4938_sramcptr->cr & 1) {
 		unsigned int size = 0x800;
 		unsigned long base =
 			(tx4938_sramcptr->cr >> (39-11)) & ~(size - 1);
-		 txboard_add_phys_region(base, size);
+		tx4938_sram_resource.name = "SRAM";
+		tx4938_sram_resource.start = base;
+		tx4938_sram_resource.end = base + size - 1;
+		tx4938_sram_resource.flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, &tx4938_sram_resource);
 	}
 
 	/* TMR */
@@ -778,71 +361,15 @@ void __init tx4938_board_setup(void)
 	__raw_writel(0, &tx4938_pioptr->maskcpu);
 	__raw_writel(0, &tx4938_pioptr->maskext);
 
-	/* TX4938 internal registers */
-	if (request_resource(&iomem_resource, &tx4938_reg_resource))
-		printk("request resource for internal registers failed\n");
-}
-
 #ifdef CONFIG_PCI
-static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr)
-{
-	unsigned short pcistatus = (unsigned short)(pcicptr->pcistatus >> 16);
-	unsigned long g2pstatus = pcicptr->g2pstatus;
-	unsigned long pcicstatus = pcicptr->pcicstatus;
-	static struct {
-		unsigned long flag;
-		const char *str;
-	} pcistat_tbl[] = {
-		{ PCI_STATUS_DETECTED_PARITY,	"DetectedParityError" },
-		{ PCI_STATUS_SIG_SYSTEM_ERROR,	"SignaledSystemError" },
-		{ PCI_STATUS_REC_MASTER_ABORT,	"ReceivedMasterAbort" },
-		{ PCI_STATUS_REC_TARGET_ABORT,	"ReceivedTargetAbort" },
-		{ PCI_STATUS_SIG_TARGET_ABORT,	"SignaledTargetAbort" },
-		{ PCI_STATUS_PARITY,	"MasterParityError" },
-	}, g2pstat_tbl[] = {
-		{ TX4938_PCIC_G2PSTATUS_TTOE,	"TIOE" },
-		{ TX4938_PCIC_G2PSTATUS_RTOE,	"RTOE" },
-	}, pcicstat_tbl[] = {
-		{ TX4938_PCIC_PCICSTATUS_PME,	"PME" },
-		{ TX4938_PCIC_PCICSTATUS_TLB,	"TLB" },
-		{ TX4938_PCIC_PCICSTATUS_NIB,	"NIB" },
-		{ TX4938_PCIC_PCICSTATUS_ZIB,	"ZIB" },
-		{ TX4938_PCIC_PCICSTATUS_PERR,	"PERR" },
-		{ TX4938_PCIC_PCICSTATUS_SERR,	"SERR" },
-		{ TX4938_PCIC_PCICSTATUS_GBE,	"GBE" },
-		{ TX4938_PCIC_PCICSTATUS_IWB,	"IWB" },
-	};
-	int i;
-
-	printk("pcistat:%04x(", pcistatus);
-	for (i = 0; i < ARRAY_SIZE(pcistat_tbl); i++)
-		if (pcistatus & pcistat_tbl[i].flag)
-			printk("%s ", pcistat_tbl[i].str);
-	printk("), g2pstatus:%08lx(", g2pstatus);
-	for (i = 0; i < ARRAY_SIZE(g2pstat_tbl); i++)
-		if (g2pstatus & g2pstat_tbl[i].flag)
-			printk("%s ", g2pstat_tbl[i].str);
-	printk("), pcicstatus:%08lx(", pcicstatus);
-	for (i = 0; i < ARRAY_SIZE(pcicstat_tbl); i++)
-		if (pcicstatus & pcicstat_tbl[i].flag)
-			printk("%s ", pcicstat_tbl[i].str);
-	printk(")\n");
-}
-
-void tx4938_report_pcic_status(void)
-{
-	int i;
-	struct tx4938_pcic_reg *pcicptr;
-	for (i = 0; (pcicptr = get_tx4938_pcicptr(i)) != NULL; i++)
-		tx4938_report_pcic_status1(pcicptr);
+	txx9_alloc_pci_controller(&txx9_primary_pcic, 0, 0, 0, 0);
+#endif
 }
 
-#endif /* CONFIG_PCI */
-
 void __init plat_time_init(void)
 {
 	mips_hpt_frequency = txx9_cpu_clock / 2;
-	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_TINTDIS)
+	if (____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_TINTDIS)
 		txx9_clockevent_init(TX4938_TMR_REG(0) & 0xfffffffffULL,
 				     TXX9_IRQ_BASE + TX4938_IR_TMR(0),
 				     txx9_gbus_clock / 2);
@@ -890,19 +417,20 @@ void __init plat_mem_setup(void)
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
 	printk("PIOSEL: disabling both ata and nand selection\n");
 	local_irq_disable();
-	tx4938_ccfgptr->pcfg &= ~(TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
+	txx9_clear64(&tx4938_ccfgptr->pcfg,
+		     TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND
 	printk("PIOSEL: enabling nand selection\n");
-	tx4938_ccfgptr->pcfg |= TX4938_PCFG_NDF_SEL;
-	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_ATA_SEL;
+	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
+	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA
 	printk("PIOSEL: enabling ata selection\n");
-	tx4938_ccfgptr->pcfg |= TX4938_PCFG_ATA_SEL;
-	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_NDF_SEL;
+	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
+	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
 #endif
 
 #ifdef CONFIG_IP_PNP
@@ -920,7 +448,7 @@ void __init plat_mem_setup(void)
 #endif
 
 	rbtx4938_spi_setup();
-	pcfg = tx4938_ccfgptr->pcfg;	/* updated */
+	pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);	/* updated */
 	/* fixup piosel */
 	if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
 	    TX4938_PCFG_ATA_SEL)
@@ -1063,6 +591,7 @@ static int __init rbtx4938_arch_init(void)
 {
 	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, 16);
 	gpiochip_add(&rbtx4938_spi_gpio_chip);
+	rbtx4938_pci_setup();
 	return rbtx4938_spi_init();
 }
 arch_initcall(rbtx4938_arch_init);
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
new file mode 100644
index 0000000..2ff6c20
--- /dev/null
+++ b/include/asm-mips/txx9/generic.h
@@ -0,0 +1,23 @@
+/*
+ * linux/include/asm-mips/txx9/generic.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_TXX9_GENERIC_H
+#define __ASM_TXX9_GENERIC_H
+
+#include <linux/init.h>
+#include <linux/ioport.h>	/* for struct resource */
+
+extern struct resource txx9_ce_res[];
+extern char txx9_pcode_str[8];
+void txx9_reg_res_init(unsigned int pcode, unsigned long base,
+		       unsigned long size);
+
+extern unsigned int txx9_master_clock;
+extern unsigned int txx9_cpu_clock;
+extern unsigned int txx9_gbus_clock;
+
+#endif /* __ASM_TXX9_GENERIC_H */
diff --git a/include/asm-mips/txx9/pci.h b/include/asm-mips/txx9/pci.h
new file mode 100644
index 0000000..d89a450
--- /dev/null
+++ b/include/asm-mips/txx9/pci.h
@@ -0,0 +1,36 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_TXX9_PCI_H
+#define __ASM_TXX9_PCI_H
+
+#include <linux/pci.h>
+
+extern struct pci_controller txx9_primary_pcic;
+struct pci_controller *
+txx9_alloc_pci_controller(struct pci_controller *pcic,
+			  unsigned long mem_base, unsigned long mem_size,
+			  unsigned long io_base, unsigned long io_size);
+
+int txx9_pci66_check(struct pci_controller *hose, int top_bus,
+			int current_bus);
+extern int txx9_pci_mem_high __initdata;
+
+extern int txx9_pci_option;
+#define TXX9_PCI_OPT_PICMG	0x0002
+#define TXX9_PCI_OPT_CLK_33	0x0008
+#define TXX9_PCI_OPT_CLK_66	0x0010
+#define TXX9_PCI_OPT_CLK_MASK	\
+	(TXX9_PCI_OPT_CLK_33 | TXX9_PCI_OPT_CLK_66)
+#define TXX9_PCI_OPT_CLK_AUTO	TXX9_PCI_OPT_CLK_MASK
+
+enum txx9_pci_err_action {
+	TXX9_PCI_ERR_REPORT,
+	TXX9_PCI_ERR_IGNORE,
+	TXX9_PCI_ERR_PANIC,
+};
+extern enum txx9_pci_err_action txx9_pci_err_action;
+
+#endif /* __ASM_TXX9_PCI_H */
diff --git a/include/asm-mips/txx9/rbtx4927.h b/include/asm-mips/txx9/rbtx4927.h
index 5531342..5b6f488 100644
--- a/include/asm-mips/txx9/rbtx4927.h
+++ b/include/asm-mips/txx9/rbtx4927.h
@@ -29,10 +29,33 @@
 
 #include <asm/txx9/tx4927.h>
 
+#define RBTX4927_PCIMEM		0x08000000
+#define RBTX4927_PCIMEM_SIZE	0x08000000
+#define RBTX4927_PCIIO		0x16000000
+#define RBTX4927_PCIIO_SIZE	0x01000000
+
+#define rbtx4927_pcireset_addr	((__u8 __iomem *)0xbc00f006UL)
+
+/* bits for ISTAT/IMASK/IMSTAT */
+#define RBTX4927_INTB_PCID	0
+#define RBTX4927_INTB_PCIC	1
+#define RBTX4927_INTB_PCIB	2
+#define RBTX4927_INTB_PCIA	3
+#define RBTX4927_INTF_PCID	(1 << RBTX4927_INTB_PCID)
+#define RBTX4927_INTF_PCIC	(1 << RBTX4927_INTB_PCIC)
+#define RBTX4927_INTF_PCIB	(1 << RBTX4927_INTB_PCIB)
+#define RBTX4927_INTF_PCIA	(1 << RBTX4927_INTB_PCIA)
+
+#define RBTX4927_IRQ_IOC	(TX4927_IRQ_PIC_BEG + TX4927_NUM_IR)
+#define RBTX4927_IRQ_IOC_PCID	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCID)
+#define RBTX4927_IRQ_IOC_PCIC	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCIC)
+#define RBTX4927_IRQ_IOC_PCIB	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCIB)
+#define RBTX4927_IRQ_IOC_PCIA	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCIA)
+
 #ifdef CONFIG_PCI
-#define TBTX4927_ISA_IO_OFFSET TX4927_PCIIO
+#define RBTX4927_ISA_IO_OFFSET RBTX4927_PCIIO
 #else
-#define TBTX4927_ISA_IO_OFFSET 0
+#define RBTX4927_ISA_IO_OFFSET 0
 #endif
 
 #define RBTX4927_SW_RESET_DO         (void __iomem *)0xbc00f000UL
@@ -41,7 +64,7 @@
 #define RBTX4927_SW_RESET_ENABLE     (void __iomem *)0xbc00f002UL
 #define RBTX4927_SW_RESET_ENABLE_SET            0x01
 
-#define RBTX4927_RTL_8019_BASE (0x1c020280-TBTX4927_ISA_IO_OFFSET)
+#define RBTX4927_RTL_8019_BASE (0x1c020280 - RBTX4927_ISA_IO_OFFSET)
 #define RBTX4927_RTL_8019_IRQ  (TX4927_IRQ_PIC_BEG + 5)
 
 int toshiba_rbtx4927_irq_nested(int sw_irq);
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index 63b62d6..ca414c7 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -316,4 +316,8 @@ struct tx3927_ccfg_reg {
 #define tx3927_sioptr(ch)	((struct txx927_sio_reg *)TX3927_SIO_REG(ch))
 #define tx3927_pioptr		((struct txx9_pio_reg __iomem *)TX3927_PIO_REG)
 
+struct pci_controller;
+void __init tx3927_pcic_setup(struct pci_controller *channel,
+			      unsigned long sdram_size, int extarb);
+
 #endif /* __ASM_TXX9_TX3927_H */
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index f21a7b1..c0382fd 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -27,7 +27,10 @@
 #ifndef __ASM_TXX9_TX4927_H
 #define __ASM_TXX9_TX4927_H
 
+#include <linux/types.h>
+#include <linux/io.h>
 #include <asm/txx9irq.h>
+#include <asm/txx9/tx4927pcic.h>
 
 #define TX4927_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
 #define TX4927_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
@@ -43,15 +46,6 @@
 
 #define TX4927_IRQ_NEST_EXT_ON_PIC  (TX4927_IRQ_PIC_BEG+3)
 
-#define TX4927_CCFG_TOE 0x00004000
-#define TX4927_CCFG_WR	0x00008000
-#define TX4927_CCFG_TINTDIS	0x01000000
-
-#define TX4927_PCIMEM	   0x08000000
-#define TX4927_PCIMEM_SIZE 0x08000000
-#define TX4927_PCIIO	   0x16000000
-#define TX4927_PCIIO_SIZE  0x01000000
-
 #define TX4927_SDRAMC_REG	0xff1f8000
 #define TX4927_EBUSC_REG	0xff1f9000
 #define TX4927_PCIC_REG		0xff1fd000
@@ -60,36 +54,9 @@
 #define TX4927_NR_TMR	3
 #define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
 
-/* bits for ISTAT3/IMASK3/IMSTAT3 */
-#define TX4927_INT3B_PCID	0
-#define TX4927_INT3B_PCIC	1
-#define TX4927_INT3B_PCIB	2
-#define TX4927_INT3B_PCIA	3
-#define TX4927_INT3F_PCID	(1 << TX4927_INT3B_PCID)
-#define TX4927_INT3F_PCIC	(1 << TX4927_INT3B_PCIC)
-#define TX4927_INT3F_PCIB	(1 << TX4927_INT3B_PCIB)
-#define TX4927_INT3F_PCIA	(1 << TX4927_INT3B_PCIA)
-
-#define TX4927_NR_IRQ_LOCAL	TX4927_IRQ_PIC_BEG
-#define TX4927_NR_IRQ_IRC	32	/* On-Chip IRC */
-
 #define TX4927_IR_PCIC		16
 #define TX4927_IR_PCIERR	22
-#define TX4927_IR_PCIPMA	23
-#define TX4927_IRQ_IRC_PCIC	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIC)
-#define TX4927_IRQ_IRC_PCIERR	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIERR)
-#define TX4927_IRQ_IOC1		(TX4927_NR_IRQ_LOCAL + TX4927_NR_IRQ_IRC)
-#define TX4927_IRQ_IOC_PCID	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCID)
-#define TX4927_IRQ_IOC_PCIC	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIC)
-#define TX4927_IRQ_IOC_PCIB	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIB)
-#define TX4927_IRQ_IOC_PCIA	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIA)
-
-#ifdef _LANGUAGE_ASSEMBLY
-#define _CONST64(c)	c
-#else
-#define _CONST64(c)	c##ull
-
-#include <asm/byteorder.h>
+#define TX4927_NUM_IR	32
 
 struct tx4927_sdramc_reg {
 	volatile unsigned long long cr[4];
@@ -104,177 +71,158 @@ struct tx4927_ebusc_reg {
 };
 
 struct tx4927_ccfg_reg {
-	volatile unsigned long long ccfg;
-	volatile unsigned long long crir;
-	volatile unsigned long long pcfg;
-	volatile unsigned long long tear;
-	volatile unsigned long long clkctr;
-	volatile unsigned long long unused0;
-	volatile unsigned long long garbc;
-	volatile unsigned long long unused1;
-	volatile unsigned long long unused2;
-	volatile unsigned long long ramp;
-};
-
-struct tx4927_pcic_reg {
-	volatile unsigned long pciid;
-	volatile unsigned long pcistatus;
-	volatile unsigned long pciccrev;
-	volatile unsigned long pcicfg1;
-	volatile unsigned long p2gm0plbase;		/* +10 */
-	volatile unsigned long p2gm0pubase;
-	volatile unsigned long p2gm1plbase;
-	volatile unsigned long p2gm1pubase;
-	volatile unsigned long p2gm2pbase;		/* +20 */
-	volatile unsigned long p2giopbase;
-	volatile unsigned long unused0;
-	volatile unsigned long pcisid;
-	volatile unsigned long unused1;		/* +30 */
-	volatile unsigned long pcicapptr;
-	volatile unsigned long unused2;
-	volatile unsigned long pcicfg2;
-	volatile unsigned long g2ptocnt;		/* +40 */
-	volatile unsigned long unused3[15];
-	volatile unsigned long g2pstatus;		/* +80 */
-	volatile unsigned long g2pmask;
-	volatile unsigned long pcisstatus;
-	volatile unsigned long pcimask;
-	volatile unsigned long p2gcfg;		/* +90 */
-	volatile unsigned long p2gstatus;
-	volatile unsigned long p2gmask;
-	volatile unsigned long p2gccmd;
-	volatile unsigned long unused4[24];		/* +a0 */
-	volatile unsigned long pbareqport;		/* +100 */
-	volatile unsigned long pbacfg;
-	volatile unsigned long pbastatus;
-	volatile unsigned long pbamask;
-	volatile unsigned long pbabm;		/* +110 */
-	volatile unsigned long pbacreq;
-	volatile unsigned long pbacgnt;
-	volatile unsigned long pbacstate;
-	volatile unsigned long long g2pmgbase[3];		/* +120 */
-	volatile unsigned long long g2piogbase;
-	volatile unsigned long g2pmmask[3];		/* +140 */
-	volatile unsigned long g2piomask;
-	volatile unsigned long long g2pmpbase[3];		/* +150 */
-	volatile unsigned long long g2piopbase;
-	volatile unsigned long pciccfg;		/* +170 */
-	volatile unsigned long pcicstatus;
-	volatile unsigned long pcicmask;
-	volatile unsigned long unused5;
-	volatile unsigned long long p2gmgbase[3];		/* +180 */
-	volatile unsigned long long p2giogbase;
-	volatile unsigned long g2pcfgadrs;		/* +1a0 */
-	volatile unsigned long g2pcfgdata;
-	volatile unsigned long unused6[8];
-	volatile unsigned long g2pintack;
-	volatile unsigned long g2pspc;
-	volatile unsigned long unused7[12];		/* +1d0 */
-	volatile unsigned long long pdmca;		/* +200 */
-	volatile unsigned long long pdmga;
-	volatile unsigned long long pdmpa;
-	volatile unsigned long long pdmcut;
-	volatile unsigned long long pdmcnt;		/* +220 */
-	volatile unsigned long long pdmsts;
-	volatile unsigned long long unused8[2];
-	volatile unsigned long long pdmdb[4];		/* +240 */
-	volatile unsigned long long pdmtdh;		/* +260 */
-	volatile unsigned long long pdmdms;
+	u64 ccfg;
+	u64 crir;
+	u64 pcfg;
+	u64 toea;
+	u64 clkctr;
+	u64 unused0;
+	u64 garbc;
+	u64 unused1;
+	u64 unused2;
+	u64 ramp;
 };
 
-#endif /* _LANGUAGE_ASSEMBLY */
-
-/*
- * PCIC
- */
-
-/* bits for G2PSTATUS/G2PMASK */
-#define TX4927_PCIC_G2PSTATUS_ALL	0x00000003
-#define TX4927_PCIC_G2PSTATUS_TTOE	0x00000002
-#define TX4927_PCIC_G2PSTATUS_RTOE	0x00000001
-
-/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
-#define TX4927_PCIC_PCISTATUS_ALL	0x0000f900
-
-/* bits for PBACFG */
-#define TX4927_PCIC_PBACFG_RPBA 0x00000004
-#define TX4927_PCIC_PBACFG_PBAEN	0x00000002
-#define TX4927_PCIC_PBACFG_BMCEN	0x00000001
-
-/* bits for G2PMnGBASE */
-#define TX4927_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for G2PIOGBASE */
-#define TX4927_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for PCICSTATUS/PCICMASK */
-#define TX4927_PCIC_PCICSTATUS_ALL	0x000007dc
-
-/* bits for PCICCFG */
-#define TX4927_PCIC_PCICCFG_LBWC_MASK	0x0fff0000
-#define TX4927_PCIC_PCICCFG_HRST	0x00000800
-#define TX4927_PCIC_PCICCFG_SRST	0x00000400
-#define TX4927_PCIC_PCICCFG_IRBER	0x00000200
-#define TX4927_PCIC_PCICCFG_IMSE0	0x00000100
-#define TX4927_PCIC_PCICCFG_IMSE1	0x00000080
-#define TX4927_PCIC_PCICCFG_IMSE2	0x00000040
-#define TX4927_PCIC_PCICCFG_IISE	0x00000020
-#define TX4927_PCIC_PCICCFG_ATR 0x00000010
-#define TX4927_PCIC_PCICCFG_ICAE	0x00000008
-
-/* bits for P2GMnGBASE */
-#define TX4927_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
-#define TX4927_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
-
-/* bits for P2GIOGBASE */
-#define TX4927_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
-#define TX4927_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
-
-#define TX4927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
-#define TX4927_PCIC_MAX_DEVNU	TX4927_PCIC_IDSEL_AD_TO_SLOT(32)
-
 /*
  * CCFG
  */
 /* CCFG : Chip Configuration */
+#define TX4927_CCFG_WDRST	0x0000020000000000ULL
+#define TX4927_CCFG_WDREXEN	0x0000010000000000ULL
+#define TX4927_CCFG_BCFG_MASK	0x000000ff00000000ULL
+#define TX4927_CCFG_TINTDIS	0x01000000
 #define TX4927_CCFG_PCI66	0x00800000
-#define TX4927_CCFG_PCIMIDE	0x00400000
-#define TX4927_CCFG_PCIXARB	0x00002000
+#define TX4927_CCFG_PCIMODE	0x00400000
+#define TX4927_CCFG_DIVMODE_MASK	0x000e0000
+#define TX4927_CCFG_DIVMODE_8	(0x0 << 17)
+#define TX4927_CCFG_DIVMODE_12	(0x1 << 17)
+#define TX4927_CCFG_DIVMODE_16	(0x2 << 17)
+#define TX4927_CCFG_DIVMODE_10	(0x3 << 17)
+#define TX4927_CCFG_DIVMODE_2	(0x4 << 17)
+#define TX4927_CCFG_DIVMODE_3	(0x5 << 17)
+#define TX4927_CCFG_DIVMODE_4	(0x6 << 17)
+#define TX4927_CCFG_DIVMODE_2_5	(0x7 << 17)
+#define TX4927_CCFG_BEOW	0x00010000
+#define TX4927_CCFG_WR	0x00008000
+#define TX4927_CCFG_TOE	0x00004000
+#define TX4927_CCFG_PCIARB	0x00002000
 #define TX4927_CCFG_PCIDIVMODE_MASK	0x00001800
 #define TX4927_CCFG_PCIDIVMODE_2_5	0x00000000
 #define TX4927_CCFG_PCIDIVMODE_3	0x00000800
 #define TX4927_CCFG_PCIDIVMODE_5	0x00001000
 #define TX4927_CCFG_PCIDIVMODE_6	0x00001800
-
-#define TX4937_CCFG_PCIDIVMODE_MASK	0x00001c00
-#define TX4937_CCFG_PCIDIVMODE_8	0x00000000
-#define TX4937_CCFG_PCIDIVMODE_4	0x00000400
-#define TX4937_CCFG_PCIDIVMODE_9	0x00000800
-#define TX4937_CCFG_PCIDIVMODE_4_5	0x00000c00
-#define TX4937_CCFG_PCIDIVMODE_10	0x00001000
-#define TX4937_CCFG_PCIDIVMODE_5	0x00001400
-#define TX4937_CCFG_PCIDIVMODE_11	0x00001800
-#define TX4937_CCFG_PCIDIVMODE_5_5	0x00001c00
+#define TX4927_CCFG_SYSSP_MASK	0x000000c0
+#define TX4927_CCFG_ENDIAN	0x00000004
+#define TX4927_CCFG_HALT	0x00000002
+#define TX4927_CCFG_ACEHOLD	0x00000001
+#define TX4927_CCFG_W1CBITS	(TX4927_CCFG_WDRST | TX4927_CCFG_BEOW)
 
 /* PCFG : Pin Configuration */
+#define TX4927_PCFG_SDCLKDLY_MASK	0x30000000
+#define TX4927_PCFG_SDCLKDLY(d)	((d)<<28)
+#define TX4927_PCFG_SYSCLKEN	0x08000000
+#define TX4927_PCFG_SDCLKEN_ALL	0x07800000
+#define TX4927_PCFG_SDCLKEN(ch)	(0x00800000<<(ch))
 #define TX4927_PCFG_PCICLKEN_ALL	0x003f0000
 #define TX4927_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
+#define TX4927_PCFG_SEL2	0x00000200
+#define TX4927_PCFG_SEL1	0x00000100
+#define TX4927_PCFG_DMASEL_ALL	0x000000ff
+#define TX4927_PCFG_DMASEL0_MASK	0x00000003
+#define TX4927_PCFG_DMASEL1_MASK	0x0000000c
+#define TX4927_PCFG_DMASEL2_MASK	0x00000030
+#define TX4927_PCFG_DMASEL3_MASK	0x000000c0
+#define TX4927_PCFG_DMASEL0_DRQ0	0x00000000
+#define TX4927_PCFG_DMASEL0_SIO1	0x00000001
+#define TX4927_PCFG_DMASEL0_ACL0	0x00000002
+#define TX4927_PCFG_DMASEL0_ACL2	0x00000003
+#define TX4927_PCFG_DMASEL1_DRQ1	0x00000000
+#define TX4927_PCFG_DMASEL1_SIO1	0x00000004
+#define TX4927_PCFG_DMASEL1_ACL1	0x00000008
+#define TX4927_PCFG_DMASEL1_ACL3	0x0000000c
+#define TX4927_PCFG_DMASEL2_DRQ2	0x00000000	/* SEL2=0 */
+#define TX4927_PCFG_DMASEL2_SIO0	0x00000010	/* SEL2=0 */
+#define TX4927_PCFG_DMASEL2_ACL1	0x00000000	/* SEL2=1 */
+#define TX4927_PCFG_DMASEL2_ACL2	0x00000020	/* SEL2=1 */
+#define TX4927_PCFG_DMASEL2_ACL0	0x00000030	/* SEL2=1 */
+#define TX4927_PCFG_DMASEL3_DRQ3	0x00000000
+#define TX4927_PCFG_DMASEL3_SIO0	0x00000040
+#define TX4927_PCFG_DMASEL3_ACL3	0x00000080
+#define TX4927_PCFG_DMASEL3_ACL1	0x000000c0
 
 /* CLKCTR : Clock Control */
+#define TX4927_CLKCTR_ACLCKD	0x02000000
+#define TX4927_CLKCTR_PIOCKD	0x01000000
+#define TX4927_CLKCTR_DMACKD	0x00800000
 #define TX4927_CLKCTR_PCICKD	0x00400000
+#define TX4927_CLKCTR_TM0CKD	0x00100000
+#define TX4927_CLKCTR_TM1CKD	0x00080000
+#define TX4927_CLKCTR_TM2CKD	0x00040000
+#define TX4927_CLKCTR_SIO0CKD	0x00020000
+#define TX4927_CLKCTR_SIO1CKD	0x00010000
+#define TX4927_CLKCTR_ACLRST	0x00000200
+#define TX4927_CLKCTR_PIORST	0x00000100
+#define TX4927_CLKCTR_DMARST	0x00000080
 #define TX4927_CLKCTR_PCIRST	0x00000040
-
-#ifndef _LANGUAGE_ASSEMBLY
+#define TX4927_CLKCTR_TM0RST	0x00000010
+#define TX4927_CLKCTR_TM1RST	0x00000008
+#define TX4927_CLKCTR_TM2RST	0x00000004
+#define TX4927_CLKCTR_SIO0RST	0x00000002
+#define TX4927_CLKCTR_SIO1RST	0x00000001
 
 #define tx4927_sdramcptr	((struct tx4927_sdramc_reg *)TX4927_SDRAMC_REG)
-#define tx4927_pcicptr		((struct tx4927_pcic_reg *)TX4927_PCIC_REG)
-#define tx4927_ccfgptr		((struct tx4927_ccfg_reg *)TX4927_CCFG_REG)
+#define tx4927_pcicptr \
+		((struct tx4927_pcic_reg __iomem *)TX4927_PCIC_REG)
+#define tx4927_ccfgptr \
+		((struct tx4927_ccfg_reg __iomem *)TX4927_CCFG_REG)
 #define tx4927_ebuscptr		((struct tx4927_ebusc_reg *)TX4927_EBUSC_REG)
 
-#endif /* _LANGUAGE_ASSEMBLY */
+/* utilities */
+static inline void txx9_clear64(__u64 __iomem *adr, __u64 bits)
+{
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+	local_irq_save(flags);
+#endif
+	____raw_writeq(____raw_readq(adr) & ~bits, adr);
+#ifdef CONFIG_32BIT
+	local_irq_restore(flags);
+#endif
+}
+static inline void txx9_set64(__u64 __iomem *adr, __u64 bits)
+{
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+	local_irq_save(flags);
+#endif
+	____raw_writeq(____raw_readq(adr) | bits, adr);
+#ifdef CONFIG_32BIT
+	local_irq_restore(flags);
+#endif
+}
+
+/* These functions are not interrupt safe. */
+static inline void tx4927_ccfg_clear(__u64 bits)
+{
+	____raw_writeq(____raw_readq(&tx4927_ccfgptr->ccfg)
+		       & ~(TX4927_CCFG_W1CBITS | bits),
+		       &tx4927_ccfgptr->ccfg);
+}
+static inline void tx4927_ccfg_set(__u64 bits)
+{
+	____raw_writeq((____raw_readq(&tx4927_ccfgptr->ccfg)
+			& ~TX4927_CCFG_W1CBITS) | bits,
+		       &tx4927_ccfgptr->ccfg);
+}
+static inline void tx4927_ccfg_change(__u64 change, __u64 new)
+{
+	____raw_writeq((____raw_readq(&tx4927_ccfgptr->ccfg)
+			& ~(TX4927_CCFG_W1CBITS | change)) |
+		       new,
+		       &tx4927_ccfgptr->ccfg);
+}
+
+int tx4927_report_pciclk(void);
+int tx4927_pciclk66_setup(void);
 
 #endif /* __ASM_TXX9_TX4927_H */
diff --git a/include/asm-mips/txx9/tx4927pcic.h b/include/asm-mips/txx9/tx4927pcic.h
new file mode 100644
index 0000000..d61c3d0
--- /dev/null
+++ b/include/asm-mips/txx9/tx4927pcic.h
@@ -0,0 +1,199 @@
+/*
+ * include/asm-mips/txx9/tx4927pcic.h
+ * TX4927 PCI controller definitions.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_TXX9_TX4927PCIC_H
+#define __ASM_TXX9_TX4927PCIC_H
+
+#include <linux/pci.h>
+
+struct tx4927_pcic_reg {
+	u32 pciid;
+	u32 pcistatus;
+	u32 pciccrev;
+	u32 pcicfg1;
+	u32 p2gm0plbase;		/* +10 */
+	u32 p2gm0pubase;
+	u32 p2gm1plbase;
+	u32 p2gm1pubase;
+	u32 p2gm2pbase;		/* +20 */
+	u32 p2giopbase;
+	u32 unused0;
+	u32 pcisid;
+	u32 unused1;		/* +30 */
+	u32 pcicapptr;
+	u32 unused2;
+	u32 pcicfg2;
+	u32 g2ptocnt;		/* +40 */
+	u32 unused3[15];
+	u32 g2pstatus;		/* +80 */
+	u32 g2pmask;
+	u32 pcisstatus;
+	u32 pcimask;
+	u32 p2gcfg;		/* +90 */
+	u32 p2gstatus;
+	u32 p2gmask;
+	u32 p2gccmd;
+	u32 unused4[24];		/* +a0 */
+	u32 pbareqport;		/* +100 */
+	u32 pbacfg;
+	u32 pbastatus;
+	u32 pbamask;
+	u32 pbabm;		/* +110 */
+	u32 pbacreq;
+	u32 pbacgnt;
+	u32 pbacstate;
+	u64 g2pmgbase[3];		/* +120 */
+	u64 g2piogbase;
+	u32 g2pmmask[3];		/* +140 */
+	u32 g2piomask;
+	u64 g2pmpbase[3];		/* +150 */
+	u64 g2piopbase;
+	u32 pciccfg;		/* +170 */
+	u32 pcicstatus;
+	u32 pcicmask;
+	u32 unused5;
+	u64 p2gmgbase[3];		/* +180 */
+	u64 p2giogbase;
+	u32 g2pcfgadrs;		/* +1a0 */
+	u32 g2pcfgdata;
+	u32 unused6[8];
+	u32 g2pintack;
+	u32 g2pspc;
+	u32 unused7[12];		/* +1d0 */
+	u64 pdmca;		/* +200 */
+	u64 pdmga;
+	u64 pdmpa;
+	u64 pdmctr;
+	u64 pdmcfg;		/* +220 */
+	u64 pdmsts;
+};
+
+/* bits for PCICMD */
+/* see PCI_COMMAND_XXX in linux/pci_regs.h */
+
+/* bits for PCISTAT */
+/* see PCI_STATUS_XXX in linux/pci_regs.h */
+
+/* bits for IOBA/MBA */
+/* see PCI_BASE_ADDRESS_XXX in linux/pci_regs.h */
+
+/* bits for G2PSTATUS/G2PMASK */
+#define TX4927_PCIC_G2PSTATUS_ALL	0x00000003
+#define TX4927_PCIC_G2PSTATUS_TTOE	0x00000002
+#define TX4927_PCIC_G2PSTATUS_RTOE	0x00000001
+
+/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci_regs.h */
+#define TX4927_PCIC_PCISTATUS_ALL	0x0000f900
+
+/* bits for PBACFG */
+#define TX4927_PCIC_PBACFG_FIXPA	0x00000008
+#define TX4927_PCIC_PBACFG_RPBA	0x00000004
+#define TX4927_PCIC_PBACFG_PBAEN	0x00000002
+#define TX4927_PCIC_PBACFG_BMCEN	0x00000001
+
+/* bits for PBASTATUS/PBAMASK */
+#define TX4927_PCIC_PBASTATUS_ALL	0x00000001
+#define TX4927_PCIC_PBASTATUS_BM	0x00000001
+
+/* bits for G2PMnGBASE */
+#define TX4927_PCIC_G2PMnGBASE_BSDIS	0x0000002000000000ULL
+#define TX4927_PCIC_G2PMnGBASE_ECHG	0x0000001000000000ULL
+
+/* bits for G2PIOGBASE */
+#define TX4927_PCIC_G2PIOGBASE_BSDIS	0x0000002000000000ULL
+#define TX4927_PCIC_G2PIOGBASE_ECHG	0x0000001000000000ULL
+
+/* bits for PCICSTATUS/PCICMASK */
+#define TX4927_PCIC_PCICSTATUS_ALL	0x000007b8
+#define TX4927_PCIC_PCICSTATUS_PME	0x00000400
+#define TX4927_PCIC_PCICSTATUS_TLB	0x00000200
+#define TX4927_PCIC_PCICSTATUS_NIB	0x00000100
+#define TX4927_PCIC_PCICSTATUS_ZIB	0x00000080
+#define TX4927_PCIC_PCICSTATUS_PERR	0x00000020
+#define TX4927_PCIC_PCICSTATUS_SERR	0x00000010
+#define TX4927_PCIC_PCICSTATUS_GBE	0x00000008
+#define TX4927_PCIC_PCICSTATUS_IWB	0x00000002
+#define TX4927_PCIC_PCICSTATUS_E2PDONE	0x00000001
+
+/* bits for PCICCFG */
+#define TX4927_PCIC_PCICCFG_GBWC_MASK	0x0fff0000
+#define TX4927_PCIC_PCICCFG_HRST	0x00000800
+#define TX4927_PCIC_PCICCFG_SRST	0x00000400
+#define TX4927_PCIC_PCICCFG_IRBER	0x00000200
+#define TX4927_PCIC_PCICCFG_G2PMEN(ch)	(0x00000100>>(ch))
+#define TX4927_PCIC_PCICCFG_G2PM0EN	0x00000100
+#define TX4927_PCIC_PCICCFG_G2PM1EN	0x00000080
+#define TX4927_PCIC_PCICCFG_G2PM2EN	0x00000040
+#define TX4927_PCIC_PCICCFG_G2PIOEN	0x00000020
+#define TX4927_PCIC_PCICCFG_TCAR	0x00000010
+#define TX4927_PCIC_PCICCFG_ICAEN	0x00000008
+
+/* bits for P2GMnGBASE */
+#define TX4927_PCIC_P2GMnGBASE_TMEMEN	0x0000004000000000ULL
+#define TX4927_PCIC_P2GMnGBASE_TBSDIS	0x0000002000000000ULL
+#define TX4927_PCIC_P2GMnGBASE_TECHG	0x0000001000000000ULL
+
+/* bits for P2GIOGBASE */
+#define TX4927_PCIC_P2GIOGBASE_TIOEN	0x0000004000000000ULL
+#define TX4927_PCIC_P2GIOGBASE_TBSDIS	0x0000002000000000ULL
+#define TX4927_PCIC_P2GIOGBASE_TECHG	0x0000001000000000ULL
+
+#define TX4927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
+#define TX4927_PCIC_MAX_DEVNU	TX4927_PCIC_IDSEL_AD_TO_SLOT(32)
+
+/* bits for PDMCFG */
+#define TX4927_PCIC_PDMCFG_RSTFIFO	0x00200000
+#define TX4927_PCIC_PDMCFG_EXFER	0x00100000
+#define TX4927_PCIC_PDMCFG_REQDLY_MASK	0x00003800
+#define TX4927_PCIC_PDMCFG_REQDLY_NONE	(0 << 11)
+#define TX4927_PCIC_PDMCFG_REQDLY_16	(1 << 11)
+#define TX4927_PCIC_PDMCFG_REQDLY_32	(2 << 11)
+#define TX4927_PCIC_PDMCFG_REQDLY_64	(3 << 11)
+#define TX4927_PCIC_PDMCFG_REQDLY_128	(4 << 11)
+#define TX4927_PCIC_PDMCFG_REQDLY_256	(5 << 11)
+#define TX4927_PCIC_PDMCFG_REQDLY_512	(6 << 11)
+#define TX4927_PCIC_PDMCFG_REQDLY_1024	(7 << 11)
+#define TX4927_PCIC_PDMCFG_ERRIE	0x00000400
+#define TX4927_PCIC_PDMCFG_NCCMPIE	0x00000200
+#define TX4927_PCIC_PDMCFG_NTCMPIE	0x00000100
+#define TX4927_PCIC_PDMCFG_CHNEN	0x00000080
+#define TX4927_PCIC_PDMCFG_XFRACT	0x00000040
+#define TX4927_PCIC_PDMCFG_BSWAP	0x00000020
+#define TX4927_PCIC_PDMCFG_XFRSIZE_MASK	0x0000000c
+#define TX4927_PCIC_PDMCFG_XFRSIZE_1DW	0x00000000
+#define TX4927_PCIC_PDMCFG_XFRSIZE_1QW	0x00000004
+#define TX4927_PCIC_PDMCFG_XFRSIZE_4QW	0x00000008
+#define TX4927_PCIC_PDMCFG_XFRDIRC	0x00000002
+#define TX4927_PCIC_PDMCFG_CHRST	0x00000001
+
+/* bits for PDMSTS */
+#define TX4927_PCIC_PDMSTS_REQCNT_MASK	0x3f000000
+#define TX4927_PCIC_PDMSTS_FIFOCNT_MASK	0x00f00000
+#define TX4927_PCIC_PDMSTS_FIFOWP_MASK	0x000c0000
+#define TX4927_PCIC_PDMSTS_FIFORP_MASK	0x00030000
+#define TX4927_PCIC_PDMSTS_ERRINT	0x00000800
+#define TX4927_PCIC_PDMSTS_DONEINT	0x00000400
+#define TX4927_PCIC_PDMSTS_CHNEN	0x00000200
+#define TX4927_PCIC_PDMSTS_XFRACT	0x00000100
+#define TX4927_PCIC_PDMSTS_ACCMP	0x00000080
+#define TX4927_PCIC_PDMSTS_NCCMP	0x00000040
+#define TX4927_PCIC_PDMSTS_NTCMP	0x00000020
+#define TX4927_PCIC_PDMSTS_CFGERR	0x00000008
+#define TX4927_PCIC_PDMSTS_PCIERR	0x00000004
+#define TX4927_PCIC_PDMSTS_CHNERR	0x00000002
+#define TX4927_PCIC_PDMSTS_DATAERR	0x00000001
+#define TX4927_PCIC_PDMSTS_ALL_CMP	0x000000e0
+#define TX4927_PCIC_PDMSTS_ALL_ERR	0x0000000f
+
+struct tx4927_pcic_reg __iomem *get_tx4927_pcicptr(
+	struct pci_controller *channel);
+void __init tx4927_pcic_setup(struct tx4927_pcic_reg __iomem *pcicptr,
+			      struct pci_controller *channel, int extarb);
+void tx4927_report_pcic_status(void);
+
+#endif /* __ASM_TXX9_TX4927PCIC_H */
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 7f9cfef..0bb8919 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -12,6 +12,9 @@
 #ifndef __ASM_TXX9_TX4938_H
 #define __ASM_TXX9_TX4938_H
 
+/* some controllers are compatible with 4927 */
+#include <asm/txx9/tx4927.h>
+
 #define tx4938_read_nfmc(addr) (*(volatile unsigned int *)(addr))
 #define tx4938_write_nfmc(b, addr) (*(volatile unsigned int *)(addr)) = (b)
 
@@ -51,9 +54,6 @@
 #define TX4938_ACLC_REG		(TX4938_REG_BASE + 0xf700)
 #define TX4938_SPI_REG		(TX4938_REG_BASE + 0xf800)
 
-#ifdef __ASSEMBLY__
-#define _CONST64(c)	c
-#else
 #define _CONST64(c)	c##ull
 
 #include <asm/byteorder.h>
@@ -113,68 +113,6 @@ struct tx4938_dma_reg {
 	endian_def_l2(unused0, mcr);
 };
 
-struct tx4938_pcic_reg {
-	volatile unsigned long pciid;
-	volatile unsigned long pcistatus;
-	volatile unsigned long pciccrev;
-	volatile unsigned long pcicfg1;
-	volatile unsigned long p2gm0plbase;		/* +10 */
-	volatile unsigned long p2gm0pubase;
-	volatile unsigned long p2gm1plbase;
-	volatile unsigned long p2gm1pubase;
-	volatile unsigned long p2gm2pbase;		/* +20 */
-	volatile unsigned long p2giopbase;
-	volatile unsigned long unused0;
-	volatile unsigned long pcisid;
-	volatile unsigned long unused1;		/* +30 */
-	volatile unsigned long pcicapptr;
-	volatile unsigned long unused2;
-	volatile unsigned long pcicfg2;
-	volatile unsigned long g2ptocnt;		/* +40 */
-	volatile unsigned long unused3[15];
-	volatile unsigned long g2pstatus;		/* +80 */
-	volatile unsigned long g2pmask;
-	volatile unsigned long pcisstatus;
-	volatile unsigned long pcimask;
-	volatile unsigned long p2gcfg;		/* +90 */
-	volatile unsigned long p2gstatus;
-	volatile unsigned long p2gmask;
-	volatile unsigned long p2gccmd;
-	volatile unsigned long unused4[24];		/* +a0 */
-	volatile unsigned long pbareqport;		/* +100 */
-	volatile unsigned long pbacfg;
-	volatile unsigned long pbastatus;
-	volatile unsigned long pbamask;
-	volatile unsigned long pbabm;		/* +110 */
-	volatile unsigned long pbacreq;
-	volatile unsigned long pbacgnt;
-	volatile unsigned long pbacstate;
-	volatile unsigned long long g2pmgbase[3];		/* +120 */
-	volatile unsigned long long g2piogbase;
-	volatile unsigned long g2pmmask[3];		/* +140 */
-	volatile unsigned long g2piomask;
-	volatile unsigned long long g2pmpbase[3];		/* +150 */
-	volatile unsigned long long g2piopbase;
-	volatile unsigned long pciccfg;		/* +170 */
-	volatile unsigned long pcicstatus;
-	volatile unsigned long pcicmask;
-	volatile unsigned long unused5;
-	volatile unsigned long long p2gmgbase[3];		/* +180 */
-	volatile unsigned long long p2giogbase;
-	volatile unsigned long g2pcfgadrs;		/* +1a0 */
-	volatile unsigned long g2pcfgdata;
-	volatile unsigned long unused6[8];
-	volatile unsigned long g2pintack;
-	volatile unsigned long g2pspc;
-	volatile unsigned long unused7[12];		/* +1d0 */
-	volatile unsigned long long pdmca;		/* +200 */
-	volatile unsigned long long pdmga;
-	volatile unsigned long long pdmpa;
-	volatile unsigned long long pdmctr;
-	volatile unsigned long long pdmcfg;		/* +220 */
-	volatile unsigned long long pdmsts;
-};
-
 struct tx4938_aclc_reg {
 	volatile unsigned long acctlen;
 	volatile unsigned long acctldis;
@@ -262,18 +200,18 @@ struct tx4938_sramc_reg {
 };
 
 struct tx4938_ccfg_reg {
-	volatile unsigned long long ccfg;
-	volatile unsigned long long crir;
-	volatile unsigned long long pcfg;
-	volatile unsigned long long tear;
-	volatile unsigned long long clkctr;
-	volatile unsigned long long unused0;
-	volatile unsigned long long garbc;
-	volatile unsigned long long unused1;
-	volatile unsigned long long unused2;
-	volatile unsigned long long ramp;
-	volatile unsigned long long unused3;
-	volatile unsigned long long jmpadr;
+	u64 ccfg;
+	u64 crir;
+	u64 pcfg;
+	u64 toea;
+	u64 clkctr;
+	u64 unused0;
+	u64 garbc;
+	u64 unused1;
+	u64 unused2;
+	u64 ramp;
+	u64 unused3;
+	u64 jmpadr;
 };
 
 #undef endian_def_l2
@@ -282,8 +220,6 @@ struct tx4938_ccfg_reg {
 #undef endian_def_b2s
 #undef endian_def_b4
 
-#endif /* __ASSEMBLY__ */
-
 /*
  * NDFMC
  */
@@ -360,7 +296,7 @@ struct tx4938_ccfg_reg {
 #define TX4938_CCFG_BEOW	0x00010000
 #define TX4938_CCFG_WR	0x00008000
 #define TX4938_CCFG_TOE	0x00004000
-#define TX4938_CCFG_PCIXARB	0x00002000
+#define TX4938_CCFG_PCIARB	0x00002000
 #define TX4938_CCFG_PCIDIVMODE_MASK	0x00001c00
 #define TX4938_CCFG_PCIDIVMODE_4	(0x1 << 10)
 #define TX4938_CCFG_PCIDIVMODE_4_5	(0x3 << 10)
@@ -436,110 +372,6 @@ struct tx4938_ccfg_reg {
 #define TX4938_CLKCTR_SIO0RST	0x00000002
 #define TX4938_CLKCTR_SIO1RST	0x00000001
 
-/* bits for G2PSTATUS/G2PMASK */
-#define TX4938_PCIC_G2PSTATUS_ALL	0x00000003
-#define TX4938_PCIC_G2PSTATUS_TTOE	0x00000002
-#define TX4938_PCIC_G2PSTATUS_RTOE	0x00000001
-
-/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
-#define TX4938_PCIC_PCISTATUS_ALL	0x0000f900
-
-/* bits for PBACFG */
-#define TX4938_PCIC_PBACFG_FIXPA	0x00000008
-#define TX4938_PCIC_PBACFG_RPBA	0x00000004
-#define TX4938_PCIC_PBACFG_PBAEN	0x00000002
-#define TX4938_PCIC_PBACFG_BMCEN	0x00000001
-
-/* bits for G2PMnGBASE */
-#define TX4938_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for G2PIOGBASE */
-#define TX4938_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for PCICSTATUS/PCICMASK */
-#define TX4938_PCIC_PCICSTATUS_ALL	0x000007b8
-#define TX4938_PCIC_PCICSTATUS_PME	0x00000400
-#define TX4938_PCIC_PCICSTATUS_TLB	0x00000200
-#define TX4938_PCIC_PCICSTATUS_NIB	0x00000100
-#define TX4938_PCIC_PCICSTATUS_ZIB	0x00000080
-#define TX4938_PCIC_PCICSTATUS_PERR	0x00000020
-#define TX4938_PCIC_PCICSTATUS_SERR	0x00000010
-#define TX4938_PCIC_PCICSTATUS_GBE	0x00000008
-#define TX4938_PCIC_PCICSTATUS_IWB	0x00000002
-#define TX4938_PCIC_PCICSTATUS_E2PDONE	0x00000001
-
-/* bits for PCICCFG */
-#define TX4938_PCIC_PCICCFG_GBWC_MASK	0x0fff0000
-#define TX4938_PCIC_PCICCFG_HRST	0x00000800
-#define TX4938_PCIC_PCICCFG_SRST	0x00000400
-#define TX4938_PCIC_PCICCFG_IRBER	0x00000200
-#define TX4938_PCIC_PCICCFG_G2PMEN(ch)	(0x00000100>>(ch))
-#define TX4938_PCIC_PCICCFG_G2PM0EN	0x00000100
-#define TX4938_PCIC_PCICCFG_G2PM1EN	0x00000080
-#define TX4938_PCIC_PCICCFG_G2PM2EN	0x00000040
-#define TX4938_PCIC_PCICCFG_G2PIOEN	0x00000020
-#define TX4938_PCIC_PCICCFG_TCAR	0x00000010
-#define TX4938_PCIC_PCICCFG_ICAEN	0x00000008
-
-/* bits for P2GMnGBASE */
-#define TX4938_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
-#define TX4938_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
-
-/* bits for P2GIOGBASE */
-#define TX4938_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
-#define TX4938_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
-
-#define TX4938_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
-#define TX4938_PCIC_MAX_DEVNU	TX4938_PCIC_IDSEL_AD_TO_SLOT(32)
-
-/* bits for PDMCFG */
-#define TX4938_PCIC_PDMCFG_RSTFIFO	0x00200000
-#define TX4938_PCIC_PDMCFG_EXFER	0x00100000
-#define TX4938_PCIC_PDMCFG_REQDLY_MASK	0x00003800
-#define TX4938_PCIC_PDMCFG_REQDLY_NONE	(0 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_16	(1 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_32	(2 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_64	(3 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_128	(4 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_256	(5 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_512	(6 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_1024	(7 << 11)
-#define TX4938_PCIC_PDMCFG_ERRIE	0x00000400
-#define TX4938_PCIC_PDMCFG_NCCMPIE	0x00000200
-#define TX4938_PCIC_PDMCFG_NTCMPIE	0x00000100
-#define TX4938_PCIC_PDMCFG_CHNEN	0x00000080
-#define TX4938_PCIC_PDMCFG_XFRACT	0x00000040
-#define TX4938_PCIC_PDMCFG_BSWAP	0x00000020
-#define TX4938_PCIC_PDMCFG_XFRSIZE_MASK	0x0000000c
-#define TX4938_PCIC_PDMCFG_XFRSIZE_1DW	0x00000000
-#define TX4938_PCIC_PDMCFG_XFRSIZE_1QW	0x00000004
-#define TX4938_PCIC_PDMCFG_XFRSIZE_4QW	0x00000008
-#define TX4938_PCIC_PDMCFG_XFRDIRC	0x00000002
-#define TX4938_PCIC_PDMCFG_CHRST	0x00000001
-
-/* bits for PDMSTS */
-#define TX4938_PCIC_PDMSTS_REQCNT_MASK	0x3f000000
-#define TX4938_PCIC_PDMSTS_FIFOCNT_MASK	0x00f00000
-#define TX4938_PCIC_PDMSTS_FIFOWP_MASK	0x000c0000
-#define TX4938_PCIC_PDMSTS_FIFORP_MASK	0x00030000
-#define TX4938_PCIC_PDMSTS_ERRINT	0x00000800
-#define TX4938_PCIC_PDMSTS_DONEINT	0x00000400
-#define TX4938_PCIC_PDMSTS_CHNEN	0x00000200
-#define TX4938_PCIC_PDMSTS_XFRACT	0x00000100
-#define TX4938_PCIC_PDMSTS_ACCMP	0x00000080
-#define TX4938_PCIC_PDMSTS_NCCMP	0x00000040
-#define TX4938_PCIC_PDMSTS_NTCMP	0x00000020
-#define TX4938_PCIC_PDMSTS_CFGERR	0x00000008
-#define TX4938_PCIC_PDMSTS_PCIERR	0x00000004
-#define TX4938_PCIC_PDMSTS_CHNERR	0x00000002
-#define TX4938_PCIC_PDMSTS_DATAERR	0x00000001
-#define TX4938_PCIC_PDMSTS_ALL_CMP	0x000000e0
-#define TX4938_PCIC_PDMSTS_ALL_ERR	0x0000000f
-
 /*
  * DMA
  */
@@ -595,15 +427,15 @@ struct tx4938_ccfg_reg {
 #define TX4938_DMA_CSR_DESERR	0x00000002
 #define TX4938_DMA_CSR_SORERR	0x00000001
 
-#ifndef __ASSEMBLY__
-
 #define tx4938_sdramcptr	((struct tx4938_sdramc_reg *)TX4938_SDRAMC_REG)
 #define tx4938_ebuscptr         ((struct tx4938_ebusc_reg *)TX4938_EBUSC_REG)
 #define tx4938_dmaptr(ch)	((struct tx4938_dma_reg *)TX4938_DMA_REG(ch))
 #define tx4938_ndfmcptr		((struct tx4938_ndfmc_reg *)TX4938_NDFMC_REG)
-#define tx4938_pcicptr		((struct tx4938_pcic_reg *)TX4938_PCIC_REG)
-#define tx4938_pcic1ptr		((struct tx4938_pcic_reg *)TX4938_PCIC1_REG)
-#define tx4938_ccfgptr		((struct tx4938_ccfg_reg *)TX4938_CCFG_REG)
+#define tx4938_pcicptr		tx4927_pcicptr
+#define tx4938_pcic1ptr \
+		((struct tx4927_pcic_reg __iomem *)TX4938_PCIC1_REG)
+#define tx4938_ccfgptr \
+		((struct tx4938_ccfg_reg __iomem *)TX4938_CCFG_REG)
 #define tx4938_sioptr(ch)	((struct tx4938_sio_reg *)TX4938_SIO_REG(ch))
 #define tx4938_pioptr		((struct txx9_pio_reg __iomem *)TX4938_PIO_REG)
 #define tx4938_aclcptr		((struct tx4938_aclc_reg *)TX4938_ACLC_REG)
@@ -611,17 +443,25 @@ struct tx4938_ccfg_reg {
 #define tx4938_sramcptr		((struct tx4938_sramc_reg *)TX4938_SRAMC_REG)
 
 
-#define TX4938_REV_MAJ_MIN()	((unsigned long)tx4938_ccfgptr->crir & 0x00ff)
-#define TX4938_REV_PCODE()	((unsigned long)tx4938_ccfgptr->crir >> 16)
+#define TX4938_REV_PCODE()	\
+	((__u32)__raw_readq(&tx4938_ccfgptr->crir) >> 16)
+
+#define tx4938_ccfg_clear(bits)	tx4927_ccfg_clear(bits)
+#define tx4938_ccfg_set(bits)	tx4927_ccfg_set(bits)
+#define tx4938_ccfg_change(change, new)	tx4927_ccfg_change(change, new)
 
 #define TX4938_SDRAMC_BA(ch)	((tx4938_sdramcptr->cr[ch] >> 49) << 21)
 #define TX4938_SDRAMC_SIZE(ch)	(((tx4938_sdramcptr->cr[ch] >> 33) + 1) << 21)
 
+#define TX4938_EBUSC_CR(ch)	__raw_readq(&tx4938_ebuscptr->cr[(ch)])
 #define TX4938_EBUSC_BA(ch)	((tx4938_ebuscptr->cr[ch] >> 48) << 20)
 #define TX4938_EBUSC_SIZE(ch)	\
 	(0x00100000 << ((unsigned long)(tx4938_ebuscptr->cr[ch] >> 8) & 0xf))
 
-
-#endif /* !__ASSEMBLY__ */
+int tx4938_report_pciclk(void);
+void tx4938_report_pci1clk(void);
+int tx4938_pciclk66_setup(void);
+struct pci_dev;
+int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot);
 
 #endif
