Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 05:01:35 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:26377 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009084AbaIYDBbqQvCm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 05:01:31 +0200
Received: from 172.24.2.119 (EHLO szxeml409-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BZX30384;
        Thu, 25 Sep 2014 10:50:48 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml409-hub.china.huawei.com (10.82.67.136) with Microsoft SMTP Server id
 14.3.158.1; Thu, 25 Sep 2014 10:50:36 +0800
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
Subject: [PATCH v2 12/22] MIPS/Octeon/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Date:   Thu, 25 Sep 2014 11:14:22 +0800
Message-ID: <1411614872-4009-13-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 42797
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
 arch/mips/pci/msi-octeon.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 63bbe07..14f2d16 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -57,7 +57,7 @@ static int msi_irq_size;
  *
  * Returns 0 on success.
  */
-int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+static int octeon_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_msg msg;
 	u16 control;
@@ -132,12 +132,12 @@ msi_irq_allocated:
 	/* Make sure the search for available interrupts didn't fail */
 	if (irq >= 64) {
 		if (request_private_bits) {
-			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying just one",
+			pr_err("octeon_setup_msi_irq: Unable to find %d free interrupts, trying just one",
 			       1 << request_private_bits);
 			request_private_bits = 0;
 			goto try_only_one;
 		} else
-			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
+			panic("octeon_setup_msi_irq: Unable to find a free MSI interrupt");
 	}
 
 	/* MSI interrupts start at logical IRQ OCTEON_IRQ_MSI_BIT0 */
@@ -168,7 +168,7 @@ msi_irq_allocated:
 		msg.address_hi = (0 + CVMX_SLI_PCIE_MSI_RCV) >> 32;
 		break;
 	default:
-		panic("arch_setup_msi_irq: Invalid octeon_dma_bar_type");
+		panic("octeon_setup_msi_irq: Invalid octeon_dma_bar_type");
 	}
 	msg.data = irq - OCTEON_IRQ_MSI_BIT0;
 
@@ -182,7 +182,7 @@ msi_irq_allocated:
 	return 0;
 }
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int octeon_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -201,7 +201,7 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return 1;
 
 	list_for_each_entry(entry, &dev->msi_list, list) {
-		ret = arch_setup_msi_irq(dev, entry);
+		ret = octeon_setup_msi_irq(dev, entry);
 		if (ret < 0)
 			return ret;
 		if (ret > 0)
@@ -210,14 +210,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	return 0;
 }
-
 /**
  * Called when a device no longer needs its MSI interrupts. All
  * MSI interrupts for the device are freed.
  *
  * @irq:    The devices first irq number. There may be multple in sequence.
  */
-void arch_teardown_msi_irq(unsigned int irq)
+static void octeon_teardown_msi_irq(unsigned int irq)
 {
 	int number_irqs;
 	u64 bitmask;
@@ -226,8 +225,8 @@ void arch_teardown_msi_irq(unsigned int irq)
 
 	if ((irq < OCTEON_IRQ_MSI_BIT0)
 		|| (irq > msi_irq_size + OCTEON_IRQ_MSI_BIT0))
-		panic("arch_teardown_msi_irq: Attempted to teardown illegal "
-		      "MSI interrupt (%d)", irq);
+		panic("octeon_teardown_msi_irq: Attempted to teardown illegal "
+			"MSI interrupt (%d)", irq);
 
 	irq -= OCTEON_IRQ_MSI_BIT0;
 	index = irq / 64;
@@ -240,7 +239,7 @@ void arch_teardown_msi_irq(unsigned int irq)
 	 */
 	number_irqs = 0;
 	while ((irq0 + number_irqs < 64) &&
-	       (msi_multiple_irq_bitmask[index]
+		(msi_multiple_irq_bitmask[index]
 		& (1ull << (irq0 + number_irqs))))
 		number_irqs++;
 	number_irqs++;
@@ -249,8 +248,8 @@ void arch_teardown_msi_irq(unsigned int irq)
 	/* Shift the mask to the correct bit location */
 	bitmask <<= irq0;
 	if ((msi_free_irq_bitmask[index] & bitmask) != bitmask)
-		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
-		      "interrupt (%d) not in use", irq);
+		panic("octeon_teardown_msi_irq: Attempted to teardown MSI "
+			"interrupt (%d) not in use", irq);
 
 	/* Checks are done, update the in use bitmask */
 	spin_lock(&msi_free_irq_bitmask_lock);
@@ -259,6 +258,16 @@ void arch_teardown_msi_irq(unsigned int irq)
 	spin_unlock(&msi_free_irq_bitmask_lock);
 }
 
+static struct msi_chip octeon_msi_chip = {
+	.setup_irqs = octeon_setup_msi_irqs,
+	.teardown_irq = octeon_teardown_msi_irq,
+};
+
+struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
+{
+	return &octeon_msi_chip;
+}
+
 static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
 
 static u64 msi_rcv_reg[4];
-- 
1.7.1
