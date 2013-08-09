Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 22:27:39 +0200 (CEST)
Received: from top.free-electrons.com ([176.31.233.9]:58086 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6865318Ab3HIU1caoau- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 22:27:32 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 5E2D96CE6; Fri,  9 Aug 2013 22:27:36 +0200 (CEST)
Received: from localhost (unknown [37.161.232.130])
        by mail.free-electrons.com (Postfix) with ESMTPSA id F1CC06CE4;
        Fri,  9 Aug 2013 22:27:34 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>
Cc:     Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Maen Suleiman <maen@marvell.com>,
        Lior Amsalem <alior@marvell.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCHv9 01/10] PCI: use weak functions for MSI arch-specific functions
Date:   Fri,  9 Aug 2013 22:27:06 +0200
Message-Id: <1376080035-29344-2-git-send-email-thomas.petazzoni@free-electrons.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Until now, the MSI architecture-specific functions could be overloaded
using a fairly complex set of #define and compile-time
conditionals. In order to prepare for the introduction of the msi_chip
infrastructure, it is desirable to switch all those functions to use
the 'weak' mechanism. This commit converts all the architectures that
were overidding those MSI functions to use the new strategy.

Note that we keep two separate, non-weak, functions
default_teardown_msi_irqs() and default_restore_msi_irqs() for the
default behavior of the arch_teardown_msi_irqs() and
arch_restore_msi_irqs(), as the default behavior is needed by x86 PCI
code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tested-by: Daniel Price <daniel.price@gmail.com>
Tested-by: Thierry Reding <thierry.reding@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/mips/include/asm/pci.h    |  5 -----
 arch/powerpc/include/asm/pci.h |  5 -----
 arch/s390/include/asm/pci.h    |  4 ----
 arch/x86/include/asm/pci.h     | 30 --------------------------
 arch/x86/kernel/x86_init.c     | 24 +++++++++++++++++++++
 drivers/pci/msi.c              | 48 +++++++++++++++++++++---------------------
 include/linux/msi.h            |  8 ++++++-
 7 files changed, 55 insertions(+), 69 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index fa8e0aa..f194c08 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -136,11 +136,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-/* MSI arch hook for OCTEON */
-#define arch_setup_msi_irqs arch_setup_msi_irqs
-#endif
-
 extern char * (*pcibios_plat_setup)(char *str);
 
 #ifdef CONFIG_OF
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 6653f27..95145a1 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -113,11 +113,6 @@ extern int pci_domain_nr(struct pci_bus *bus);
 /* Decide whether to display the domain number in /proc */
 extern int pci_proc_domain(struct pci_bus *bus);
 
-/* MSI arch hooks */
-#define arch_setup_msi_irqs arch_setup_msi_irqs
-#define arch_teardown_msi_irqs arch_teardown_msi_irqs
-#define arch_msi_check_device arch_msi_check_device
-
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 6e577ba..262b91b 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -21,10 +21,6 @@ void pci_iounmap(struct pci_dev *, void __iomem *);
 int pci_domain_nr(struct pci_bus *);
 int pci_proc_domain(struct pci_bus *);
 
-/* MSI arch hooks */
-#define arch_setup_msi_irqs	arch_setup_msi_irqs
-#define arch_teardown_msi_irqs	arch_teardown_msi_irqs
-
 #define ZPCI_BUS_NR			0	/* default bus number */
 #define ZPCI_DEVFN			0	/* default device number */
 
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d9e9e6c..7d74432 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -100,29 +100,6 @@ static inline void early_quirks(void) { }
 extern void pci_iommu_alloc(void);
 
 #ifdef CONFIG_PCI_MSI
-/* MSI arch specific hooks */
-static inline int x86_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	return x86_msi.setup_msi_irqs(dev, nvec, type);
-}
-
-static inline void x86_teardown_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.teardown_msi_irqs(dev);
-}
-
-static inline void x86_teardown_msi_irq(unsigned int irq)
-{
-	x86_msi.teardown_msi_irq(irq);
-}
-static inline void x86_restore_msi_irqs(struct pci_dev *dev, int irq)
-{
-	x86_msi.restore_msi_irqs(dev, irq);
-}
-#define arch_setup_msi_irqs x86_setup_msi_irqs
-#define arch_teardown_msi_irqs x86_teardown_msi_irqs
-#define arch_teardown_msi_irq x86_teardown_msi_irq
-#define arch_restore_msi_irqs x86_restore_msi_irqs
 /* implemented in arch/x86/kernel/apic/io_apic. */
 struct msi_desc;
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
@@ -130,16 +107,9 @@ void native_teardown_msi_irq(unsigned int irq);
 void native_restore_msi_irqs(struct pci_dev *dev, int irq);
 int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 		  unsigned int irq_base, unsigned int irq_offset);
