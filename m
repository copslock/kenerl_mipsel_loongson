Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:12:29 +0100 (WEST)
Received: from ey-out-1920.google.com ([74.125.78.147]:55347 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024960AbZFASL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 19:11:58 +0100
Received: by ey-out-1920.google.com with SMTP id 4so446786eyg.54
        for <multiple recipients>; Mon, 01 Jun 2009 11:11:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ABTBV+PxGmew6DWQrYZiZkijTxvLHpxV3+ZbJO29VVU=;
        b=BbGDLFjL1PqGZ4xZy/lZbdrzKi+Kwjxx/MN3GrnRXO8clTldbLKaei/nH9U5odadsG
         2dUbX4YTvruQcKelOmairl0cBWK4QbFB1llLCleH/st9ENjVyUN6cEldlKuKK/EGnXRQ
         A9nASw3rOBE3tDfm+8epU1g1U1IarNVhfUz88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jab3sLJ9fnp6x+Jkz+6A22zfQiyJtbMmvYoNQfOx7ah/Y/YyjgJRqUlXo9nciHLCaq
         sGoKrxJm8BCRAEZ3wDkuQ7ACOOZlRQmBpdg7cRADMEBeMfmnHWkjAC9a6zpu2xNM6Chj
         6KldX64y1QtkLtRYULClF2FEPMTYOwd5AJu04=
Received: by 10.210.43.11 with SMTP id q11mr1868958ebq.86.1243879917752;
        Mon, 01 Jun 2009 11:11:57 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 23sm131541eya.59.2009.06.01.11.11.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:11:56 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 07/10] bcm63xx: clarify meaning of the magical value in ohci-bcm63xx.c
Date:	Mon, 1 Jun 2009 20:11:51 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-8-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-8-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012011.52421.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:55 Maxime Bizon, vous avez écrit :
> USB maintainer asked for clarification  of the magic value used during
> USB init. Be clear about the source of it.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>
> ---
>  drivers/usb/host/ohci-bcm63xx.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-bcm63xx.c
> b/drivers/usb/host/ohci-bcm63xx.c index d48c8ac..bd66d5a 100644
> --- a/drivers/usb/host/ohci-bcm63xx.c
> +++ b/drivers/usb/host/ohci-bcm63xx.c
> @@ -85,7 +85,9 @@ static int __devinit ohci_hcd_bcm63xx_drv_probe(struct
> platform_device *pdev) reg &= ~USBH_PRIV_SWAP_OHCI_ENDN_MASK;
>  		reg |= USBH_PRIV_SWAP_OHCI_DATA_MASK;
>  		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
> -		/* don't ask... */
> +		/* the magic value comes for the original vendor BSP
> +		 * and is needed for USB to work. Datasheet does not
> +		 * help, so the magic value is used as-is. */
>  		bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
>  	} else
>  		return 0;



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
