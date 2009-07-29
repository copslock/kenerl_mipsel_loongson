Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2009 10:10:28 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:63005 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491989AbZG2IKX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Jul 2009 10:10:23 +0200
Received: by ewy12 with SMTP id 12so378395ewy.0
        for <multiple recipients>; Wed, 29 Jul 2009 01:10:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lI8tUu0d9YgODybx+F+SjMXl8KAdE6UFsvq2aXaMPjM=;
        b=UxLo4M5ZwFUcnevWkEtmbrd/Gvct7t3Dc0HlnqyW9gPCi8wF9XRlRuet74vulsai2c
         OWO0q/M3Whhu7tN9RXbDJmEzZ+8kH0iD1U4tlyHfYFBlXxReMRwcNPNoMEiTcKT3d5lP
         qOvmy/O+HM3hJIYS6u4Q2XP2gE2R7CUTUlegQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oajUnA9gFhlR8TG0/dLE0Nq9lJqRm2dZfF/3D8ygydyqB5TaMee/bYsnnOpeOBh7Rw
         iTGGXiT/i7tJ4VXofIQFCMHBMeioxelSIB4niDUWIitcw7GNr7WKGj26+83q/oJidXjj
         ZEbpNKGSwPBzyyh6WKjV+oeaGAJWMj3M3QRjM=
Received: by 10.210.11.17 with SMTP id 17mr7941536ebk.92.1248855015008;
        Wed, 29 Jul 2009 01:10:15 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 7sm1643412eyb.52.2009.07.29.01.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 01:10:12 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 1/4] alchemy: register au1000_eth as a platform driver  part one
Date:	Wed, 29 Jul 2009 10:10:09 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200907282300.14118.florian@openwrt.org> <f861ec6f0907290015v34d277beh18efed6aac10aa79@mail.gmail.com>
In-Reply-To: <f861ec6f0907290015v34d277beh18efed6aac10aa79@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200907291010.09526.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Wednesday 29 July 2009 09:15:52 Manuel Lauss, vous avez écrit :
> Hi Florian,
>
> On Tue, Jul 28, 2009 at 11:00 PM, Florian Fainelli<florian@openwrt.org> wrote:
> > --- a/arch/mips/alchemy/common/platform.c
> > +++ b/arch/mips/alchemy/common/platform.c
> > @@ -331,6 +331,61 @@ static struct platform_device pbdb_smbus_device = {
> >  };
> >  #endif
> >
> > +/* All Alchemy board have at least one Ethernet MAC */
>
> Au1200/1300 don't have a MAC (unfortunately, IMO).

Right.

>
> >  static int __init au1xxx_platform_init(void)
> >  {
> >        unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
> > -       int i;
> > +       int i, ni;
> >
> >        /* Fill up uartclk. */
> >        for (i = 0; au1x00_uart_data[i].flags; i++)
> >                au1x00_uart_data[i].uartclk = uartclk;
> >
> > +       /* Register second MAC if enabled in pinfunc */
> > +#ifndef CONFIG_SOC_AU1100
> > +        ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
> > +        if (!(ni + 1))
> > +               platform_device_register(&au1xxx_eth1_device);
> > +#endif
> > +
>
> This won't work on Au1200/Au1300 since their SYS_PINFUNC register
> has a different bit layout.
>
>
> And you already know that I'm not very fond of alchemy/common/platform.c
> ;-) I still think you should add appropriate MAC platform information to
> the boards which actually use it.

Yes I know ;) I was just wanting to get this out quickly before you kill platform.c

I will make the au1000-eth devices be registered on a per-board basis.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
