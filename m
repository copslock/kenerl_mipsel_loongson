Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 17:12:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:59376 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28584188AbYGGQMd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2008 17:12:33 +0100
Received: from localhost (p7140-ipad206funabasi.chiba.ocn.ne.jp [222.145.81.140])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F3340AA82; Tue,  8 Jul 2008 01:12:25 +0900 (JST)
Date:	Tue, 08 Jul 2008 01:14:10 +0900 (JST)
Message-Id: <20080708.011410.41198497.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Make pcibios_plat_dev_init weak
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080418.235357.25909447.anemo@mba.ocn.ne.jp>
References: <20080418.235357.25909447.anemo@mba.ocn.ne.jp>
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
X-archive-position: 19729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Most platforms do not need special pcibios_plat_dev_init.  Make it
weak function and kill all empty instances.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Revised against current linux-queue tree.

 arch/mips/pci/fixup-atlas.c    |    6 ------
 arch/mips/pci/fixup-au1000.c   |    6 ------
 arch/mips/pci/fixup-capcella.c |    6 ------
 arch/mips/pci/fixup-cobalt.c   |    6 ------
 arch/mips/pci/fixup-emma2rh.c  |    6 ------
 arch/mips/pci/fixup-excite.c   |    6 ------
 arch/mips/pci/fixup-ip32.c     |    6 ------
 arch/mips/pci/fixup-jmr3927.c  |    6 ------
 arch/mips/pci/fixup-lm2e.c     |    6 ------
 arch/mips/pci/fixup-malta.c    |    6 ------
 arch/mips/pci/fixup-mpc30x.c   |    6 ------
 arch/mips/pci/fixup-pmcmsp.c   |   21 ---------------------
 arch/mips/pci/fixup-pnx8550.c  |    6 ------
 arch/mips/pci/fixup-rbtx4927.c |    6 ------
 arch/mips/pci/fixup-sni.c      |    6 ------
 arch/mips/pci/fixup-tb0219.c   |    6 ------
 arch/mips/pci/fixup-tb0226.c   |    6 ------
 arch/mips/pci/fixup-tb0287.c   |    6 ------
 arch/mips/pci/fixup-tx4938.c   |    9 ---------
 arch/mips/pci/fixup-wrppmc.c   |    6 ------
 arch/mips/pci/fixup-yosemite.c |    6 ------
 arch/mips/pci/pci-bcm1480.c    |    6 ------
 arch/mips/pci/pci-ip27.c       |    6 ------
 arch/mips/pci/pci-lasat.c      |    6 ------
 arch/mips/pci/pci-sb1250.c     |    6 ------
 arch/mips/pci/pci.c            |    5 +++++
 26 files changed, 5 insertions(+), 168 deletions(-)

diff --git a/arch/mips/pci/fixup-atlas.c b/arch/mips/pci/fixup-atlas.c
index 506e883..d41c8c6 100644
--- a/arch/mips/pci/fixup-atlas.c
+++ b/arch/mips/pci/fixup-atlas.c
@@ -63,12 +63,6 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq_tab[slot][pin];
 }
 
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
 #ifdef CONFIG_KGDB
 /*
  * The PCI scan may have moved the saa9730 I/O address, so reread
diff --git a/arch/mips/pci/fixup-au1000.c b/arch/mips/pci/fixup-au1000.c
index e2ddfc4..d611d97 100644
--- a/arch/mips/pci/fixup-au1000.c
+++ b/arch/mips/pci/fixup-au1000.c
@@ -35,9 +35,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_alchemy[slot][pin];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-capcella.c b/arch/mips/pci/fixup-capcella.c
index 1416bca..834be10 100644
--- a/arch/mips/pci/fixup-capcella.c
+++ b/arch/mips/pci/fixup-capcella.c
@@ -42,9 +42,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_capcella[slot][pin];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index 9553b14..eff9041 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -185,9 +185,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return irq_tab_cobalt[slot];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-emma2rh.c b/arch/mips/pci/fixup-emma2rh.c
index a270589..cc26790 100644
--- a/arch/mips/pci/fixup-emma2rh.c
+++ b/arch/mips/pci/fixup-emma2rh.c
@@ -93,9 +93,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_map[slot][pin];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-excite.c b/arch/mips/pci/fixup-excite.c
index cd64d9f..106649d 100644
--- a/arch/mips/pci/fixup-excite.c
+++ b/arch/mips/pci/fixup-excite.c
@@ -28,9 +28,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return USB_IRQ;		/* USB controller is the only PCI device */
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-ip32.c b/arch/mips/pci/fixup-ip32.c
index 190fffd..97e3a04 100644
--- a/arch/mips/pci/fixup-ip32.c
+++ b/arch/mips/pci/fixup-ip32.c
@@ -43,9 +43,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_mace[slot][pin];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index e974394..a46196a 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -84,9 +84,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		irq = JMR3927_IRQ_ETHER0;
 	return irq;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-lm2e.c b/arch/mips/pci/fixup-lm2e.c
index e18ae4f..791cb8f 100644
--- a/arch/mips/pci/fixup-lm2e.c
+++ b/arch/mips/pci/fixup-lm2e.c
@@ -59,12 +59,6 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 }
 
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
 static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 0f48498..c3b2ba0 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -43,12 +43,6 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return pci_irq[virq];
 }
 
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
 static void __init malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
