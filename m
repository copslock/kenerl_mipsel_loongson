Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 14:30:20 +0000 (GMT)
Received: from p508B7E65.dip.t-dialin.net ([IPv6:::ffff:80.139.126.101]:44123
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225331AbUA1OaT>; Wed, 28 Jan 2004 14:30:19 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0SEU6ex003691;
	Wed, 28 Jan 2004 15:30:06 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0SEU44n003584;
	Wed, 28 Jan 2004 15:30:04 +0100
Date: Wed, 28 Jan 2004 15:30:04 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kevin Paul Herbert <kph@cisco.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
Message-ID: <20040128143004.GB1717@linux-mips.org>
References: <1075255111.8744.4.camel@shakedown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075255111.8744.4.camel@shakedown>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2004 at 05:58:31PM -0800, Kevin Paul Herbert wrote:

> In edit 1.68, the non-interrupt locking versions of
> raw_readq()/raw_writeq() were removed, in favor of locking ones. While
> this makes sense in general, it breaks the compilation of the sb1250
> which uses the non-locking versions (____raw_readq() and
> ____raw_writeq()) in interrupt handlers.
> 
> Personally, I think that it is very confusing to have so many similar
> macros with similar names and increasing numbers of underscores, so I
> don't really have a problem with this. I've modified
> arch/mips/sibyte/sb1250/time.c and arch/mips/sibyte/sb1250/irq.c to use
> the __ versions and have a few more instructions of overhead.

You actually have no extra overhead - the old versions were broken such
that they were doing the locking thing anyway; this was the primary reason
for the fix.

As for the naming, in general Linux uses a double underscore name prefix
to indicate a more raw, basic version of a function.  This naming
principle applied twice leads to a quad underscore name prefix.  Which
is consequent but ugly.

> My question is whether this removal was intended or not, or whether
> there are some other changes to the handlers in the sb1250-specific code
> that got dropped somewhere.
> 
> If the consensus is that the ____ versions really should perish for the
> sake of simplicity, I'll send my simple patches to the list to fix the
> sb1250 build.

It was removed intensionally under the false assumption the quad-underscore
variants were unused.

  Ralf
