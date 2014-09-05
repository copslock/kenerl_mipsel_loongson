Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 11:51:36 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:56104 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007106AbaIEJqjjnk-I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 11:46:39 +0200
Received: from 172.24.2.119 (EHLO szxeml419-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BZB92846;
        Fri, 05 Sep 2014 17:46:00 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml419-hub.china.huawei.com (10.82.67.158) with Microsoft SMTP Server id
 14.3.158.1; Fri, 5 Sep 2014 17:45:46 +0800
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
        Yijing Wang <wangyiijng@huawei.com>
Subject: [PATCH v1 12/21] MIPS/Xlp: Remove the dead function destroy_irq() to fix build error
Date:   Fri, 5 Sep 2014 18:09:57 +0800
Message-ID: <1409911806-10519-13-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42420
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

Commit 465665f78a7 ("mips: Kill pointless destroy_irq()") removed
the destroy_irq(). So remove the leftover one in xlp_setup_msix()
to fix build error.

arch/mips/pci/msi-xlp.c: In function 'xlp_setup_msix':
arch/mips/pci/msi-xlp.c:447:3: error: implicit declaration of function 'destroy_irq'..
cc1: some warnings being treated as errors
make[1]: *** [arch/mips/pci/msi-xlp.o] Error 1
make: *** [arch/mips/pci/] Error 2

Signed-off-by: Yijing Wang <wangyiijng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/pci/msi-xlp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
index fa374fe..e469dc7 100644
--- a/arch/mips/pci/msi-xlp.c
+++ b/arch/mips/pci/msi-xlp.c
@@ -443,10 +443,8 @@ static int xlp_setup_msix(uint64_t lnkbase, int node, int link,
 	msg.data = 0xc00 | msixvec;
 
 	ret = irq_set_msi_desc(xirq, desc);
-	if (ret < 0) {
-		destroy_irq(xirq);
+	if (ret < 0)
 		return ret;
-	}
 
 	write_msi_msg(xirq, &msg);
 	return 0;
-- 
1.7.1
