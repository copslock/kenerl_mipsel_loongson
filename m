Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2003 18:43:38 +0100 (BST)
Received: from p508B51CB.dip.t-dialin.net ([IPv6:::ffff:80.139.81.203]:33736
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225512AbTJORnc>; Wed, 15 Oct 2003 18:43:32 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9FHgHNK019163;
	Wed, 15 Oct 2003 19:42:17 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9FHgGpQ019150;
	Wed, 15 Oct 2003 19:42:16 +0200
Date: Wed, 15 Oct 2003 19:42:16 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: MIPS addressing limits, Was: Re: CVS Update@-mips.org: linux
Message-ID: <20031015174216.GD11276@linux-mips.org>
References: <20031014132850.GA12938@linux-mips.org> <Pine.GSO.3.96.1031015161040.9299D-100000@delta.ds2.pg.gda.pl> <20031015145948.GB23514@linux-mips.org> <20031015101902.C8761@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015101902.C8761@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 15, 2003 at 10:19:02AM -0700, Jun Sun wrote:

> Isn't ia64 still using 3-level page tables?  Any performance data we
> can infer from theirs?

Very different MMU, IA64 data is hardly an indicator.  And anyway, the
result should be MIPS TLB refill handlers suck big chunky rocks through
a straw so should be rewritten ;-)

> I feel a little uneasy about ditching 3-level pagetable altogether.
> Leaving all the parameters configurable, including the possiblity of
> nullifying the second level and changing page size, seems to be a more 
> comforting thought.

3 levels are only needed if you can seriously say you're need more than
64GB of vmalloc space or processes larger than 64GB.  Little need for
that in the current universe though I know one institution which broke
the 1TB process size limit > 5 years ago.

  Ralf
