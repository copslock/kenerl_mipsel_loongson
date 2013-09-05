Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:57:29 +0200 (CEST)
Received: from mail-oa0-f45.google.com ([209.85.219.45]:64350 "EHLO
        mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837145Ab3IES51YNHrH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Sep 2013 20:57:27 +0200
Received: by mail-oa0-f45.google.com with SMTP id m6so2718668oag.4
        for <linux-mips@linux-mips.org>; Thu, 05 Sep 2013 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5g1iMOhPZMcYCU9IBJyvhBxEB4IdUvsLG+lPkF3bT+g=;
        b=PiERm8W4MMQfrjPs9Se7mIo0TyQ+A4c4YgOedhvQv9/K32P9Wmmnytep30LS0zuW31
         x++pRBLeZQ3D1plhyh5WvEYSZZc9M4/K2taBEbLaU+VrpxiQQD2IQIfcbqjsVOi/mjTO
         /GfOwmOMeiri6J90MUEaP1zGnYXACpFspsp0RzVNmdj93fI+e8POJi04+grzZA0X1OFF
         2oUdr0FKFlABTuhlIv/VkDrmNXT3DPvS8sFsQ5mHzsydlL9orep8g1fcBp+gH+CePDqo
         lVf0WO1NCYRBBi0ottYL59il9OmdId9nvUrzEgkKxxyrZ6iYHV0IZ6ER9/pUuuTBCaHB
         l5Nw==
X-Received: by 10.182.214.98 with SMTP id nz2mr7652932obc.37.1378407441312;
        Thu, 05 Sep 2013 11:57:21 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id d8sm32372404oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 11:57:20 -0700 (PDT)
Message-ID: <5228D40E.3010208@gmail.com>
Date:   Thu, 05 Sep 2013 11:57:18 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, richard@nod.at
Subject: Re: [PATCH 2/3] staging: octeon-ethernet: remove skb alloc failure
 warnings
References: <1378406641-16530-1-git-send-email-aaro.koskinen@iki.fi> <1378406641-16530-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1378406641-16530-3-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 09/05/2013 11:44 AM, Aaro Koskinen wrote:
> Remove skb allocation failure warnings. They will trigger a page
> allocation warning already. Also, one of the warnings was not ratelimited,
> causing the box to lock up under heavy traffic & low memory.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This seems fine.

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   drivers/staging/octeon/ethernet-mem.c | 7 +------
>   drivers/staging/octeon/ethernet-rx.c  | 3 ---
>   2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/staging/octeon/ethernet-mem.c b/drivers/staging/octeon/ethernet-mem.c
> index 78b6cb7..199059d 100644
> --- a/drivers/staging/octeon/ethernet-mem.c
> +++ b/drivers/staging/octeon/ethernet-mem.c
> @@ -48,13 +48,8 @@ static int cvm_oct_fill_hw_skbuff(int pool, int size, int elements)
>   	while (freed) {
>
>   		struct sk_buff *skb = dev_alloc_skb(size + 256);
> -		if (unlikely(skb == NULL)) {
> -			pr_warning
> -			    ("Failed to allocate skb for hardware pool %d\n",
> -			     pool);
> +		if (unlikely(skb == NULL))
>   			break;
> -		}
> -
>   		skb_reserve(skb, 256 - (((unsigned long)skb->data) & 0x7f));
>   		*(struct sk_buff **)(skb->data - sizeof(void *)) = skb;
>   		cvmx_fpa_free(skb->data, pool, DONT_WRITEBACK(size / 128));
> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> index 10e5416..e14a1bb 100644
> --- a/drivers/staging/octeon/ethernet-rx.c
> +++ b/drivers/staging/octeon/ethernet-rx.c
> @@ -337,9 +337,6 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
>   			 */
>   			skb = dev_alloc_skb(work->len);
>   			if (!skb) {
> -				printk_ratelimited("Port %d failed to allocate "
> -						   "skbuff, packet dropped\n",
> -						   work->ipprt);
>   				cvm_oct_free_work(work);
>   				continue;
>   			}
>
