Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 22:12:10 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:45062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042893AbcFQUL7mqt0F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 22:11:59 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id DE2BE2017E;
        Fri, 17 Jun 2016 20:11:57 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D622D201C7;
        Fri, 17 Jun 2016 20:11:56 +0000 (UTC)
Subject: [PATCH v1 1/4] PCI: Unify pci_resource_to_user() declarations
To:     Michal Simek <monstr@monstr.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yinghai Lu <yinghai@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     sparclinux@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Fri, 17 Jun 2016 15:11:55 -0500
Message-ID: <20160617201155.11714.51900.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

Replace the pci_resource_to_user() declarations in each arch that defines
HAVE_ARCH_PCI_RESOURCE_TO_USER with a single one in linux/pci.h.

Change the MIPS static inline implementation to a non-inline version so the
static inline doesn't conflict with the new non-static linux/pci.h
declaration.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci.h |    3 ---
 arch/mips/include/asm/pci.h       |   10 ----------
 arch/mips/pci/pci.c               |   10 ++++++++++
 arch/powerpc/include/asm/pci.h    |    3 ---
 arch/sparc/include/asm/pci_64.h   |    3 ---
 include/linux/pci.h               |    6 +++++-
 6 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index fc3ecb5..2a120bb 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -82,9 +82,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 pgprot_t prot);
 
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
-extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
-				 const struct resource *rsrc,
-				 resource_size_t *start, resource_size_t *end);
 
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 86b239d..9b63cd4 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -80,16 +80,6 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 
-static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
-		const struct resource *rsrc, resource_size_t *start,
-		resource_size_t *end)
-{
-	phys_addr_t size = resource_size(rsrc);
-
-	*start = fixup_bigphys_addr(rsrc->start, size);
-	*end = rsrc->start + size;
-}
-
 /*
  * Dynamic DMA mapping stuff.
  * MIPS has everything mapped statically.
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index f1b11f0..5717384 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -319,6 +319,16 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc, resource_size_t *start,
+			  resource_size_t *end)
+{
+	phys_addr_t size = resource_size(rsrc);
+
+	*start = fixup_bigphys_addr(rsrc->start, size);
+	*end = rsrc->start + size;
+}
+
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index a6f3ac0..e9bd6cf 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -136,9 +136,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 pgprot_t prot);
 
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
-extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
-				 const struct resource *rsrc,
-				 resource_size_t *start, resource_size_t *end);
 
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 022d160..2303635 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -55,9 +55,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 }
 
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-			  const struct resource *rsrc,
-			  resource_size_t *start, resource_size_t *end);
 #endif /* __KERNEL__ */
 
 #endif /* __SPARC64_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..9c201d4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1554,7 +1554,11 @@ static inline const char *pci_name(const struct pci_dev *pdev)
 /* Some archs don't want to expose struct resource to userland as-is
  * in sysfs and /proc
  */
-#ifndef HAVE_ARCH_PCI_RESOURCE_TO_USER
+#ifdef HAVE_ARCH_PCI_RESOURCE_TO_USER
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc,
+			  resource_size_t *start, resource_size_t *end);
+#else
 static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
 		const struct resource *rsrc, resource_size_t *start,
 		resource_size_t *end)
