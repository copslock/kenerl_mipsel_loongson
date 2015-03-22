Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Mar 2015 16:55:50 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:49030 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009511AbbCVPzsAOCax (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Mar 2015 16:55:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 4AC9C19BDA9;
        Sun, 22 Mar 2015 17:55:48 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 8xBxJ3f+KK6f; Sun, 22 Mar 2015 17:55:43 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 4D8B35BC010;
        Sun, 22 Mar 2015 17:55:43 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: fix PCI interrupt mapping for D-Link DSR-1000N
Date:   Sun, 22 Mar 2015 17:55:39 +0200
Message-Id: <1427039739-11322-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Fix PCI interrupt mapping for DSR1000N. This will get the PCI slot
interrupts working. The mapping is based on D-Link GPL tarball.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/pci/pci-octeon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index a04af55..ec3de02 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -214,6 +214,8 @@ const char *octeon_get_pci_interrupts(void)
 		return "AAABAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
 	case CVMX_BOARD_TYPE_BBGW_REF:
 		return "AABCD";
+	case CVMX_BOARD_TYPE_CUST_DSR1000N:
+		return "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC";
 	case CVMX_BOARD_TYPE_THUNDER:
 	case CVMX_BOARD_TYPE_EBH3000:
 	default:
-- 
2.2.0
