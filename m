Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2012 19:29:46 +0100 (CET)
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:60914 "EHLO
        viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825670Ab2KSS2M1iS0K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2012 19:28:12 +0100
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
        id 31F7C80387; Mon, 19 Nov 2012 13:27:39 -0500 (EST)
From:   Bill Pemberton <wfp5p@virginia.edu>
To:     gregkh@linuxfoundation.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 276/493] mips: remove use of __devinit
Date:   Mon, 19 Nov 2012 13:23:45 -0500
Message-Id: <1353349642-3677-276-git-send-email-wfp5p@virginia.edu>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
X-archive-position: 35040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wfp5p@virginia.edu
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
Return-Path: <linux-mips-bounce@linux-mips.org>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-mips@linux-mips.org 
---
 arch/mips/cavium-octeon/serial.c          |  2 +-
 arch/mips/include/asm/pci.h               |  2 +-
 arch/mips/kernel/smp.c                    |  2 +-
 arch/mips/lantiq/xway/dma.c               |  3 +--
 arch/mips/lantiq/xway/gptu.c              |  2 +-
 arch/mips/lantiq/xway/xrx200_phy_fw.c     |  2 +-
 arch/mips/mti-sead3/sead3-i2c-drv.c       |  2 +-
 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c |  3 +--
 arch/mips/pci/fixup-cobalt.c              |  8 ++++----
 arch/mips/pci/fixup-emma2rh.c             |  4 ++--
 arch/mips/pci/fixup-fuloong2e.c           | 12 ++++++------
 arch/mips/pci/fixup-lemote2f.c            | 12 ++++++------
 arch/mips/pci/fixup-malta.c               |  6 +++---
 arch/mips/pci/fixup-rc32434.c             |  4 ++--
 arch/mips/pci/fixup-sb1250.c              |  6 +++---
 arch/mips/pci/ops-bcm63xx.c               |  2 +-
 arch/mips/pci/ops-tx4927.c                |  4 ++--
 arch/mips/pci/pci-alchemy.c               |  2 +-
 arch/mips/pci/pci-ip27.c                  |  4 ++--
 arch/mips/pci/pci-lantiq.c                |  4 ++--
 arch/mips/pci/pci.c                       |  8 ++++----
 arch/mips/sni/setup.c                     |  2 +-
 arch/mips/txx9/generic/pci.c              | 11 +++++------
 23 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
index 569f41b..f393f65 100644
--- a/arch/mips/cavium-octeon/serial.c
+++ b/arch/mips/cavium-octeon/serial.c
@@ -43,7 +43,7 @@ void octeon_serial_out(struct uart_port *up, int offset, int value)
 	cvmx_write_csr((uint64_t)(up->membase + (offset << 3)), (u8)value);
 }
 
