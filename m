Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2016 15:24:40 +0100 (CET)
Received: from m12-17.163.com ([220.181.12.17]:52254 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010928AbcBFOYhN98As (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Feb 2016 15:24:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oQPml
        OEAIMPEqK7gb+0HInc3B5AVq7mUmsB6xDdaTaw=; b=QORrM8sd8H4XflIX/ptXN
        Rv2IuJ7TIla4kiacwlKUxrrPv9pvESzArJh5BP6Zpk2yYUrYvVijAxHtlQoikGqN
        UVjj3qk6ehwmD+wejl87702gk47gL0cza8gi8aWFM3VgklCgAvg4jwkGqWJY9QxA
        hJydeRrxZh9O7tJNeP0bKU=
Received: from localhost.localdomain.localdomain (unknown [49.77.206.103])
        by smtp13 (Coremail) with SMTP id EcCowAAXTnYfArZW3M2kAw--.40432S2;
        Sat, 06 Feb 2016 22:24:33 +0800 (CST)
From:   weiyj_lk@163.com
To:     Ralf Baechle <ralf@linux-mips.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <blogic@openwrt.org>
Cc:     Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: pci-mt7620: Fix return value check in mt7620_pci_probe()
Date:   Sat,  6 Feb 2016 22:24:19 +0800
Message-Id: <1454768659-32720-1-git-send-email-weiyj_lk@163.com>
X-Mailer: git-send-email 2.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EcCowAAXTnYfArZW3M2kAw--.40432S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4kAFWDXryfuF1fuFyDWrg_yoWDKrgEv3
        90krn7JrZ3JFyYqay2yry5CFy3Aa4qgr9Igr4vgay3Aryrury3KFW7ur9rAF4ru39xKrWq
        9rZxGr47ur43AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnxMaUUUUUU==
X-Originating-IP: [49.77.206.103]
X-CM-SenderInfo: pzhl5yxbonqiywtou0bp/1tbiowAH1lUL4agH2gAAs4
Return-Path: <weiyj_lk@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyj_lk@163.com
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

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns
ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/mips/pci/pci-mt7620.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index a009ee4..044c1cd 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -297,12 +297,12 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 		return PTR_ERR(rstpcie0);
 
 	bridge_base = devm_ioremap_resource(&pdev->dev, bridge_res);
-	if (!bridge_base)
-		return -ENOMEM;
+	if (IS_ERR(bridge_base))
+		return PTR_ERR(bridge_base);
 
 	pcie_base = devm_ioremap_resource(&pdev->dev, pcie_res);
-	if (!pcie_base)
-		return -ENOMEM;
+	if (IS_ERR(pcie_base))
+		return PTR_ERR(pcie_base);
 
 	iomem_resource.start = 0;
 	iomem_resource.end = ~0;
