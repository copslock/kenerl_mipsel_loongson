Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 20:20:35 +0200 (CEST)
Received: from fudo.makrotopia.org ([IPv6:2a07:2ec0:3002::71]:49779 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdFCSU3DUWfZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 20:20:29 +0200
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.88)
        (envelope-from <daniel@makrotopia.org>)
        id 1dHDeu-0003f3-Nj; Sat, 03 Jun 2017 20:20:20 +0200
Date:   Sat, 3 Jun 2017 20:20:14 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Cc:     Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] MIPS: pci-mt7620: enabled PCIe on MT7688
Message-ID: <20170603181807.GA27284@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Return-Path: <daniel@makrotopia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@makrotopia.org
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

Use PCIe support for MT7628AN also on MT7688.
Tested on WRTNODE2R.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/mips/pci/pci-mt7620.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index 628c5132b3d8..cd8e2b87efd5 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -316,6 +316,7 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 		break;
 
 	case MT762X_SOC_MT7628AN:
+	case MT762X_SOC_MT7688:
 		if (mt7628_pci_hw_init(pdev))
 			return -1;
 		break;
-- 
2.13.0
