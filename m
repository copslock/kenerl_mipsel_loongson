Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 20:28:34 +0100 (BST)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:61887 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225363AbVE1T2T>; Sat, 28 May 2005 20:28:19 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4SJR62h008048;
	Sat, 28 May 2005 20:27:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4SJR4qo008047;
	Sat, 28 May 2005 20:27:04 +0100
Date:	Sat, 28 May 2005 20:27:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Cameron Cooper <developer@phatlinux.com>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
Subject: Re: Porting To New System
Message-ID: <20050528192704.GA4995@linux-mips.org>
References: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl> <1117217584.5743.229.camel@localhost.localdomain> <1117223539.2921.15.camel@phatbox> <1117237244.5744.284.camel@localhost.localdomain> <1117294983.2800.12.camel@phatbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117294983.2800.12.camel@phatbox>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 28, 2005 at 11:43:03AM -0400, Cameron Cooper wrote:

> It looks like Xiptech only did a port for R3K, which is no good for me.
> The issue that I'm running into right now is in
> arch/mipsnommu/mm/c-r4k.c

Sort of amusing to make that a separate architecture - TLB or not, the
remainder of the CPU stays pretty much the same.

> I guess the problem is that it is trying to use things which belong to
> the MM code, which are not included from mm.h becuase NO_MM is set.
> c-r3k.c was rewritten for NO_MM, but not c-r4k.c. I looked into
> rewriting c-r4k.c by taking ideas from c-r3k.c but unfortunatly they are
> not similar enough, and I'm afraid I'm not even sure what this file
> does.

The key feature of R4000 caches that causes alot of complexity in the
c-r4k code is that it needs to handle virtually indexed caches, especially
avoid cache aliases.  On a TLB-less processors aliases are not possible,
thus c-r4k.c can be significantly simplified making it quite a bit more
similar to c-r3k.c.

> Can you help me understand what this file does, and what I might
> do to rewrite it for NO_MM?

Your question would require a very long answer to be somewhat exhaustive,
so here the express version.  Start by reading Documentation/cachetlb.txt
from the kernel sources.  You can find plenty of discussions related to
this code in the linux-mips and linux-kernel archives - especially the
subtle points aren't exactly documented ;-)

  Ralf
