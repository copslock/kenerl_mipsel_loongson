Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SKKIq02722
	for linux-mips-outgoing; Mon, 28 May 2001 13:20:18 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SKJkd02699
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 13:19:47 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA23240;
	Mon, 28 May 2001 15:59:30 +0200 (MET DST)
Date: Mon, 28 May 2001 15:59:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
In-Reply-To: <005901c0e77c$dae9f2e0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010528155039.15200F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 28 May 2001, Kevin D. Kissell wrote:

> I'd been disassembling the resulting .o files, as I didn't care whether
> it's the compiler or the assembler that ultimately makes things right.

 It's good to check the generated assembly if you suspect a tool bug.

> Repeating your experiment using -S gives the following results:

 Thanks for testing other versions.

> However, if one compiles all the way to object code and looks
> at what the assembler is actually doing with those "impossible"
> offsets under gcc 2.90 and 2.91, technically, it's not violating ".noat"
> in the "m" and "o" constraint  cases.   It is *not* using the "at" register.
> It is, however, cleverly using the load destination  register as a temporary
> to calculate  the correct address.  As there are no memory operations,

 That's clever, indeed...

> these instructions should have no effect  on the correct execution
> of the ll/sc sequence  (though they will  increase the statistical
> probability
> of a context  switch between ll and sc).

 ... but that won't work for a lone store, so we need a properly working
'R' constraint in the compiler.  Since 3.0 works, as you report, there is
no need to worry (but I might consider backporting changes to 2.95.3).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
