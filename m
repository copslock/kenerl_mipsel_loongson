Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2RJ3Av06686
	for linux-mips-outgoing; Tue, 27 Mar 2001 11:03:10 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2RJ38M06683
	for <linux-mips@oss.sgi.com>; Tue, 27 Mar 2001 11:03:08 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA23797;
	Tue, 27 Mar 2001 21:02:36 +0200 (MET DST)
Date: Tue, 27 Mar 2001 21:02:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
cc: Simon Gee <simong@oz.agile.tv>, linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain
In-Reply-To: <200103202012.VAA07412@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1010327205904.17103B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 20 Mar 2001, Karel van Houten wrote:

> Well, I'm currently using:
> binutils 2.10.1
> gcc 2.95.3 (with Maciej's patches)
> glibc 2.2.2 (compiled with above toolchain).
> 
> This toolchain works for native compiles on my mipsel box.
> One drawback: I can't compile any kernels with this setup,
> For kernel compiles I use 2.8.1/egcs-2.90.27/glibc-2.0.6.

 What's wrong with the toolchain wrt the kernel now?  I've been compiling
2.4 kernels successfully till the end of January -- it's just a lack of
time and a nasty bug I want to track down that stop me from trying to
compile a new kernel these days.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