-static int __devinit octeon_serial_probe(struct platform_device *pdev)
+static int octeon_serial_probe(struct platform_device *pdev)
 {
 	int irq, res;
 	struct resource *res_mem;
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 90bf3b3..940ece3 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -145,7 +145,7 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 extern char * (*pcibios_plat_setup)(char *str);
 
 /* this function parses memory ranges from a device node */
-extern void __devinit pci_load_of_ranges(struct pci_controller *hose,
+extern void pci_load_of_ranges(struct pci_controller *hose,
 					 struct device_node *node);
 
 #endif /* _ASM_PCI_H */
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 9005bf9..15bf0be 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -188,7 +188,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 }
 
 /* preload SMP state for boot cpu */
-void __devinit smp_prepare_boot_cpu(void)
+void smp_prepare_boot_cpu(void)
 {
 	set_cpu_possible(0, true);
 	set_cpu_online(0, true);
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index b5d76d1..a38da1c 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -210,8 +210,7 @@ ltq_dma_init_port(int p)
 }
 EXPORT_SYMBOL_GPL(ltq_dma_init_port);
 
-static int __devinit
-ltq_dma_init(struct platform_device *pdev)
+static int ltq_dma_init(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct resource *res;
diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index cbb56fc..e30b1ed 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -133,7 +133,7 @@ static inline void clkdev_add_gptu(struct device *dev, const char *con,
 	clkdev_add(&clk->cl);
 }
 
-static int __devinit gptu_probe(struct platform_device *pdev)
+static int gptu_probe(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct resource *res;
diff --git a/arch/mips/lantiq/xway/xrx200_phy_fw.c b/arch/mips/lantiq/xway/xrx200_phy_fw.c
index fe808bf..d4d9d31 100644
--- a/arch/mips/lantiq/xway/xrx200_phy_fw.c
+++ b/arch/mips/lantiq/xway/xrx200_phy_fw.c
@@ -54,7 +54,7 @@ static dma_addr_t xway_gphy_load(struct platform_device *pdev)
 	return dev_addr;
 }
 
-static int __devinit xway_phy_fw_probe(struct platform_device *pdev)
+static int xway_phy_fw_probe(struct platform_device *pdev)
 {
 	dma_addr_t fw_addr;
 	struct property *pp;
diff --git a/arch/mips/mti-sead3/sead3-i2c-drv.c b/arch/mips/mti-sead3/sead3-i2c-drv.c
index 114a167..51270bc 100644
--- a/arch/mips/mti-sead3/sead3-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-i2c-drv.c
@@ -297,7 +297,7 @@ static void sead3_i2c_platform_setup(struct pic32_i2c_platform_data *priv)
 		priv->base + PIC32_I2CxSTATCLR);
 }
 
-static int __devinit sead3_i2c_platform_probe(struct platform_device *pdev)
+static int sead3_i2c_platform_probe(struct platform_device *pdev)
 {
 	struct pic32_i2c_platform_data *priv;
 	struct resource *r;
diff --git a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
index 587d5b5..219d1db 100644
--- a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
@@ -304,8 +304,7 @@ static void i2c_platform_disable(struct i2c_platform_data *priv)
 	pr_debug("i2c_platform_disable\n");
 }
 
-static int __devinit
-i2c_platform_probe(struct platform_device *pdev)
+static int i2c_platform_probe(struct platform_device *pdev)
 {
 	struct i2c_platform_data *priv;
 	struct resource *r;
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index 3e7ce65..9553b14 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -37,7 +37,7 @@
 #define VIA_COBALT_BRD_ID_REG  0x94
 #define VIA_COBALT_BRD_REG_to_ID(reg)	((unsigned char)(reg) >> 4)
 
-static void __devinit qube_raq_galileo_early_fixup(struct pci_dev *dev)
+static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 {
 	if (dev->devfn == PCI_DEVFN(0, 0) &&
 		(dev->class >> 8) == PCI_CLASS_MEMORY_OTHER) {
@@ -51,7 +51,7 @@ static void __devinit qube_raq_galileo_early_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 	 qube_raq_galileo_early_fixup);
 
-static void __devinit qube_raq_via_bmIDE_fixup(struct pci_dev *dev)
+static void qube_raq_via_bmIDE_fixup(struct pci_dev *dev)
 {
 	unsigned short cfgword;
 	unsigned char lt;
@@ -74,7 +74,7 @@ static void __devinit qube_raq_via_bmIDE_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
 	 qube_raq_via_bmIDE_fixup);
 
-static void __devinit qube_raq_galileo_fixup(struct pci_dev *dev)
+static void qube_raq_galileo_fixup(struct pci_dev *dev)
 {
 	if (dev->devfn != PCI_DEVFN(0, 0))
 		return;
@@ -129,7 +129,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 
 int cobalt_board_id;
 
-static void __devinit qube_raq_via_board_id_fixup(struct pci_dev *dev)
+static void qube_raq_via_board_id_fixup(struct pci_dev *dev)
 {
 	u8 id;
 	int retval;
diff --git a/arch/mips/pci/fixup-emma2rh.c b/arch/mips/pci/fixup-emma2rh.c
index 0d9ccf4..beaec32 100644
--- a/arch/mips/pci/fixup-emma2rh.c
+++ b/arch/mips/pci/fixup-emma2rh.c
@@ -52,7 +52,7 @@ static unsigned char irq_map[][5] __initdata = {
 	       MARKEINS_PCI_IRQ_INTA, MARKEINS_PCI_IRQ_INTB,},
 };
 
-static void __devinit nec_usb_controller_fixup(struct pci_dev *dev)
+static void nec_usb_controller_fixup(struct pci_dev *dev)
 {
 	if (PCI_SLOT(dev->devfn) == EMMA2RH_USB_SLOT)
 		/* on board USB controller configuration */
@@ -67,7 +67,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
  * if it is the host bridge by marking it as such.  These resources are of
  * no consequence to the PCI layer (they are handled elsewhere).
  */
-static void __devinit emma2rh_pci_host_fixup(struct pci_dev *dev)
+static void emma2rh_pci_host_fixup(struct pci_dev *dev)
 {
 	int i;
 
diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
index 0857ab8..63ab4a0 100644
--- a/arch/mips/pci/fixup-fuloong2e.c
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -48,7 +48,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-static void __devinit loongson2e_nec_fixup(struct pci_dev *pdev)
+static void loongson2e_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
@@ -60,7 +60,7 @@ static void __devinit loongson2e_nec_fixup(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, 0xe4, 1 << 5);
 }
 
-static void __devinit loongson2e_686b_func0_fixup(struct pci_dev *pdev)
+static void loongson2e_686b_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char c;
 
@@ -135,7 +135,7 @@ static void __devinit loongson2e_686b_func0_fixup(struct pci_dev *pdev)
 	printk(KERN_INFO"via686b fix: ISA bridge done\n");
 }
 
-static void __devinit loongson2e_686b_func1_fixup(struct pci_dev *pdev)
+static void loongson2e_686b_func1_fixup(struct pci_dev *pdev)
 {
 	printk(KERN_INFO"via686b fix: IDE\n");
 
@@ -168,19 +168,19 @@ static void __devinit loongson2e_686b_func1_fixup(struct pci_dev *pdev)
 	printk(KERN_INFO"via686b fix: IDE done\n");
 }
 
-static void __devinit loongson2e_686b_func2_fixup(struct pci_dev *pdev)
+static void loongson2e_686b_func2_fixup(struct pci_dev *pdev)
 {
 	/* irq routing */
 	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 10);
 }
 
-static void __devinit loongson2e_686b_func3_fixup(struct pci_dev *pdev)
+static void loongson2e_686b_func3_fixup(struct pci_dev *pdev)
 {
 	/* irq routing */
 	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 11);
 }
 
-static void __devinit loongson2e_686b_func5_fixup(struct pci_dev *pdev)
+static void loongson2e_686b_func5_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 	unsigned char c;
diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index a7b917dcf..519daaebb 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -96,21 +96,21 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 }
 
 /* CS5536 SPEC. fixup */
-static void __devinit loongson_cs5536_isa_fixup(struct pci_dev *pdev)
+static void loongson_cs5536_isa_fixup(struct pci_dev *pdev)
 {
 	/* the uart1 and uart2 interrupt in PIC is enabled as default */
 	pci_write_config_dword(pdev, PCI_UART1_INT_REG, 1);
 	pci_write_config_dword(pdev, PCI_UART2_INT_REG, 1);
 }
 
-static void __devinit loongson_cs5536_ide_fixup(struct pci_dev *pdev)
+static void loongson_cs5536_ide_fixup(struct pci_dev *pdev)
 {
 	/* setting the mutex pin as IDE function */
 	pci_write_config_dword(pdev, PCI_IDE_CFG_REG,
 			       CS5536_IDE_FLASH_SIGNATURE);
 }
 
-static void __devinit loongson_cs5536_acc_fixup(struct pci_dev *pdev)
+static void loongson_cs5536_acc_fixup(struct pci_dev *pdev)
 {
 	/* enable the AUDIO interrupt in PIC  */
 	pci_write_config_dword(pdev, PCI_ACC_INT_REG, 1);
@@ -118,14 +118,14 @@ static void __devinit loongson_cs5536_acc_fixup(struct pci_dev *pdev)
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
 }
 
-static void __devinit loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
+static void loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
 {
 	/* enable the OHCI interrupt in PIC */
 	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
 	pci_write_config_dword(pdev, PCI_OHCI_INT_REG, 1);
 }
 
-static void __devinit loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
+static void loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
 {
 	u32 hi, lo;
 
@@ -137,7 +137,7 @@ static void __devinit loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, PCI_EHCI_FLADJ_REG, 0x2000);
 }
 
