Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NCE1Rw023765
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 05:14:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NCE0DM023764
	for linux-mips-outgoing; Tue, 23 Jul 2002 05:14:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f249.dialo.tiscali.de [62.246.17.249])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NCDQRw023726
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 05:13:28 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6NCE7b10917;
	Tue, 23 Jul 2002 14:14:07 +0200
Date: Tue, 23 Jul 2002 14:14:07 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
Message-ID: <20020723141407.B10566@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020722222909.2373P-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020722222909.2373P-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 23, 2002 at 01:55:13PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 23, 2002 at 01:55:13PM +0200, Maciej W. Rozycki wrote:

>  There is no need to carry support for pure 32-bit CPUs around in
> cpu_probe() in arch/mips64/kernel/setup.c, since such CPUs are not
> supported by the port and likely won't ever reach that code due to a
> reserved instruction exception earlier.  The code is misleading and a
> possible cause of troubles, e.g. the 2.4 branch doesn't link now because
> of an unresolved reference to cpu_has_fpu() which is only needed for
> R2000/R3000. 
> 
>  The following patch removes the code for 2.4.  For the trunk
> cpu_has_fpu() would be removed as well.  Any objections?

I intentionally have that 32-bit stuff in the 64-bit kernel so we can simply
have share identical CPU probing code between the 32-bit and 64-bit kernels.
This in anticipation of a further unification of the two ports which still
duplicate plenty of code with just minor changes.

To make sharing easier I suggest to move all the CPU probing code into it's
own file, probe.c or so?

  Ralf
