Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5BHClH12519
	for linux-mips-outgoing; Mon, 11 Jun 2001 10:12:47 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5BHAVV12396;
	Mon, 11 Jun 2001 10:10:32 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA04812;
	Mon, 11 Jun 2001 19:08:59 +0200 (MET DST)
Date: Mon, 11 Jun 2001 19:08:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: Does anyone know this?
In-Reply-To: <20010609162404.A8916@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010611181925.26184C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 9 Jun 2001, Ralf Baechle wrote:

> > Does anyone know this?
> > 
> > http://mail-index.netbsd.org/port-mips/2001/05/24/0002.html
> > 
> > Do we still have the pthread problems mentioned there?
> 
> The varargs bug afair was fixed in glibc by Chris Johnson and Andreas
> Jaeger and Maciej recently posted a patch for the kernel to linux-kernel.

 We have a _test_and_set() implementation in glibc for some time now,
actually -- what is problematic (buggy), is the underlying kernel
emulation for MIPS I systems.  There is no consensus if the patch is fine,
due to a bit non-standard calling convention, I'm afraid.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
