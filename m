Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 22:12:43 +0100 (BST)
Received: from p508B7E12.dip.t-dialin.net ([IPv6:::ffff:80.139.126.18]:23156
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225074AbUGWVMj>; Fri, 23 Jul 2004 22:12:39 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6NLCX6f005317;
	Fri, 23 Jul 2004 23:12:33 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6NLCWdJ005316;
	Fri, 23 Jul 2004 23:12:32 +0200
Date: Fri, 23 Jul 2004 23:12:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Richard Henderson <rth@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Richard Sandiford <rsandifo@redhat.com>,
	gcc-patches@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040723211232.GB5138@linux-mips.org>
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl> <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl> <20040719213801.GD14931@redhat.com> <Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl> <20040723202703.GB30931@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723202703.GB30931@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 23, 2004 at 01:27:03PM -0700, Richard Henderson wrote:

> > Sometimes putting these eight (or nine for ashrdi3) instructions
> > inline would be a performance win.
> 
> Sometimes, maybe.  I suspect you'll find that in general it's
> nothing but bloat.

With a bit of hand waiving because haven't done benchmarks I guess Richard
might be right.  The subroutine calling overhead on modern processors is
rather low and smaller code means better cache hit rates ...

  Ralf
