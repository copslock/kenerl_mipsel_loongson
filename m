Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57JbSU10405
	for linux-mips-outgoing; Thu, 7 Jun 2001 12:37:28 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57JbIh10381
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 12:37:26 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA23773;
	Thu, 7 Jun 2001 21:35:57 +0200 (MET DST)
Date: Thu, 7 Jun 2001 21:35:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010607121741.A24155@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1010607213008.16852F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 7 Jun 2001, Daniel Jacobowitz wrote:

> >  This happened to me once.  Otherwise, it looks like gdb doesn't recognize
> > a breakpoint for some reason -- possibly it places it at a wrong address. 
> > It shouldn't be difficult to debug -- you get information of the address
> > the trap happened. 
> 
> Wouldn't you hope?  No such luck.
> 
> Program received signal SIGTRAP, Trace/breakpoint trap.
> [Switching to Thread 1024 (LWP 89)]
> 0x00000000 in ?? ()

 Then patch your kernel to display the address.  It's trivial.  See
do_bp() in arch/mips/kernel/traps.c. 

> I blame the threads handling, which I'm only about half through
> debugging.

 Ah, threads...  They might be completely non-fuctional on MIPS/Linux. 
I've never run threaded programs on MIPS/Linux, but such trivial users as
ls appear to work.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
