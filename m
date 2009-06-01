Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:12:54 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50307 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024116AbZFASMJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:12:09 +0100
Received: by mail-ew0-f219.google.com with SMTP id 19so8324030ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:12:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=46aFMGEgFNOkmMlgxr3iOions2dAjUyKanwN03FfLO0=;
        b=HG6o9Yum+kmsGvoGg3yNZZxu2n5ce7yhOpnvGObV5R4Cpivk+pqelazMYuzrh6n2p1
         Rd9vvqxX/5wmKMrWRzTW+KgizZ427xplyD444D8sZ53zjgRXpGtGmPDvDkg5d9nDFFjA
         eIVfNjEPPwVGCkx0FIwAESA0U6xRbggmEeOzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IZm3xZnSiG/7cNvP5aRmDtFrbKWwhv2+Ru2imzHjMko5kW+i9tuVSpgNSOmFaPWgn2
         ENNJmpWlulCZxfRot86M/wKDKOxC696PRpkh+igC/qXkMs1KLKrInDQyxhG++yEW/+3U
         SSfg5/DKE/faVjFcahlixUV3jtQdZ3/K2bvfE=
Received: by 10.210.33.15 with SMTP id g15mr6742035ebg.63.1243879929446;
        Mon, 01 Jun 2009 11:12:09 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm198371eyh.50.2009.06.01.11.12.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:12:08 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 08/10] bcm63xx: use platform_get_irq in ehci-bcm63xx.c
Date:	Mon, 1 Jun 2009 20:12:05 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-9-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-9-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012012.06132.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:56 Maxime Bizon, vous avez écrit :
> As requested by USB maintainer, use platform_get_irq instead of
> platform_get_resource.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  drivers/usb/host/ehci-bcm63xx.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-bcm63xx.c
> b/drivers/usb/host/ehci-bcm63xx.c index 2fef571..0aba0f9 100644
> --- a/drivers/usb/host/ehci-bcm63xx.c
> +++ b/drivers/usb/host/ehci-bcm63xx.c
> @@ -62,15 +62,15 @@ static const struct hc_driver ehci_bcm63xx_hc_driver =
> {
>
>  static int __devinit ehci_hcd_bcm63xx_drv_probe(struct platform_device
> *pdev) {
> -	struct resource *res_mem, *res_irq;
> +	struct resource *res_mem;
>  	struct usb_hcd *hcd;
>  	struct ehci_hcd *ehci;
>  	u32 reg;
> -	int ret;
> +	int ret, irq;
>
>  	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res_mem || !res_irq)
> +	irq = platform_get_irq(pdev, 0);;
> +	if (!res_mem || irq < 0)
>  		return -ENODEV;
>
>  	reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_REG);
> @@ -109,7 +109,7 @@ static int __devinit ehci_hcd_bcm63xx_drv_probe(struct
> platform_device *pdev) ehci->hcs_params = ehci_readl(ehci,
> &ehci->caps->hcs_params);
>  	ehci->sbrn = 0x20;
>
> -	ret = usb_add_hcd(hcd, res_irq->start, IRQF_DISABLED);
> +	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
>  	if (ret)
>  		goto out2;



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
