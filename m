Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34CI6Z14316
	for linux-mips-outgoing; Wed, 4 Apr 2001 05:18:06 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34CI1M14310
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 05:18:02 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA14379;
	Wed, 4 Apr 2001 14:15:42 +0200 (MET DST)
Date: Wed, 4 Apr 2001 14:15:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Florian Lohoff <flo@rfc822.org>, Jun Sun <jsun@mvista.com>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <Pine.GSO.4.10.10104041213260.17324-100000@escobaria.sonytel.be>
Message-ID: <Pine.GSO.3.96.1010404140642.6521C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 4 Apr 2001, Geert Uytterhoeven wrote:

> What about modifying dpkg so it can install the lib and include parts of
> non-native packages for arch $ARCH in /usr/$ARCH-linux/? Thay way you can
> easily install *-dev packages for cross-development.

 I'm not sure if that actually solves the problem.  I think
cross-compilation libraries need to be built specifically for this purpose
as bits might be different, such as in the case of
/usr/mipsel-linux/lib/libc.so, which has to be different from the
mipsel-linux native /usr/lib/libc.so.  Cross-compilation libraries might
be built as noarch packages as they are actually independent from the
build system they are installed on. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
