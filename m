Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 09:10:08 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:23392 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862110AbaHLHJAVmbMI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 09:09:00 +0200
Received: from 172.24.2.119 (EHLO szxeml421-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CAE07917;
        Tue, 12 Aug 2014 15:03:02 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml421-hub.china.huawei.com (10.82.67.160) with Microsoft SMTP Server id
 14.3.158.1; Tue, 12 Aug 2014 15:02:54 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>, <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        <arnab.basu@freescale.com>, <x86@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Tony Luck" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>,
        Yijing Wang <wangyijing@huawei.com>
Subject: [RFC PATCH 19/20] tile/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
Date:   Tue, 12 Aug 2014 15:26:12 +0800
Message-ID: <1407828373-24322-20-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41967
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

Introduce a new struct msi_chip tile_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/tile/kernel/pci_gx.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index e39f9c5..d1f308c 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -1485,7 +1485,7 @@ static struct irq_chip tilegx_msi_chip = {
 	/* TBD: support set_affinity. */
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+int tile_setup_msi_irq(struct device *dev, struct msi_desc *desc)
 {
 	struct pci_controller *controller;
 	gxio_trio_context_t *trio_context;
@@ -1510,7 +1510,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 	 * Most PCIe endpoint devices do support 64-bit message addressing.
 	 */
 	if (desc->msi_attrib.is_64 == 0) {
-		dev_printk(KERN_INFO, &pdev->dev,
+		dev_printk(KERN_INFO, dev,
 			"64-bit MSI message address not supported, "
 			"falling back to legacy interrupts.\n");
 
@@ -1549,7 +1549,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 		/* SQ regions are out, allocate from map mem regions. */
 		mem_map = gxio_trio_alloc_memory_maps(trio_context, 1, 0, 0);
 		if (mem_map < 0) {
-			dev_printk(KERN_INFO, &pdev->dev,
+			dev_printk(KERN_INFO, dev,
 				"%s Mem-Map alloc failure. "
 				"Failed to initialize MSI interrupts. "
 				"Falling back to legacy interrupts.\n",
@@ -1580,7 +1580,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 					mem_map, mem_map_base, mem_map_limit,
 					trio_context->asid);
 	if (ret < 0) {
-		dev_printk(KERN_INFO, &pdev->dev, "HV MSI config failed.\n");
+		dev_printk(KERN_INFO, dev, "HV MSI config failed.\n");
 
 		goto hv_msi_config_failure;
 	}
@@ -1604,7 +1604,17 @@ is_64_failure:
 	return ret;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+void tile_teardown_msi_irq(unsigned int irq)
 {
 	irq_free_hwirq(irq);
 }
+
+struct msi_chip tile_msi_chip = {
+	.setup_irq = tile_setup_msi_irq,
+	.teardown_irq = tile_teardown_msi_irq,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &tile_msi_chip;
+}
-- 
1.7.1
