Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SI7KC32547
	for linux-mips-outgoing; Mon, 28 May 2001 11:07:20 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SI6sd32513
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 11:06:55 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA26502;
	Mon, 28 May 2001 17:34:27 +0200 (MET DST)
Date: Mon, 28 May 2001 17:34:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@uni-koblenz.de>
cc: Joe deBlaquiere <jadb@redhat.com>, "Kevin D. Kissell" <kevink@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0ED686.C1D85CE1@mvista.com>
Message-ID: <Pine.GSO.3.96.1010528172454.15200I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 25 May 2001, Jun Sun wrote:

> Alright, I rolled my sleeve and digged into IRIX 6.5, and guess what? 
> sysmips() does NOT have MIPS_ATOMIC_SET (2001) on IRIX!  See the header below.

 I remember Ralf writing of this being a compatibility call with RISC/OS
(is it the original OS of MIPS, Inc.?), IIRC.  Ralf: am I right? 

> So apparently MIPS_ATOMIC_SET was invented for Linux only, probably just to
> implement _test_and_set().  (It would be interesting to see how IRIX implement
> _test_and_set() on MIPS I machines.  However, the machine I have access uses
> ll/sc instructions).

 Does IRIX actually run on anything below ISA II?

> To me, either 1.a) or 2) is fine with me, although I have a slight faovr over
> 2) (perhaps because I don't like assembly code and the extra "vertical"
> calling layer introduced in 1.a)

 What about 3) -- a new syscall with a different semantics and no need to
care about limitations of current implementations (especially the
sysmips() bag).  I've just sent a proposal for discussion.  I'm looking
forward for constructive feedback.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
