Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 10:05:24 +0100 (CET)
Received: from laurent.telenet-ops.be ([195.130.137.89]:35174 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992285AbcLGJFRV3lQJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 10:05:17 +0100
Received: from ayla.of.borg ([84.193.137.253])
        by laurent.telenet-ops.be with bizsmtp
        id Gx5G1u0045UCtCs01x5G1o; Wed, 07 Dec 2016 10:05:16 +0100
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1cEYA8-0008Ga-77; Wed, 07 Dec 2016 10:05:16 +0100
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1cEYAD-0003TS-5K; Wed, 07 Dec 2016 10:05:21 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MIPS: TXx9: Modernize printing of kernel messages
Date:   Wed,  7 Dec 2016 10:05:15 +0100
Message-Id: <1481101515-13319-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

  - Convert from printk() to pr_*(),
  - Add missing continuations, to fix user-visible breakage,
  - Drop superfluous casts (u64 has been unsigned long long on all
    architectures for many years).

On rbtx4927, this restores the kernel output like:

    -TX4927 SDRAMC --
    - CR0:0000007e00000544
    - TR:32800030e
    +TX4927 SDRAMC -- CR0:0000007e00000544 TR:32800030e

and:

    -PCIC -- PCICLK:
    -Internal(33.3MHz)
    -
    +PCIC -- PCICLK:Internal(33.3MHz)

Fixes: 4bcc595ccd80decb ("printk: reinstate KERN_CONT for printing continuation lines")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/mips/pci/pci-tx4927.c              | 22 +++++++++++-----------
 arch/mips/pci/pci-tx4938.c              | 30 +++++++++++++++---------------
 arch/mips/pci/pci-tx4939.c              | 10 +++++-----
 arch/mips/txx9/generic/pci.c            | 28 +++++++++++++---------------
 arch/mips/txx9/generic/setup_tx3927.c   |  6 +++---
 arch/mips/txx9/generic/setup_tx4927.c   | 20 +++++++++-----------
 arch/mips/txx9/generic/setup_tx4938.c   | 28 +++++++++++++---------------
 arch/mips/txx9/generic/setup_tx4939.c   |  8 ++++----
 arch/mips/txx9/generic/smsc_fdc37m81x.c | 17 +++++++----------
 arch/mips/txx9/jmr3927/prom.c           |  2 +-
 arch/mips/txx9/jmr3927/setup.c          | 11 +++++------
 arch/mips/txx9/rbtx4938/setup.c         | 14 +++++++-------
 12 files changed, 93 insertions(+), 103 deletions(-)

diff --git a/arch/mips/pci/pci-tx4927.c b/arch/mips/pci/pci-tx4927.c
index a032ae0a533dce2d..9b3301d19a63f5b5 100644
--- a/arch/mips/pci/pci-tx4927.c
+++ b/arch/mips/pci/pci-tx4927.c
@@ -21,9 +21,9 @@ int __init tx4927_report_pciclk(void)
 {
 	int pciclk = 0;
 
-	printk(KERN_INFO "PCIC --%s PCICLK:",
-	       (__raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_PCI66) ?
-	       " PCI66" : "");
+	pr_info("PCIC --%s PCICLK:",
+		(__raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_PCI66) ?
+		" PCI66" : "");
 	if (__raw_readq(&tx4927_ccfgptr->pcfg) & TX4927_PCFG_PCICLKEN_ALL) {
 		u64 ccfg = __raw_readq(&tx4927_ccfgptr->ccfg);
 		switch ((unsigned long)ccfg &
@@ -37,14 +37,14 @@ int __init tx4927_report_pciclk(void)
 		case TX4927_CCFG_PCIDIVMODE_6:
 			pciclk = txx9_cpu_clock / 6; break;
 		}
-		printk("Internal(%u.%uMHz)",
-		       (pciclk + 50000) / 1000000,
-		       ((pciclk + 50000) / 100000) % 10);
+		pr_cont("Internal(%u.%uMHz)",
+			(pciclk + 50000) / 1000000,
+			((pciclk + 50000) / 100000) % 10);
 	} else {
-		printk("External");
+		pr_cont("External");
 		pciclk = -1;
 	}
-	printk("\n");
+	pr_cont("\n");
 	return pciclk;
 }
 
@@ -74,8 +74,8 @@ int __init tx4927_pciclk66_setup(void)
 		}
 		tx4927_ccfg_change(TX4927_CCFG_PCIDIVMODE_MASK,
 				   pcidivmode);
