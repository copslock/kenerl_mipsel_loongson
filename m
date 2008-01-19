Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jan 2008 19:12:57 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:51857 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20037072AbYASTMr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Jan 2008 19:12:47 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JGJ7U-0005h4-00; Sat, 19 Jan 2008 20:12:44 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 0D8E0C2F85; Sat, 19 Jan 2008 20:12:41 +0100 (CET)
Date:	Sat, 19 Jan 2008 20:12:41 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080119191240.GA17902@alpha.franken.de>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <20080117082741.GA2586@paradigm.rfc822.org> <20080117151052.GA12457@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080117151052.GA12457@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Jan 17, 2008 at 03:10:52PM +0000, Ralf Baechle wrote:
> On Thu, Jan 17, 2008 at 09:27:41AM +0100, Florian Lohoff wrote:
> 
> > > this kills my IP28 after a few seconds. If I drop rdhwr or sync the
> > > machine hasn't locked up after running for several minutes. Looks
> > > like we are hiting a strange condition.
> > > 
> > > This sort of code could be found in glibc 2.7 all over the place...
> > > 
> > > Thomas.
> > > 
> > > PS: Using rdhwr_noopt doesn't make a difference...
> > 
> > Kills my ip28 after 2 seconds ...
> 
> Doesn't harm IP27.  I even tried running two copies running in parallel.

IP28 only locks up if spin() spans two I-cache lines. The lockup also
happens if I use a different reserved instruction and skip it via 
SIGILL handler. As I don't have a working compiler/assembler for Irix
I couldn't check, if this lockup also happens with Irix.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
