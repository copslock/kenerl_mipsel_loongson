Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:13:41 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62433 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025041AbZFASMv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:12:51 +0100
Received: by ewy19 with SMTP id 19so8324904ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:12:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4wc4uzcAxNxN4F9ULcIYFLjDTmV0aCdZwDUkwvcqYnU=;
        b=lqsdrKD0RKApWQF59hOPdws1NBK21/trqD3JNWBcOg7hMPUd2XpBAPI7fcID1H+vJY
         RY59f9urQHTjogeDmPDg7GSVIilhYcd28hntBj1bau0D0xIzeWAVqWrxQasntCqVTFtJ
         YmcuzRuQjjGN8Q0f0/Xt1BHln3NKL8TSuIFxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VXbIC5viDjIUjNZOgJO+xlhYWrXMMCvigBcRD35GBD/BOZK2C5IU103s0N3RISn4lY
         FB9Pmw/7WC2rLtDSqVrG+0qFiVOlWR4w/M+3P2of1EUmJLglIh63EGG1xqCgA66A1SG7
         Liw9zue/gKso6sn8+QgQjXWbM1aPFubQuo5sQ=
Received: by 10.210.71.12 with SMTP id t12mr3654603eba.68.1243879965397;
        Mon, 01 Jun 2009 11:12:45 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm56491eyg.44.2009.06.01.11.12.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:12:44 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 10/10] bcm63xx: clarify meaning of the magical value in ehci-bcm63xx.c
Date:	Mon, 1 Jun 2009 20:12:41 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-11-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-11-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012012.42372.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:58 Maxime Bizon, vous avez écrit :
> USB maintainer asked for clarification of the magic value used during
> USB init. Be clear about the source of it.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  drivers/usb/host/ehci-bcm63xx.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-bcm63xx.c
> b/drivers/usb/host/ehci-bcm63xx.c index 8a62c0a..5a03fdd 100644
> --- a/drivers/usb/host/ehci-bcm63xx.c
> +++ b/drivers/usb/host/ehci-bcm63xx.c
> @@ -78,7 +78,9 @@ static int __devinit ehci_hcd_bcm63xx_drv_probe(struct
> platform_device *pdev) reg |= USBH_PRIV_SWAP_EHCI_ENDN_MASK;
>  	bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
>
> -	/* don't ask... */
> +	/* the magic value comes for the original vendor BSP and is
> +	 * needed for USB to work. Datasheet does not help, so the
> +	 * magic value is used as-is. */
>  	bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
>
>  	hcd = usb_create_hcd(&ehci_bcm63xx_hc_driver, &pdev->dev, "bcm63xx");



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
