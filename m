Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2014 04:29:25 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:16249 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010631AbaJOC0Evtzs3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2014 04:26:04 +0200
Received: from 172.24.2.119 (EHLO szxeml412-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CAT35324;
        Wed, 15 Oct 2014 10:25:25 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml412-hub.china.huawei.com (10.82.67.91) with Microsoft SMTP Server id
 14.3.158.1; Wed, 15 Oct 2014 10:25:15 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
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
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>,
        Liviu Dudau <liviu@dudau.co.uk>,
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 04/27] arm/MSI: Save MSI chip in pci_sys_data
Date:   Wed, 15 Oct 2014 11:06:52 +0800
Message-ID: <1413342435-7876-5-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43270
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

Saving msi chip in pci_sys_data can make pci bus and
devices don't need to know msi chip detail, it also
make pci enumeration code be decoupled from msi chip.
In fact, all pci devices under the same pci hostbridge
share same msi chip. So msi chip should be seen as one
of resources or attributes to be initialized in pci host
bridge driver. Currently, pci hostbridge drivers create
pci_host_bridge in pci_create_root_bus(), and pass arch
specific pci sysdata to core pci scan functions. So pci
arch sysdata is good place to save msi chip.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/include/asm/mach/pci.h |    6 ++++++
 arch/arm/include/asm/pci.h      |    9 +++++++++
 arch/arm/kernel/bios32.c        |    3 +++
 drivers/pci/msi.c               |    6 ++++++
 include/linux/pci.h             |    9 +++++++++
 5 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 7fc4278..59b0d87 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -22,6 +22,9 @@ struct hw_pci {
 #ifdef CONFIG_PCI_DOMAINS
 	int		domain;
 #endif
+#ifdef CONFIG_PCI_MSI
+	struct msi_chip *msi_chip;
+#endif
 	struct pci_ops	*ops;
 	int		nr_controllers;
 	void		**private_data;
@@ -47,6 +50,9 @@ struct pci_sys_data {
 #ifdef CONFIG_PCI_DOMAINS
 	int		domain;
 #endif
+#ifdef CONFIG_PCI_MSI
+	struct msi_chip *msi_chip;
+#endif
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
 	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 7e95d85..b562c09 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -31,6 +31,15 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif /* CONFIG_PCI_DOMAINS */
 
+#ifdef CONFIG_PCI_MSI
+static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
+{
+	struct pci_sys_data *root = bus->sysdata;
+
+	return root->msi_chip;
+}
+#endif
+
 /*
  * The PCI address space does equal the physical memory address space.
  * The networking and block device layers use this boolean for bounce
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..a19038d 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -471,6 +471,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 #ifdef CONFIG_PCI_DOMAINS
 		sys->domain  = hw->domain;
 #endif
+#ifdef CONFIG_PCI_MSI
+		sys->msi_chip = hw->msi_chip;
+#endif
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 22e413c..f11108c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -35,6 +35,9 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	struct msi_chip *chip = dev->bus->msi;
 	int err;
 
+	if (!chip)
+		chip = pci_msi_chip(dev->bus);
+
 	if (!chip || !chip->setup_irq)
 		return -EINVAL;
 
@@ -50,6 +53,9 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
 	struct msi_desc *entry = irq_get_msi_desc(irq);
 	struct msi_chip *chip = entry->dev->bus->msi;
 
+	if (!chip)
+		chip = pci_msi_chip(entry->dev->bus);
+
 	if (!chip || !chip->teardown_irq)
 		return;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9cd2721..7a48b40 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1433,6 +1433,15 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
+/* Just avoid compile error, will be clean up later */
+#ifdef CONFIG_PCI_MSI
+
+#ifndef pci_msi_chip
+#define pci_msi_chip(bus)	NULL
+#endif
+
+#endif
+
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-- 
1.7.1