diff --git a/arch/mips/pci/fixup-mpc30x.c b/arch/mips/pci/fixup-mpc30x.c
index 5911596..092cc75 100644
--- a/arch/mips/pci/fixup-mpc30x.c
+++ b/arch/mips/pci/fixup-mpc30x.c
@@ -41,9 +41,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return irq_tab_mpc30x[slot];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-pmcmsp.c b/arch/mips/pci/fixup-pmcmsp.c
index 65735b1..087bf06 100644
--- a/arch/mips/pci/fixup-pmcmsp.c
+++ b/arch/mips/pci/fixup-pmcmsp.c
@@ -164,27 +164,6 @@ static char irq_tab[][5] __initdata = {
 
 /*****************************************************************************
  *
- *  FUNCTION: pcibios_plat_dev_init
- *  _________________________________________________________________________
- *
- *  DESCRIPTION: Perform platform specific device initialization at
- *               pci_enable_device() time.
- *               None are needed for the MSP7120 PCI Controller.
- *
- *  INPUTS:      dev     - structure describing the PCI device
- *
- *  OUTPUTS:     none
- *
- *  RETURNS:     PCIBIOS_SUCCESSFUL
- *
- ****************************************************************************/
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return PCIBIOS_SUCCESSFUL;
-}
-
-/*****************************************************************************
- *
  *  FUNCTION: pcibios_map_irq
  *  _________________________________________________________________________
  *
diff --git a/arch/mips/pci/fixup-pnx8550.c b/arch/mips/pci/fixup-pnx8550.c
index 96857ac..1ef895a 100644
--- a/arch/mips/pci/fixup-pnx8550.c
+++ b/arch/mips/pci/fixup-pnx8550.c
@@ -49,9 +49,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return pnx8550_irq_tab[slot][pin];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index 2d234ca..bccf7be 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -131,9 +131,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return irq;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-sni.c b/arch/mips/pci/fixup-sni.c
index 5c8a79b..bf6718c 100644
--- a/arch/mips/pci/fixup-sni.c
+++ b/arch/mips/pci/fixup-sni.c
@@ -162,9 +162,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return 0;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-tb0219.c b/arch/mips/pci/fixup-tb0219.c
index ed87733..d525c53 100644
--- a/arch/mips/pci/fixup-tb0219.c
+++ b/arch/mips/pci/fixup-tb0219.c
@@ -43,9 +43,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return irq;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-tb0226.c b/arch/mips/pci/fixup-tb0226.c
index e3eedf4..7e5e922 100644
--- a/arch/mips/pci/fixup-tb0226.c
+++ b/arch/mips/pci/fixup-tb0226.c
@@ -78,9 +78,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return irq;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-tb0287.c b/arch/mips/pci/fixup-tb0287.c
index 267ab3d..fd0f628 100644
--- a/arch/mips/pci/fixup-tb0287.c
+++ b/arch/mips/pci/fixup-tb0287.c
@@ -57,9 +57,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return irq;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-tx4938.c b/arch/mips/pci/fixup-tx4938.c
index f2ba06e..6d33d06 100644
--- a/arch/mips/pci/fixup-tx4938.c
+++ b/arch/mips/pci/fixup-tx4938.c
@@ -81,12 +81,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return irq;
 }
-
-/*
- * Do platform specific device initialization at pci_enable_device() time
- */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
diff --git a/arch/mips/pci/fixup-wrppmc.c b/arch/mips/pci/fixup-wrppmc.c
index 3d27754..f50b078 100644
--- a/arch/mips/pci/fixup-wrppmc.c
+++ b/arch/mips/pci/fixup-wrppmc.c
@@ -29,9 +29,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return pci_irq_tab[slot][pin];
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-yosemite.c b/arch/mips/pci/fixup-yosemite.c
index fdafb13..0a75d30 100644
--- a/arch/mips/pci/fixup-yosemite.c
+++ b/arch/mips/pci/fixup-yosemite.c
@@ -33,9 +33,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return 3;			/* Everything goes to one irq bit */
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index a9060c7..0deac04 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -82,12 +82,6 @@ int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return K_BCM1480_INT_PCI_INTA - 1 + pin;
 }
 
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
 /*
  * Some checks before doing config cycles:
  * In PCI Device Mode, hide everything on bus 0 except the LDT host
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index ce92f82..9b39fd5 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -159,12 +159,6 @@ int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
 /*
  * Device might live on a subordinate PCI bus.  XXX Walk up the chain of buses
  * to find the slot number in sense of the bridge device register.
diff --git a/arch/mips/pci/pci-lasat.c b/arch/mips/pci/pci-lasat.c
index e70ae32..fce5e52 100644
--- a/arch/mips/pci/pci-lasat.c
+++ b/arch/mips/pci/pci-lasat.c
@@ -86,9 +86,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return -1;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index bf63959..a97a667 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -89,12 +89,6 @@ int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return dev->irq;
 }
 
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
 /*
  * Some checks before doing config cycles:
  * In PCI Device Mode, hide everything on bus 0 except the LDT host
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index d7d6cb0..9dd6e01 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -226,6 +226,11 @@ unsigned int pcibios_assign_all_busses(void)
 	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
 }
 
+int __weak pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	int err;
