Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2012 19:19:55 +0100 (CET)
Received: from mail-gx0-f201.google.com ([209.85.161.201]:49635 "EHLO
        mail-gx0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903751Ab2BVSTp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Feb 2012 19:19:45 +0100
Received: by ggno5 with SMTP id o5so40206ggn.0
        for <linux-mips@linux-mips.org>; Wed, 22 Feb 2012 10:19:38 -0800 (PST)
Received-SPF: pass (google.com: domain of bhelgaas@google.com designates 10.236.131.104 as permitted sender) client-ip=10.236.131.104;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of bhelgaas@google.com designates 10.236.131.104 as permitted sender) smtp.mail=bhelgaas@google.com; dkim=pass header.i=bhelgaas@google.com
Received: from mr.google.com ([10.236.131.104])
        by 10.236.131.104 with SMTP id l68mr67899492yhi.3.1329934778681 (num_hops = 1);
        Wed, 22 Feb 2012 10:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=pFi8IOaM0Mg3d1z6XWls3pdXdM4Wb5twPWGg8IPxZVI=;
        b=NlMT4B+tStgQzRUxDVvoavu4YI2SdF+d0NzlUEC7oPCtPv/v8KQmnwQ49CgVLm5f6/
         IYfDBNq9eku4CAzBrHlq1StPXP2CIaZBd4VkDVHn6ehofqYwRuA1EApeaio/9fehrKIM
         ontaWCDNPbEBZ6fGNm9G2VYwtmyzQHMjmRNoE=
Received: by 10.236.131.104 with SMTP id l68mr48456758yhi.3.1329934778666;
        Wed, 22 Feb 2012 10:19:38 -0800 (PST)
Received: by 10.236.131.104 with SMTP id l68mr48456731yhi.3.1329934778491;
        Wed, 22 Feb 2012 10:19:38 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id e44si15280575yhk.0.2012.02.22.10.19.38
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 22 Feb 2012 10:19:38 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
        by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 539C410004D;
        Wed, 22 Feb 2012 10:19:38 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
        by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 02D5D180085;
        Wed, 22 Feb 2012 10:19:38 -0800 (PST)
Subject: [PATCH v1 07/11] mips/PCI: replace pci_probe_only with pci_flags
To:     linux-pci@vger.kernel.org
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Wed, 22 Feb 2012 11:19:38 -0700
Message-ID: <20120222181937.27513.62108.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlqnJ4YKvCNpJVtaEmfz2UakIrbZjvIntVWTIs9iq/UvrFAHUuwSin2qWosHdV2OrFHYlwATS/9jyYX/Qh6kbEE9IN5P6E1b3Qwgs//a/xW3a6JyRDIznYYTWYlHHpNotTT9WOlxwbHyUYrm3JRBsMTUn98p2lxdFbL11K2BFKbSEw4PC4=
X-archive-position: 32497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Some architectures (alpha, mips, powerpc) have an arch-specific
"pci_probe_only" flag.  Others use PCI_PROBE_ONLY in pci_flags for
the same purpose.  This moves mips to the pci_flags approach so
generic code can use the same test across all architectures.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/include/asm/pci.h |    3 +--
 arch/mips/pci/pci-bcm1480.c |    2 +-
 arch/mips/pci/pci-ip27.c    |    2 +-
 arch/mips/pci/pci-lantiq.c  |    3 ++-
 arch/mips/pci/pci-sb1250.c  |    2 +-
 arch/mips/pci/pci-xlr.c     |    2 +-
 arch/mips/pci/pci.c         |   13 +++++--------
 7 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 576397c..1e4fa3d 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -92,6 +92,7 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 #include <asm/scatterlist.h>
 #include <linux/string.h>
 #include <asm/io.h>
+#include <asm-generic/pci-bridge.h>
 
 struct pci_dev;
 
@@ -145,8 +146,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 #define arch_setup_msi_irqs arch_setup_msi_irqs
 #endif
 
-extern int pci_probe_only;
-
 extern char * (*pcibios_plat_setup)(char *str);
 
 #endif /* _ASM_PCI_H */
diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index af8c319..37b52dc 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -204,7 +204,7 @@ static int __init bcm1480_pcibios_init(void)
 	uint64_t reg;
 
 	/* CFE will assign PCI resources */
-	pci_probe_only = 1;
+	pci_set_flags(PCI_PROBE_ONLY);
 
 	/* Avoid ISA compat ranges.  */
 	PCIBIOS_MIN_IO = 0x00008000UL;
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index 193e949..0fbe4c0 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -50,7 +50,7 @@ int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	bridge_t *bridge;
 	int slot;
 
-	pci_probe_only = 1;
+	pci_set_flags(PCI_PROBE_ONLY);
 
 	printk("a bridge\n");
 
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index be1e1af..030c77e 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -270,7 +270,8 @@ static int __devinit ltq_pci_probe(struct platform_device *pdev)
 {
 	struct ltq_pci_data *ltq_pci_data =
 		(struct ltq_pci_data *) pdev->dev.platform_data;
-	pci_probe_only = 0;
+
+	pci_clear_flags(PCI_PROBE_ONLY);
 	ltq_pci_irq_map = ltq_pci_data->irq;
 	ltq_pci_membase = ioremap_nocache(PCI_CR_BASE_ADDR, PCI_CR_SIZE);
 	ltq_pci_mapped_cfg =
diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index 1711e8e..dd97f3a 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -213,7 +213,7 @@ static int __init sb1250_pcibios_init(void)
 	uint64_t reg;
 
 	/* CFE will assign PCI resources */
-	pci_probe_only = 1;
+	pci_set_flags(PCI_PROBE_ONLY);
 
 	/* Avoid ISA compat ranges.  */
 	PCIBIOS_MIN_IO = 0x00008000UL;
diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 3d701a9..1644805 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -292,7 +292,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 static int __init pcibios_init(void)
 {
 	/* PSB assigns PCI resources */
-	pci_probe_only = 1;
+	pci_set_flags(PCI_PROBE_ONLY);
 	pci_config_base = ioremap(DEFAULT_PCI_CONFIG_BASE, 16 << 20);
 
 	/* Extend IO port for memory mapped io */
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index aec2b11..2a11045 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -20,12 +20,9 @@
 #include <asm/cpu-info.h>
 
 /*
- * Indicate whether we respect the PCI setup left by the firmware.
- *
- * Make this long-lived  so that we know when shutting down
- * whether we probed only or not.
+ * If PCI_PROBE_ONLY in pci_flags is set, we don't change any PCI resource
+ * assignments.
  */
-int pci_probe_only;
 
 #define PCI_ASSIGN_ALL_BUSSES	1
 
@@ -92,7 +89,7 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 	if (!hose->iommu)
 		PCI_DMA_BUS_IS_PHYS = 1;
 
-	if (hose->get_busno && pci_probe_only)
+	if (hose->get_busno && pci_has_flag(PCI_PROBE_ONLY))
 		next_busno = (*hose->get_busno)();
 
 	pci_add_resource(&resources, hose->mem_resource);
@@ -115,7 +112,7 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 			need_domain_info = 1;
 		}
 
-		if (!pci_probe_only) {
+		if (!pci_has_flag(PCI_PROBE_ONLY)) {
 			pci_bus_size_bridges(bus);
 			pci_bus_assign_resources(bus);
 			pci_enable_bridges(bus);
@@ -282,7 +279,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	struct list_head *ln;
 	struct pci_dev *dev = bus->self;
 
-	if (pci_probe_only && dev &&
+	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
 	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		pci_read_bridge_bases(bus);
 		pcibios_fixup_device_resources(dev, bus);
