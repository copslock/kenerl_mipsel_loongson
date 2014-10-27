Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 13:45:22 +0100 (CET)
Received: from szxga02-in.huawei.com ([119.145.14.65]:4679 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011378AbaJ0MmEzTgKf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 13:42:04 +0100
Received: from 172.24.2.119 (EHLO szxeml404-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CBJ49240;
        Mon, 27 Oct 2014 20:41:34 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml404-hub.china.huawei.com (10.82.67.59) with Microsoft SMTP Server id
 14.3.158.1; Mon, 27 Oct 2014 20:41:26 +0800
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
Subject: [PATCH 09/16] MIPS/Xlr/MSI: Use MSI controller framework to configure MSI/MSI-X irq
Date:   Mon, 27 Oct 2014 21:22:15 +0800
Message-ID: <1414416142-31239-10-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 43590
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
 arch/mips/pci/pci-xlr.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 0dde803..1e43c70 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -149,6 +149,8 @@ static struct resource nlm_pci_io_resource = {
 	.flags		= IORESOURCE_IO,
 };
 
+static struct msi_controller xlr_msi_ctrl;
+
 struct pci_controller nlm_pci_controller = {
 	.index		= 0,
 	.pci_ops	= &nlm_pci_ops,
@@ -156,6 +158,9 @@ struct pci_controller nlm_pci_controller = {
 	.mem_offset	= 0x00000000UL,
 	.io_resource	= &nlm_pci_io_resource,
 	.io_offset	= 0x00000000UL,
+#ifdef CONFIG_PCI_MSI
+	.msi_ctrl = &xlr_msi_ctrl,
+#endif
 };
 
 /*
@@ -214,11 +219,13 @@ static int get_irq_vector(const struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PCI_MSI
-void arch_teardown_msi_irq(unsigned int irq)
+static void xlr_teardown_msi_irq(struct msi_controller *ctrl,
+		unsigned int irq)
 {
 }
 
-int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+static int xlr_setup_msi_irq(struct msi_controller *ctrl,
+		struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_msg msg;
 	struct pci_dev *lnk;
@@ -263,6 +270,12 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	write_msi_msg(irq, &msg);
 	return 0;
 }
+
+static struct msi_controller xlr_msi_ctrl = {
+	.setup_irq = xlr_setup_msi_irq,
+	.teardown_irq = xlr_teardown_msi_irq,
+};
+
 #endif
 
 /* Extra ACK needed for XLR on chip PCI controller */
-- 
1.7.1
