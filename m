Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SE3qn23434
	for linux-mips-outgoing; Mon, 28 May 2001 07:03:52 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SE3Kd23421
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 07:03:22 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA18358;
	Mon, 28 May 2001 13:20:41 +0200 (MET DST)
Date: Mon, 28 May 2001 13:20:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
In-Reply-To: <00c901c0e631$4bcebd80$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010528131446.15200C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 27 May 2001, Kevin D. Kissell wrote:

> Fair enough.  It was an offhand remark.  But seriously, what does
> the "R" constraint mean here?  The only documentation I've got
> (http://linux.fh-heilbronn.de/doku/GNU/docs/gcc/gcc_163.html#SEC163)

 `info gcc' has most relevant data, at least for 2.95.3.

> says that "Q" through "U" are reserved for use with EXTRA_CONSTRAINT
> in machine-dependent definitions of arbitrary operand types.  When
> and where does it get bound for MIPS gcc, and what is it supposed
> to mean?  If I compile this kind of fragment using a "m" constraint,
> it seems to do the right thing, at least on my archaic native compiler.

 Is it gcc generating right code or gas expanding a macro?  Try `gcc -S'
-- for me "m" generates "lw $0,262144($2)", which is unacceptable when
".set noat" is in effect (and perfectly fine otherwise). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
