Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 12:59:19 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:56289 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826484AbaANL7RLr10f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jan 2014 12:59:17 +0100
Received: from p4fe254f4.dip0.t-ipconnect.de ([79.226.84.244]:42117 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <wsa@the-dreams.de>)
        id 1W32eK-0003Gb-Er; Tue, 14 Jan 2014 12:59:16 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/7] arch/mips/lantiq/xway: don't check resource with devm_ioremap_resource
Date:   Tue, 14 Jan 2014 12:58:52 +0100
Message-Id: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 1.8.5.1
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: John Crispin <blogic@openwrt.org>
---

Should go via subsystem tree

 arch/mips/lantiq/xway/dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 08f7ebd..78a91fa 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -220,10 +220,6 @@ ltq_dma_init(struct platform_device *pdev)
 	int i;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		panic("Failed to get dma resource");
-
-	/* remap dma register range */
 	ltq_dma_membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ltq_dma_membase))
 		panic("Failed to remap dma resource");
-- 
1.8.5.1
