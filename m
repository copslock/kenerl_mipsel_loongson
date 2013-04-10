Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 18:03:57 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47536 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835045Ab3DJQDwOO-DV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Apr 2013 18:03:52 +0200
Received: by mail-pd0-f172.google.com with SMTP id 5so349151pdd.3
        for <multiple recipients>; Wed, 10 Apr 2013 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8Fc9TRsPvebJ+Lz4Uq8jRWRLM+UIGUzXgrwC/hNg7sY=;
        b=WUVHeK/FbQoXUqOFBolpThocssY4Jnj1hlvjTlUyy2vx2/D9cqfFiU5FgBzIJPCzR6
         mDKYTvKnlSyhebqakHhcaHYe7RJ44Y8ZHO1DOTNP7AvHPStJMo2KxoVQYrhK+e0zaijG
         xDNqSAJHE2kMrplnmmNv3JyUlBBryqSO5i0KkM2NjXzYTJzLZaEUjxDcfu4xRhf1fTUL
         YX0PdqvlHowztHxZ6zb9DFrP1e47He3Y7APak023l0+Xbd0vJ8GqVxCYfmcvAf/RFm4U
         9Szr3DE+ruIZ3ODVJaXtUW+QBTYvoMB+/W+6ncuNRX4FBb8fTOnfZHWjCk0AF1LJXVfk
         xUnA==
X-Received: by 10.68.44.169 with SMTP id f9mr3739378pbm.29.1365609825506;
        Wed, 10 Apr 2013 09:03:45 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jk11sm480980pbb.0.2013.04.10.09.03.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 09:03:44 -0700 (PDT)
Message-ID: <51658D59.6070602@gmail.com>
Date:   Wed, 10 Apr 2013 09:03:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
CC:     linux-mips@linux-mips.org, david.daney@cavium.com
Subject: Re: [PATCH] octeon-irq: Fix GPIO number in IRQ chip private data
References: <5139FA0A.8060908@nsn.com>
In-Reply-To: <5139FA0A.8060908@nsn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36066
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

On 03/08/2013 06:47 AM, Alexander Sverdlin wrote:
> octeon-irq: Fix GPIO number in IRQ chip private data
>
> Current GPIO chip implementation in octeon-irq is still broken, even
> after upstream
> commit 87161ccdc61862c8b49e75c21209d7f79dc758e9 (MIPS: Octeon: Fix
> broken interrupt
> controller code). It works for GPIO IRQs that have reset-default
> configuration, but
> not for edge-triggered ones.
>
> The problem is in octeon_irq_gpio_map_common(), which passes modified
> "hw" variable
> (which has range of possible values 16..31) as "gpio_line" parameter to
> octeon_irq_set_ciu_mapping(), which saves it in private data of the IRQ
> chip. Later,
> neither octeon_irq_gpio_setup() is able to re-configure GPIOs
> (cvmx_write_csr() is
> writing to non-existent CVMX_GPIO_BIT_CFGX), nor
> octeon_irq_ciu_gpio_ack() is able
> to acknowledge such IRQ, because "mask" is incorrect.
>
> Fix is trivial and has been tested on Cavium Octeon II -based board,
> including
> both level-triggered and edge-triggered GPIO IRQs.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
> Cc: David Daney <david.daney@cavium.com>

Yes, this patch is needed...

Acked-by: David Daney <david.daney@cavium.com>

> ---
> --- linux.orig/arch/mips/cavium-octeon/octeon-irq.c
> +++ linux/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1034,9 +1034,8 @@ static int octeon_irq_gpio_map_common(st
>       if (!octeon_irq_virq_in_range(virq))
>           return -EINVAL;
>
> -    hw += gpiod->base_hwirq;
> -    line = hw >> 6;
> -    bit = hw & 63;
> +    line = (hw + gpiod->base_hwirq) >> 6;
> +    bit = (hw + gpiod->base_hwirq) & 63;
>       if (line > line_limit || octeon_irq_ciu_to_irq[line][bit] != 0)
>           return -EINVAL;
>
>
>
>
