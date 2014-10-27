Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 13:42:47 +0100 (CET)
Received: from szxga02-in.huawei.com ([119.145.14.65]:4680 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011346AbaJ0Ml4mrRiA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 13:41:56 +0100
Received: from 172.24.2.119 (EHLO szxeml404-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CBJ49247;
        Mon, 27 Oct 2014 20:41:39 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml404-hub.china.huawei.com (10.82.67.59) with Microsoft SMTP Server id
 14.3.158.1; Mon, 27 Oct 2014 20:41:31 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
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
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 12/16] arm/iop13xx/MSI: Use MSI controller framework to configure MSI/MSI-X irq
Date:   Mon, 27 Oct 2014 21:22:18 +0800
Message-ID: <1414416142-31239-13-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
References: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43581
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

Use MSI controller framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/mach-iop13xx/include/mach/pci.h |    4 ++++
 arch/arm/mach-iop13xx/iq81340mc.c        |    3 +++
 arch/arm/mach-iop13xx/iq81340sc.c        |    5 ++++-
 arch/arm/mach-iop13xx/msi.c              |   11 +++++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/pci.h b/arch/arm/mach-iop13xx/include/mach/pci.h
index 59f42b5..c8f5caf 100644
--- a/arch/arm/mach-iop13xx/include/mach/pci.h
+++ b/arch/arm/mach-iop13xx/include/mach/pci.h
@@ -11,6 +11,10 @@ void iop13xx_atu_select(struct hw_pci *plat_pci);
 void iop13xx_pci_init(void);
 void iop13xx_map_pci_memory(void);
 
+#ifdef CONFIG_PCI_MSI
+extern struct msi_controller iop13xx_msi_ctrl;
+#endif
+
 #define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_REC_TARGET_ABORT | \
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 9cd07d3..7b802f5 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -59,6 +59,9 @@ static struct hw_pci iq81340mc_pci __initdata = {
 	.map_irq	= iq81340mc_pcix_map_irq,
 	.scan		= iop13xx_scan_bus,
 	.preinit	= iop13xx_pci_init,
+#ifdef CONFIG_PCI_MSI
+	.msi_ctrl	= &iop13xx_msi_ctrl,
+#endif
 };
 
 static int __init iq81340mc_pci_init(void)
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index b3ec11c..934de2e 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -60,7 +60,10 @@ static struct hw_pci iq81340sc_pci __initdata = {
 	.setup		= iop13xx_pci_setup,
 	.scan		= iop13xx_scan_bus,
 	.map_irq	= iq81340sc_atux_map_irq,
-	.preinit	= iop13xx_pci_init
+	.preinit	= iop13xx_pci_init,
+#ifdef CONFIG_PCI_MSI
+	.msi_ctrl	= &iop13xx_msi_ctrl,
+#endif
 };
 
 static int __init iq81340sc_pci_init(void)
diff --git a/arch/arm/mach-iop13xx/msi.c b/arch/arm/mach-iop13xx/msi.c
index e7730cf..07a512e 100644
--- a/arch/arm/mach-iop13xx/msi.c
+++ b/arch/arm/mach-iop13xx/msi.c
@@ -132,7 +132,8 @@ static struct irq_chip iop13xx_msi_chip = {
 	.irq_unmask = unmask_msi_irq,
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+static int iop13xx_setup_msi_irq(struct msi_controller *ctrl,
+		struct pci_dev *dev, struct msi_desc *desc)
 {
 	int id, irq = irq_alloc_desc_from(IRQ_IOP13XX_MSI_0, -1);
 	struct msi_msg msg;
@@ -159,7 +160,13 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 	return 0;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+static void iop13xx_teardown_msi_irq(struct msi_controller *ctrl,
+		unsigned int irq)
 {
 	irq_free_desc(irq);
 }
+
+struct msi_controller iop13xx_msi_ctrl = {
+	.setup_irq = iop13xx_setup_msi_irq,
+	.teardown_irq = iop13xx_teardown_msi_irq,
+};
-- 
1.7.1
