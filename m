Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 11:46:08 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:62926 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007048AbaIEJqF6I5Ly (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 11:46:05 +0200
Received: from 172.24.2.119 (EHLO szxeml419-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id ATY92806;
        Fri, 05 Sep 2014 17:45:42 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml419-hub.china.huawei.com (10.82.67.158) with Microsoft SMTP Server id
 14.3.158.1; Fri, 5 Sep 2014 17:45:26 +0800
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
        Yijing Wang <wangyijing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v1 01/21] PCI/MSI: Clean up struct msi_chip argument
Date:   Fri, 5 Sep 2014 18:09:46 +0800
Message-ID: <1409911806-10519-2-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020206.5409864A.017D,ss=1,re=0.000,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2011-05-27 18:58:46
X-Mirapoint-Loop-Id: 9849e949b8bbcab4997d27c03d49b308
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42401
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

Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
argument. We can look up msi_chip pointer by the device pointer
or irq number, so clean up msi_chip argument.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c |   12 +++++-------
 drivers/pci/host/pci-tegra.c        |    8 +++++---
 drivers/pci/host/pcie-designware.c  |    4 ++--
 drivers/pci/host/pcie-rcar.c        |    8 +++++---
 drivers/pci/msi.c                   |    4 ++--
 include/linux/msi.h                 |    5 ++---
 6 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 574aba0..658990c 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -129,9 +129,8 @@ static void armada_370_xp_free_msi(int hwirq)
 	mutex_unlock(&msi_used_lock);
 }
 
-static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
-				       struct pci_dev *pdev,
-				       struct msi_desc *desc)
+static int armada_370_xp_setup_msi_irq(struct pci_dev *pdev,
+		struct msi_desc *desc)
 {
 	struct msi_msg msg;
 	int virq, hwirq;
@@ -156,8 +155,7 @@ static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
 	return 0;
 }
 
-static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
-					   unsigned int irq)
+static void armada_370_xp_teardown_msi_irq(unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
 	unsigned long hwirq = d->hwirq;
@@ -166,8 +164,8 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 	armada_370_xp_free_msi(hwirq);
 }
 
-static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
-					  int nvec, int type)
+static int armada_370_xp_check_msi_device(struct pci_dev *dev,
+		int nvec, int type)
 {
 	/* We support MSI, but not MSI-X */
 	if (type == PCI_CAP_ID_MSI)
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 0fb0fdb..edd4040 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1157,9 +1157,10 @@ static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
+static int tegra_msi_setup_irq(struct pci_dev *pdev,
 			       struct msi_desc *desc)
 {
+	struct msi_chip *chip = pdev->bus->msi;
 	struct tegra_msi *msi = to_tegra_msi(chip);
 	struct msi_msg msg;
 	unsigned int irq;
@@ -1185,10 +1186,11 @@ static int tegra_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	return 0;
 }
 
-static void tegra_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
+static void tegra_msi_teardown_irq(unsigned int irq)
 {
-	struct tegra_msi *msi = to_tegra_msi(chip);
 	struct irq_data *d = irq_get_irq_data(irq);
+	struct msi_chip *chip = irq_get_chip_data(irq);
+	struct tegra_msi *msi = to_tegra_msi(chip);
 
 	tegra_msi_free(msi, d->hwirq);
 }
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 52bd3a1..2204456 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -342,7 +342,7 @@ static void clear_irq(unsigned int irq)
 	msi->msi_attrib.multiple = 0;
 }
 
-static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
+static int dw_msi_setup_irq(struct pci_dev *pdev,
 			struct msi_desc *desc)
 {
 	int irq, pos, msgvec;
@@ -384,7 +384,7 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	return 0;
 }
 
-static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
+static void dw_msi_teardown_irq(unsigned int irq)
 {
 	clear_irq(irq);
 }
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 4884ee5..647bc9f 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -615,9 +615,10 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int rcar_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
+static int rcar_msi_setup_irq(struct pci_dev *pdev,
 			      struct msi_desc *desc)
 {
+	struct msi_chip *chip = pdev->bus->msi;
 	struct rcar_msi *msi = to_rcar_msi(chip);
 	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
 	struct msi_msg msg;
@@ -645,10 +646,11 @@ static int rcar_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	return 0;
 }
 
-static void rcar_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
+static void rcar_msi_teardown_irq(unsigned int irq)
 {
-	struct rcar_msi *msi = to_rcar_msi(chip);
 	struct irq_data *d = irq_get_irq_data(irq);
+	struct msi_chip *chip = irq_get_chip_data(irq);
+	struct rcar_msi *msi = to_rcar_msi(chip);
 
 	rcar_msi_free(msi, d->hwirq);
 }
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 8fc9587..f6cb317 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -37,7 +37,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (!chip || !chip->setup_irq)
 		return -EINVAL;
 
-	err = chip->setup_irq(chip, dev, desc);
+	err = chip->setup_irq(dev, desc);
 	if (err < 0)
 		return err;
 
@@ -53,7 +53,7 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
 	if (!chip || !chip->teardown_irq)
 		return;
 
-	chip->teardown_irq(chip, irq);
+	chip->teardown_irq(irq);
 }
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index c3c70a6..762fe61 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -71,9 +71,8 @@ struct msi_chip {
 	struct device_node *of_node;
 	struct list_head list;
 
-	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
-			 struct msi_desc *desc);
-	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
+	int (*setup_irq)(struct pci_dev *dev, struct msi_desc *desc);
+	void (*teardown_irq)(unsigned int irq);
 };
 
 #endif /* LINUX_MSI_H */
-- 
1.7.1
