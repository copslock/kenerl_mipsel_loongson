Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IMhin12485
	for linux-mips-outgoing; Fri, 18 Jan 2002 14:43:44 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IMhcP12481
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 14:43:38 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA02492;
	Fri, 18 Jan 2002 22:42:15 +0100 (MET)
Date: Fri, 18 Jan 2002 22:42:15 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Carlson <justincarlson@cmu.edu>
cc: drepper@redhat.com, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <1011389085.7765.69.camel@gs256.sp.cs.cmu.edu>
Message-ID: <Pine.GSO.3.96.1020118223709.22923T-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 18 Jan 2002, Justin Carlson wrote:

> We could, theoretically, free up k1 or k0 (but not both) at the expense
> of some time in the stackframe setup at the userland/kernel boundary and
> some time in the fast TLB handler.  This wouldn't be read-only from
> userland, though, but is that really a hard requirement?  

 Much, *much* time, especially in the case of TLB exceptions.

> There is precedent for hijacking some CP0 registers for purposes other
> than originally intended, e.g., the WATCH registers for holding the
> kernel stack pointer.  I don't have a mips spec in front of me, though,

 That's not used exactly a stack pointer, but as a safeguard.  I'm still
thinking on a better use of this register, i.e. as a watchpoint for gdb. 

> so I don't know if any CP0 registers are readable from userland: I seem
> to remember that all mfc0 ops are priveleged at the instruction level,
> not the register level, though.

 Technically you can make cp0 registers r/w accessible from the userland,
but that's unacceptable for us.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
