Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQEqA806281
	for linux-mips-outgoing; Mon, 26 Nov 2001 06:52:10 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQEpqo06266
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 06:51:56 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA28734;
	Mon, 26 Nov 2001 14:50:13 +0100 (MET)
Date: Mon, 26 Nov 2001 14:50:13 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com, karel@sparta.research.kpn.com
Subject: Re: FPU interrupt handler 
In-Reply-To: <200111261219.NAA10058@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1011126142508.21598H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karel,

> I would love to do more work on my DECstation, but I had some disk
> problems recently, and I don't seem te get any newer kernels
> then 2.4.0-test9 running after a native compile by the toolchain
> provided by H.J. Lu.

 Hmm, for R3k gcc 2.95.3 + binutils 2.11.2 as available at my site seem to
be rock solid.

 For R4k you need binutils 2.11.92, as there is a problem with dla/la
expansion in the Ulf's patch for .mips3+.  That actually can be fixed in
2.11.2 easily but I was going to switch to 2.11.92 anyway, as it has more
MIPS/Linux support integrated and 2.12 is supposedly soon to be released.
Unfortunately 2.11.92 is not as stable as 2.11.2 due to generic ELF code
problems, but I'm trying to track changes and spot a more stable snapshot.

> Some kernels don't start-up, others hang just before forking init,
> and all have problems with my serial console.

 Well, I'm very happy with a /240 running a 2.4.14 snapshot dated
20011123.  For a /260 I need a small, but critical bugfix I'm sending to
the list right now.  I wonder how was it possible for the bug to remain
uncovered for so long as it's absolutely lethal and often triggered (I've
only got my /260 recently and it wasn't even running a few minutes
continuously before the fix). 

 I can't comment other models.

> When I get a recent kernel running again, I would love to update my
> DECStation Linux Website with newer instructions and a new root FS.

 I may upload binaries of my kernels to my site if they are to be useful
-- they are fully monolithic (but with kmod support) due to historical
reasons.  Only IPv6 is modular due to its unstability -- it freezes the
system immediately on my /240 and splashes a bunch of suspicious messages
on my /260 (weird, but no time to debug).  They only support /240 and /260
due to CONFIG_CPU_HAS_WB unset.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
