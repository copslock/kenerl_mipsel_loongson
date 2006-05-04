Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 00:06:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26844 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133813AbWEDXGv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2006 00:06:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k44N6mdF005319;
	Fri, 5 May 2006 00:06:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k44N6lQq005318;
	Fri, 5 May 2006 00:06:47 +0100
Date:	Fri, 5 May 2006 00:06:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tom Rini <trini@kernel.crashing.org>
Cc:	Thiemo Seufer <ths@networkno.de>, Tim Bird <tim.bird@am.sony.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var
Message-ID: <20060504230647.GA3465@linux-mips.org>
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de> <20060504210449.GA12676@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504210449.GA12676@smtp.west.cox.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 04, 2006 at 02:04:49PM -0700, Tom Rini wrote:

> Let me ask a stupid question.  With all of the ways to otherwise do a
> cross compile, why a config option on MIPS?  ARM*/SH*, which are at
> least as likely to not be native-compiled, don't do that.  Just
> something I've always wondered, really.

Having such information in an environment variable is imho terribly
inelegant, having to pass it on the command line for each make invocation
is terrible abuse for the fingertips so I went for this option which makes
the makefile pick the right prefix.

  Ralf
