Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:12:06 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50307 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024908AbZFASLn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:11:43 +0100
Received: by mail-ew0-f219.google.com with SMTP id 19so8324030ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:11:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eKGa4Yot+JWaSEOOReU/3bX5RXMzeuSg5RhYmuvDRSU=;
        b=oybneFwzF+Y7K17Cguumzi6zHNj9rHZOJemjBRFst3v7AkO29BkU07QXBzQ6QbZC/M
         87kK25rzzdumE2MwJBTtwc2b5ybsD4p6OQHy9BAfrlBmnIn8U6pBg+01ouubki6THWXI
         1JSUH1XiieOapbdV4Z20VJwcA9fBKhw+wQTxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xRMl1zvprt377MrDJmEIhlWkJqFOxnidCUaWn7vb8WZe94MyIrLQ5SR+K4VQCfiZ/z
         SaRZq76w5oc9qfKlII9GF7Z6MwfvkOC3CdnhNAo5rZUa4yN/dN6SCMbXIn+lP57BWRz0
         52STUFqOQNQN15XtfgXaqzSzq0IsmKVqlKsIE=
Received: by 10.210.41.14 with SMTP id o14mr4332963ebo.73.1243879902699;
        Mon, 01 Jun 2009 11:11:42 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 24sm325249eyx.23.2009.06.01.11.11.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:11:42 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 06/10] bcm63xx: don't set bus type in ohci-bcm63xx.c
Date:	Mon, 1 Jun 2009 20:11:39 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-7-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-7-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012011.40170.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:54 Maxime Bizon, vous avez écrit :
> The platform code already sets the bus type, so don't do it.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  drivers/usb/host/ohci-bcm63xx.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-bcm63xx.c
> b/drivers/usb/host/ohci-bcm63xx.c index f0e4639..d48c8ac 100644
> --- a/drivers/usb/host/ohci-bcm63xx.c
> +++ b/drivers/usb/host/ohci-bcm63xx.c
> @@ -154,7 +154,6 @@ static struct platform_driver ohci_hcd_bcm63xx_driver =
> { .driver		= {
>  		.name	= "bcm63xx_ohci",
>  		.owner	= THIS_MODULE,
> -		.bus	= &platform_bus_type
>  	},
>  };



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
