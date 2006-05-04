Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 00:34:58 +0100 (BST)
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33213 "HELO
	fed1rmmtao05.cox.net") by ftp.linux-mips.org with SMTP
	id S8133806AbWEDXeq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 May 2006 00:34:46 +0100
Received: from opus ([68.110.9.227]) by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504233429.BHWC25666.fed1rmmtao05.cox.net@opus>;
          Thu, 4 May 2006 19:34:29 -0400
Date:	Thu, 4 May 2006 16:34:29 -0700
From:	Tom Rini <trini@kernel.crashing.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, Tim Bird <tim.bird@am.sony.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var
Message-ID: <20060504233429.GD12676@smtp.west.cox.net>
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de> <20060504210449.GA12676@smtp.west.cox.net> <20060504230647.GA3465@linux-mips.org> <20060504231432.GC12676@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504231432.GC12676@smtp.west.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, May 04, 2006 at 04:14:32PM -0700, Tom Rini wrote:
> On Fri, May 05, 2006 at 12:06:47AM +0100, Ralf Baechle wrote:
> > On Thu, May 04, 2006 at 02:04:49PM -0700, Tom Rini wrote:
> > 
> > > Let me ask a stupid question.  With all of the ways to otherwise do a
> > > cross compile, why a config option on MIPS?  ARM*/SH*, which are at
> > > least as likely to not be native-compiled, don't do that.  Just
> > > something I've always wondered, really.
> > 
> > Having such information in an environment variable is imho terribly
> > inelegant, having to pass it on the command line for each make invocation
> > is terrible abuse for the fingertips so I went for this option which makes
> > the makefile pick the right prefix.
> 
> I don't suppose you'd be willing to front pushing that to the rest of
> the world then, would you?  Inconsistency is more of a problem for me
> than changing any of my scripts to use something else :)

... I forgot this doesn't take a string value of what to use but
hard-coded options.

-- 
Tom Rini
http://gate.crashing.org/~trini/
