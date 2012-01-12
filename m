Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2012 12:35:15 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:39032 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901164Ab2ALLfH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2012 12:35:07 +0100
Received: by bkty8 with SMTP id y8so1938972bkt.36
        for <multiple recipients>; Thu, 12 Jan 2012 03:35:01 -0800 (PST)
Received: by 10.204.10.72 with SMTP id o8mr963867bko.92.1326368101755;
        Thu, 12 Jan 2012 03:35:01 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-80-144.pppoe.mtu-net.ru. [91.79.80.144])
        by mx.google.com with ESMTPS id cg2sm10087392bkb.12.2012.01.12.03.34.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 03:35:00 -0800 (PST)
Message-ID: <4F0EC523.7040608@mvista.com>
Date:   Thu, 12 Jan 2012 15:33:55 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH RESEND 15/17] NET: MIPS: lantiq: return value of request_irq
 was not handled gracefully
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org> <1326314674-9899-15-git-send-email-blogic@openwrt.org>
In-Reply-To: <1326314674-9899-15-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 12-01-2012 0:44, John Crispin wrote:

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
> index 9fd6779..659c868 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
[...]
> @@ -364,21 +365,22 @@ ltq_etop_hw_init(struct net_device *dev)
>
>   		if (IS_TX(i)) {
>   			ltq_dma_alloc_tx(&ch->dma);
> -			request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,
> +			err = request_irq(irq, ltq_etop_dma_irq, 0,
>   				"etop_tx", priv);
>   		} else if (IS_RX(i)) {
>   			ltq_dma_alloc_rx(&ch->dma);
>   			for (ch->dma.desc = 0; ch->dma.desc<  LTQ_DESC_NUM;
>   					ch->dma.desc++)
>   				if (ltq_etop_alloc_skb(ch))
> -					return -ENOMEM;
> +					err = -ENOMEM;

   This 'err' will get overwrtitten by subseuent request_irq().

>   			ch->dma.desc = 0;
> -			request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,
> +			err = request_irq(irq, ltq_etop_dma_irq, 0,
>   				"etop_rx", priv);
>   		}
> -		ch->dma.irq = irq;
> +		if (!err)
> +			ch->dma.irq = irq;
>   	}
> -	return 0;
> +	return err;
>   }

WBR, Sergei
