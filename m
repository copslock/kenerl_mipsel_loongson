Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:09:19 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:45526 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023379AbZFASJL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:09:11 +0100
Received: by ewy19 with SMTP id 19so8322152ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:09:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eqSrgNkG+3/6PvNeluhcdY+QMGw+vKiLIfzcu2FV5ko=;
        b=M2TpWSGr6zukVX71gEQg+Iak1QlscCmUGLzIXrvxg1de1kXty0l8lBeHEeHpzwCPbs
         spZBIV7/ztFiK7itvKaOBxJrD/Hgh9pGa6Sz5Xt1Df4+leKENuNkxErdDcWXNgby1ZQb
         JjoUE3bYyEFOu7js+NdIYE8ZJWWTIYz0q55JA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Bqh02IpC2C+QHVtOboapAbqpDqalawWyQjfZJTE4xHvux+AaekGnuz93ZI0VGLxpVc
         bfHfadwnIl3GSsM3VOG52CCXy5rM/DotTF50FWmNoTDPaIC0UAZm2eMEURpg4P4nbxJe
         AYwpiLV5QUFwP1XqIPJG2zhJ+QFfncad8HtlQ=
Received: by 10.211.180.15 with SMTP id h15mr1200268ebp.97.1243879745761;
        Mon, 01 Jun 2009 11:09:05 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm7773eyg.17.2009.06.01.11.09.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:09:04 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 02/10] bcm63xx: use napi_complete instead of __napi_complete
Date:	Mon, 1 Jun 2009 20:09:02 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-3-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-3-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012009.03194.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:50 Maxime Bizon, vous avez écrit :
> We're not disabling IRQ, so we must call the irq safe flavour of
> napi_complete.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Tested-by: Florian Fainelli <florian@openwrt.org>
Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  drivers/net/bcm63xx_enet.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
> index a91f909..20e08ef 100644
> --- a/drivers/net/bcm63xx_enet.c
> +++ b/drivers/net/bcm63xx_enet.c
> @@ -450,7 +450,7 @@ static int bcm_enet_poll(struct napi_struct *napi, int
> budget)
>
>  	/* no more packet in rx/tx queue, remove device from poll
>  	 * queue */
> -	__napi_complete(napi);
> +	napi_complete(napi);
>
>  	/* restore rx/tx interrupt */
>  	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
