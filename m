Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQHMMd12319
	for linux-mips-outgoing; Mon, 26 Nov 2001 09:22:22 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQHMFo12314
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 09:22:16 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA03502;
	Mon, 26 Nov 2001 17:20:27 +0100 (MET)
Date: Mon, 26 Nov 2001 17:20:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: FPU interrupt handler 
In-Reply-To: <200111261407.PAA11348@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1011126171137.21598V-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karel,

> I'm using the RedHat 7.1 packages from oss:
> binutils-2.11.92.0.10-1.mips.rpm
> gcc-2.96-99.1.mips.rpm

 Can't comment on these.  I feel a bit uneasy about gcc 2.96, possibly due
to the way it was incarnated.  I'll probably switch directly to 3.x when
it's proved stable enough not to distract me from primary tasks.  I don't
know how much binutils 2.11.92.0.10 differ from the mainline.

> >  I may upload binaries of my kernels to my site if they are to be useful
[...]
> Yes please. I hope to get a new disk this week, so I can build a
> stable development server...

 OK -- I should have them by tomorrow.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
