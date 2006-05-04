Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 22:05:09 +0100 (BST)
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:3249 "HELO
	fed1rmmtao04.cox.net") by ftp.linux-mips.org with SMTP
	id S8133786AbWEDVE5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 22:04:57 +0100
Received: from opus ([68.110.9.227]) by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504210449.VKUZ17501.fed1rmmtao04.cox.net@opus>;
          Thu, 4 May 2006 17:04:49 -0400
Date:	Thu, 4 May 2006 14:04:49 -0700
From:	Tom Rini <trini@kernel.crashing.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Tim Bird <tim.bird@am.sony.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var
Message-ID: <20060504210449.GA12676@smtp.west.cox.net>
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504205517.GF18218@networkno.de>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, May 04, 2006 at 09:55:17PM +0100, Thiemo Seufer wrote:
> Tim Bird wrote:
> > The following patch allows to build using CROSS_COMPILE from the environment.
> > I have an automated system which works like this, but it chokes on MIPS when
> > I use it with (albeit non-standard-named) cross-compiler tools.  An easy
> > workaround I'm using is to put CROSS_COMPILE on the make command line, but it would
> > be nice to use the definition already in the environment when I work
> > manually in the system.
> > 
> > For past discussion of this see:
> > http://www.linux-mips.org/archives/linux-mips/2003-02/msg00196.html
> > 
> > I'm not sure why the change didn't make it in back in 2003, but
> > if the complaint was about the use of "?=", that seems to be in use
> > other places, and fairly standard now.
> > 
> > For example, from the top level kernel Makefile:
> > ARCH            ?= $(SUBARCH)
> > CROSS_COMPILE   ?=
> 
> It looks like the other arch-specific Makefiles also override the
> environment. To work around the problem, you can disable
> CONFIG_CROSSCOMPILE and define CROSS_COMPILE in the environment.
> 
> Strangely enough, the help for CONFIG_CROSSCOMPILE already explains
> that.

Let me ask a stupid question.  With all of the ways to otherwise do a
cross compile, why a config option on MIPS?  ARM*/SH*, which are at
least as likely to not be native-compiled, don't do that.  Just
something I've always wondered, really.

-- 
Tom Rini
http://gate.crashing.org/~trini/
