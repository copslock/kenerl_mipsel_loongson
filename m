Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 17:08:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20645 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027021AbYBSRI5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 17:08:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JH8uwB017282;
	Tue, 19 Feb 2008 17:08:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JH8tCd017281;
	Tue, 19 Feb 2008 17:08:55 GMT
Date:	Tue, 19 Feb 2008 17:08:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <adrian.bunk@movial.fi>
Cc:	linux-mips@linux-mips.org, Aurelien Jarno <aurelien@aurel32.net>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: mips: compile testing of 2.6.25-rc2
Message-ID: <20080219170855.GB15678@linux-mips.org>
References: <20080218010314.GO1403@cs181133002.pp.htv.fi> <20080219165008.GA14178@linux-mips.org> <20080219170429.GC23655@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080219170429.GC23655@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 19, 2008 at 07:04:29PM +0200, Adrian Bunk wrote:

> > There is a public autobuilder at http://mipslinux.simtec.co.uk/kautobuild.
> 
> Neat, I only knew about http://armlinux.simtec.co.uk/kautobuild/ .
> 
> Are arm and mips the only architectures with autobuilders there or are 
> more architectures available?

By the time when the MIPS autobuilder was setup it was the 2nd architecture
and the machine was running seriously out of steam.  It has been upgraded
in the meantime so maybe some more architectures have or will be added.

  Ralf
