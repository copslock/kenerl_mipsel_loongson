Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57AvXQ15233
	for linux-mips-outgoing; Thu, 7 Jun 2001 03:57:33 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57AvHh15180
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 03:57:20 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA05824;
	Thu, 7 Jun 2001 12:37:28 +0200 (MET DST)
Date: Thu, 7 Jun 2001 12:37:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010606132402.A27901@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1010607123246.4624B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Jun 2001, Daniel Jacobowitz wrote:

> >  Make sure your kernel is flushing the icache right. 
> 
> Hmm, thanks, I'll check.  I don't think that's it, though.

 This happened to me once.  Otherwise, it looks like gdb doesn't recognize
a breakpoint for some reason -- possibly it places it at a wrong address. 
It shouldn't be difficult to debug -- you get information of the address
the trap happened. 

> Nope.  It's based mostly on the same 4.17 patch from David Miller, and
> some bits from Ralf, all marked as assigned to the FSF (though I'm not
> sure if that ever actually happened); I'll straighten out copyright
> once I've got the whole thing done.

 You need to contact David, then.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
