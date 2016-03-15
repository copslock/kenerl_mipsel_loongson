Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 00:13:28 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:43172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013450AbcCOXN0cfiZJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2016 00:13:26 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0835D60352;
        Tue, 15 Mar 2016 23:13:25 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EDC64611BF; Tue, 15 Mar 2016 23:13:24 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F6A260352;
        Tue, 15 Mar 2016 23:13:23 +0000 (UTC)
Date:   Tue, 15 Mar 2016 16:13:22 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/firmware/broadcom/bcm47xx_nvram.c: fix
 incorrect __ioread32_copy
Message-ID: <20160315231322.GL25972@codeaurora.org>
References: <1458083178-8207-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458083178-8207-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52596
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

On 03/16, Aaro Koskinen wrote:
> Commit 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use
> __ioread32_copy() instead of open-coding") switched to use a generic copy
> function, but failed to notice that the header pointer is updated between
> the two copies, resulting in bogus data being copied in the latter one.
> Fix by keeping the old header pointer.
> 
> The patch fixes totally broken networking on WRT54GL router (both LAN
> and WLAN interfaces fail to probe).
> 
> Fixes: 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use __ioread32_copy() instead of open-coding")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
