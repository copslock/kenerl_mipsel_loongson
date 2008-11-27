Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 11:39:47 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:9446 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S23948808AbYK0Ljk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2008 11:39:40 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1L5fDe-0005Qg-00; Thu, 27 Nov 2008 12:39:38 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id DFFD2C3145; Thu, 27 Nov 2008 12:34:53 +0100 (CET)
Date:	Thu, 27 Nov 2008 12:34:53 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Remove unused header file gio.h
Message-ID: <20081127113453.GA7618@alpha.franken.de>
References: <1227706472-16219-1-git-send-email-dmitri.vorobiev@movial.fi> <20081127091619.GA6255@alpha.franken.de> <43787.88.114.226.209.1227781466.squirrel@webmail.movial.fi> <20081127103706.GA6929@alpha.franken.de> <20081127112234.GA20189@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081127112234.GA20189@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Nov 27, 2008 at 11:22:34AM +0000, Ralf Baechle wrote:
> On Thu, Nov 27, 2008 at 11:37:06AM +0100, Thomas Bogendoerfer wrote:
> 
> > first step is to introduce GIO devices similair to PCI devices. My
> > current working GIO device is solid impact. I also looked at
> > supporting Phobos G160 cards, but the current set of 2114x drivers
> > is not useable for that...
> > 
> > The big missing thing in the GIO framework right now is a bullet proof
> > detection for non standard GIO cards, like newport and XZ cards. They
> > don't provide ID information...
> 
> So the resulting code will be a mix of normal probing bus code and
> something like "GIO platform devices" which are just added if we somehow
> "know" they're there?  SGI never stops to amaze me ...

Newport and XZ are probeable somehow, PROM and IRIX gfxinit are able
to do that. I want to integrate the documented probing and the special
probes into the GIO framework.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
