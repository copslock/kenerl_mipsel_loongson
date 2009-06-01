Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:10:28 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41286 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023445AbZFASKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:10:17 +0100
Received: by ewy19 with SMTP id 19so8322936ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:10:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DwTDCDoj8Cxpw/J3KwT3ybz+mydC2GbgvmCtDip2sfw=;
        b=xg656avkXYxUUjB0+tPZMRn/h8nHfyUSFNCuNuRnk/+5P0XM/4ul/Vj3dW9Xpd45Th
         UoXknm+3gmwRhcqXxmog3iPhjeL3sTonG+mHiVy2TJ1xO6cS/vajO3Dr9Lz0421XYHXp
         wwsST4ukfM5i7C0gCTXOVZNbmqzRnJVdkFK6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oMBozc66Uku/K09tto+VT9grBEs19/TqsP9R7ZGk3019zkPeDy2SLk8+llobeBXDL7
         stHsvyRkxga8DK4xN8ucQiS5abqKxDUC0O0wVxy/1wfPV84KkCGgWQTpH+C4ZVd4qnaP
         M1cjgynyFpl1JX9rZdE9PDsMCdu8tRL6al4r4=
Received: by 10.210.33.3 with SMTP id g3mr4380033ebg.27.1243879811241;
        Mon, 01 Jun 2009 11:10:11 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm60411eye.6.2009.06.01.11.10.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:10:10 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 03/10] bcm63xx: convert bcm63xx_enet to netdev ops.
Date:	Mon, 1 Jun 2009 20:10:08 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-4-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-4-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012010.09162.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:51 Maxime Bizon, vous avez écrit :
> This patch makes bcm63xx_enet driver use netdevice ops.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  drivers/net/bcm63xx_enet.c |   24 ++++++++++++++----------
>  1 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
> index 20e08ef..36324b3 100644
> --- a/drivers/net/bcm63xx_enet.c
> +++ b/drivers/net/bcm63xx_enet.c
> @@ -1551,6 +1551,19 @@ static void bcm_enet_hw_preinit(struct bcm_enet_priv
> *priv) enet_writel(priv, val, ENET_MIBCTL_REG);
>  }
>
> +static const struct net_device_ops bcm_enet_ops = {
> +	.ndo_open		= bcm_enet_open,
> +	.ndo_stop		= bcm_enet_stop,
> +	.ndo_start_xmit		= bcm_enet_start_xmit,
> +	.ndo_get_stats		= bcm_enet_get_stats,
> +	.ndo_set_mac_address	= bcm_enet_set_mac_address,
> +	.ndo_set_multicast_list = bcm_enet_set_multicast_list,
> +	.ndo_do_ioctl		= bcm_enet_ioctl,
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	.ndo_poll_controller = bcm_enet_netpoll,
> +#endif
> +};
> +
>  /*
>   * allocate netdevice, request register memory and register device.
>   */
> @@ -1716,17 +1729,8 @@ static int __devinit bcm_enet_probe(struct
> platform_device *pdev) enet_writel(priv, 0, ENET_MIB_REG(i));
>
>  	/* register netdevice */
> -	dev->open = bcm_enet_open;
> -	dev->stop = bcm_enet_stop;
> -	dev->hard_start_xmit = bcm_enet_start_xmit;
> -	dev->get_stats = bcm_enet_get_stats;
> -	dev->set_mac_address = bcm_enet_set_mac_address;
> -	dev->set_multicast_list = bcm_enet_set_multicast_list;
> +	dev->netdev_ops = &bcm_enet_ops;
>  	netif_napi_add(dev, &priv->napi, bcm_enet_poll, 16);
> -	dev->do_ioctl = bcm_enet_ioctl;
> -#ifdef CONFIG_NET_POLL_CONTROLLER
> -	dev->poll_controller = bcm_enet_netpoll;
> -#endif
>
>  	SET_ETHTOOL_OPS(dev, &bcm_enet_ethtool_ops);



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
