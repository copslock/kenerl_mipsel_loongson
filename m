Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KA5gnC019672
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 03:05:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4KA5gNZ019671
	for linux-mips-outgoing; Mon, 20 May 2002 03:05:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4KA5anC019668;
	Mon, 20 May 2002 03:05:37 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA23620;
	Mon, 20 May 2002 12:06:45 +0200 (MET DST)
Date: Mon, 20 May 2002 12:06:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, Daniel Jacobowitz <dan@debian.org>,
   Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
In-Reply-To: <20020519123059.E20670@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020520120546.19733B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 19 May 2002, Ralf Baechle wrote:

> Int vs. long was a very small issue as I discovered during porting for the
> first 64-bit machines, the IP22 and IP27.

 Well, the surprise is going to happen in drivers, I'm afraid...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
