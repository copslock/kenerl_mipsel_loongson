Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2017 20:36:52 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:38037
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995040AbdILSghNnxws (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Sep 2017 20:36:37 +0200
Received: by mail-wr0-x243.google.com with SMTP id p37so6626893wrb.5;
        Tue, 12 Sep 2017 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pzegHMtcQFZIZkRtCZ7EFaL0tkwNALujVK1vVv4xPuA=;
        b=ah4VJ3fVwsiFgaZ9oT8MxHwXAB7qV09BG4id8uOpRGnk261XDlQX6NEwbh6qg500iZ
         GIG1j5AYURU8mE+1HXwyzecwWmh5Imm505yJNZNZOrimBe+GOpBLbeub1sJt8rKhve8M
         lCe8BYrQAmm7CC7LcUG9on6FVc9OMojeqPlfwq+Oenqk5efTs+3wGjOKpZO9egPeNreu
         isXa7Jx4j78+86BuVagtToSJbcPnq7f8ljDj9TUpNq5CqKoCr/BcJQU6loVns07AKsuT
         SXXlYv6LJQTqNS2n6Sow2qxc4u0SEkkxeHG8RkXBkS4FDMaW2RSbzzysvZH622mCq1HL
         r/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pzegHMtcQFZIZkRtCZ7EFaL0tkwNALujVK1vVv4xPuA=;
        b=KJh0OldvMCM3gTmeMo6ooPjJpqp3J5mKIDoEcIgyX+7VhRvB9gFxgxCZShogyNHkpt
         +be7sBKPhzltiiUqumqO2JLkquescpcthLPp876myl/s+TS2IiAAiZqu/L0g0JewCLFZ
         8Am8KvDZ0zHx/x63RScNb/8H93nUUiAnxkD03NLu+H+4HNS3mIx9go/lHPNAkRv8JQPK
         TcPpKox7/AxFfxn9K5OIhKglhAhWQeD6Mm7IWrAkrgEY+HqAMRFHz7XnvGKSciKhlN4D
         v7AEyGrQH2Kb15k3t+wfWAbA7B5fpKFojofza83E8DB1fNUCcFpaZl8Fy5MAsW6yYbcE
         hNuw==
X-Gm-Message-State: AHPjjUj9pLDqQHEXFRhTbJAK523naA9KwH0/sMisq3KB5L1ekTp5y1qy
        e4MjkGq3HiXz92+u
X-Google-Smtp-Source: ADKCNb6MPGaWGWRMYfjiTS8BVcPGobBRvZpZbhK3YEq0umg7uodUPQAOma9X2WmM9k1lBlyKacMJxQ==
X-Received: by 10.223.198.202 with SMTP id c10mr13148705wrh.230.1505241391440;
        Tue, 12 Sep 2017 11:36:31 -0700 (PDT)
Received: from flagship2.speedport.ip (p200300C20BD7D759A57D9F569AFD81BD.dip0.t-ipconnect.de. [2003:c2:bd7:d759:a57d:9f56:9afd:81bd])
        by smtp.gmail.com with ESMTPSA id 10sm4361272wrt.59.2017.09.12.11.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Sep 2017 11:36:30 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: PCI: fix pcibios_map_irq section mismatch
Date:   Tue, 12 Sep 2017 20:36:28 +0200
Message-Id: <20170912183628.906625-1-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Drop  the __init from pcibios_map_irq() to make this section mis-
match go away:

WARNING: vmlinux.o(.text+0x56acd4): Section mismatch in reference from the function pcibios_scanbus() to the function .init.text:pcibios_map_irq()
The function pcibios_scanbus() references
the function __init pcibios_map_irq().
This is often because pcibios_scanbus lacks a __init
annotation or the annotation of pcibios_map_irq is wrong.

Run-Tested only on Alchemy.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/pci/fixup-capcella.c  | 2 +-
 arch/mips/pci/fixup-cobalt.c    | 2 +-
 arch/mips/pci/fixup-emma2rh.c   | 2 +-
 arch/mips/pci/fixup-fuloong2e.c | 2 +-
 arch/mips/pci/fixup-ip32.c      | 2 +-
 arch/mips/pci/fixup-lantiq.c    | 2 +-
 arch/mips/pci/fixup-lemote2f.c  | 2 +-
 arch/mips/pci/fixup-loongson3.c | 2 +-
 arch/mips/pci/fixup-malta.c     | 2 +-
 arch/mips/pci/fixup-mpc30x.c    | 2 +-
 arch/mips/pci/fixup-pmcmsp.c    | 2 +-
 arch/mips/pci/fixup-sni.c       | 2 +-
 arch/mips/pci/fixup-tb0219.c    | 2 +-
 arch/mips/pci/fixup-tb0226.c    | 2 +-
 arch/mips/pci/fixup-tb0287.c    | 2 +-
 arch/mips/pci/pci-alchemy.c     | 2 +-
 arch/mips/pci/pci-bcm47xx.c     | 2 +-
 arch/mips/pci/pci-lasat.c       | 2 +-
 arch/mips/pci/pci-mt7620.c      | 2 +-
 arch/mips/pci/pci-octeon.c      | 4 ++--
 arch/mips/pci/pci-rt2880.c      | 2 +-
 arch/mips/pci/pci-rt3883.c      | 2 +-
 arch/mips/pci/pci-xlp.c         | 2 +-
 arch/mips/pci/pci-xlr.c         | 2 +-
 24 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/mips/pci/fixup-capcella.c b/arch/mips/pci/fixup-capcella.c
index 1c02f5737367..35a671595a37 100644
--- a/arch/mips/pci/fixup-capcella.c
+++ b/arch/mips/pci/fixup-capcella.c
@@ -38,7 +38,7 @@ static char irq_tab_capcella[][5] __initdata = {
  [14] = { -1, INTA, INTB, INTC, INTD }
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_capcella[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index b3ab59318d91..62810d3fe99b 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -174,7 +174,7 @@ static char irq_tab_raq2[] __initdata = {
   [COBALT_PCICONF_ETH1]	   = ETH1_IRQ
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)
 		return irq_tab_qube1[slot];
diff --git a/arch/mips/pci/fixup-emma2rh.c b/arch/mips/pci/fixup-emma2rh.c
index 19caf775c206..4832ac9f118a 100644
--- a/arch/mips/pci/fixup-emma2rh.c
+++ b/arch/mips/pci/fixup-emma2rh.c
@@ -85,7 +85,7 @@ static void emma2rh_pci_host_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_EMMA2RH,
 			 emma2rh_pci_host_fixup);
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_map[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
index 50da773faede..b47c2771dc99 100644
--- a/arch/mips/pci/fixup-fuloong2e.c
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -19,7 +19,7 @@
 /* South bridge slot number is set by the pci probe process */
 static u8 sb_slot = 5;
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = 0;
 
diff --git a/arch/mips/pci/fixup-ip32.c b/arch/mips/pci/fixup-ip32.c
index 133685e215ee..ea29f5450be3 100644
--- a/arch/mips/pci/fixup-ip32.c
+++ b/arch/mips/pci/fixup-ip32.c
@@ -39,7 +39,7 @@ static char irq_tab_mace[][5] __initdata = {
  * irqs.  I suppose a device without a pin A will thank us for doing it
  * right if there exists such a broken piece of crap.
  */
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_mace[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
index 2b5427d3f35c..81530a13b349 100644
--- a/arch/mips/pci/fixup-lantiq.c
+++ b/arch/mips/pci/fixup-lantiq.c
@@ -23,7 +23,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return of_irq_parse_and_map_pci(dev, slot, pin);
 }
diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index 95ab9a1bd010..7e5991e0e323 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -51,7 +51,7 @@ static char irq_tab[][5] __initdata = {
 	{0, 0, 0, 0, 0},	/*  27: Unused */
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int virq;
 
diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
index 2b6d5e196f99..8a741c2c6685 100644
--- a/arch/mips/pci/fixup-loongson3.c
+++ b/arch/mips/pci/fixup-loongson3.c
@@ -32,7 +32,7 @@ static void print_fixup_info(const struct pci_dev *pdev)
 			pdev->vendor, pdev->device, pdev->irq);
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	print_fixup_info(dev);
 	return dev->irq;
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 40e920c653cc..1f5f25e39590 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -38,7 +38,7 @@ static char irq_tab[][5] __initdata = {
 	{0,	PCID,	PCIA,	PCIB,	PCIC }	/* 21: PCI Slot 4 */
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int virq;
 	virq = irq_tab[slot][pin];
diff --git a/arch/mips/pci/fixup-mpc30x.c b/arch/mips/pci/fixup-mpc30x.c
index 8e4f8288eca2..5da62c76e271 100644
--- a/arch/mips/pci/fixup-mpc30x.c
+++ b/arch/mips/pci/fixup-mpc30x.c
@@ -34,7 +34,7 @@ static const int irq_tab_mpc30x[] __initconst = {
  [29] = MQ200_IRQ,
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (slot == 30)
 		return internal_func_irqs[PCI_FUNC(dev->devfn)];
diff --git a/arch/mips/pci/fixup-pmcmsp.c b/arch/mips/pci/fixup-pmcmsp.c
index fab405c21c2f..f2b7b1e4395b 100644
--- a/arch/mips/pci/fixup-pmcmsp.c
+++ b/arch/mips/pci/fixup-pmcmsp.c
@@ -202,7 +202,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
  *  RETURNS:	 IRQ number
  *
  ****************************************************************************/
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 #if !defined(CONFIG_PMC_MSP7120_GW) && !defined(CONFIG_PMC_MSP7120_EVAL)
 	printk(KERN_WARNING "PCI: unknown board, no PCI IRQs assigned.\n");
diff --git a/arch/mips/pci/fixup-sni.c b/arch/mips/pci/fixup-sni.c
index f67ebeeb4200..309e1c562959 100644
--- a/arch/mips/pci/fixup-sni.c
+++ b/arch/mips/pci/fixup-sni.c
@@ -130,7 +130,7 @@ static inline int is_rm300_revd(void)
 	return (csmsr & 0xa0) == 0x20;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch (sni_brd_type) {
 	case SNI_BRD_PCI_TOWER_CPLUS:
diff --git a/arch/mips/pci/fixup-tb0219.c b/arch/mips/pci/fixup-tb0219.c
index d0b0083fbd27..cc581535f257 100644
--- a/arch/mips/pci/fixup-tb0219.c
+++ b/arch/mips/pci/fixup-tb0219.c
@@ -23,7 +23,7 @@
 
 #include <asm/vr41xx/tb0219.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = -1;
 
diff --git a/arch/mips/pci/fixup-tb0226.c b/arch/mips/pci/fixup-tb0226.c
index 4196ccf3ea3d..b827b5cad5fd 100644
--- a/arch/mips/pci/fixup-tb0226.c
+++ b/arch/mips/pci/fixup-tb0226.c
@@ -23,7 +23,7 @@
 #include <asm/vr41xx/giu.h>
 #include <asm/vr41xx/tb0226.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = -1;
 
diff --git a/arch/mips/pci/fixup-tb0287.c b/arch/mips/pci/fixup-tb0287.c
index 8c5039ed75d7..98f26285f2e3 100644
--- a/arch/mips/pci/fixup-tb0287.c
+++ b/arch/mips/pci/fixup-tb0287.c
@@ -22,7 +22,7 @@
 
 #include <asm/vr41xx/tb0287.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char bus;
 	int irq = -1;
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index e99ca7702d8a..f15ec98de2de 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -522,7 +522,7 @@ static int __init alchemy_pci_init(void)
 arch_initcall(alchemy_pci_init);
 
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct alchemy_pci_context *ctx = dev->sysdata;
 	if (ctx && ctx->board_map_irq)
diff --git a/arch/mips/pci/pci-bcm47xx.c b/arch/mips/pci/pci-bcm47xx.c
index 76f16eaed0ad..230d7dd273e2 100644
--- a/arch/mips/pci/pci-bcm47xx.c
+++ b/arch/mips/pci/pci-bcm47xx.c
@@ -28,7 +28,7 @@
 #include <linux/bcma/bcma.h>
 #include <bcm47xx.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return 0;
 }
diff --git a/arch/mips/pci/pci-lasat.c b/arch/mips/pci/pci-lasat.c
index 40d2797d2bc4..47f4ee6bbb3b 100644
--- a/arch/mips/pci/pci-lasat.c
+++ b/arch/mips/pci/pci-lasat.c
@@ -61,7 +61,7 @@ arch_initcall(lasat_pci_setup);
 #define LASAT_IRQ_PCIC	 (LASAT_IRQ_BASE + 7)
 #define LASAT_IRQ_PCID	 (LASAT_IRQ_BASE + 8)
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch (slot) {
 	case 1:
diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index 628c5132b3d8..c8e393d19833 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -361,7 +361,7 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	u16 cmd;
 	u32 val;
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 9ee01936862e..771f5de6362d 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -59,7 +59,7 @@ union octeon_pci_address {
 	} s;
 };
 
-int __initconst (*octeon_pcibios_map_irq)(const struct pci_dev *dev,
+int (*octeon_pcibios_map_irq)(const struct pci_dev *dev,
 					 u8 slot, u8 pin);
 enum octeon_dma_bar_type octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_INVALID;
 
@@ -74,7 +74,7 @@ enum octeon_dma_bar_type octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_INVALID;
  *		 as it goes through each bridge.
  * Returns Interrupt number for the device
  */
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (octeon_pcibios_map_irq)
 		return octeon_pcibios_map_irq(dev, slot, pin);
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index d6360fe73d05..711cdccdf65b 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -181,7 +181,7 @@ static inline void rt2880_pci_write_u32(unsigned long reg, u32 val)
 	spin_unlock_irqrestore(&rt2880_pci_lock, flags);
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	u16 cmd;
 	int irq = -1;
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 3520e9b414e7..e8597d39cd5b 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -565,7 +565,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	return err;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return of_irq_parse_and_map_pci(dev, slot, pin);
 }
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 7babf01600cb..9eff9137f78e 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -205,7 +205,7 @@ int xlp_socdev_to_node(const struct pci_dev *lnkdev)
 		return PCI_SLOT(lnkdev->devfn) / 8;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_dev *lnkdev;
 	int lnkfunc, node;
diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 26d2dabef281..2a1c81a129ba 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -315,7 +315,7 @@ static void xls_pcie_ack_b(struct irq_data *d)
 	}
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return get_irq_vector(dev);
 }
-- 
2.14.1
