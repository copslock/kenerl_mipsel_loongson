Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 09:03:25 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:31094 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842533AbaHLHDTS8-0s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 09:03:19 +0200
Received: from 172.24.2.119 (EHLO szxeml421-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id ASY16060;
        Tue, 12 Aug 2014 15:02:41 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml421-hub.china.huawei.com (10.82.67.160) with Microsoft SMTP Server id
 14.3.158.1; Tue, 12 Aug 2014 15:02:30 +0800
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
        Yijing Wang <wangyijing@huawei.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [RFC PATCH 05/20] MSI: Refactor struct msi_chip to become more common
Date:   Tue, 12 Aug 2014 15:25:58 +0800
Message-ID: <1407828373-24322-6-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020205.53E9BC13.0086,ss=1,re=0.000,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2011-05-27 18:58:46
X-Mirapoint-Loop-Id: c6341c0ed4bcc387b32ede7dcf80a5e9
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41953
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

Now there are a lot of __weak arch functions in MSI code.
These functions make MSI driver complex, It's time to
refactor it. Add .restore_irq(), .setup_irqs(), .teardown_irqs()
to make msi_chip common across all platforms.
Also replace the argument "struct pci_dev" with "struct device"
to support future Non-PCI MSI device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c |    4 ++--
 drivers/pci/host/pci-tegra.c        |    3 ++-
 drivers/pci/host/pcie-designware.c  |    4 ++--
 drivers/pci/host/pcie-rcar.c        |    3 ++-
 drivers/pci/msi.c                   |    4 ++--
 include/linux/msi.h                 |    7 +++++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ee1f0ba..3761e52 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -129,7 +129,7 @@ static void armada_370_xp_free_msi(int hwirq)
 	mutex_unlock(&msi_used_lock);
 }
 
-static int armada_370_xp_setup_msi_irq(struct pci_dev *pdev, 
+static int armada_370_xp_setup_msi_irq(struct device *dev,
 		struct msi_desc *desc)
 {
 	struct msi_msg msg;
@@ -164,7 +164,7 @@ static void armada_370_xp_teardown_msi_irq(unsigned int irq)
 	armada_370_xp_free_msi(hwirq);
 }
 
-static int armada_370_xp_check_msi_device(struct pci_dev *dev, 
+static int armada_370_xp_check_msi_device(struct device *dev,
 		int nvec, int type)
 {
 	/* We support MSI, but not MSI-X */
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 3872bc0..a2fa0ec 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1192,9 +1192,10 @@ static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_msi_setup_irq(struct pci_dev *pdev,
+static int tegra_msi_setup_irq(struct device *dev,
 			       struct msi_desc *desc)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct msi_chip *chip = pdev->bus->msi;
 	struct tegra_msi *msi = to_tegra_msi(chip);
 	struct msi_msg msg;
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2204456..9c3816d 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -342,12 +342,12 @@ static void clear_irq(unsigned int irq)
 	msi->msi_attrib.multiple = 0;
 }
 
-static int dw_msi_setup_irq(struct pci_dev *pdev,
-			struct msi_desc *desc)
+static int dw_msi_setup_irq(struct device *dev, struct msi_desc *desc)
 {
 	int irq, pos, msgvec;
 	u16 msg_ctr;
 	struct msi_msg msg;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
 
 	if (!pp) {
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 647bc9f..fa33432 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -615,9 +615,10 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int rcar_msi_setup_irq(struct pci_dev *pdev,
+static int rcar_msi_setup_irq(struct device *dev,
 			      struct msi_desc *desc)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct msi_chip *chip = pdev->bus->msi;
 	struct rcar_msi *msi = to_rcar_msi(chip);
 	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 242d775..7b7abe9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -37,7 +37,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (!chip || !chip->setup_irq)
 		return -EINVAL;
 
-	err = chip->setup_irq(dev, desc);
+	err = chip->setup_irq(&dev->dev, desc);
 	if (err < 0)
 		return err;
 
@@ -61,7 +61,7 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (!chip || !chip->check_device)
 		return 0;
 
-	return chip->check_device(dev, nvec, type);
+	return chip->check_device(&dev->dev, nvec, type);
 }
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a510d25..2068d25 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -72,9 +72,12 @@ struct msi_chip {
 	struct device_node *of_node;
 	struct list_head list;
 
-	int (*setup_irq)(struct pci_dev *dev, struct msi_desc *desc);
+	int (*check_device)(struct device *dev, int nvec, int type);
+	int (*setup_irq)(struct device *dev, struct msi_desc *desc);
+	int (*setup_irqs)(struct device *dev, int nvec, int type);
 	void (*teardown_irq)(unsigned int irq);
-	int (*check_device)(struct pci_dev *dev, int nvec, int type);
+	void (*teardown_irqs)(struct device *dev);
+	void (*restore_irqs)(struct device *dev);
 };
 
 #endif /* LINUX_MSI_H */
-- 
1.7.1
