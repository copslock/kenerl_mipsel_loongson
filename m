Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 23:34:09 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:52680 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab2DIVd4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 23:33:56 +0200
Received: by yenm10 with SMTP id m10so2329364yen.36
        for <multiple recipients>; Mon, 09 Apr 2012 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kvRuibZ200IdxDND61UzenYhS9jKaohk6ClIwXhBe4k=;
        b=abCqvfTGjnLGlscMixXEOFlDZ1Jhw9AKsa/golA30NnMN9jHfjZmqMfrll+zRzAiIj
         7cEFOe+Y4y9LQiNnwcY/TzwsCIwpjoE0Ea6Uyd09r30JEcasocLJiNyA8JwDozvJh3SH
         HYSprKA2jSNseU8Fz54Kox2fn+EINY5wSe9dkAkoEk+Xl5sE9Fax3Tz2mGU8HpO2NpIo
         Dzf3WGHf9NKwumClGMGMHWfrC0MSoqqQhh+y0I2vZo05DLvvo6tXOiMm5PHUDXKg2Tdn
         RmGdOZFNEe+C/oGFHX/OzlHwwb/zqU6mxuWjWsmZyriZmDxQdsyv1DsnX6mp9qUwb5UX
         0S3w==
Received: by 10.60.7.196 with SMTP id l4mr12538900oea.8.1334007229618;
        Mon, 09 Apr 2012 14:33:49 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id xb7sm17624071obb.10.2012.04.09.14.33.48
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Apr 2012 14:33:48 -0700 (PDT)
Message-ID: <4F8355BB.5020308@gmail.com>
Date:   Mon, 09 Apr 2012 14:33:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Imre Kaloz <kaloz@openwrt.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] STAGING: octeon-ethernet: fix build errors by including
 interrupt.h
References: <1333996155-30523-1-git-send-email-kaloz@openwrt.org>
In-Reply-To: <1333996155-30523-1-git-send-email-kaloz@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/09/2012 11:29 AM, Imre Kaloz wrote:
> This patch fixes the following build failures:
>
> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_cleanup_module':
> drivers/staging/octeon/ethernet.c:799:2: error: implicit declaration of function 'free_irq'
> drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_no_more_work':
> drivers/staging/octeon/ethernet-rx.c:119:3: error: implicit declaration of function 'enable_irq'
> drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_do_interrupt':
> drivers/staging/octeon/ethernet-rx.c:136:2: error: implicit declaration of function 'disable_irq_nosync'
> drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_rx_initialize':
> drivers/staging/octeon/ethernet-rx.c:532:2: error: implicit declaration of function 'request_irq'
> drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_initialize':
> drivers/staging/octeon/ethernet-tx.c:712:2: error: implicit declaration of function 'request_irq'
> drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_shutdown':
> drivers/staging/octeon/ethernet-tx.c:723:2: error: implicit declaration of function 'free_irq'
>

If you select some of the IPSec options, linux/interrupt.h will be 
included indirectly via net/xfrm.h.  Without CONFIG_XFRM, you indeed get 
these errors, so...

Acked-by: David Daney <david.daney@cavium.com>

I am not sure when Ralf would merge it, but since it is in 
drivers/staging, it may be best to route it to Greg K-H. with the 
corresponding stable annotations.

> Signed-off-by: Imre Kaloz<kaloz@openwrt.org>
> ---
>   drivers/staging/octeon/ethernet-rx.c |    1 +
>   drivers/staging/octeon/ethernet-tx.c |    1 +
>   drivers/staging/octeon/ethernet.c    |    1 +
>   3 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> index 400df8c..d91751f 100644
> --- a/drivers/staging/octeon/ethernet-rx.c
> +++ b/drivers/staging/octeon/ethernet-rx.c
> @@ -36,6 +36,7 @@
>   #include<linux/prefetch.h>
>   #include<linux/ratelimit.h>
>   #include<linux/smp.h>
> +#include<linux/interrupt.h>
>   #include<net/dst.h>
>   #ifdef CONFIG_XFRM
>   #include<linux/xfrm.h>
> diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
> index 56d74dc..91a97b3 100644
> --- a/drivers/staging/octeon/ethernet-tx.c
> +++ b/drivers/staging/octeon/ethernet-tx.c
> @@ -32,6 +32,7 @@
>   #include<linux/ip.h>
>   #include<linux/ratelimit.h>
>   #include<linux/string.h>
> +#include<linux/interrupt.h>
>   #include<net/dst.h>
>   #ifdef CONFIG_XFRM
>   #include<linux/xfrm.h>
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index 9112cd8..60cba81 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -31,6 +31,7 @@
>   #include<linux/etherdevice.h>
>   #include<linux/phy.h>
>   #include<linux/slab.h>
> +#include<linux/interrupt.h>
>
>   #include<net/dst.h>
>
