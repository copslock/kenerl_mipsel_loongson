Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 01:03:42 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54433 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903720Ab2D3XDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 01:03:35 +0200
Received: by lbbgg6 with SMTP id gg6so940906lbb.36
        for <linux-mips@linux-mips.org>; Mon, 30 Apr 2012 16:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=uomlzoNfU7YF6iNaEYGdDFLBnUGTpYX+JOlIv1HXYoU=;
        b=Wb9ynJjEWAZOvpanES4j1/6CJ7iNDrRdMYmzzsrNvX9y9+cLwk07J3KyXee3s+b7ju
         CdfVXaL/QC3b1t1bSUkh35J6gvc6M3pwJupjNvoGHZQ6OeAm0vpIe0psPppcH/8kg0j3
         rwQQdKrTU3V2w4xQcqeDD0rxgI1d9Po52bW5Q37k4gqCBrZ4KxffLRZ5sCkK3Bf0NYME
         LozvV44R6lFhYvsVVeAL+6w/SfRketWFd6S3nl46p7/O2WpuMtSLyQthS/ZouWgrHcqa
         5qlS8mCPDn51HvJGtad1WiHyi8+iouePoR93fRI1rOQsy64/aKGWviiE3KhdXuBM/ejT
         uASA==
Received: by 10.112.29.40 with SMTP id g8mr10521361lbh.39.1335827010177;
        Mon, 30 Apr 2012 16:03:30 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-91-188.pppoe.mtu-net.ru. [91.79.91.188])
        by mx.google.com with ESMTPS id ph8sm17979237lab.15.2012.04.30.16.03.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 16:03:28 -0700 (PDT)
Message-ID: <4F9F19D3.7040006@mvista.com>
Date:   Tue, 01 May 2012 03:01:39 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120420 Thunderbird/12.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 08/14] MIPS: lantiq: clear all irqs properly on boot
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org> <1335785589-32532-8-git-send-email-blogic@openwrt.org>
In-Reply-To: <1335785589-32532-8-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkfHr7xkj3z276YLYctUdaP+1qj5DZRu7PAOCa5Eb5NhJr1h4QxBTLAkaMpclvLY5Pcrqd5
X-archive-position: 33102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 30-04-2012 15:33, John Crispin wrote:

> Due to a wrongly placed bracket,

    I don't see a bracket in old code at all.

> the irq modules were not properly reset on
> boot.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   arch/mips/lantiq/irq.c |   11 ++++++-----
>   1 files changed, 6 insertions(+), 5 deletions(-)

> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index d673731..b6b1c72 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -271,12 +271,13 @@ void __init arch_init_irq(void)
>   	if (!ltq_eiu_membase)
>   		panic("Failed to remap eiu memory");
>
> -	/* make sure all irqs are turned off by default */
> -	for (i = 0; i<  5; i++)
> +	/* turn off all irqs by default */
> +	for (i = 0; i<  5; i++) {
> +		/* make sure all irqs are turned off by default */
>   		ltq_icu_w32(0, LTQ_ICU_IM0_IER + (i * LTQ_ICU_OFFSET));
> -
> -	/* clear all possibly pending interrupts */
> -	ltq_icu_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));
> +		/* clear all possibly pending interrupts */
> +		ltq_icu_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));
> +	}
>
>   	mips_cpu_irq_init();

WBR, Sergei
