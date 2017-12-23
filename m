Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Dec 2017 12:11:03 +0100 (CET)
Received: from szxga04-in.huawei.com ([45.249.212.190]:2173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990483AbdLWLK4gh250 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Dec 2017 12:10:56 +0100
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1849EE65CBA79;
        Sat, 23 Dec 2017 19:10:38 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.361.1; Sat, 23 Dec 2017 19:10:32 +0800
From:   Yisheng Xie <xieyisheng1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC:     <ysxie@foxmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH v3 23/27] MIPS: pci: replace devm_ioremap_nocache with devm_ioremap
Date:   Sat, 23 Dec 2017 19:02:03 +0800
Message-ID: <1514026923-33665-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Return-Path: <xieyisheng1@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xieyisheng1@huawei.com
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

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/mips/pci/pci-ar2315.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index b4fa641..8f3baf1 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -428,8 +428,7 @@ static int ar2315_pci_probe(struct platform_device *pdev)
 	apc->mem_res.flags = IORESOURCE_MEM;
 
 	/* Remap PCI config space */
-	apc->cfg_mem = devm_ioremap_nocache(dev, res->start,
-					    AR2315_PCI_CFG_SIZE);
+	apc->cfg_mem = devm_ioremap(dev, res->start, AR2315_PCI_CFG_SIZE);
 	if (!apc->cfg_mem) {
 		dev_err(dev, "failed to remap PCI config space\n");
 		return -ENOMEM;
-- 
1.8.3.1
