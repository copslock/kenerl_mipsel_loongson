Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 12:34:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14450 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012185AbcBCLdxbhDpM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 12:33:53 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 7B4319A21ADD5;
        Wed,  3 Feb 2016 11:33:45 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 11:33:47 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 11:33:47 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/15] dmaengine: pch_dma: Allow build on MIPS platforms
Date:   Wed, 3 Feb 2016 11:30:41 +0000
Message-ID: <1454499045-5020-12-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.105]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Allow the pch_dma driver to be built on MIPS platforms, in preparation
for use on the MIPS Boston board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---

Changes in v2: None

 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 79b1390..b7ac926 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -376,7 +376,7 @@ config NBPFAXI_DMA
 
 config PCH_DMA
 	tristate "Intel EG20T PCH / LAPIS Semicon IOH(ML7213/ML7223/ML7831) DMA"
-	depends on PCI && (X86_32 || COMPILE_TEST)
+	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
 	select DMA_ENGINE
 	help
 	  Enable support for Intel EG20T PCH DMA engine.
-- 
2.7.0
