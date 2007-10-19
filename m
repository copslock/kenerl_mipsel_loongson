Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 12:19:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49103 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044164AbXJSLTU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 12:19:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9JBINMm015886;
	Fri, 19 Oct 2007 12:18:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9JBINLO015885;
	Fri, 19 Oct 2007 12:18:23 +0100
Date:	Fri, 19 Oct 2007 12:18:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wolfgang Denk <wd@denx.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS Makefile not picking up CROSS_COMPILE from environment
	setting
Message-ID: <20071019111823.GB30767@linux-mips.org>
References: <20071018184636.48637242E9@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071018184636.48637242E9@gemini.denx.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 18, 2007 at 08:46:36PM +0200, Wolfgang Denk wrote:

> I noticed that, unlike for other architectures like ARM  or  PowerPC,
> the  MIPS Makefile does not pick up the settings from a CROSS_COMPILE
> environment variable, at least not with many (all?) default  configu-
> rations.
> 
> This makes no sense to me - is there an intention behind it?

There are four different tool prefixes possible for MIPS kernels,
mips-linux-, mipsel-linux-, mips64-linux- and mips64el-linux.  This bit
in the Makefile makes the kernel automatically pick up the right thing
if CONFIG_CROSSCOMPILE is set.

The idea of passing CROSS_COMPILE from the environment always seemed to
be wrong to me - I keep jumping between all sorts of weird different
kernel configurations so no single setting of an environment variable
would cut it.

What I'd really like to see is a properly working CONFIG_MYARCH option
selectable in Kconfig.  Then the makefiles should figure out if it's a
native or crosscompile and add the right tool prefix.  The user should
not need to know that sort of stuff unless he wants to.

  Ralf
