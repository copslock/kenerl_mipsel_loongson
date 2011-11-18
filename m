Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 09:53:09 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:54339 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903545Ab1KRIxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 09:53:02 +0100
Received: by bkat2 with SMTP id t2so4126359bka.36
        for <multiple recipients>; Fri, 18 Nov 2011 00:52:56 -0800 (PST)
Received: by 10.204.148.67 with SMTP id o3mr2294773bkv.130.1321606375766;
        Fri, 18 Nov 2011 00:52:55 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-239-170.pppoe.mtu-net.ru. [85.141.239.170])
        by mx.google.com with ESMTPS id j9sm105965bkd.2.2011.11.18.00.52.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 00:52:54 -0800 (PST)
Message-ID: <4EC61CB0.3080205@mvista.com>
Date:   Fri, 18 Nov 2011 12:52:00 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] NET: MIPS: lantiq: return value of request_irq was
 not handled gracefully
References: <1321548165-22563-1-git-send-email-blogic@openwrt.org> <1321548165-22563-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1321548165-22563-3-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15187

Hello.

On 17-11-2011 20:42, John Crispin wrote:

> The return values of request_irq() were not checked leading to the following
> error message.

> drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
> drivers/net/ethernet/lantiq_etop.c:368:15: warning: ignoring return value of 'request_irq', declared with attribute warn_unused_result
> drivers/net/ethernet/lantiq_etop.c:377:15: warning: ignoring return value of 'request_irq', declared with attribute warn_unused_result

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Acked-by: David S. Miller<davem@davemloft.net>
> ---
>   drivers/net/ethernet/lantiq_etop.c |   14 ++++++++------
>   1 files changed, 8 insertions(+), 6 deletions(-)

> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index 9fd6779..dddb9fe 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
[...]
> @@ -364,21 +365,22 @@ ltq_etop_hw_init(struct net_device *dev)
>
>   		if (IS_TX(i)) {
>   			ltq_dma_alloc_tx(&ch->dma);
> -			request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,
> +			err = request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,

    BTW, IRQF_DISABLED is a nop now, so could have dropped it...

>   				"etop_tx", priv);
>   		} else if (IS_RX(i)) {
>   			ltq_dma_alloc_rx(&ch->dma);
>   			for (ch->dma.desc = 0; ch->dma.desc<  LTQ_DESC_NUM;
>   					ch->dma.desc++)
>   				if (ltq_etop_alloc_skb(ch))
> -					return -ENOMEM;
> +					err = -ENOMEM;
>   			ch->dma.desc = 0;
> -			request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,
> +			err = request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,

    Same here.

WBR, Sergei
