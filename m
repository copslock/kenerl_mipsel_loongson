Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 22:44:35 +0100 (BST)
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:988 "HELO
	fed1rmmtao11.cox.net") by ftp.linux-mips.org with SMTP
	id S8133790AbWEDVoZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 22:44:25 +0100
Received: from opus ([68.110.9.227]) by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504214417.VUNH9215.fed1rmmtao11.cox.net@opus>;
          Thu, 4 May 2006 17:44:17 -0400
Date:	Thu, 4 May 2006 14:44:17 -0700
From:	Tom Rini <trini@kernel.crashing.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Thiemo Seufer <ths@networkno.de>, Tim Bird <tim.bird@am.sony.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var
Message-ID: <20060504214417.GB12676@smtp.west.cox.net>
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de> <20060504210449.GA12676@smtp.west.cox.net> <028201c66fc1$4f724d20$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028201c66fc1$4f724d20$10eca8c0@grendel>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, May 04, 2006 at 11:25:46PM +0200, Kevin D. Kissell wrote:
> > Let me ask a stupid question.  With all of the ways to otherwise do a
> > cross compile, why a config option on MIPS?  ARM*/SH*, which are at
> > least as likely to not be native-compiled, don't do that.  Just
> > something I've always wondered, really.
> 
> Probably because, unlike ARM and SH, the MIPS architecture began life
> as a workstation/server processor, and for a while there cross-compilation
> was the exception rather than the rule.

OK, PowerPC.  My kinda question/point was perhaps it's time to deprecate
CONFIG_CROSSCOMPILE in favor of env or make to bring it in line with
other arches (similar to how 2.4 had a few ways for
arch/$(ARCH)/*config/ dirs, 2.6 is uniform).

-- 
Tom Rini
http://gate.crashing.org/~trini/
