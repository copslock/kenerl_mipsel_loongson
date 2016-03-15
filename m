Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2016 23:13:32 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:39802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013783AbcCOWN2AVams (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Mar 2016 23:13:28 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 278716048C;
        Tue, 15 Mar 2016 22:13:26 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1AB73611D1; Tue, 15 Mar 2016 22:13:26 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83C206048C;
        Tue, 15 Mar 2016 22:13:25 +0000 (UTC)
Date:   Tue, 15 Mar 2016 15:13:24 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/firmware/broadcom/bcm47xx_nvram.c: fix incorrect
 __ioread32_copy
Message-ID: <20160315221324.GI25972@codeaurora.org>
References: <1458078386-30254-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458078386-30254-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52593
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

On 03/15, Aaro Koskinen wrote:
> Commit 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use
> __ioread32_copy() instead of open-coding") switched to use a generic
> copy functions, but failed to notice that the header pointer is
> updated between the two copies, resulting in bogus data being copied
> in the latter one. Fix by keeping the old header pointer as references
> to iomem should be fine.
> 
> The patch fixes totally broken networking on WRL54GL router (both LAN
> and WLAN interfaces fail to probe).
> 
> Fixes: 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use __ioread32_copy() instead of open-coding")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---

Ah sorry. That was a stupid mistake. But it might be bad to
access header->len now because that's still some device memory
and not the copy of the memory into ram anymore. How about
this patch instead? Commit text and authorship can be the same as
the original patch.

---8<----
diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 0c2f0a61b0ea..0b631e5b5b84 100644
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
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
