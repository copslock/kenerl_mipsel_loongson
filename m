Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MIZfRw032087
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 11:35:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MIZf87032086
	for linux-mips-outgoing; Mon, 22 Jul 2002 11:35:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f32.dialo.tiscali.de [62.246.19.32])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MIZYRw032040
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 11:35:36 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6MIaIC22758;
	Mon, 22 Jul 2002 20:36:18 +0200
Date: Mon, 22 Jul 2002 20:36:18 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: sys32_execve fix
Message-ID: <20020722203618.A22721@dea.linux-mips.net>
References: <3D3C0E26.676F4799@mips.com> <Pine.GSO.3.96.1020722184609.2373J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020722184609.2373J-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 22, 2002 at 06:56:42PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 22, 2002 at 06:56:42PM +0200, Maciej W. Rozycki wrote:

> > The problem is that "nargs" in arch/mips64/kernel/linux32.c fails when
> > argv is NULL, the patch below should fix the problem:
> 
>  How about just:
> 
> 	if (!arg)
> 		return 0;
> 
> at the top?  Gcc should optimize it to a single branch, likely not taken,
> and a register move.

Right.  Coincidentally this is also what was done to the IA64 port where
this code did originate.

  Ralf