-		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
-		       (unsigned long)__raw_readq(&tx4927_ccfgptr->ccfg));
+		pr_debug("PCICLK: ccfg:%08lx\n",
+			 (unsigned long)__raw_readq(&tx4927_ccfgptr->ccfg));
 	} else
 		pciclk = -1;
 	return pciclk;
@@ -87,5 +87,5 @@ void __init tx4927_setup_pcierr_irq(void)
 			tx4927_pcierr_interrupt,
 			0, "PCI error",
 			(void *)TX4927_PCIC_REG))
-		printk(KERN_WARNING "Failed to request irq for PCIERR\n");
+		pr_warn("Failed to request irq for PCIERR\n");
 }
diff --git a/arch/mips/pci/pci-tx4938.c b/arch/mips/pci/pci-tx4938.c
index 141bba562488d1d3..000c0e1f9ef869d8 100644
--- a/arch/mips/pci/pci-tx4938.c
+++ b/arch/mips/pci/pci-tx4938.c
@@ -21,9 +21,9 @@ int __init tx4938_report_pciclk(void)
 {
 	int pciclk = 0;
 
-	printk(KERN_INFO "PCIC --%s PCICLK:",
-	       (__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCI66) ?
-	       " PCI66" : "");
+	pr_info("PCIC --%s PCICLK:",
+		(__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCI66) ?
+		" PCI66" : "");
 	if (__raw_readq(&tx4938_ccfgptr->pcfg) & TX4938_PCFG_PCICLKEN_ALL) {
 		u64 ccfg = __raw_readq(&tx4938_ccfgptr->ccfg);
 		switch ((unsigned long)ccfg &
@@ -45,14 +45,14 @@ int __init tx4938_report_pciclk(void)
 		case TX4938_CCFG_PCIDIVMODE_11:
 			pciclk = txx9_cpu_clock / 11; break;
 		}
-		printk("Internal(%u.%uMHz)",
-		       (pciclk + 50000) / 1000000,
-		       ((pciclk + 50000) / 100000) % 10);
+		pr_cont("Internal(%u.%uMHz)",
+			(pciclk + 50000) / 1000000,
+			((pciclk + 50000) / 100000) % 10);
 	} else {
-		printk("External");
+		pr_cont("External");
 		pciclk = -1;
 	}
-	printk("\n");
+	pr_cont("\n");
 	return pciclk;
 }
 
@@ -62,10 +62,10 @@ void __init tx4938_report_pci1clk(void)
 	unsigned int pciclk =
 		txx9_gbus_clock / ((ccfg & TX4938_CCFG_PCI1DMD) ? 4 : 2);
 
-	printk(KERN_INFO "PCIC1 -- %sPCICLK:%u.%uMHz\n",
-	       (ccfg & TX4938_CCFG_PCI1_66) ? "PCI66 " : "",
-	       (pciclk + 50000) / 1000000,
-	       ((pciclk + 50000) / 100000) % 10);
+	pr_info("PCIC1 -- %sPCICLK:%u.%uMHz\n",
+		(ccfg & TX4938_CCFG_PCI1_66) ? "PCI66 " : "",
+		(pciclk + 50000) / 1000000,
+		((pciclk + 50000) / 100000) % 10);
 }
 
 int __init tx4938_pciclk66_setup(void)
@@ -105,8 +105,8 @@ int __init tx4938_pciclk66_setup(void)
 		}
 		tx4938_ccfg_change(TX4938_CCFG_PCIDIVMODE_MASK,
 				   pcidivmode);
-		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
-		       (unsigned long)__raw_readq(&tx4938_ccfgptr->ccfg));
+		pr_debug("PCICLK: ccfg:%08lx\n",
+			 (unsigned long)__raw_readq(&tx4938_ccfgptr->ccfg));
 	} else
 		pciclk = -1;
 	return pciclk;
@@ -138,5 +138,5 @@ void __init tx4938_setup_pcierr_irq(void)
 			tx4927_pcierr_interrupt,
 			0, "PCI error",
 			(void *)TX4927_PCIC_REG))
-		printk(KERN_WARNING "Failed to request irq for PCIERR\n");
+		pr_warn("Failed to request irq for PCIERR\n");
 }
