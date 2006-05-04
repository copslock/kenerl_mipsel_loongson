Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 23:36:16 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:54494 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133797AbWEDWf5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 May 2006 23:35:57 +0100
Received: from lagash (88-106-136-76.dynamic.dsl.as9105.com [88.106.136.76])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 2493244BE2; Fri,  5 May 2006 00:35:57 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FbmQ7-000780-OZ; Thu, 04 May 2006 23:35:39 +0100
Date:	Thu, 4 May 2006 23:35:39 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Tim Bird <tim.bird@am.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var
Message-ID: <20060504223539.GG18218@networkno.de>
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de> <445A6F51.90308@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445A6F51.90308@am.sony.com>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Tim Bird wrote:
> Thiemo Seufer wrote:
> > It looks like the other arch-specific Makefiles also override the
> > environment.
> 
> 4 other arches I work with don't.
> 
> > To work around the problem, you can disable
> > CONFIG_CROSSCOMPILE and define CROSS_COMPILE in the environment.
> 
> I thought that might be the case, but that's pretty broken IMHO.
> It's counterintuitive and undocumented.
> 
> > 
> > Strangely enough, the help for CONFIG_CROSSCOMPILE already explains
> > that.
> 
> Here's the help from my Kconfig.debug:
> 
>           Say Y here if you are compiling the kernel on a different
>           architecture than the one it is intended to run on.
> 
> Am I missing something?

Update to a newer version:

config CROSSCOMPILE
	bool "Are you using a crosscompiler"
	help
	  Say Y here if you are compiling the kernel on a different
	  architecture than the one it is intended to run on.  This is just a
	  convenience option which will select the appropriate value for
	  the CROSS_COMPILE make variable which otherwise has to be passed on
	  the command line from mips-linux-, mipsel-linux-, mips64-linux- and
	  mips64el-linux- as appropriate for a particular kernel configuration.
	  You will have to pass the value for CROSS_COMPILE manually if the
	  name prefix for your tools is different.


Thiemo
