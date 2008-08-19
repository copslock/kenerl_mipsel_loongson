Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 17:06:47 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:26580
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28574522AbYHSQGk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 17:06:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7JG6bcL006175;
	Tue, 19 Aug 2008 17:06:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7JG6ZDk006173;
	Tue, 19 Aug 2008 17:06:35 +0100
Date:	Tue, 19 Aug 2008 17:06:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Compilation problem
Message-ID: <20080819160635.GA5193@linux-mips.org>
References: <1219151811.3948.1.camel@kh-ubuntu.razamicroelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1219151811.3948.1.camel@kh-ubuntu.razamicroelectronics.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 19, 2008 at 08:16:50AM -0500, Kevin Hickey wrote:

> Is anyone else having trouble compiling the HEAD of LMO?  Under multiple
> defconfigs, I get:
> 
> In file included from init/main.c:32:
> include/linux/security.h: In function ‘security_ptrace_traceme’:
> include/linux/security.h:1760: error: ‘parent’ undeclared (first use in
> this function)
> include/linux/security.h:1760: error: (Each undeclared identifier is
> reported only once
> include/linux/security.h:1760: error: for each function it appears in.)
> make[1]: *** [init/main.o] Error 1
> 
> I did a clean clone to be sure that it was not anything leftover in my
> working directory.  Is it just me?

Broken code which I merged from upstream.  If that happens I usually don't
commit the fixes locally unless the fix affects MIPS files.  So the issue
may persist for a day or two.

  Ralf