diff --git a/arch/mips/pci/pci-tx4939.c b/arch/mips/pci/pci-tx4939.c
index cd8ed09c4f5302ff..9d6acc00f3489ddb 100644
--- a/arch/mips/pci/pci-tx4939.c
+++ b/arch/mips/pci/pci-tx4939.c
@@ -28,14 +28,14 @@ int __init tx4939_report_pciclk(void)
 		pciclk = txx9_master_clock * 20 / 6;
 		if (!(__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCI66))
 			pciclk /= 2;
-		printk(KERN_CONT "Internal(%u.%uMHz)",
-		       (pciclk + 50000) / 1000000,
-		       ((pciclk + 50000) / 100000) % 10);
+		pr_cont("Internal(%u.%uMHz)",
+			(pciclk + 50000) / 1000000,
+			((pciclk + 50000) / 100000) % 10);
 	} else {
-		printk(KERN_CONT "External");
+		pr_cont("External");
 		pciclk = -1;
 	}
-	printk(KERN_CONT "\n");
+	pr_cont("\n");
 	return pciclk;
 }
 
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 285d84e5c7b92cf5..0bd2a1e1ff9ab8e0 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -55,7 +55,7 @@ int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
 	/* It seems SLC90E66 needs some time after PCI reset... */
 	mdelay(80);
 
-	printk(KERN_INFO "PCI: Checking 66MHz capabilities...\n");
+	pr_info("PCI: Checking 66MHz capabilities...\n");
 
 	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
 		if (PCI_FUNC(pci_devfn))
@@ -74,9 +74,8 @@ int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
 			early_read_config_word(hose, top_bus, current_bus,
 					       pci_devfn, PCI_STATUS, &stat);
 			if (!(stat & PCI_STATUS_66MHZ)) {
-				printk(KERN_DEBUG
-				       "PCI: %02x:%02x not 66MHz capable.\n",
-				       current_bus, pci_devfn);
+				pr_debug("PCI: %02x:%02x not 66MHz capable.\n",
+					 current_bus, pci_devfn);
 				cap66 = 0;
 				break;
 			}
@@ -209,8 +208,8 @@ struct pci_controller *__init
 
 	pcic->mem_offset = 0;	/* busaddr == physaddr */
 
-	printk(KERN_INFO "PCI: IO %pR MEM %pR\n",
-	       &pcic->mem_resource[1], &pcic->mem_resource[0]);
+	pr_info("PCI: IO %pR MEM %pR\n", &pcic->mem_resource[1],
+		&pcic->mem_resource[0]);
 
 	/* register_pci_controller() will request MEM resource */
 	release_resource(&pcic->mem_resource[0]);
@@ -219,7 +218,7 @@ struct pci_controller *__init
 	release_resource(&pcic->mem_resource[0]);
  free_and_exit:
 	kfree(new);
-	printk(KERN_ERR "PCI: Failed to allocate resources.\n");
+	pr_err("PCI: Failed to allocate resources.\n");
 	return NULL;
 }
 
@@ -260,7 +259,7 @@ static int txx9_i8259_irq_setup(int irq)
 	err = request_irq(irq, &i8259_interrupt, IRQF_SHARED,
 			  "cascade(i8259)", (void *)(long)irq);
 	if (!err)
-		printk(KERN_INFO "PCI-ISA bridge PIC (irq %d)\n", irq);
+		pr_info("PCI-ISA bridge PIC (irq %d)\n", irq);
 	return err;
 }
 
@@ -308,13 +307,13 @@ static void quirk_slc90e66_ide(struct pci_dev *dev)
 	/* SMSC SLC90E66 IDE uses irq 14, 15 (default) */
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &dat);
-	printk(KERN_INFO "PCI: %s: IRQ %02x", pci_name(dev), dat);
+	pr_info("PCI: %s: IRQ %02x", pci_name(dev), dat);
 	/* enable SMSC SLC90E66 IDE */
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
 		pci_read_config_byte(dev, regs[i], &dat);
 		pci_write_config_byte(dev, regs[i], dat | 0x80);
 		pci_read_config_byte(dev, regs[i], &dat);
