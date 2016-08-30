Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:32:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46353 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992009AbcH3RbhIdol0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:31:37 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 247B0638D97EC;
        Tue, 30 Aug 2016 18:31:17 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:31:20 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, John Crispin <blogic@openwrt.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 05/26] MIPS: PCI: Introduce CONFIG_PCI_DRIVERS_LEGACY
Date:   Tue, 30 Aug 2016 18:29:08 +0100
Message-ID: <20160830172929.16948-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54846
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

Changes in v2: None

 arch/mips/Kconfig           |  8 ++++++-
 arch/mips/include/asm/pci.h | 54 ++++++++++++++++++++++++++-------------------
 arch/mips/lib/iomap-pci.c   |  4 ++++
 arch/mips/pci/Makefile      |  2 +-
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 88c0c0d..45c7895 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2959,7 +2959,6 @@ config PCI
 	bool "Support for PCI controller"
 	depends on HW_HAS_PCI
 	select PCI_DOMAINS
-	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -2983,6 +2982,13 @@ config PCI_DOMAINS
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
index fd35daa..9cf279d 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
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
2.9.3
