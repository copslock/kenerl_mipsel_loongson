Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 00:19:45 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:61405 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225240AbTBEATo>;
	Wed, 5 Feb 2003 00:19:44 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h14MJoG8032344;
	Tue, 4 Feb 2003 14:19:51 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA28512; Wed, 5 Feb 2003 11:19:38 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h150JCMd028980;
	Wed, 5 Feb 2003 11:19:12 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h150JBTN028978;
	Wed, 5 Feb 2003 11:19:11 +1100
Date: Wed, 5 Feb 2003 11:19:11 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030205001911.GH27302@pureza.melbourne.sgi.com>
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix> <20030204223930.GD27302@pureza.melbourne.sgi.com> <20030204231203.GY16674@bogon.ms20.nix> <20030204231909.GE27302@pureza.melbourne.sgi.com> <20030204234529.GZ16674@bogon.ms20.nix> <20030204235543.GG27302@pureza.melbourne.sgi.com> <20030205000734.GA16674@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205000734.GA16674@bogon.ms20.nix>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 01:07:35AM +0100, Guido Guenther wrote:
> On IP22 the PROM uses SystemPartition to find the kernel/bootloader.
> We set it to something like scsi(0)disk(1)rdisk(0)partition(8) to grab
> it from the vh. Is SystemPartition used differently on IP27?

I think SystemPartition is ignored (haven't been able to see any
evidence to the contrary... I should look in the source...)

> [..snip..]
> > So, we should obviously support OSLoadPartition=/dev/sda1 (=> root=/dev/sda1),
> > but it would also be nice to support OSLoadPartition=dksc(0,1,3).
> Well we could either check if OSLoadPartition matches the linux device
> naming scheme or the other way around and see if it looks like a valid
> device identifier used by the PROM (I'd prefer the later, though) - or
> simply make the OSLoadPartition <-> root= mapping '#ifdef CONFIG_SGI_IP22'.

I think the middle option (the one you prefer) of matching dksc(0,1,3)
and converting it /dev/sda2 is best.  Just, it has to happen after the
hard disks are probed - /dev/sdXY are allocated dynamically (in
a predictable-for-end-user way), so you need to find out what it was
allocated to.  Is this doable in a nice way?

BTW, I think file system labels are a much better way of identifying FSs.

Perhaps this discussion is irrelevant... people who are using
OSLoadPartition to control their bootloader should just add a root=
option.

Cheers,
Andrew
