Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 00:25:01 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:5048 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225195AbTBGAZA>;
	Fri, 7 Feb 2003 00:25:00 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h16MP6G8025142;
	Thu, 6 Feb 2003 14:25:07 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA23045; Fri, 7 Feb 2003 11:24:54 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h170Os8G007942;
	Fri, 7 Feb 2003 11:24:55 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h170OrDY007940;
	Fri, 7 Feb 2003 11:24:53 +1100
Date: Fri, 7 Feb 2003 11:24:53 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Clausen <clausen@melbourne.sgi.com>,
	Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030207002453.GG1278@pureza.melbourne.sgi.com>
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix> <20030204223930.GD27302@pureza.melbourne.sgi.com> <20030204231203.GY16674@bogon.ms20.nix> <20030204231909.GE27302@pureza.melbourne.sgi.com> <20030204234529.GZ16674@bogon.ms20.nix> <20030204235543.GG27302@pureza.melbourne.sgi.com> <20030205000734.GA16674@bogon.ms20.nix> <20030205001911.GH27302@pureza.melbourne.sgi.com> <20030206175333.A22327@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206175333.A22327@linux-mips.org>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 06, 2003 at 05:53:33PM +0100, Ralf Baechle wrote:
> > I think SystemPartition is ignored (haven't been able to see any
> > evidence to the contrary... I should look in the source...)
> 
> SystemPartition is to be used by the bootloader, that is sash in SGI's case.

AFAICT, sash ignores SystemPartition here.

> > BTW, I think file system labels are a much better way of identifying FSs.
> 
> ARC dates back more than 10 years back.  It was written with PC partitions
> and NT as OS in mind.  So don't expect fancy concepts or sanity ;-)

I'm talking about linux.  Linux should default to "root=rootfs", or
something.  If linux installers set labels, that is.

> The ARC code is also used by non-SGI systems and on some of those using a
> non-standard variables is a bit of a pita.
> 
>   SystemPartition	The default path for the system partition.

What's the "system partition"?  I think this is an Irix thing,
but I don't have any evidence.

> Btw, device names like dksc(0,1,2) came from SGI's / MIPS's pre-ARC firmware
> so are deprecated since 10 years.  Some things just don't want to die.

It requires a lot less typing ;)

Cheers,
Andrew
