Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2014 04:29:42 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:16220 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010647AbaJOC0FIYsF7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2014 04:26:05 +0200
Received: from 172.24.2.119 (EHLO szxeml412-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CAT35352;
        Wed, 15 Oct 2014 10:25:33 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml412-hub.china.huawei.com (10.82.67.91) with Microsoft SMTP Server id
 14.3.158.1; Wed, 15 Oct 2014 10:25:21 +0800
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
Subject: [PATCH v3 07/27] PCI: rcar: Save msi chip in pci_sys_data
Date:   Wed, 15 Oct 2014 11:06:55 +0800
Message-ID: <1413342435-7876-8-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 43271
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

Save msi chip in pci_sys_data instead of assign
msi chip to every pci bus in .add_bus().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pcie-rcar.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 61158e0..c999c7e 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -380,20 +380,10 @@ static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static void rcar_pcie_add_bus(struct pci_bus *bus)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
-
-		bus->msi = &pcie->msi.chip;
-	}
-}
-
 struct hw_pci rcar_pci = {
 	.setup          = rcar_pcie_setup,
 	.map_irq        = of_irq_parse_and_map_pci,
 	.ops            = &rcar_pcie_ops,
-	.add_bus        = rcar_pcie_add_bus,
 };
 
 static void rcar_pcie_enable(struct rcar_pcie *pcie)
@@ -402,6 +392,9 @@ static void rcar_pcie_enable(struct rcar_pcie *pcie)
 
 	rcar_pci.nr_controllers = 1;
 	rcar_pci.private_data = (void **)&pcie;
+#ifdef CONFIG_PCI_MSI
+	rcar_pci.msi_chip = &pcie->msi.chip;
+#endif
 
 	pci_common_init_dev(&pdev->dev, &rcar_pci);
 #ifdef CONFIG_PCI_DOMAINS
-- 
1.7.1
