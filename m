Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14DKxZ16534
	for linux-mips-outgoing; Mon, 4 Feb 2002 05:20:59 -0800
Received: from dea.linux-mips.net (a1as01-p54.stg.tli.de [195.252.185.54])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14DKsA16468
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 05:20:54 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g146kJh19091;
	Mon, 4 Feb 2002 07:46:19 +0100
Date: Mon, 4 Feb 2002 07:46:19 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Justin Carlson <justinca@ri.cmu.edu>
Cc: Daniel Jacobowitz <dan@debian.org>, "H . J . Lu" <hjl@lucon.org>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020204074619.B13799@dea.linux-mips.net>
References: <20020131231714.E32690@lucon.org> <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl> <20020201102943.A11146@lucon.org> <20020201180126.A23740@nevyn.them.org> <20020201151513.A15913@lucon.org> <20020201222657.A13339@nevyn.them.org> <1012676003.1563.6.camel@xyzzy.stargate.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012676003.1563.6.camel@xyzzy.stargate.net>; from justinca@ri.cmu.edu on Sat, Feb 02, 2002 at 01:53:23PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Feb 02, 2002 at 01:53:23PM -0500, Justin Carlson wrote:

> 2)  More importantly, most implementations don't use any sort of dynamic
> branch prediction on branch likelies.  They predict taken, always, since
> that's the specified intent (it's a branch *likely* to be taken).

CPU guys hate branch likely and would probably love if whoever invented
them hires at Intel ;-)

> For most spin locks, the normal behaviour is a fall through, not taking
> that branch, so you're inflicting a branch mispredict penalty on every
> lock grabbed without contention.  Even for locks which the general case
> is contention, giving the processor branch predictor a chance to learn
> that is a Good Idea.

I was thinking about spinlocks like

retry:	la	addrreg, retry
	ll	reg, lockvar
	...
	sc	reg, lockvar
	teq	$0, reg

That would depend on the price of a trap instruction when it's not taken
and the probability of the lock being congested.

  Ralf
