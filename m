Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:08:09 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39870 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023376AbZFASIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:08:02 +0100
Received: by ewy19 with SMTP id 19so8321366ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:07:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IjcI12sqBxqY1TwjGQhR/SmSLkmtSuRH2NNfHziodes=;
        b=kIhia/p6UNccNflgwVfFgcZt88e/PuvpxZtspYKN+b4rruqz9PZPyq4uVJHEdzgRAj
         NL4EJGO49ic65gYDLYfAKjCXHUwjo9FCbZMJn45qqHNIO+jRHhIq4nIyF53R15LBdT48
         J9328K7vgxDnC+p8B4Ptduz672INz4G3ssCtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FzO76LPIKEg4+sT300IxxUtFR+E1Pd8FUpZkBxAZs+yy2ReavEoGzxc3LJGLYdppcY
         904+TI0lRzv+lxZoUTE+U3gkV1qYVXs1l/Co+y3OnwqGUdzxsVneGA1hEgfs2W/2rKFx
         wbjpsEfeOaKyco3eJHCep8wIeCECQ8QN02Ba8=
Received: by 10.210.60.8 with SMTP id i8mr3643874eba.35.1243879676573;
        Mon, 01 Jun 2009 11:07:56 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 23sm127157eya.59.2009.06.01.11.07.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:07:55 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 01/10] bcm63xx: remove duplicate init fields.
Date:	Mon, 1 Jun 2009 20:07:53 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-2-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-2-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012007.53758.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:49 Maxime Bizon, vous avez écrit :
> This patch removes duplicate init fields in resource.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/bcm63xx/dev-enet.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
> index 51c2e5a..188fa66 100644
> --- a/arch/mips/bcm63xx/dev-enet.c
> +++ b/arch/mips/bcm63xx/dev-enet.c
> @@ -42,12 +42,10 @@ static struct resource enet0_res[] = {
>  	},
>  	{
>  		.start		= -1, /* filled at runtime */
> -		.start		= IRQ_ENET0_RXDMA,
>  		.flags		= IORESOURCE_IRQ,
>  	},
>  	{
>  		.start		= -1, /* filled at runtime */
> -		.start		= IRQ_ENET0_TXDMA,
>  		.flags		= IORESOURCE_IRQ,
>  	},
>  };
