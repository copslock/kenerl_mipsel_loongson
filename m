Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:13:17 +0100 (WEST)
Received: from ey-out-1920.google.com ([74.125.78.144]:6982 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025017AbZFASMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 19:12:32 +0100
Received: by ey-out-1920.google.com with SMTP id 4so446864eyg.54
        for <multiple recipients>; Mon, 01 Jun 2009 11:12:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hdixYAEPoHYNUX0Rnf66BF0m91oASGcYN9fTaoaoDJA=;
        b=VY9ntilx+1uPu+8LvEL2VkJh2yjKap8I1oYHHoiaYzEdhpVd0OOFX/6Xr6DBTE/h2T
         iYkNq2/8mF1zq5mviDVxVFcoaRTYz9SgAv4bbdhQ7rya/9DIK7u4t8kQCVp3iQqCOtNX
         MwpcR9neprS7vXl53ouFE8aloeakGIiBrsavY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tpfaGa15peAPoo76w+wUFLS5BcP2fqQLp9f6AaXULShWXXmtUGnNaey+pW+gaADJL2
         5416lUgp4uD8H02MJcNF19jAEZpMHI4O/WNRK9vcF0hFvfOvjBDVuTI37jAedSqguwPk
         ptng8N+g3EqQOiAvSQd3KAMNtAZnZsL4JowKQ=
Received: by 10.210.33.15 with SMTP id g15mr4376020ebg.42.1243879949749;
        Mon, 01 Jun 2009 11:12:29 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm115344eyf.48.2009.06.01.11.12.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:12:27 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 09/10] bcm63xx: don't set bus type in ehci-bcm63xx.c
Date:	Mon, 1 Jun 2009 20:12:23 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-10-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-10-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012012.24267.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:57 Maxime Bizon, vous avez écrit :
> The platform code already sets the bus type, so don't do it.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Acked-by: Florian Fainelli <florian@openwrt.org>


> ---
>  drivers/usb/host/ehci-bcm63xx.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-bcm63xx.c
> b/drivers/usb/host/ehci-bcm63xx.c index 0aba0f9..8a62c0a 100644
> --- a/drivers/usb/host/ehci-bcm63xx.c
> +++ b/drivers/usb/host/ehci-bcm63xx.c
> @@ -145,7 +145,6 @@ static struct platform_driver ehci_hcd_bcm63xx_driver =
> { .driver		= {
>  		.name	= "bcm63xx_ehci",
>  		.owner	= THIS_MODULE,
> -		.bus	= &platform_bus_type
>  	},
>  };



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
