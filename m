Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 13:12:58 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33397 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013349AbbLHMMzyk8XF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 13:12:55 +0100
Received: by lbbkw15 with SMTP id kw15so9940718lbb.0
        for <linux-mips@linux-mips.org>; Tue, 08 Dec 2015 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=cJtjFMSL7fYh6MKDObHyP5f7I+1M7M08qZiUyZycCEw=;
        b=O4NEzNOtYVIpaisu5VV5TfggmC5ShKFDeDdSOb/sMmbjjho3M67i7BoYdES+O4GBNT
         pe8dse7WIx21XHhH+j4d3oXFx8na4iEeiXsGWMrXd3+jdeQIwOZTBcYwPoKRxRX3XXFS
         TczrjCQixsSD5e1pU0Vw3Bv8UtRFCzyIjYw66CEBTUvFEj8KIYM9cAEf18S0WASZi58A
         sVuxHjrfLirh7whuwvmOugsQKubb0MjkdgXYmVK1MKKBNV596ZTBCb3qydlKa41bxdIO
         bKZUQSFohnZPeSoFp3jAJy3mFcKyZx175/P78PQHQNFDuULueq1x0OnIWUh5LLmyvftY
         ZhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cJtjFMSL7fYh6MKDObHyP5f7I+1M7M08qZiUyZycCEw=;
        b=EP8LMPwTFCMfwYSNFGGzcjlNTf4L230FVCakUgjUnoXadWlAscQJNha9tNxuNlR0I+
         ceju+GLo/yq6lJWmDFvoeF905Z0QU5HK2JmV4sJ0OP9ArH/ylqLGR6r9XYVFDFAiH9cT
         zyTdhnNNUR8mmcJTHYPTsIGpb8ZVxomC29VGQcezFwmOrxm9ZqGWPrBeuv8Amt1piR02
         f1VcunqxhoaboQ19sVQqJOlA4HyrbRqAIagx9XvO0MFCsxuYjd0XSTKqrh5sFapOvYYh
         wjtkmoNnGpDDeQ7DJsBcoButuhz9B7/wR9/IN6Zyxa4U0b4wl9PcyR4zEg0tQNMTd9lI
         toaA==
X-Gm-Message-State: ALoCoQn8tvjv2SsBy7/XEhFRA7+0I5vLYMCW3NWa2YKgWPcECX7B7denDlg8QfgythqAZ4H40L35/CiZjIPu8Zn6loacVpk2zg==
X-Received: by 10.112.146.42 with SMTP id sz10mr1326370lbb.50.1449576770533;
        Tue, 08 Dec 2015 04:12:50 -0800 (PST)
Received: from [192.168.4.126] ([83.149.8.57])
        by smtp.gmail.com with ESMTPSA id um1sm527346lbb.23.2015.12.08.04.12.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Dec 2015 04:12:49 -0800 (PST)
Subject: Re: [PATCH] MIPS: Fix DMA contiguous allocation
To:     Qais Yousef <qais.yousef@imgtec.com>, linux-mips@linux-mips.org
References: <1449569930-2118-1-git-send-email-qais.yousef@imgtec.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5666C941.20209@cogentembedded.com>
Date:   Tue, 8 Dec 2015 15:12:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1449569930-2118-1-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 12/8/2015 1:18 PM, Qais Yousef wrote:

> Recent changes to how GFP_ATOMIC is defined seems to have broken the condition
> to use mips_alloc_from_contiguous() in mips_dma_alloc_coherent().
>
> I couldn't bottom out the exact change but I think it's this one
>
> d0164adc89f6 (mm, page_alloc: distinguish between being unable to sleep,
> unwilling to sleep and avoiding waking kswapd)
>
>  From what I see GFP_ATOMIC has multiple bits set and the check for !(gfp
> & GFP_ATOMIC) isn't enough. To verify if the flag is atomic we need to make
> sure that (gfp & GFP_ATOMIC) == GFP_ATOMIC to verify that all bits rquired to

    Required.

> satisfy GFP_ATOMIC condition are set.
>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> ---
>   arch/mips/mm/dma-default.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index d8117be729a2..d6b8a1445a3a 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -145,7 +145,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
>
>   	gfp = massage_gfp_flags(dev, gfp);
>
> -	if (IS_ENABLED(CONFIG_DMA_CMA) && !(gfp & GFP_ATOMIC))
> +	if (IS_ENABLED(CONFIG_DMA_CMA) && ((gfp & GFP_ATOMIC) != GFP_ATOMIC))

    () around != not necessary.

[...]

MBR, Sergei
