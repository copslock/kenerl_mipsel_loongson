Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2016 23:00:18 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:48876 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008998AbcCWWAPu3YvA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2016 23:00:15 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 05CF7615D4;
        Wed, 23 Mar 2016 22:00:14 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E62C0615BC; Wed, 23 Mar 2016 22:00:13 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 239876022C;
        Wed, 23 Mar 2016 22:00:12 +0000 (UTC)
Date:   Wed, 23 Mar 2016 15:00:12 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/firmware/broadcom/bcm47xx_nvram.c: fix
 incorrect __ioread32_copy
Message-ID: <20160323220012.GB18567@codeaurora.org>
References: <1458083178-8207-1-git-send-email-aaro.koskinen@iki.fi>
 <56F30E1F.5020108@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56F30E1F.5020108@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52690
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

On 03/23, Hauke Mehrtens wrote:
> On 03/16/2016 12:06 AM, Aaro Koskinen wrote:
> > Commit 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use
> > __ioread32_copy() instead of open-coding") switched to use a generic copy
> > function, but failed to notice that the header pointer is updated between
> > the two copies, resulting in bogus data being copied in the latter one.
> > Fix by keeping the old header pointer.
> > 
> > The patch fixes totally broken networking on WRT54GL router (both LAN
> > and WLAN interfaces fail to probe).
> > 
> > Fixes: 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use __ioread32_copy() instead of open-coding")
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> > 
> > 	v2: Avoid using the device memory after the first copy when
> > 	    checking the nvram length, suggested by Stephen Boyd.
> > 
> > 	v1: http://marc.info/?t=145807850800003&r=1&w=2
> > 
> >  drivers/firmware/broadcom/bcm47xx_nvram.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
> > index 0c2f0a6..0b631e5 100644
> > --- a/drivers/firmware/broadcom/bcm47xx_nvram.c
> > +++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
> > @@ -94,15 +94,14 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
> >  
> >  found:
> >  	__ioread32_copy(nvram_buf, header, sizeof(*header) / 4);
> > -	header = (struct nvram_header *)nvram_buf;
> > -	nvram_len = header->len;
> > +	nvram_len = ((struct nvram_header *)(nvram_buf))->len;
> 
> I do not understand why this change is needed? Doesn't the old code do
> exactly the same as the new one?
> 
> The old code updated the header pointer and then accesses a member, the
> new one directly accesses this member without updating this pointer.
> 
> I assume, I am missing something. ;-)

The goal is to access 'nvram_buf' which is a copy of 'header'.
This is to avoid any problems with accessing device memory, i.e.
'header', without using the appropriate I/O accessors (readl,
readw, readb).

The bug that's being fixed though is to make sure 'header'
doesn't get overwritten with the pointer to the in-memory copy
that we just made. Further down in this function we copy the
second 'header' that lives in device memory, and repointing
'header' to the in-memory copy breaks that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