-		printk(KERN_CONT " IDETIM%d %02x", i, dat);
+		pr_cont(" IDETIM%d %02x", i, dat);
 	}
 	pci_read_config_byte(dev, 0x5c, &dat);
 	/*
@@ -329,8 +328,7 @@ static void quirk_slc90e66_ide(struct pci_dev *dev)
 	dat |= 0x01;
 	pci_write_config_byte(dev, 0x5c, dat);
 	pci_read_config_byte(dev, 0x5c, &dat);
-	printk(KERN_CONT " REG5C %02x", dat);
-	printk(KERN_CONT "\n");
+	pr_cont(" REG5C %02x\n", dat);
 }
 #endif /* CONFIG_TOSHIBA_FPCIB0 */
 
@@ -352,7 +350,7 @@ static void final_fixup(struct pci_dev *dev)
 	    (bist & PCI_BIST_CAPABLE)) {
 		unsigned long timeout;
 		pci_set_power_state(dev, PCI_D0);
-		printk(KERN_INFO "PCI: %s BIST...", pci_name(dev));
+		pr_info("PCI: %s BIST...", pci_name(dev));
 		pci_write_config_byte(dev, PCI_BIST, PCI_BIST_START);
 		timeout = jiffies + HZ * 2;	/* timeout after 2 sec */
 		do {
@@ -361,9 +359,9 @@ static void final_fixup(struct pci_dev *dev)
 				break;
 		} while (bist & PCI_BIST_START);
 		if (bist & (PCI_BIST_CODE_MASK | PCI_BIST_START))
-			printk(KERN_CONT "failed. (0x%x)\n", bist);
+			pr_cont("failed. (0x%x)\n", bist);
 		else
-			printk(KERN_CONT "OK.\n");
+			pr_cont("OK.\n");
 	}
 }
 
diff --git a/arch/mips/txx9/generic/setup_tx3927.c b/arch/mips/txx9/generic/setup_tx3927.c
index d3b83a92cf26c707..33f7a7253963ad38 100644
--- a/arch/mips/txx9/generic/setup_tx3927.c
+++ b/arch/mips/txx9/generic/setup_tx3927.c
@@ -67,9 +67,9 @@ void __init tx3927_setup(void)
 	/* do reset on watchdog */
 	tx3927_ccfgptr->ccfg |= TX3927_CCFG_WR;
 
-	printk(KERN_INFO "TX3927 -- CRIR:%08lx CCFG:%08lx PCFG:%08lx\n",
-	       tx3927_ccfgptr->crir,
-	       tx3927_ccfgptr->ccfg, tx3927_ccfgptr->pcfg);
+	pr_info("TX3927 -- CRIR:%08lx CCFG:%08lx PCFG:%08lx\n",
+		tx3927_ccfgptr->crir, tx3927_ccfgptr->ccfg,
+		tx3927_ccfgptr->pcfg);
 
 	/* TMR */
 	for (i = 0; i < TX3927_NR_TMR; i++)
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index 8d8011570b1dbe99..46e9c41013862c96 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -183,15 +183,14 @@ void __init tx4927_setup(void)
 	if (!(____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_PCIARB))
 		txx9_clear64(&tx4927_ccfgptr->pcfg, TX4927_PCFG_PCICLKEN_ALL);
 
-	printk(KERN_INFO "%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
-	       txx9_pcode_str,
-	       (cpuclk + 500000) / 1000000,
-	       (txx9_master_clock + 500000) / 1000000,
-	       (__u32)____raw_readq(&tx4927_ccfgptr->crir),
-	       (unsigned long long)____raw_readq(&tx4927_ccfgptr->ccfg),
-	       (unsigned long long)____raw_readq(&tx4927_ccfgptr->pcfg));
+	pr_info("%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
+		txx9_pcode_str, (cpuclk + 500000) / 1000000,
+		(txx9_master_clock + 500000) / 1000000,
+		(__u32)____raw_readq(&tx4927_ccfgptr->crir),
+		____raw_readq(&tx4927_ccfgptr->ccfg),
+		____raw_readq(&tx4927_ccfgptr->pcfg));
 
