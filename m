Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:11:42 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50307 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024213AbZFASLg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:11:36 +0100
Received: by ewy19 with SMTP id 19so8324030ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:11:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eroIrH6omSQlCQsafb2P2iHVxams7VOebVEgekIiksc=;
        b=nJMSImrAy6wHr/qGbNugoVFtAyQHgFsOdlxfczJXzOJhMh3A+927AKQOySC13OkFE+
         X4+SeeR3KY/R5umGiARKdJgtYm56gFxhc559E86p65+3NklVb7Aytq9hmnRVRV2zxZkJ
         GQQ4XVE16zB/jN9NMgnGr+EKXYo5yblbkzS+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AGUPGhCs5CJUEvIYTNgxyPVV2zTHfgH9gPDQErfpJRErdOeKuSYK2/sjFUjgVN8bNq
         DJRNQSvxG/wPPgs6OnTOwelZCdgBxCbESD6cHn7ICv+3LwdLQ1A5BHRvFFE42VCRrvUI
         GxWroawalGSuPw+ougYZU6nu15FVvqQGGLkxQ=
Received: by 10.210.79.9 with SMTP id c9mr2356471ebb.75.1243879890105;
        Mon, 01 Jun 2009 11:11:30 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm58557eyg.57.2009.06.01.11.11.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:11:27 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 05/10] bcm63xx: use platform_get_irq in ohci-bcm63xx.c
Date:	Mon, 1 Jun 2009 20:11:23 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-6-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-6-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012011.23576.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:53 Maxime Bizon, vous avez écrit :
> As requested by USB maintainer, use platform_get_irq instead of
> platform_get_resource.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>
> ---
>  drivers/usb/host/ohci-bcm63xx.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-bcm63xx.c
> b/drivers/usb/host/ohci-bcm63xx.c index 74f432f..f0e4639 100644
> --- a/drivers/usb/host/ohci-bcm63xx.c
> +++ b/drivers/usb/host/ohci-bcm63xx.c
> @@ -58,15 +58,15 @@ static const struct hc_driver ohci_bcm63xx_hc_driver =
> {
>
>  static int __devinit ohci_hcd_bcm63xx_drv_probe(struct platform_device
> *pdev) {
> -	struct resource *res_mem, *res_irq;
> +	struct resource *res_mem;
>  	struct usb_hcd *hcd;
>  	struct ohci_hcd *ohci;
>  	u32 reg;
> -	int ret;
> +	int ret, irq;
>
>  	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res_mem || !res_irq)
> +	irq = platform_get_irq(pdev, 0);
> +	if (!res_mem || irq < 0)
>  		return -ENODEV;
>
>  	if (BCMCPU_IS_6348()) {
> @@ -114,7 +114,7 @@ static int __devinit ohci_hcd_bcm63xx_drv_probe(struct
> platform_device *pdev) OHCI_QUIRK_FRAME_NO;
>  	ohci_hcd_init(ohci);
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
