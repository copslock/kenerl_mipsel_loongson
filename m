Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBQLhdk26371
	for linux-mips-outgoing; Wed, 26 Dec 2001 13:43:39 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBQLhYX26360
	for <linux-mips@oss.sgi.com>; Wed, 26 Dec 2001 13:43:34 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBP6pY317026;
	Tue, 25 Dec 2001 04:51:34 -0200
Date: Tue, 25 Dec 2001 04:51:34 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: an old FPU context corruption problem when signal happens
Message-ID: <20011225045134.A17007@dea.linux-mips.net>
References: <3C21390A.FA23978D@mvista.com> <3C219A3B.6DA93A75@mips.com> <20011225044125.A16759@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011225044125.A16759@dea.linux-mips.net>; from ralf@oss.sgi.com on Tue, Dec 25, 2001 at 04:41:25AM -0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 25, 2001 at 04:41:25AM -0200, Ralf Baechle wrote:

> > Are you sure this hasn't been fix in the latest sources (2.4.16) ?
> > I have send a patch to Ralf, which I believe solves a similar problem as
> > you describe below.
> > 
> > Ralf have you applied the patch ?
> 
> Well, I applied it but it's really broken as something can be.  Just an
> example:
> 
> +       /* 
> +        * FPU emulator may have it's own trampoline active just
> +        * above the user stack, 16-bytes before the next lowest
> +        * 16 byte boundary.  Try to avoid trashing it.
> +        */
> +       sp -= 32;
> 
> So the whole thing needs some overhaul.

Btw, the whole fp trampoline thing will have to die anyway.  Virtually
indexed i-caches on some new types of SMP are making them even more
expensive then they already are.

  Ralf