-	printk(KERN_INFO "%s SDRAMC --", txx9_pcode_str);
+	pr_info("%s SDRAMC --", txx9_pcode_str);
 	for (i = 0; i < 4; i++) {
 		__u64 cr = TX4927_SDRAMC_CR(i);
 		unsigned long base, size;
@@ -199,15 +198,14 @@ void __init tx4927_setup(void)
 			continue;	/* disabled */
 		base = (unsigned long)(cr >> 49) << 21;
 		size = (((unsigned long)(cr >> 33) & 0x7fff) + 1) << 21;
-		printk(" CR%d:%016llx", i, (unsigned long long)cr);
+		pr_cont(" CR%d:%016llx", i, cr);
 		tx4927_sdram_resource[i].name = "SDRAM";
 		tx4927_sdram_resource[i].start = base;
 		tx4927_sdram_resource[i].end = base + size - 1;
 		tx4927_sdram_resource[i].flags = IORESOURCE_MEM;
 		request_resource(&iomem_resource, &tx4927_sdram_resource[i]);
 	}
-	printk(" TR:%09llx\n",
-	       (unsigned long long)____raw_readq(&tx4927_sdramcptr->tr));
+	pr_cont(" TR:%09llx\n", ____raw_readq(&tx4927_sdramcptr->tr));
 
 	/* TMR */
 	/* disable all timers */
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index ba265bf1fd067036..85d1795652da6d09 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -196,15 +196,14 @@ void __init tx4938_setup(void)
 	if (!(____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCIARB))
 		txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_PCICLKEN_ALL);
 
-	printk(KERN_INFO "%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
-	       txx9_pcode_str,
-	       (cpuclk + 500000) / 1000000,
-	       (txx9_master_clock + 500000) / 1000000,
-	       (__u32)____raw_readq(&tx4938_ccfgptr->crir),
-	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->ccfg),
-	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->pcfg));
-
-	printk(KERN_INFO "%s SDRAMC --", txx9_pcode_str);
+	pr_info("%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
+		txx9_pcode_str, (cpuclk + 500000) / 1000000,
+		(txx9_master_clock + 500000) / 1000000,
+		(__u32)____raw_readq(&tx4938_ccfgptr->crir),
+		____raw_readq(&tx4938_ccfgptr->ccfg),
+		____raw_readq(&tx4938_ccfgptr->pcfg));
+
+	pr_info("%s SDRAMC --", txx9_pcode_str);
 	for (i = 0; i < 4; i++) {
 		__u64 cr = TX4938_SDRAMC_CR(i);
 		unsigned long base, size;
@@ -212,15 +211,14 @@ void __init tx4938_setup(void)
 			continue;	/* disabled */
 		base = (unsigned long)(cr >> 49) << 21;
 		size = (((unsigned long)(cr >> 33) & 0x7fff) + 1) << 21;
-		printk(" CR%d:%016llx", i, (unsigned long long)cr);
+		pr_cont(" CR%d:%016llx", i, cr);
 		tx4938_sdram_resource[i].name = "SDRAM";
 		tx4938_sdram_resource[i].start = base;
 		tx4938_sdram_resource[i].end = base + size - 1;
 		tx4938_sdram_resource[i].flags = IORESOURCE_MEM;
 		request_resource(&iomem_resource, &tx4938_sdram_resource[i]);
 	}
-	printk(" TR:%09llx\n",
-	       (unsigned long long)____raw_readq(&tx4938_sdramcptr->tr));
+	pr_cont(" TR:%09llx\n", ____raw_readq(&tx4938_sdramcptr->tr));
 
 	/* SRAM */
 	if (txx9_pcode == 0x4938 && ____raw_readq(&tx4938_sramcptr->cr) & 1) {
@@ -254,20 +252,20 @@ void __init tx4938_setup(void)
 			txx9_clear64(&tx4938_ccfgptr->clkctr,
 				     TX4938_CLKCTR_PCIC1RST);
 		} else {
-			printk(KERN_INFO "%s: stop PCIC1\n", txx9_pcode_str);
+			pr_info("%s: stop PCIC1\n", txx9_pcode_str);
 			/* stop PCIC1 */
 			txx9_set64(&tx4938_ccfgptr->clkctr,
 				   TX4938_CLKCTR_PCIC1CKD);
 		}
 		if (!(pcfg & TX4938_PCFG_ETH0_SEL)) {
-			printk(KERN_INFO "%s: stop ETH0\n", txx9_pcode_str);
+			pr_info("%s: stop ETH0\n", txx9_pcode_str);
 			txx9_set64(&tx4938_ccfgptr->clkctr,
 				   TX4938_CLKCTR_ETH0RST);
 			txx9_set64(&tx4938_ccfgptr->clkctr,
 				   TX4938_CLKCTR_ETH0CKD);
 		}
 		if (!(pcfg & TX4938_PCFG_ETH1_SEL)) {
-			printk(KERN_INFO "%s: stop ETH1\n", txx9_pcode_str);
+			pr_info("%s: stop ETH1\n", txx9_pcode_str);
 			txx9_set64(&tx4938_ccfgptr->clkctr,
 				   TX4938_CLKCTR_ETH1RST);
 			txx9_set64(&tx4938_ccfgptr->clkctr,
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index 402ac2ec7e834903..274928987a21a686 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -221,8 +221,8 @@ void __init tx4939_setup(void)
 		(txx9_master_clock + 500000) / 1000000,
 		(txx9_gbus_clock + 500000) / 1000000,
 		(__u32)____raw_readq(&tx4939_ccfgptr->crir),
-		(unsigned long long)____raw_readq(&tx4939_ccfgptr->ccfg),
-		(unsigned long long)____raw_readq(&tx4939_ccfgptr->pcfg));
+		____raw_readq(&tx4939_ccfgptr->ccfg),
+		____raw_readq(&tx4939_ccfgptr->pcfg));
 
 	pr_info("%s DDRC -- EN:%08x", txx9_pcode_str,
 		(__u32)____raw_readq(&tx4939_ddrcptr->winen));
