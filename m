Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 11:47:36 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:63209 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007097AbaIEJqScUMV3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 11:46:18 +0200
Received: from 172.24.2.119 (EHLO szxeml419-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id ATY92831;
        Fri, 05 Sep 2014 17:45:42 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml419-hub.china.huawei.com (10.82.67.158) with Microsoft SMTP Server id
 14.3.158.1; Fri, 5 Sep 2014 17:45:32 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Russell King" <linux@arm.linux.org.uk>,
        <linux-arch@vger.kernel.org>, <arnab.basu@freescale.com>,
        <Bharat.Bhushan@freescale.com>, <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Tony Luck" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v1 04/21] x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()
Date:   Fri, 5 Sep 2014 18:09:49 +0800
Message-ID: <1409911806-10519-5-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020202.5409864A.0166,ss=1,re=0.000,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2011-05-27 18:58:46
X-Mirapoint-Loop-Id: 98a0bc4e9f7c16e32cc7e9587c469bdf
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
and arch_msi_mask_irq() to fix a bug found when running xen in x86.
Introduced these two funcntions make MSI code complex. And mask/unmask
is the irq actions related to interrupt controller, should not use
weak arch functions to override mask/unmask interfaces. This patch
reverted commit 0e4ccb150 and export struct irq_chip msi_chip, modify
msi_chip->irq_mask/irq_unmask() in xen init functions to fix this
bug for simplicity. Also this is preparation for using struct
msi_chip instead of weak arch MSI functions in all platforms.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/include/asm/apic.h     |    4 ++++
 arch/x86/include/asm/x86_init.h |    3 ---
 arch/x86/kernel/apic/io_apic.c  |    2 +-
 arch/x86/kernel/x86_init.c      |   10 ----------
 arch/x86/pci/xen.c              |   16 ++++++----------
 drivers/pci/msi.c               |   22 ++++++----------------
 include/linux/msi.h             |    4 ++--
 7 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 465b309..47a5f94 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -43,6 +43,10 @@ static inline void generic_apic_probe(void)
 }
 #endif
 
+#ifdef CONFIG_PCI_MSI
+extern struct irq_chip msi_chip;
+#endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
 
 extern unsigned int apic_verbosity;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index e45e4da..f58a9c7 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -172,7 +172,6 @@ struct x86_platform_ops {
 
 struct pci_dev;
 struct msi_msg;
-struct msi_desc;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
@@ -183,8 +182,6 @@ struct x86_msi_ops {
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 	int  (*setup_hpet_msi)(unsigned int irq, unsigned int id);
-	u32 (*msi_mask_irq)(struct msi_desc *desc, u32 mask, u32 flag);
-	u32 (*msix_mask_irq)(struct msi_desc *desc, u32 flag);
 };
 
 struct IO_APIC_route_entry;
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e877cfb..2a2ec28 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3161,7 +3161,7 @@ msi_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force)
  * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI or MSI-X Capability Structure.
  */
-static struct irq_chip msi_chip = {
+struct irq_chip msi_chip = {
 	.name			= "PCI-MSI",
 	.irq_unmask		= unmask_msi_irq,
 	.irq_mask		= mask_msi_irq,
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e48b674..234b072 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -116,8 +116,6 @@ struct x86_msi_ops x86_msi = {
 	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 	.setup_hpet_msi		= default_setup_hpet_msi,
-	.msi_mask_irq		= default_msi_mask_irq,
-	.msix_mask_irq		= default_msix_mask_irq,
 };
 
 /* MSI arch specific hooks */
@@ -140,14 +138,6 @@ void arch_restore_msi_irqs(struct pci_dev *dev)
 {
 	x86_msi.restore_msi_irqs(dev);
 }
-u32 arch_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return x86_msi.msi_mask_irq(desc, mask, flag);
-}
-u32 arch_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return x86_msi.msix_mask_irq(desc, flag);
-}
 #endif
 
 struct x86_io_apic_ops x86_io_apic_ops = {
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index ad03739..84c2fce 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -394,13 +394,9 @@ static void xen_teardown_msi_irq(unsigned int irq)
 {
 	xen_destroy_irq(irq);
 }
-static u32 xen_nop_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return 0;
-}
-static u32 xen_nop_msix_mask_irq(struct msi_desc *desc, u32 flag)
+
+void xen_nop_msi_mask(struct irq_data *data)
 {
-	return 0;
 }
 #endif
 
@@ -425,8 +421,8 @@ int __init pci_xen_init(void)
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	msi_chip.irq_mask = xen_nop_msi_mask;
+	msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
 	return 0;
 }
@@ -506,8 +502,8 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	msi_chip.irq_mask = xen_nop_msi_mask;
+	msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
 	xen_setup_acpi_sci();
 	__acpi_register_gsi = acpi_register_gsi_xen;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d547f7f..a77e7f7 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -161,7 +161,7 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 
@@ -175,14 +175,9 @@ u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 	return mask_bits;
 }
 
-__weak u32 arch_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return default_msi_mask_irq(desc, mask, flag);
-}
-
 static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
-	desc->masked = arch_msi_mask_irq(desc, mask, flag);
+	desc->masked = __msi_mask_irq(desc, mask, flag);
 }
 
 /*
@@ -192,7 +187,7 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
  * file.  This saves a few milliseconds when initialising devices with lots
  * of MSI-X interrupts.
  */
-u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 	unsigned offset = desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
@@ -205,14 +200,9 @@ u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
 	return mask_bits;
 }
 
-__weak u32 arch_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return default_msix_mask_irq(desc, flag);
-}
-
 static void msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
-	desc->masked = arch_msix_mask_irq(desc, flag);
+	desc->masked = __msix_mask_irq(desc, flag);
 }
 
 static void msi_set_mask_bit(struct irq_data *data, u32 flag)
@@ -864,7 +854,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI unmasked as initial states */
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	/* Keep cached state to be restored */
-	arch_msi_mask_irq(desc, mask, ~mask);
+	__msi_mask_irq(desc, mask, ~mask);
 
 	/* Restore dev->irq to its default pin-assertion irq */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -964,7 +954,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI-X masked as initial states */
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		/* Keep cached states to be restored */
-		arch_msix_mask_irq(entry, 1);
+		__msix_mask_irq(entry, 1);
 	}
 
 	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 762fe61..5650848 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -19,6 +19,8 @@ void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag);
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 
 struct msi_desc {
 	struct {
@@ -62,8 +64,6 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
-u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
-u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag);
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.1
