Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 08:45:59 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:12488 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133404AbWEEHpq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2006 08:45:46 +0100
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k457jcCQ005595;
	Fri, 5 May 2006 09:45:39 +0200 (MEST)
Date:	Fri, 5 May 2006 09:45:38 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Tom Rini <trini@kernel.crashing.org>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	Tim Bird <tim.bird@am.sony.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment
 var
In-Reply-To: <20060504233429.GD12676@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.62.0605050940410.649@pademelon.sonytel.be>
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de>
 <20060504210449.GA12676@smtp.west.cox.net> <20060504230647.GA3465@linux-mips.org>
 <20060504231432.GC12676@smtp.west.cox.net> <20060504233429.GD12676@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 May 2006, Tom Rini wrote:
> On Thu, May 04, 2006 at 04:14:32PM -0700, Tom Rini wrote:
> > On Fri, May 05, 2006 at 12:06:47AM +0100, Ralf Baechle wrote:
> > > On Thu, May 04, 2006 at 02:04:49PM -0700, Tom Rini wrote:
> > > 
> > > > Let me ask a stupid question.  With all of the ways to otherwise do a
> > > > cross compile, why a config option on MIPS?  ARM*/SH*, which are at
> > > > least as likely to not be native-compiled, don't do that.  Just
> > > > something I've always wondered, really.
> > > 
> > > Having such information in an environment variable is imho terribly
> > > inelegant, having to pass it on the command line for each make invocation
> > > is terrible abuse for the fingertips so I went for this option which makes

You can make it so that you can use both, right? This is what the suggested
patch does. No CROSS_COMPILE in env or on the make command line means a native
compilation.

> > > the makefile pick the right prefix.
> > 
> > I don't suppose you'd be willing to front pushing that to the rest of
> > the world then, would you?  Inconsistency is more of a problem for me
> > than changing any of my scripts to use something else :)
> 
> ... I forgot this doesn't take a string value of what to use but
> hard-coded options.

So let it take a string option, and make it generic.

But on second thought: config options are part of the target configuration,
while CROSS_COMPILE= is part of the host configuration, so IMHO it doesn't
belong in Kconfig. I.e. do you want to have CONFIG_CROSS_COMPILE set in your
defconfig? Yes or no, depending on whether you do cross-compilations or not. So
you cannot simply take a defconfig, you'll have to modify it for your host
setup.

So I'd prefer to keep the CROSS_COMPILE, like other arches do.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