@@ -230,7 +230,7 @@ void __init tx4939_setup(void)
 		__u64 win = ____raw_readq(&tx4939_ddrcptr->win[i]);
 		if (!((__u32)____raw_readq(&tx4939_ddrcptr->winen) & (1 << i)))
 			continue;	/* disabled */
-		printk(KERN_CONT " #%d:%016llx", i, (unsigned long long)win);
+		pr_cont(" #%d:%016llx", i, win);
 		tx4939_sdram_resource[i].name = "DDR SDRAM";
 		tx4939_sdram_resource[i].start =
 			(unsigned long)(win >> 48) << 20;
@@ -240,7 +240,7 @@ void __init tx4939_setup(void)
 		tx4939_sdram_resource[i].flags = IORESOURCE_MEM;
 		request_resource(&iomem_resource, &tx4939_sdram_resource[i]);
 	}
-	printk(KERN_CONT "\n");
+	pr_cont("\n");
 
 	/* SRAM */
 	if (____raw_readq(&tx4939_sramcptr->cr) & 1) {
diff --git a/arch/mips/txx9/generic/smsc_fdc37m81x.c b/arch/mips/txx9/generic/smsc_fdc37m81x.c
index f98baa6263d24425..40f4098d3ae18866 100644
--- a/arch/mips/txx9/generic/smsc_fdc37m81x.c
+++ b/arch/mips/txx9/generic/smsc_fdc37m81x.c
@@ -105,9 +105,8 @@ unsigned long __init smsc_fdc37m81x_init(unsigned long port)
 	u8 chip_id;
 
 	if (g_smsc_fdc37m81x_base)
-		printk(KERN_WARNING "%s: stepping on old base=0x%0*lx\n",
-		       __func__,
-		       field, g_smsc_fdc37m81x_base);
+		pr_warn("%s: stepping on old base=0x%0*lx\n", __func__, field,
+			g_smsc_fdc37m81x_base);
 
 	g_smsc_fdc37m81x_base = port;
 
@@ -117,8 +116,7 @@ unsigned long __init smsc_fdc37m81x_init(unsigned long port)
 	if (chip_id == SMSC_FDC37M81X_CHIP_ID)
 		smsc_fdc37m81x_config_end();
 	else {
-		printk(KERN_WARNING "%s: unknown chip id 0x%02x\n", __func__,
-		       chip_id);
+		pr_warn("%s: unknown chip id 0x%02x\n", __func__, chip_id);
 		g_smsc_fdc37m81x_base = 0;
 	}
 
@@ -128,9 +126,8 @@ unsigned long __init smsc_fdc37m81x_init(unsigned long port)
 #ifdef DEBUG
 static void smsc_fdc37m81x_config_dump_one(const char *key, u8 dev, u8 reg)
 {
-	printk(KERN_INFO "%s: dev=0x%02x reg=0x%02x val=0x%02x\n",
-	       key, dev, reg,
-	       smsc_fdc37m81x_rd(reg));
+	pr_info("%s: dev=0x%02x reg=0x%02x val=0x%02x\n", key, dev, reg,
+		smsc_fdc37m81x_rd(reg));
 }
 
 void smsc_fdc37m81x_config_dump(void)
@@ -142,7 +139,7 @@ void smsc_fdc37m81x_config_dump(void)
 
 	orig = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DNUM);
 
