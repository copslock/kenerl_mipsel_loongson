Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 21:55:47 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:43976 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133800AbWEDUzg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 May 2006 21:55:36 +0100
Received: from lagash (88-106-136-76.dynamic.dsl.as9105.com [88.106.136.76])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 86A9C441E5; Thu,  4 May 2006 22:55:35 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1Fbkqz-0006Y1-KK; Thu, 04 May 2006 21:55:17 +0100
Date:	Thu, 4 May 2006 21:55:17 +0100
To:	Tim Bird <tim.bird@am.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var
Message-ID: <20060504205517.GF18218@networkno.de>
References: <445A577D.7090507@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445A577D.7090507@am.sony.com>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Tim Bird wrote:
> The following patch allows to build using CROSS_COMPILE from the environment.
> I have an automated system which works like this, but it chokes on MIPS when
> I use it with (albeit non-standard-named) cross-compiler tools.  An easy
> workaround I'm using is to put CROSS_COMPILE on the make command line, but it would
> be nice to use the definition already in the environment when I work
> manually in the system.
> 
> For past discussion of this see:
> http://www.linux-mips.org/archives/linux-mips/2003-02/msg00196.html
> 
> I'm not sure why the change didn't make it in back in 2003, but
> if the complaint was about the use of "?=", that seems to be in use
> other places, and fairly standard now.
> 
> For example, from the top level kernel Makefile:
> ARCH            ?= $(SUBARCH)
> CROSS_COMPILE   ?=

It looks like the other arch-specific Makefiles also override the
environment. To work around the problem, you can disable
CONFIG_CROSSCOMPILE and define CROSS_COMPILE in the environment.

Strangely enough, the help for CONFIG_CROSSCOMPILE already explains
that.


Thiemo
