Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g12L42Z20444
	for linux-mips-outgoing; Sat, 2 Feb 2002 13:04:02 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g12L3wd20441
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 13:03:59 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 29000125C3; Sat,  2 Feb 2002 12:03:54 -0800 (PST)
Date: Sat, 2 Feb 2002 12:03:54 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Justin Carlson <justinca@ri.cmu.edu>
Cc: Daniel Jacobowitz <dan@debian.org>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com, gcc@gcc.gnu.org
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020202120354.A1522@lucon.org>
References: <20020131231714.E32690@lucon.org> <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl> <20020201102943.A11146@lucon.org> <20020201180126.A23740@nevyn.them.org> <20020201151513.A15913@lucon.org> <20020201222657.A13339@nevyn.them.org> <1012676003.1563.6.camel@xyzzy.stargate.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012676003.1563.6.camel@xyzzy.stargate.net>; from justinca@ri.cmu.edu on Sat, Feb 02, 2002 at 01:53:23PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Feb 02, 2002 at 01:53:23PM -0500, Justin Carlson wrote:
> 
> Actually, regardless of whether modern cpus implement it, I'd argue that
> avoiding the branch likely is a good idea for 2 reasons:
> 
> 1)  In the latest MIPS specs (mips32 and mips64) branch likelies have
> officially been deprecated as probable removals from the architecture in
> the not-too-distant future.
> 
> 2)  More importantly, most implementations don't use any sort of dynamic
> branch prediction on branch likelies.  They predict taken, always, since
> that's the specified intent (it's a branch *likely* to be taken).  For
> most spin locks, the normal behaviour is a fall through, not taking that
> branch, so you're inflicting a branch mispredict penalty on every  lock
> grabbed without contention.  Even for locks which the general case is
> contention, giving the processor branch predictor a chance to learn that
> is a Good Idea.
> 

Does everyone agree with this? If yes, I can make a patch not to use
branch likely. But on the other hand, "gcc -mips2" will generate code
using branch likely. If branch likely doesn't buy you anything, 
shouldn't we change gcc not to generate branch likely instructions?


H.J.
