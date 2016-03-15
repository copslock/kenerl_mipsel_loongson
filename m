Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2016 22:46:39 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:51722 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014047AbcCOVqhxFbHs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Mar 2016 22:46:37 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id BD956234041;
        Tue, 15 Mar 2016 23:46:36 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] drivers/firmware/broadcom/bcm47xx_nvram.c: fix incorrect __ioread32_copy
Date:   Tue, 15 Mar 2016 23:46:26 +0200
Message-Id: <1458078386-30254-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.7.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52591
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

Commit 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use
__ioread32_copy() instead of open-coding") switched to use a generic
copy functions, but failed to notice that the header pointer is
updated between the two copies, resulting in bogus data being copied
in the latter one. Fix by keeping the old header pointer as references
to iomem should be fine.

The patch fixes totally broken networking on WRL54GL router (both LAN
and WLAN interfaces fail to probe).

Fixes: 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use __ioread32_copy() instead of open-coding")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 0c2f0a6..7fe5bf2 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -94,7 +94,6 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 
 found:
 	__ioread32_copy(nvram_buf, header, sizeof(*header) / 4);
-	header = (struct nvram_header *)nvram_buf;
 	nvram_len = header->len;
 	if (nvram_len > size) {
 		pr_err("The nvram size according to the header seems to be bigger than the partition on flash\n");
-- 
2.7.2
