Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 09:10:45 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:23458 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860194AbaHLHJJF-gBM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 09:09:09 +0200
Received: from 172.24.2.119 (EHLO szxeml421-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CAE07909;
        Tue, 12 Aug 2014 15:03:00 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml421-hub.china.huawei.com (10.82.67.160) with Microsoft SMTP Server id
 14.3.158.1; Tue, 12 Aug 2014 15:02:46 +0800
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
Subject: [RFC PATCH 14/20] Powerpc/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
Date:   Tue, 12 Aug 2014 15:26:07 +0800
Message-ID: <1407828373-24322-15-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 41969
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

Introduce a new struct msi_chip ppc_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/kernel/msi.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 8bbc12d..170b02c 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,7 +13,7 @@
 
 #include <asm/machdep.h>
 
-int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
+int ppc_msi_check_device(struct device *dev, int nvec, int type)
 {
 	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
 		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
@@ -26,18 +26,29 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
 
 	if (ppc_md.msi_check_device) {
 		pr_debug("msi: Using platform check routine.\n");
-		return ppc_md.msi_check_device(dev, nvec, type);
+		return ppc_md.msi_check_device(to_pci_dev(dev), nvec, type);
 	}
 
         return 0;
 }
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+int ppc_setup_msi_irqs(struct device *dev, int nvec, int type)
 {
-	return ppc_md.setup_msi_irqs(dev, nvec, type);
+	return ppc_md.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *dev)
+void ppc_teardown_msi_irqs(struct device *dev)
 {
-	ppc_md.teardown_msi_irqs(dev);
+	ppc_md.teardown_msi_irqs(to_pci_dev(dev));
+}
+
+struct msi_chip ppc_msi_chip = {
+	.setup_irqs = ppc_setup_msi_irqs,
+	.teardown_irqs = ppc_teardown_msi_irqs,
+	.check_device = ppc_msi_check_device,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &ppc_msi_chip;
 }
-- 
1.7.1
