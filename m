Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SHtav31896
	for linux-mips-outgoing; Mon, 28 May 2001 10:55:36 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SHtPd31883
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 10:55:26 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA29654;
	Mon, 28 May 2001 19:10:56 +0200 (MET DST)
Date: Mon, 28 May 2001 19:10:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <00d001c0e792$d48b14e0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010528190412.15200Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 28 May 2001, Kevin D. Kissell wrote:

> Use a global variable testable by the inline code?

 With both variants inlined?  Now that's really ugly.

> >  Are vr41xx plain ISA I or crippled ISA II+ CPUs?
> 
> Actually, they are crippled MIPS III+ 64-bit CPUs

 Then an ll/sc and lld/scd emulation seems to be most appropriate here.  I
don't think we want to add _test_and_set() to mips64*-linux. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
