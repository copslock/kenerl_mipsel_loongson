Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 22:02:21 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:48766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011386AbbJWUB5tIBxZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 22:01:57 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 44B1D13EF5C;
        Fri, 23 Oct 2015 20:01:56 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 2F6F013EFBE; Fri, 23 Oct 2015 20:01:56 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B89813EF5C;
        Fri, 23 Oct 2015 20:01:55 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Paul Walmsley <paul@pwsan.com>, linux-mips@linux-mips.org
Subject: [PATCH v3 4/4] FIRMWARE: bcm47xx_nvram: Use __ioread32_copy() instead of open-coding
Date:   Fri, 23 Oct 2015 13:01:52 -0700
Message-Id: <1445630512-10888-5-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.6.2.281.g6766aa3
In-Reply-To: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
References: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

Now that we have a generic library function for this, replace the
open-coded instance.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index e41594510b97..0c2f0a61b0ea 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -56,9 +56,7 @@ static u32 find_nvram_size(void __iomem *end)
 static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 {
 	struct nvram_header __iomem *header;
-	int i;
 	u32 off;
-	u32 *src, *dst;
 	u32 size;
 
 	if (nvram_len) {
@@ -95,10 +93,7 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 	return -ENXIO;
 
 found:
-	src = (u32 *)header;
-	dst = (u32 *)nvram_buf;
-	for (i = 0; i < sizeof(struct nvram_header); i += 4)
-		*dst++ = __raw_readl(src++);
+	__ioread32_copy(nvram_buf, header, sizeof(*header) / 4);
 	header = (struct nvram_header *)nvram_buf;
 	nvram_len = header->len;
 	if (nvram_len > size) {
@@ -111,8 +106,8 @@ found:
 		nvram_len = NVRAM_SPACE - 1;
 	}
 	/* proceed reading data after header */
-	for (; i < nvram_len; i += 4)
-		*dst++ = readl(src++);
+	__ioread32_copy(nvram_buf + sizeof(*header), header + 1,
+			DIV_ROUND_UP(nvram_len, 4));
 	nvram_buf[NVRAM_SPACE - 1] = '\0';
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
