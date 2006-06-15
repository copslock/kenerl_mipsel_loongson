Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 16:33:06 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:59548 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8134067AbWFOPc5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2006 16:32:57 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1Fqtq0-0005cw-6P; Thu, 15 Jun 2006 11:32:52 -0400
Date:	Thu, 15 Jun 2006 11:32:52 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	libc-ports@sourceware.org, linux-mips@linux-mips.org
Subject: Re: mips RDHWR instruction in glibc
Message-ID: <20060615153252.GA21598@nevyn.them.org>
References: <20060615.001238.65193088.anemo@mba.ocn.ne.jp> <20060614165040.GA19480@nevyn.them.org> <20060616.002837.59465125.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616.002837.59465125.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 16, 2006 at 12:28:37AM +0900, Atsushi Nemoto wrote:
> On Wed, 14 Jun 2006 12:50:40 -0400, Daniel Jacobowitz <dan@debian.org> wrote:
> > > For example, in the code below, RDHWR is placed _before_ checking the
> > > error.  I suppose these instructions were reordered by gcc's
> > > optimization, but the optimization would have large negative effect in
> > > this case.
> > 
> > You'd have to figure out how to get GCC not to eagerly schedule the
> > rdhwr.  This might be quite hard.  I don't know much about this part of
> > the scheduler.
> 
> I really did not understand yet how errno is bound TLS.  I found some
> "rdhwr" in glibc-ports source code (tls-macros.h, nptl/tls.h).  The
> RDHWR instruction in the example code comes from one of them, no?

No.

> I also found a "rdhwr" in gcc's mips.md file ("tls_get_tp_<mode>").
> Is this the origin?  MD is a very foreign language for me...

Yes.  Compile something like this with -O2 but without -fpic:

__thread int x;
int foo() { return x; }

It should use the IE model, which will generate a rdhwr.

-- 
Daniel Jacobowitz
CodeSourcery