-static void __devinit loongson_nec_fixup(struct pci_dev *pdev)
+static void loongson_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 9a1a224..1c1e20d 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -50,7 +50,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-static void __devinit malta_piix_func0_fixup(struct pci_dev *pdev)
+static void malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
 	static int piixirqmap[16] __devinitdata = {  /* PIIX PIRQC[A:D] irq mappings */
@@ -84,7 +84,7 @@ static void __devinit malta_piix_func0_fixup(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
 	 malta_piix_func0_fixup);
 
-static void __devinit malta_piix_func1_fixup(struct pci_dev *pdev)
+static void malta_piix_func1_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
 
@@ -104,7 +104,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB,
 	 malta_piix_func1_fixup);
 
 /* Enable PCI 2.1 compatibility in PIIX4 */
-static void __devinit quirk_dlcsetup(struct pci_dev *dev)
+static void quirk_dlcsetup(struct pci_dev *dev)
 {
 	u8 odlc, ndlc;
 
diff --git a/arch/mips/pci/fixup-rc32434.c b/arch/mips/pci/fixup-rc32434.c
index 76bb1be..34a0b91 100644
--- a/arch/mips/pci/fixup-rc32434.c
+++ b/arch/mips/pci/fixup-rc32434.c
@@ -37,7 +37,7 @@ static int __devinitdata irq_map[2][12] = {
 	{0, 0, 1, 3, 0, 2, 1, 3, 0, 2, 1, 3}
 };
 
-int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = 0;
 
@@ -47,7 +47,7 @@ int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq + GROUP4_IRQ_BASE + 4;
 }
 
