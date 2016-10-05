Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 19:21:40 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:58405 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992209AbcJERUe5kiwu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Oct 2016 19:20:34 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 1E856F18A1CB;
        Wed,  5 Oct 2016 18:20:27 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct 2016
 18:20:28 +0100
Received: from localhost (10.100.200.82) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct
 2016 18:20:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 06/18] MIPS: PCI: Introduce CONFIG_PCI_DRIVERS_LEGACY
Date:   Wed, 5 Oct 2016 18:18:12 +0100
Message-ID: <20161005171824.18014-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161005171824.18014-1-paul.burton@imgtec.com>
References: <20161005171824.18014-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.82]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Introduce 2 Kconfig symbols, CONFIG_PCI_DRIVERS_GENERIC &
CONFIG_PCI_DRIVERS_LEGACY, which indicate whether the system should be
built to for PCI drivers using the MIPS-specific struct pci_controller
API (hereafter "legacy" drivers) or more generic drivers using only
functionality provided by the PCI core (hereafter "generic" drivers).

The Kconfig entries are created such that platforms have to select
CONFIG_PCI_DRIVERS_GENERIC if they wish to use it - that is, the default
is CONFIG_PCI_DRIVERS_LEGACY so that existing platforms need no
modification.

The functions declared in pci.h are rearranged with those provided only
by pci-legacy.c being guarded by an #ifdef CONFIG_PCI_DRIVERS_LEGACY to
ensure they are only used in configurations where they are implemented.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/Kconfig           |  8 ++++++-
 arch/mips/include/asm/pci.h | 54 ++++++++++++++++++++++++++-------------------
 arch/mips/lib/iomap-pci.c   |  4 ++++
 arch/mips/pci/Makefile      |  2 +-
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a75215..d31f839 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2974,7 +2974,6 @@ config PCI
 	bool "Support for PCI controller"
 	depends on HW_HAS_PCI
 	select PCI_DOMAINS
-	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -2998,6 +2997,13 @@ config PCI_DOMAINS
 config PCI_DOMAINS_GENERIC
 	bool
 
+config PCI_DRIVERS_GENERIC
+	bool
+
+config PCI_DRIVERS_LEGACY
+	def_bool !PCI_DRIVERS_GENERIC
+	select NO_GENERIC_PCI_IOPORT_MAP
+
 source "drivers/pci/Kconfig"
 
 #
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index acc651e..30d1129 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -20,6 +20,8 @@
 #include <linux/list.h>
 #include <linux/of.h>
 
+#ifdef CONFIG_PCI_DRIVERS_LEGACY
+
 /*
  * Each pci channel is a top-level PCI bus seem by CPU.	 A machine  with
  * multiple PCI channels may have multiple PCI host controllers or a
@@ -62,6 +64,35 @@ extern void register_pci_controller(struct pci_controller *hose);
  */
 extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 
+/* Do platform specific device initialization at pci_enable_device() time */
+extern int pcibios_plat_dev_init(struct pci_dev *dev);
+
+extern char * (*pcibios_plat_setup)(char *str);
+
+#ifdef CONFIG_OF
+/* this function parses memory ranges from a device node */
+extern void pci_load_of_ranges(struct pci_controller *hose,
+			       struct device_node *node);
+#else
+static inline void pci_load_of_ranges(struct pci_controller *hose,
+				      struct device_node *node) {}
+#endif
+
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+static inline void set_pci_need_domain_info(struct pci_controller *hose,
+					    int need_domain_info)
+{
+	/* nothing to do */
+}
+#elif defined(CONFIG_PCI_DOMAINS)
+static inline void set_pci_need_domain_info(struct pci_controller *hose,
+					    int need_domain_info)
+{
+	hose->need_domain_info = need_domain_info;
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
+#endif
 
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
@@ -110,12 +141,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	return pci_domain_nr(bus);
 }
-
-static inline void set_pci_need_domain_info(struct pci_controller *hose,
-					    int need_domain_info)
-{
-	/* nothing to do */
-}
 #elif defined(CONFIG_PCI_DOMAINS)
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
@@ -124,12 +149,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	struct pci_controller *hose = bus->sysdata;
 	return hose->need_domain_info;
 }
-
-static inline void set_pci_need_domain_info(struct pci_controller *hose,
-					    int need_domain_info)
-{
-	hose->need_domain_info = need_domain_info;
-}
 #endif /* CONFIG_PCI_DOMAINS */
 
 #endif /* __KERNEL__ */
@@ -143,15 +162,4 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
-extern char * (*pcibios_plat_setup)(char *str);
-
-#ifdef CONFIG_OF
-/* this function parses memory ranges from a device node */
-extern void pci_load_of_ranges(struct pci_controller *hose,
-			       struct device_node *node);
-#else
-static inline void pci_load_of_ranges(struct pci_controller *hose,
-				      struct device_node *node) {}
-#endif
-
 #endif /* _ASM_PCI_H */
diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
index a629077..8ed3f25 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -10,6 +10,8 @@
 #include <linux/export.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_PCI_DRIVERS_LEGACY
+
 void __iomem *__pci_ioport_map(struct pci_dev *dev,
 			       unsigned long port, unsigned int nr)
 {
@@ -40,6 +42,8 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
 	return (void __iomem *) (ctrl->io_map_base + port);
 }
 
+#endif /* CONFIG_PCI_DRIVERS_LEGACY */
+
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
 	iounmap(addr);
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 5666637..8478210 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y				+= pci.o
-obj-y				+= pci-legacy.o
+obj-$(CONFIG_PCI_DRIVERS_LEGACY)+= pci-legacy.o
 
 #
 # PCI bus host bridge specific code
-- 
2.10.0
