Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2014 23:50:59 +0100 (CET)
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38792 "EHLO
        mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824041AbaBJWu4oQ4xM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Feb 2014 23:50:56 +0100
Received: by mail-oa0-f50.google.com with SMTP id n16so8271347oag.37
        for <linux-mips@linux-mips.org>; Mon, 10 Feb 2014 14:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ba8HOCEdYoQONVgzmgwIK7Gwi2wIgAX49DAO16km6QA=;
        b=ZhUhdb7ei6qrmLQ61L6t4QdidiAhzuWqBGkN/HOUc4QJsUOimA74emVDNMKgaqQITh
         ZI6WDKgrK92a1oJf1xYVqgK3LKxi4FlcG367k6lvijocbkjr9OsigyDq36wGvdBxYxlI
         CRsdfhyrTZ+ygglvZXbKQyPmNBJR/d5opcMHe6/GVq+oF2e/PALbjXemcsO1gyxINciQ
         eli6v0muPwwCNheCBRiwOTXk0rIbm3qr1xf5Snz+ZOEPtqBneYzn4EeO30bNaWZmMllw
         DOWyBzAnEghhVfLk8QdY0xvzni/HXBbZ/5aXhIW59UwF0osOfCSeYjOVc2w8RQnWQNin
         sGog==
X-Received: by 10.60.45.38 with SMTP id j6mr29311484oem.2.1392072649915;
        Mon, 10 Feb 2014 14:50:49 -0800 (PST)
Received: from larrylap.site (cpe-75-81-36-251.kc.res.rr.com. [75.81.36.251])
        by mx.google.com with ESMTPSA id nw5sm39109113obc.9.2014.02.10.14.50.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Feb 2014 14:50:49 -0800 (PST)
Message-ID: <52F957C6.40407@lwfinger.net>
Date:   Mon, 10 Feb 2014 16:50:46 -0600
From:   Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org
CC:     Herton Ronaldo Krzesinski <herton@canonical.com>,
        Hin-Tak Leung <htl10@users.sourceforge.net>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] rtl8187: fix regression on MIPS without coherent DMA
References: <20140210213828.GA15903@localhost.localdomain>
In-Reply-To: <20140210213828.GA15903@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <larry.finger@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Larry.Finger@lwfinger.net
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

On 02/10/2014 03:38 PM, Stanislaw Gruszka wrote:
> This patch fixes regression caused by commit a16dad77634 "MIPS: Fix
> potencial corruption". That commit fixes one corruption scenario in
> cost of adding another one, which actually start to cause crashes
> on Yeeloong laptop when rtl8187 driver is used.
>
> For correct DMA read operation on machines without DMA coherence, kernel
> have to invalidate cache, such it will refill later with new data that
> device wrote to memory, when that data is needed to process. We can only
> invalidate full cache line. Hence when cache line includes both dma
> buffer and some other data (written in cache, but not yet in main
> memory), the other data can not hit memory due to invalidation. That
> happen on rtl8187 where struct rtl8187_priv fields are located just
> before and after small buffers that are passed to USB layer and DMA
> is performed on them.
>
> To fix the problem we align buffers and reserve space after them to make
> them match cache line.
>
> This patch does not resolve all possible MIPS problems entirely, for
> that we have to assure that we always map cache aligned buffers for DMA,
> what can be complex or even not possible. But patch fixes visible and
> reproducible regression and seems other possible corruptions do not
> happen in practice, since Yeeloong laptop works stable without rtl8187
> driver.
>
> Bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=54391
>
> Reported-by: Petr Pisar <petr.pisar@atlas.cz>
> Bisected-by: Tom Li <biergaizi2009@gmail.com>
> Reported-and-tested-by: Tom Li <biergaizi2009@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---

Congratulations to all for sorting this out. It could not have been too easy.

The only effect I see on architectures with DMA coherence is that the private 
data area has grown a little. Certainly, my RTL8187B device still works on x86_64.

Acked-by: Larry Finger <Larry.Finger@lwfinger.next>

Larry

>   drivers/net/wireless/rtl818x/rtl8187/rtl8187.h |   10 ++++++++--
>   1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h b/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h
> index 56aee06..a6ad79f 100644
> --- a/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h
> +++ b/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h
> @@ -15,6 +15,8 @@
>   #ifndef RTL8187_H
>   #define RTL8187_H
>
> +#include <linux/cache.h>
> +
>   #include "rtl818x.h"
>   #include "leds.h"
>
> @@ -139,7 +141,10 @@ struct rtl8187_priv {
>   	u8 aifsn[4];
>   	u8 rfkill_mask;
>   	struct {
> -		__le64 buf;
> +		union {
> +			__le64 buf;
> +			u8 dummy1[L1_CACHE_BYTES];
> +		} ____cacheline_aligned;
>   		struct sk_buff_head queue;
>   	} b_tx_status; /* This queue is used by both -b and non-b devices */
>   	struct mutex io_mutex;
> @@ -147,7 +152,8 @@ struct rtl8187_priv {
>   		u8 bits8;
>   		__le16 bits16;
>   		__le32 bits32;
> -	} *io_dmabuf;
> +		u8 dummy2[L1_CACHE_BYTES];
> +	} *io_dmabuf ____cacheline_aligned;
>   	bool rfkill_off;
>   	u16 seqno;
>   };
>
