Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GJnHR22786
	for linux-mips-outgoing; Mon, 16 Jul 2001 12:49:17 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GJnEV22777
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 12:49:15 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA22184;
	Mon, 16 Jul 2001 21:51:12 +0200 (MET DST)
Date: Mon, 16 Jul 2001 21:51:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Mike McDonald <mikemac@mikemac.com>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
In-Reply-To: <20010716115012.A32434@lucon.org>
Message-ID: <Pine.GSO.3.96.1010716214033.12988I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 16 Jul 2001, H . J . Lu wrote:

> You must be using a broken Linux. /bin/ls in my RedHat 7.1/mips doesn't
> use pthreads.

 Which version of ls?  Versions up to 4.0 did not, indeed.

 Of course, you may force version 4.1 not to make use libpthreads, either. 
Just convince the configure script in the usual way not to use
clock_gettime().

 I just checked ls 4.1 compiled for i386-linux in a glibc 2.2.3
environment:

$ LD_TRACE_LOADED_OBJECTS=1 ls
	librt.so.1 => /lib/librt.so.1 (0x40020000)
	libc.so.6 => /lib/libc.so.6 (0x40032000)
	libpthread.so.0 => /lib/libpthread.so.0 (0x4015a000)
	/lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

so it's not MIPS-specific at all...  Why would it, anyway? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
