Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 09:59:25 +0200 (CEST)
Received: from mga14.intel.com ([192.55.52.115]:60574 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009483AbbGIH7XDVuem (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jul 2015 09:59:23 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP; 09 Jul 2015 00:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,438,1432623600"; 
   d="scan'208";a="758914763"
Received: from gerry-dev.bj.intel.com ([10.238.158.61])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2015 00:59:11 -0700
From:   Jiang Liu <jiang.liu@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Grant Likely <grant.likely@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stuart Yoder <stuart.yoder@freescale.com>,
        Yijing Wang <wangyijing@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Jiang Liu <jiang.liu@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
Subject: [RFC Patch V1 02/12] MIPS, PCI: Use for_pci_msi_entry() to access MSI device list
Date:   Thu,  9 Jul 2015 16:00:37 +0800
Message-Id: <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Return-Path: <jiang.liu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.liu@linux.intel.com
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

Use accessor for_pci_msi_entry() to access MSI device list, so we could
easily move msi_list from struct pci_dev into struct device later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/mips/pci/msi-octeon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index cffaaf4aae3c..2a5bb849b10e 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -200,7 +200,7 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
+	for_each_pci_msi_entry(entry, dev) {
 		ret = arch_setup_msi_irq(dev, entry);
 		if (ret < 0)
 			return ret;
-- 
1.7.10.4