-static void __devinit rc32434_pci_early_fixup(struct pci_dev *dev)
+static void rc32434_pci_early_fixup(struct pci_dev *dev)
 {
 	if (PCI_SLOT(dev->devfn) == 6 && dev->bus->number == 0) {
 		/* disable prefetched memory range */
diff --git a/arch/mips/pci/fixup-sb1250.c b/arch/mips/pci/fixup-sb1250.c
index d02900a..1441bec 100644
--- a/arch/mips/pci/fixup-sb1250.c
+++ b/arch/mips/pci/fixup-sb1250.c
@@ -15,7 +15,7 @@
  * Set the BCM1250, etc. PCI host bridge's TRDY timeout
  * to the finite max.
  */
-static void __devinit quirk_sb1250_pci(struct pci_dev *dev)
+static void quirk_sb1250_pci(struct pci_dev *dev)
 {
 	pci_write_config_byte(dev, 0x40, 0xff);
 }
@@ -25,7 +25,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_PCI,
 /*
  * The BCM1250, etc. PCI/HT bridge reports as a host bridge.
  */
-static void __devinit quirk_sb1250_ht(struct pci_dev *dev)
+static void quirk_sb1250_ht(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
@@ -35,7 +35,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_HT,
 /*
  * Set the SP1011 HT/PCI bridge's TRDY timeout to the finite max.
  */
-static void __devinit quirk_sp1011(struct pci_dev *dev)
+static void quirk_sp1011(struct pci_dev *dev)
 {
 	pci_write_config_byte(dev, 0x64, 0xff);
 }
diff --git a/arch/mips/pci/ops-bcm63xx.c b/arch/mips/pci/ops-bcm63xx.c
index 65c7bd1..4a15662 100644
--- a/arch/mips/pci/ops-bcm63xx.c
+++ b/arch/mips/pci/ops-bcm63xx.c
@@ -411,7 +411,7 @@ struct pci_ops bcm63xx_cb_ops = {
  * only one IO window, so it  cannot be shared by PCI and cardbus, use
  * fixup to choose and detect unhandled configuration
  */
-static void __devinit bcm63xx_fixup(struct pci_dev *dev)
+static void bcm63xx_fixup(struct pci_dev *dev)
 {
 	static int io_window = -1;
 	int i, found, new_io_window;
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index bc13e29..9489fa4 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -197,7 +197,7 @@ static struct {
 	.gbwc = 0xfe0,	/* 4064 GBUSCLK for CCFG.GTOT=0b11 */
 };
 
-char *__devinit tx4927_pcibios_setup(char *str)
+char *tx4927_pcibios_setup(char *str)
 {
 	unsigned long val;
 
@@ -495,7 +495,7 @@ irqreturn_t tx4927_pcierr_interrupt(int irq, void *dev_id)
 }
 
 #ifdef CONFIG_TOSHIBA_FPCIB0
-static void __devinit tx4927_quirk_slc90e66_bridge(struct pci_dev *dev)
+static void tx4927_quirk_slc90e66_bridge(struct pci_dev *dev)
 {
 	struct tx4927_pcic_reg __iomem *pcicptr = pci_bus_to_pcicptr(dev->bus);
 
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index ec125be..c4ea6cc 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -356,7 +356,7 @@ static struct syscore_ops alchemy_pci_pmops = {
 	.resume		= alchemy_pci_resume,
 };
 
-static int __devinit alchemy_pci_probe(struct platform_device *pdev)
+static int alchemy_pci_probe(struct platform_device *pdev)
 {
 	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
 	struct alchemy_pci_context *ctx;
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index fdc2444..7f4f49b 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -143,7 +143,7 @@ int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
  * A given PCI device, in general, should be able to intr any of the cpus
  * on any one of the hubs connected to its xbow.
  */
-int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return 0;
 }
@@ -212,7 +212,7 @@ static inline void pci_enable_swapping(struct pci_dev *dev)
 	bridge->b_widget.w_tflush;	/* Flush */
 }
 
-static void __devinit pci_fixup_ioc3(struct pci_dev *d)
+static void pci_fixup_ioc3(struct pci_dev *d)
 {
 	pci_disable_swapping(d);
 }
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 075d87a..9568178 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -95,7 +95,7 @@ static inline u32 ltq_calc_bar11mask(void)
 	return bar11mask;
 }
 
-static int __devinit ltq_pci_startup(struct platform_device *pdev)
+static int ltq_pci_startup(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	const __be32 *req_mask, *bus_clk;
@@ -201,7 +201,7 @@ static int __devinit ltq_pci_startup(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit ltq_pci_probe(struct platform_device *pdev)
+static int ltq_pci_probe(struct platform_device *pdev)
 {
 	struct resource *res_cfg, *res_bridge;
 
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 4040416..d28ec07 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -76,7 +76,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
-static void __devinit pcibios_scanbus(struct pci_controller *hose)
+static void pcibios_scanbus(struct pci_controller *hose)
 {
 	static int next_busno;
 	static int need_domain_info;
@@ -120,7 +120,7 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 }
 
 #ifdef CONFIG_OF
-void __devinit pci_load_of_ranges(struct pci_controller *hose,
+void pci_load_of_ranges(struct pci_controller *hose,
 				struct device_node *node)
 {
 	const __be32 *ranges;
@@ -174,7 +174,7 @@ void __devinit pci_load_of_ranges(struct pci_controller *hose,
 
 static DEFINE_MUTEX(pci_scan_mutex);
 
-void __devinit register_pci_controller(struct pci_controller *hose)
+void register_pci_controller(struct pci_controller *hose)
 {
 	if (request_resource(&iomem_resource, hose->mem_resource) < 0)
 		goto out;
@@ -303,7 +303,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pcibios_plat_dev_init(dev);
 }
 
-void __devinit pcibios_fixup_bus(struct pci_bus *bus)
+void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev = bus->self;
 
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index 413f17f..ed3c9fc 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -236,7 +236,7 @@ void __init plat_mem_setup(void)
 #include <video/vga.h>
 #include <video/cirrus.h>
 
-static void __devinit quirk_cirrus_ram_size(struct pci_dev *dev)
+static void quirk_cirrus_ram_size(struct pci_dev *dev)
 {
 	u16 cmd;
 
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 4efd918..a1fb3b7 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -256,8 +256,7 @@ static irqreturn_t i8259_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit
-txx9_i8259_irq_setup(int irq)
+static int txx9_i8259_irq_setup(int irq)
 {
 	int err;
 
@@ -269,7 +268,7 @@ txx9_i8259_irq_setup(int irq)
 	return err;
 }
 
-static void __devinit quirk_slc90e66_bridge(struct pci_dev *dev)
+static void quirk_slc90e66_bridge(struct pci_dev *dev)
 {
 	int irq;	/* PCI/ISA Bridge interrupt */
 	u8 reg_64;
@@ -304,7 +303,7 @@ static void __devinit quirk_slc90e66_bridge(struct pci_dev *dev)
 	smsc_fdc37m81x_config_end();
 }
 
-static void __devinit quirk_slc90e66_ide(struct pci_dev *dev)
+static void quirk_slc90e66_ide(struct pci_dev *dev)
 {
 	unsigned char dat;
 	int regs[2] = {0x41, 0x43};
@@ -339,7 +338,7 @@ static void __devinit quirk_slc90e66_ide(struct pci_dev *dev)
 }
 #endif /* CONFIG_TOSHIBA_FPCIB0 */
 
-static void __devinit tc35815_fixup(struct pci_dev *dev)
+static void tc35815_fixup(struct pci_dev *dev)
 {
 	/* This device may have PM registers but not they are not suported. */
 	if (dev->pm_cap) {
@@ -348,7 +347,7 @@ static void __devinit tc35815_fixup(struct pci_dev *dev)
 	}
 }
 
-static void __devinit final_fixup(struct pci_dev *dev)
+static void final_fixup(struct pci_dev *dev)
 {
 	unsigned char bist;
 
-- 
1.8.0