-/* default to the implementation in drivers/lib/msi.c */
-#define HAVE_DEFAULT_MSI_TEARDOWN_IRQS
-#define HAVE_DEFAULT_MSI_RESTORE_IRQS
-void default_teardown_msi_irqs(struct pci_dev *dev);
-void default_restore_msi_irqs(struct pci_dev *dev, int irq);
 #else
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
-#define default_teardown_msi_irqs	NULL
-#define default_restore_msi_irqs	NULL
 #endif
 
 #define PCI_DMA_BUS_IS_PHYS (dma_ops->is_phys)
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 5f24c71..8ce0072 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -107,6 +107,8 @@ struct x86_platform_ops x86_platform = {
 };
 
 EXPORT_SYMBOL_GPL(x86_platform);
+
+#if defined(CONFIG_PCI_MSI)
 struct x86_msi_ops x86_msi = {
 	.setup_msi_irqs		= native_setup_msi_irqs,
 	.compose_msi_msg	= native_compose_msi_msg,
@@ -116,6 +118,28 @@ struct x86_msi_ops x86_msi = {
 	.setup_hpet_msi		= default_setup_hpet_msi,
 };
 
+/* MSI arch specific hooks */
+int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	return x86_msi.setup_msi_irqs(dev, nvec, type);
+}
+
+void arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	x86_msi.teardown_msi_irqs(dev);
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	x86_msi.teardown_msi_irq(irq);
+}
+
+void arch_restore_msi_irqs(struct pci_dev *dev, int irq)
+{
+	x86_msi.restore_msi_irqs(dev, irq);
+}
+#endif
+
 struct x86_io_apic_ops x86_io_apic_ops = {
 	.init			= native_io_apic_init_mappings,
 	.read			= native_io_apic_read,
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index aca7578..823c386 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -30,20 +30,21 @@ static int pci_msi_enable = 1;
 
 /* Arch hooks */
 
-#ifndef arch_msi_check_device
-int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
+int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	return 0;
+	return -EINVAL;
 }
-#endif
 
-#ifndef arch_setup_msi_irqs
-# define arch_setup_msi_irqs default_setup_msi_irqs
-# define HAVE_DEFAULT_MSI_SETUP_IRQS
-#endif
+void __weak arch_teardown_msi_irq(unsigned int irq)
+{
+}
 
-#ifdef HAVE_DEFAULT_MSI_SETUP_IRQS
-int default_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
+{
+	return 0;
+}
+
+int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -65,14 +66,11 @@ int default_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	return 0;
 }
-#endif
-
-#ifndef arch_teardown_msi_irqs
-# define arch_teardown_msi_irqs default_teardown_msi_irqs
-# define HAVE_DEFAULT_MSI_TEARDOWN_IRQS
-#endif
 
-#ifdef HAVE_DEFAULT_MSI_TEARDOWN_IRQS
+/*
+ * We have a default implementation available as a separate non-weak
+ * function, as it is used by the Xen x86 PCI code
+ */
 void default_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
@@ -89,14 +87,12 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
 			arch_teardown_msi_irq(entry->irq + i);
 	}
 }
-#endif
 
-#ifndef arch_restore_msi_irqs
-# define arch_restore_msi_irqs default_restore_msi_irqs
-# define HAVE_DEFAULT_MSI_RESTORE_IRQS
-#endif
+void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	return default_teardown_msi_irqs(dev);
+}
 
-#ifdef HAVE_DEFAULT_MSI_RESTORE_IRQS
 void default_restore_msi_irqs(struct pci_dev *dev, int irq)
 {
 	struct msi_desc *entry;
@@ -114,7 +110,11 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq)
 	if (entry)
 		write_msi_msg(irq, &entry->msg);
 }
-#endif
+
+void __weak arch_restore_msi_irqs(struct pci_dev *dev, int irq)
+{
+	return default_restore_msi_irqs(dev, irq);
+}
 
 static void msi_set_enable(struct pci_dev *dev, int enable)
 {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ee66f3a..271dfd1 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -51,12 +51,18 @@ struct msi_desc {
 };
 
 /*
- * The arch hook for setup up msi irqs
+ * The arch hooks to setup up msi irqs. Those functions are
+ * implemented as weak symbols so that they /can/ be overriden by
+ * architecture specific code if needed.
  */
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
 int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
+void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
+
+void default_teardown_msi_irqs(struct pci_dev *dev);
+void default_restore_msi_irqs(struct pci_dev *dev, int irq);
 
 #endif /* LINUX_MSI_H */
-- 
1.8.1.2
