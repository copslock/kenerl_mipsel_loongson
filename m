Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g138hT206043
	for linux-mips-outgoing; Sun, 3 Feb 2002 00:43:29 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g138hLA05993
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 00:43:21 -0800
Received: from xyzzy.stargate.net ([198.144.45.122]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA00825
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 21:50:15 -0800 (PST)
	mail_from (justinca@ri.cmu.edu)
Received: (from justin@localhost)
	by xyzzy.stargate.net (8.11.6/8.11.6) id g135lVu02334;
	Sun, 3 Feb 2002 00:47:31 -0500
X-Authentication-Warning: xyzzy.stargate.net: justin set sender to justinca@ri.cmu.edu using -f
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
From: Justin Carlson <justinca@ri.cmu.edu>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Daniel Jacobowitz <dan@debian.org>,
   "Maciej W. Rozycki"
	 <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com, gcc@gcc.gnu.org
In-Reply-To: <20020202120354.A1522@lucon.org>
References: <20020131231714.E32690@lucon.org>
	<Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
	<20020201102943.A11146@lucon.org> <20020201180126.A23740@nevyn.them.org>
	<20020201151513.A15913@lucon.org> <20020201222657.A13339@nevyn.them.org>
	<1012676003.1563.6.camel@xyzzy.stargate.net> 
	<20020202120354.A1522@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 03 Feb 2002 00:47:30 -0500
Message-Id: <1012715250.2297.9.camel@xyzzy.stargate.net>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 2002-02-02 at 15:03, H . J . Lu wrote:
> On Sat, Feb 02, 2002 at 01:53:23PM -0500, Justin Carlson wrote:
> > 
> > Actually, regardless of whether modern cpus implement it, I'd argue that
> > avoiding the branch likely is a good idea for 2 reasons:
> > 
> > 1)  In the latest MIPS specs (mips32 and mips64) branch likelies have
> > officially been deprecated as probable removals from the architecture in
> > the not-too-distant future.
> > 
> > 2)  More importantly, most implementations don't use any sort of dynamic
> > branch prediction on branch likelies.  They predict taken, always, since
> > that's the specified intent (it's a branch *likely* to be taken).  For
> > most spin locks, the normal behaviour is a fall through, not taking that
> > branch, so you're inflicting a branch mispredict penalty on every  lock
> > grabbed without contention.  Even for locks which the general case is
> > contention, giving the processor branch predictor a chance to learn that
> > is a Good Idea.
> > 
> 
> Does everyone agree with this? If yes, I can make a patch not to use
> branch likely. But on the other hand, "gcc -mips2" will generate code
> using branch likely. If branch likely doesn't buy you anything, 
> shouldn't we change gcc not to generate branch likely instructions?
> 

I know of at least one internal version of gcc which already has been
hacked to remove generation of branch likely instructions.  It actually
helped performance a bit because gcc has (possibly had, this was 6-9
months ago) the bad habit of generating code like this:

beqzl   $1, next
 daddiu $2, $3, 1
next:
...

This looks like a nice, compact way to do a conditional move.  In
practice, it's a horrendous idea due to the lack of consideration of the
branch prediction.  It's easier to tell the compiler not to generate
branch likelies than to try to fix the code generation for this case. 
:)

Also, I didn't say branch likely doesn't buy you anything; there are
situations where it works well.  Looking at the spin_lock code, though,
this isn't one of them.  The cases where it is a win are far enough
between that my personal practice is to generally avoid them.

-Justin
