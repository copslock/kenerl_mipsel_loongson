Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 21:55:17 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:40137 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1494089AbZKSUzK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Nov 2009 21:55:10 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1NBE1x-0000aI-00; Thu, 19 Nov 2009 21:55:05 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 25E7DC374C; Thu, 19 Nov 2009 21:55:03 +0100 (CET)
Date:	Thu, 19 Nov 2009 21:55:03 +0100
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Disable EARLY_PRINTK on IP22 to make the system boot
Message-ID: <20091119205503.GA17383@alpha.franken.de>
References: <20091119164009.GA15038@deprecation.cyrius.com> <90edad820911190856m62275563yf610c4a7dcdd1f67@mail.gmail.com> <20091119170051.GX31954@deprecation.cyrius.com> <90edad820911191205h77f298b4u788039abff2db1d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90edad820911191205h77f298b4u788039abff2db1d0@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Nov 19, 2009 at 10:05:06PM +0200, Dmitri Vorobiev wrote:
> On Thu, Nov 19, 2009 at 7:00 PM, Martin Michlmayr <tbm@cyrius.com> wrote:
> > * Dmitri Vorobiev <dmitri.vorobiev@gmail.com> [2009-11-19 18:56]:
> >> > Some Debian users have reported that the kernel hangs early
> >> > during boot on some IP22 systems.  Thomas Bogendoerfer found
> >> > that this is due to a "bad interaction between CONFIG_EARLY_PRINTK
> >> > and overwritten prom memory during early boot".  Since there's
> >> > no fix yet, disable CONFIG_EARLY_PRINTK for now.
> >>
> >> Never experienced anything like that, although I'm quite extensively
> >> using IP22 with recent kernels. Any details on the hangs?
> >
> > It doesn't happen on all machines.  It has been reported e.g. with an
> > Indigo2.  See http://bugs.debian.org/507557
> 
> Interesting, thanks. Good to know that, since one of my machines is Indigo2.

I guess is depending on RPOM version and installed memory. I haven't
figured out exactly which parts get overwritten, but since we completely
ignore ARCS reservered memory and still use ARCS prom calls, it's not
a real safe game we are doing.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
