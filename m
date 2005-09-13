Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2005 13:42:17 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:10417 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225223AbVIMMmC>; Tue, 13 Sep 2005 13:42:02 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.50 #1 (Debian))
	id 1EF9Az-0004Si-Q4; Tue, 13 Sep 2005 06:42:13 -0500
Subject: Re: deletion of boards
In-Reply-To: <20050913122440.GA3224@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Date:	Tue, 13 Sep 2005 06:42:13 -0500 (CDT)
CC:	Pete Popov <ppopov@embeddedalley.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1EF9Az-0004Si-Q4@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> > The AMD Pb1000, Pb1100, Pb1500, and Hydrogen3 boards are not up to date
> > in 2.6 and seem to be of very little interest to anyone. Any objections
> > if I remove them to reduce the clutter?
> 
> The inflation of evaluation boards is generally some sort of problem; in
> many cases they are on the market only for a very short time before they're
> replaced - we're talking about a time frame of like 6 months or so.  That
> means the time that a Linux port is actually of interest if often just
> as short.  Which means, we have quite a few candidates for deletion.
> 
I would agree with this. Could I make a small suggestion? How about for
boards that are going to be removed, someone at least tries to build a
kernel for it, if it works then tag CVS as such for that board. If not,
blow it away. This allows someone who possibly has an interest later on
to at least be able to pull the last known working snapshot for their
board. Just a thought.

-Steve
