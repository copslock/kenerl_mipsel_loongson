Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 17:47:58 +0200 (CEST)
Received: from mail-lf1-x142.google.com ([IPv6:2a00:1450:4864:20::142]:42122
        "EHLO mail-lf1-x142.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993316AbeGTPryVMz40 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 17:47:54 +0200
Received: by mail-lf1-x142.google.com with SMTP id u202-v6so2112703lff.9
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2018 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJ4lbSD/2hhTSvfa/6VF/7Uj8rY8ilmiEjQ7Muc11Kc=;
        b=wyqVm+36SMpvOrYgnHrJtE1NwOu/X/NJgS3JDxhYUBSbmFfS3z5SNt9TgX08M+sOl3
         i1GOmMLSTSUfVied+b+H7wpdgc+8B2cH9BVR9jJDS1Uvr6Ki4VN+mmChEE1U39q0eqr3
         yYKa7XN+cP5fAjbqRK9KF2XWYyne0coe9XA4mwlJPAjYK53BNfydreVvlzjxIjazeDoh
         H6na8nk23tDOWLWhRKIcRiQpsN/6rAGCOT4iHqksuU/vpp8x+4QUaH8lEyCTOiW2NRUW
         A7e9i+fwTTs0xvv6L5nxtKKEN+DUUnQaIQXU/PAOOfI7jOtldaUycgN3ib0vv5HdIuCB
         GWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aJ4lbSD/2hhTSvfa/6VF/7Uj8rY8ilmiEjQ7Muc11Kc=;
        b=uAYS7tQcgZLKAnuw0gesNd9VfbTz/curhLAW78wRp30DaczFIt/Wn+x+gT18z1Wxzl
         n0GOeu9ka+dNlOEHENf/iRfVWCVPgQP2zsMIVQjMrBF7B2XS2yltMd9PckDfuY4ZEKsh
         3XzrYRsBTgtlcr6O+rBbbbC6S3WFrgbsqXdcSvDgdL866X6AduISnmBCEekdZ8Vinz5q
         6Vm+XUZxYnjC9fOBTPvNRZJ6zUZzaUHE44pRj5MdmDf7G1/lpYT1fvdCI1Zwa4e67FYo
         eX3P1q8HKtV7RSBm8KAsRTla8BzS+QNM7kaG/wcaQ3wC5n7UOBu9+00Tq6CANqL8LVus
         tHMA==
X-Gm-Message-State: AOUpUlHSZ4bBABuHhAcsamD74AbengijgLHpSTDiclS3Bnk/vv2Ynom3
        4rI4d02TlXn9dnBXmaUpZ/ZswA==
X-Google-Smtp-Source: AAOMgpeyWdWntXkMdAQ7tFtY6QpwkpdE8S58kps71g7STB4nXO/J3H4T8yheAPL81kf24P7xz2pszg==
X-Received: by 2002:a19:8f8f:: with SMTP id s15-v6mr1813262lfk.96.1532101669003;
        Fri, 20 Jul 2018 08:47:49 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.110])
        by smtp.gmail.com with ESMTPSA id v10-v6sm429467ljg.12.2018.07.20.08.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 08:47:47 -0700 (PDT)
Subject: Re: [PATCH V2 07/25] MIPS: ath79: enable uart during early_prink
To:     John Crispin <john@phrozen.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-8-john@phrozen.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <357b8f17-4eeb-9939-3781-af060673abf1@cogentembedded.com>
Date:   Fri, 20 Jul 2018 18:47:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180720115842.8406-8-john@phrozen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64989
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

On 07/20/2018 02:58 PM, John Crispin wrote:

> From: Gabor Juhos <juhosg@openwrt.org>
> 
> This patch ensures, that the poinmux register is properly setup for the

   Pinmux.

> boot console uart when early_printk is enabled.

   UART (else my spell-checker trips over it).

> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  arch/mips/ath79/early_printk.c | 44 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
> index d6c892cf01b1..2024a0bb9144 100644
> --- a/arch/mips/ath79/early_printk.c
> +++ b/arch/mips/ath79/early_printk.c
> @@ -58,6 +58,46 @@ static void prom_putchar_dummy(unsigned char ch)
>  	/* nothing to do */
>  }
>  
> +static void prom_enable_uart(u32 id)
> +{
> +	void __iomem *gpio_base;
> +	u32 uart_en;
> +	u32 t;
[...]
> +	gpio_base = (void __iomem *)(KSEG1ADDR(AR71XX_GPIO_BASE));

   Are the parens around KSEG1ADDR() really needed?

[...]

MBR, Sergei
