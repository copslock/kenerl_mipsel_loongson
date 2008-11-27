Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 10:37:33 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:63459 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S23948104AbYK0Kh0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2008 10:37:26 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1L5eFP-000335-00; Thu, 27 Nov 2008 11:37:23 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id BE048C313F; Thu, 27 Nov 2008 11:37:06 +0100 (CET)
Date:	Thu, 27 Nov 2008 11:37:06 +0100
To:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Remove unused header file gio.h
Message-ID: <20081127103706.GA6929@alpha.franken.de>
References: <1227706472-16219-1-git-send-email-dmitri.vorobiev@movial.fi> <20081127091619.GA6255@alpha.franken.de> <43787.88.114.226.209.1227781466.squirrel@webmail.movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43787.88.114.226.209.1227781466.squirrel@webmail.movial.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Nov 27, 2008 at 12:24:26PM +0200, Vorobiev Dmitri wrote:
> > On Wed, Nov 26, 2008 at 03:34:32PM +0200, Dmitri Vorobiev wrote:
> >> Grepping reveals that arch/mips/include/asm/sgi/gio.h is
> >> not used by anyone, so let's delete the orphan header.
> >>
> >> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> >> ---
> >
> > NAK, I have work in progress, which adds GIO devices and uses this
> > file.
> >
> 
> That's interesting news! May I ask you which ones you're working on?

first step is to introduce GIO devices similair to PCI devices. My
current working GIO device is solid impact. I also looked at
supporting Phobos G160 cards, but the current set of 2114x drivers
is not useable for that...

The big missing thing in the GIO framework right now is a bullet proof
detection for non standard GIO cards, like newport and XZ cards. They
don't provide ID information...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
