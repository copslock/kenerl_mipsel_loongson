Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15CFFt32475
	for linux-mips-outgoing; Tue, 5 Feb 2002 04:15:15 -0800
Received: from dea.linux-mips.net (a1as14-p209.stg.tli.de [195.252.191.209])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15CFBA32462
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 04:15:12 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g15CCvs04561;
	Tue, 5 Feb 2002 13:12:57 +0100
Date: Tue, 5 Feb 2002 13:12:57 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Hartvig Ekner <hartvige@mips.com>
Cc: Justin Carlson <justinca@ri.cmu.edu>, Daniel Jacobowitz <dan@debian.org>,
   "H . J . Lu" <hjl@lucon.org>, Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020205131257.A4482@dea.linux-mips.net>
References: <1012887022.3343.9.camel@xyzzy.stargate.net> <200202050839.JAA00051@copsun18.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202050839.JAA00051@copsun18.mips.com>; from hartvige@mips.com on Tue, Feb 05, 2002 at 09:39:27AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 09:39:27AM +0100, Hartvig Ekner wrote:

> Note that the issue of a "LL" will trigger bus watching activity in the
> system logic (and maybe delays?) I would personally try to avoid issuing
> "dangling" ll's in the normal case, even though the functionality would
> be ok, and in some cases they are inavoidable.

Some of the processor manuals explicitly note that the execution of a
ll instruction may not be visible at all externally.  That's the case if
the address is already in a primary cache line in exclusive (ll) or
dirty (sc) state.  That makes even if a processor supports full coherency
since there is no reason to indicate the update to any other external
agent.  Or am I missing something?

  Ralf
