Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:55:15 +0000 (GMT)
Received: from pD9562327.dip.t-dialin.net ([IPv6:::ffff:217.86.35.39]:13102
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225219AbUKXWyj>; Wed, 24 Nov 2004 22:54:39 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAOMscsT025548;
	Wed, 24 Nov 2004 23:54:38 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAOMsba2025547;
	Wed, 24 Nov 2004 23:54:37 +0100
Date: Wed, 24 Nov 2004 23:54:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Kapoor, Pankaj" <pkapoor@ti.com>, linux-mips@linux-mips.org
Subject: Re: Cache Question
Message-ID: <20041124225437.GE22439@linux-mips.org>
References: <C4D23DECD6CD714BBFB38B0AE8D25A3A24FF66@dlee2k03.ent.ti.com> <20041124223211.GB22439@linux-mips.org> <Pine.LNX.4.58L.0411242241130.843@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411242241130.843@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 24, 2004 at 10:42:45PM +0000, Maciej W. Rozycki wrote:

> > That interrupt disabling in some cache flushes dates back further than
> > CVS history.  Seems once uppon a time there was some CPU which didn't
> > like cache flushes with interrupts enabled.  This is rather bad for
> > latencies so unless somebody else on this list recalls a good reason
> > I'd like to remove this.
> 
>  Some R4600 (v1.1?) errata workaround?  Or was it elsewhere?

V1.7 you mean - it identifies as 1.0 in c0_prid though.  I don't have
my erratas for this one anymore.  I've checked erratum #3 of V2.0 with
one of the R4600 designers already a while ago and he said disabling
interrupts isn't necessary.

The ancient Linux code I was refering to used to disable interrupts
for all CPUs.  Supported CPUs back then were R4000, R4400, R4600 only,
so it must have been one of those.

  Ralf
