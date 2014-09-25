Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 04:57:37 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:42824 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009723AbaIYC4gh100s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 04:56:36 +0200
Received: from 172.24.2.119 (EHLO szxeml409-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CCC72767;
        Thu, 25 Sep 2014 10:50:58 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml409-hub.china.huawei.com (10.82.67.136) with Microsoft SMTP Server id
 14.3.158.1; Thu, 25 Sep 2014 10:50:48 +0800
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
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 19/22] IA64/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Date:   Thu, 25 Sep 2014 11:14:29 +0800
Message-ID: <1411614872-4009-20-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42795
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

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/ia64/kernel/msi_ia64.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
index 4efe748..55ac859 100644
--- a/arch/ia64/kernel/msi_ia64.c
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -112,15 +112,15 @@ static struct irq_chip ia64_msi_chip = {
 };
 
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+static int arch_ia64_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	if (platform_setup_msi_irq)
-		return platform_setup_msi_irq(pdev, desc);
+		return platform_setup_msi_irq(dev, desc);
 
-	return ia64_setup_msi_irq(pdev, desc);
+	return ia64_setup_msi_irq(dev, desc);
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+static void arch_ia64_teardown_msi_irq(unsigned int irq)
 {
 	if (platform_teardown_msi_irq)
 		return platform_teardown_msi_irq(irq);
@@ -128,6 +128,16 @@ void arch_teardown_msi_irq(unsigned int irq)
 	return ia64_teardown_msi_irq(irq);
 }
 
+static struct msi_chip chip = {
+	.setup_irq = arch_ia64_setup_msi_irq,
+	.teardown_irq = arch_ia64_teardown_msi_irq,
+};
+
+struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
+{
+	return &chip;
+}
+
 #ifdef CONFIG_INTEL_IOMMU
 #ifdef CONFIG_SMP
 static int dmar_msi_set_affinity(struct irq_data *data,
-- 
1.7.1
