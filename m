Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g12Jqbv14167
	for linux-mips-outgoing; Sat, 2 Feb 2002 11:52:37 -0800
Received: from xyzzy.stargate.net ([198.144.45.122])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g12JqUd14163
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 11:52:30 -0800
Received: (from justin@localhost)
	by xyzzy.stargate.net (8.11.6/8.11.6) id g12IrOg01938;
	Sat, 2 Feb 2002 13:53:24 -0500
X-Authentication-Warning: xyzzy.stargate.net: justin set sender to justinca@ri.cmu.edu using -f
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
From: Justin Carlson <justinca@ri.cmu.edu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "H . J . Lu" <hjl@lucon.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
In-Reply-To: <20020201222657.A13339@nevyn.them.org>
References: <20020131231714.E32690@lucon.org>
	<Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
	<20020201102943.A11146@lucon.org> <20020201180126.A23740@nevyn.them.org>
	<20020201151513.A15913@lucon.org>  <20020201222657.A13339@nevyn.them.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 02 Feb 2002 13:53:23 -0500
Message-Id: <1012676003.1563.6.camel@xyzzy.stargate.net>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2002-02-01 at 22:26, Daniel Jacobowitz wrote:
> On Fri, Feb 01, 2002 at 03:15:13PM -0800, H . J . Lu wrote:
> > On Fri, Feb 01, 2002 at 06:01:26PM -0500, Daniel Jacobowitz wrote:
> > > On Fri, Feb 01, 2002 at 10:29:43AM -0800, H . J . Lu wrote:
> > > > On Fri, Feb 01, 2002 at 12:45:02PM +0100, Maciej W. Rozycki wrote:
> > > > > On Thu, 31 Jan 2002, H . J . Lu wrote:
> > > > > 
> > > > > > > Gas will fill delay slots. Same object codes will be produced, so I
> > > > > > > think you don't have to do that by hand. 
> > > > > > 
> > > > > > It will make the code more readable. We don't have to guess what
> > > > > > the assembler will do. 
> > > > > 
> > > > >  But you lose a chance for something useful being reordered to the slot.
> > > > > That might not necessarily be a "nop".  Please don't forget of indents
> > > > > anyway.
> > > > > 
> > > > 
> > > > Here is a new patch. I use branch likely to get rid of nops. Please
> > > > tell me which indents I may have missed.
> > > 
> > > Can you really assume presence of the branch-likely instruction?  I
> > > don't think so.
> > 

Actually, regardless of whether modern cpus implement it, I'd argue that
avoiding the branch likely is a good idea for 2 reasons:

1)  In the latest MIPS specs (mips32 and mips64) branch likelies have
officially been deprecated as probable removals from the architecture in
the not-too-distant future.

2)  More importantly, most implementations don't use any sort of dynamic
branch prediction on branch likelies.  They predict taken, always, since
that's the specified intent (it's a branch *likely* to be taken).  For
most spin locks, the normal behaviour is a fall through, not taking that
branch, so you're inflicting a branch mispredict penalty on every  lock
grabbed without contention.  Even for locks which the general case is
contention, giving the processor branch predictor a chance to learn that
is a Good Idea.

-Justin
