Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GJbuS21650
	for linux-mips-outgoing; Mon, 16 Jul 2001 12:37:56 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GJbrV21641
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 12:37:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA21956;
	Mon, 16 Jul 2001 21:40:01 +0200 (MET DST)
Date: Mon, 16 Jul 2001 21:40:01 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mike McDonald <mikemac@mikemac.com>
cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch 
In-Reply-To: <200107161847.LAA09164@saturn.mikemac.com>
Message-ID: <Pine.GSO.3.96.1010716213151.12988H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 16 Jul 2001, Mike McDonald wrote:

>   Not knowing anything about the glibc architecture, I have a dumb
> question: why is 'ls' doing anything at all with pthreads?

 A short answer: clock_gettime().

 A long one: clock_gettime(), which is defined by librt, which in turn
depends on libpthread.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
