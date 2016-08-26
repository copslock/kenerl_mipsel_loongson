Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:38:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37222 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992479AbcHZPi1ZcjQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:38:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 62617E5B78D73;
        Fri, 26 Aug 2016 16:38:07 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:38:10 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 01/26] MIPS: PCI: Support for CONFIG_PCI_DOMAINS_GENERIC
Date:   Fri, 26 Aug 2016 16:37:00 +0100
Message-ID: <20160826153725.11629-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54785
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

Introduce support for CONFIG_PCI_DOMAINS_GENERIC, allowing for platforms
to make use of generic PCI domains instead of the MIPS-specific
implementation. The set_pci_need_domain_info function is introduced to
abstract away the removed need_domain_info field in struct
pci_controller, and pcibios_scanbus is adjusted to use the pci_domain_nr
accessor instead of directly accessing the index field.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig           |  3 +++
 arch/mips/include/asm/pci.h | 21 ++++++++++++++++++++-
 arch/mips/pci/pci.c         |  4 ++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 45bbddf..88c0c0d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2980,6 +2980,9 @@ config HT_PCI
 config PCI_DOMAINS
 	bool
 
+config PCI_DOMAINS_GENERIC
+	bool
+
 source "drivers/pci/Kconfig"
 
 #
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 547e113..0564692 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -39,10 +39,12 @@ struct pci_controller {
 	struct resource *busn_resource;
 	unsigned long busn_offset;
 
+#ifndef CONFIG_PCI_DOMAINS_GENERIC
 	unsigned int index;
 	/* For compatibility with current (as of July 2003) pciutils
 	   and XFree86. Eventually will be removed. */
 	unsigned int need_domain_info;
+#endif
 
 	/* Optional access methods for reading/writing the bus number
 	   of the PCI controller */
@@ -101,7 +103,18 @@ struct pci_dev;
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
-#ifdef CONFIG_PCI_DOMAINS
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+
+static inline void set_pci_need_domain_info(struct pci_controller *hose,
+					    int need_domain_info)
+{
+	/* nothing to do */
+}
+#elif defined(CONFIG_PCI_DOMAINS)
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int pci_proc_domain(struct pci_bus *bus)
@@ -109,6 +122,12 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	struct pci_controller *hose = bus->sysdata;
 	return hose->need_domain_info;
 }
+
+static inline void set_pci_need_domain_info(struct pci_controller *hose,
+					    int need_domain_info)
+{
+	hose->need_domain_info = need_domain_info;
+}
 #endif /* CONFIG_PCI_DOMAINS */
 
 #endif /* __KERNEL__ */
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 644ae96..5207c04 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -95,8 +95,8 @@ static void pcibios_scanbus(struct pci_controller *hose)
 				&resources);
 	hose->bus = bus;
 
-	need_domain_info = need_domain_info || hose->index;
-	hose->need_domain_info = need_domain_info;
+	need_domain_info = need_domain_info || pci_domain_nr(bus);
+	set_pci_need_domain_info(hose, need_domain_info);
 
 	if (!bus) {
 		pci_free_resource_list(&resources);
-- 
2.9.3
