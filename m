Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 00:06:35 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:53886 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013450AbcCOXGdQ-9oJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2016 00:06:33 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 29E69234076;
        Wed, 16 Mar 2016 01:06:31 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2] drivers/firmware/broadcom/bcm47xx_nvram.c: fix incorrect __ioread32_copy
Date:   Wed, 16 Mar 2016 01:06:18 +0200
Message-Id: <1458083178-8207-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.7.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52595
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
__ioread32_copy() instead of open-coding") switched to use a generic copy
function, but failed to notice that the header pointer is updated between
the two copies, resulting in bogus data being copied in the latter one.
Fix by keeping the old header pointer.

The patch fixes totally broken networking on WRT54GL router (both LAN
and WLAN interfaces fail to probe).

Fixes: 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use __ioread32_copy() instead of open-coding")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

	v2: Avoid using the device memory after the first copy when
	    checking the nvram length, suggested by Stephen Boyd.

	v1: http://marc.info/?t=145807850800003&r=1&w=2

 drivers/firmware/broadcom/bcm47xx_nvram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 0c2f0a6..0b631e5 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -94,15 +94,14 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 
 found:
 	__ioread32_copy(nvram_buf, header, sizeof(*header) / 4);
-	header = (struct nvram_header *)nvram_buf;
-	nvram_len = header->len;
+	nvram_len = ((struct nvram_header *)(nvram_buf))->len;
 	if (nvram_len > size) {
 		pr_err("The nvram size according to the header seems to be bigger than the partition on flash\n");
 		nvram_len = size;
 	}
 	if (nvram_len >= NVRAM_SPACE) {
 		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-		       header->len, NVRAM_SPACE - 1);
+		       nvram_len, NVRAM_SPACE - 1);
 		nvram_len = NVRAM_SPACE - 1;
 	}
 	/* proceed reading data after header */
-- 
2.7.2