-	printk(KERN_INFO "%s: common\n", fname);
+	pr_info("%s: common\n", fname);
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
 				       SMSC_FDC37M81X_DNUM);
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
@@ -154,7 +151,7 @@ void smsc_fdc37m81x_config_dump(void)
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
 				       SMSC_FDC37M81X_PMGT);
 
-	printk(KERN_INFO "%s: keyboard\n", fname);
+	pr_info("%s: keyboard\n", fname);
 	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, SMSC_FDC37M81X_KBD);
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
 				       SMSC_FDC37M81X_ACTIVE);
diff --git a/arch/mips/txx9/jmr3927/prom.c b/arch/mips/txx9/jmr3927/prom.c
index c899c0c087a0fa84..68a96473c134904f 100644
--- a/arch/mips/txx9/jmr3927/prom.c
+++ b/arch/mips/txx9/jmr3927/prom.c
@@ -45,7 +45,7 @@ void __init jmr3927_prom_init(void)
 {
 	/* CCFG */
 	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
-		printk(KERN_ERR "TX3927 TLB off\n");
+		pr_err("TX3927 TLB off\n");
 
 	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
 	txx9_sio_putchar_init(TX3927_SIO_REG(1));
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index a455166dc6d44fe7..613943886e34c5b2 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -150,12 +150,11 @@ static void __init jmr3927_board_init(void)
 
 	jmr3927_led_set(0);
 
-	printk(KERN_INFO
-	       "JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
-	       jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
-	       jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
-	       jmr3927_dipsw1(), jmr3927_dipsw2(),
-	       jmr3927_dipsw3(), jmr3927_dipsw4());
+	pr_info("JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
+		jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
+		jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
+		jmr3927_dipsw1(), jmr3927_dipsw2(),
+		jmr3927_dipsw3(), jmr3927_dipsw4());
 }
 
 /* This trick makes rtc-ds1742 driver usable as is. */
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 07939ed6b22fdac5..e68eb2e7ce0cf580 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -123,15 +123,15 @@ static int __init rbtx4938_ethaddr_init(void)
 
 	/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
 	if (spi_eeprom_read(SPI_BUSNO, SEEPROM1_CS, 0, dat, sizeof(dat))) {
-		printk(KERN_ERR "seeprom: read error.\n");
+		pr_err("seeprom: read error.\n");
 		return -ENODEV;
 	} else {
 		if (strcmp(dat, "MAC") != 0)
-			printk(KERN_WARNING "seeprom: bad signature.\n");
+			pr_warn("seeprom: bad signature.\n");
 		for (i = 0, sum = 0; i < sizeof(dat); i++)
 			sum += dat[i];
 		if (sum)
-			printk(KERN_WARNING "seeprom: bad checksum.\n");
+			pr_warn("seeprom: bad checksum.\n");
 	}
 	tx4938_ethaddr_init(&dat[4], &dat[4 + 6]);
 #endif /* CONFIG_PCI */
@@ -214,14 +214,14 @@ static void __init rbtx4938_mem_setup(void)
 	rbtx4938_fpga_resource.end = CPHYSADDR(RBTX4938_FPGA_REG_ADDR) + 0xffff;
 	rbtx4938_fpga_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	if (request_resource(&txx9_ce_res[2], &rbtx4938_fpga_resource))
-		printk(KERN_ERR "request resource for fpga failed\n");
+		pr_err("request resource for fpga failed\n");
 
 	_machine_restart = rbtx4938_machine_restart;
 
 	writeb(0xff, rbtx4938_led_addr);
-	printk(KERN_INFO "RBTX4938 --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
-	       readb(rbtx4938_fpga_rev_addr),
-	       readb(rbtx4938_dipsw_addr), readb(rbtx4938_bdipsw_addr));
+	pr_info("RBTX4938 --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
+		readb(rbtx4938_fpga_rev_addr),
+		readb(rbtx4938_dipsw_addr), readb(rbtx4938_bdipsw_addr));
 }
 
 static void __init rbtx4938_ne_init(void)
-- 
1.9.1
