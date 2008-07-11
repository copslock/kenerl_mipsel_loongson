Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 22:00:27 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:57521 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20033388AbYGKVAY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 22:00:24 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KHPj6-0002X4-00; Fri, 11 Jul 2008 23:00:24 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 98016C2EBF; Fri, 11 Jul 2008 22:56:28 +0200 (CEST)
Date:	Fri, 11 Jul 2008 22:56:28 +0200
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] IP22: Add platform device for Indy volume buttons
Message-ID: <20080711205628.GA7840@alpha.franken.de>
References: <20080711183432.1CEEDC2EB7@solo.franken.de> <Pine.LNX.4.64.0807112107360.7822@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807112107360.7822@anakin>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2008 at 09:09:31PM +0200, Geert Uytterhoeven wrote:
> On Fri, 11 Jul 2008, Thomas Bogendoerfer wrote:
> > --- a/arch/mips/sgi-ip22/ip22-platform.c
> > +++ b/arch/mips/sgi-ip22/ip22-platform.c
> > @@ -182,3 +182,14 @@ static int __init sgi_hal2_devinit(void)
> >  }
> >  
> >  device_initcall(sgi_hal2_devinit);
> > +
> > +static int __init sgi_button_devinit(void)
> > +{
> > +	if (ip22_is_fullhouse())
> > +		return 0; /* full house has no volume buttons */
> > +
> > +	return IS_ERR(platform_device_register_simple("sgiindybtns",
> > +						      0, NULL, 0));
>                                                       ^
> Shouldn't the instance id be -1, as there can be only one?
> (cfr. Documentation/driver-model/platform.txt)

thanks. I'll send an updated patch asap.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
