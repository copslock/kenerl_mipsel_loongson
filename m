Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g68HfYRw029695
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 10:41:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g68HfYk9029694
	for linux-mips-outgoing; Mon, 8 Jul 2002 10:41:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (free168-x28.dialo.tiscali.de [62.246.28.168] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g68HfRRw029684
	for <linux-mips@oss.sgi.com>; Mon, 8 Jul 2002 10:41:29 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g68Hjd902907;
	Mon, 8 Jul 2002 19:45:39 +0200
Date: Mon, 8 Jul 2002 19:45:39 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
Message-ID: <20020708194539.C2758@dea.linux-mips.net>
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com> <20020704215614.B29422@dea.linux-mips.net> <3D29CC6B.5090004@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D29CC6B.5090004@mvista.com>; from jsun@mvista.com on Mon, Jul 08, 2002 at 10:31:23AM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 08, 2002 at 10:31:23AM -0700, Jun Sun wrote:

> I think this is also an effective way to avoid cache aliasing.

Correct.  At the same time the choice of this value also tends to cause
bad use of L2 caches ...

> As long as your cache size is less than 256K, you don't get cache aliasing
> through shared memory.

Actually the "alias set" has to be less than 256kB.  On existing MIPS
implementations it's at most 16kB; a sillyness of the R4000 / R4400 VCE
exceptions makes a value of 32kB mandatory for poerformance reasons.

> Perhaps other arches don't have cache aliasing?  I know for sure i386 
> does not have that effect.

The problem doesn't exist on physically indexed caches.  Also on read-only
caches such as the instruction cache it usually can be ignored.  So for
example the R2000, R3000, SB1 cores, RM7000, R4kc and R5kc in the right
configurations and the R10000 family don't suffer from aliases.  Details
are messy :)

  Ralf
