Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g68HUjRw028067
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 10:30:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g68HUj9s028066
	for linux-mips-outgoing; Mon, 8 Jul 2002 10:30:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (free168-x28.dialo.tiscali.de [62.246.28.168] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g68HUcRw028057
	for <linux-mips@oss.sgi.com>; Mon, 8 Jul 2002 10:30:39 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g68HYdU02797;
	Mon, 8 Jul 2002 19:34:39 +0200
Date: Mon, 8 Jul 2002 19:34:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, "H. J. Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
Message-ID: <20020708193438.A2758@dea.linux-mips.net>
References: <20020702114045.A16197@lucon.org> <20020702220651.B9566@dea.linux-mips.net> <00d401c22337$7e731580$10eca8c0@grendel> <20020704155726.A28268@dea.linux-mips.net> <3D29CA34.1050306@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D29CA34.1050306@mvista.com>; from jsun@mvista.com on Mon, Jul 08, 2002 at 10:21:56AM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 08, 2002 at 10:21:56AM -0700, Jun Sun wrote:

> > No, Sony's ABI isn't MP proof and will break silently on MP systems.  As
> > such I can't consider it anything else but a hack.  sysmips(MIPS_ATOMIC_SET,
> > ...) and ll/sc however are MP proof.
> > 
> 
> 
> sysmips(MIPS_ATOMIC_SET, ...) as it is is not MP-safe.  Two processors can
> set the variable at the same time since no spinlock is used to protect the
> access. 

Note there are two cases in the code, one using ll/sc which is MP proof
and a second implementation for machines that don't have these instructions.
At least for now Linux/MIPS SMP systems by definition have ll/sc, so I
don't see any problem.

> This is also a problem when I was writing preemptiable kernel patch.

Thanks for the reminder.  I'm just working on the merge with 2.5.4 which
has all the preemption stuff.  Another one for the to-do list ...

  Ralf
