Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PBchx11417
	for linux-mips-outgoing; Mon, 25 Mar 2002 03:38:43 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PBcdq11414
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 03:38:39 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA05215;
	Mon, 25 Mar 2002 12:40:09 +0100 (MET)
Date: Mon, 25 Mar 2002 12:40:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@csn.ul.ie>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: declance multicast filter fixes
In-Reply-To: <Pine.LNX.4.32.0203241349380.32481-100000@skynet>
Message-ID: <Pine.GSO.3.96.1020325123322.4605A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 24 Mar 2002, Dave Airlie wrote:

> well it should work for the PMAD and I've got a version for the VAX that
> splits off from my one, the VAX uses a similiar wiring as the DS5000/200,
> I've been waiting for the LANCE core to be separated out a lot of people
> have talked about it and I hear for 2.5 maybe someone is actually going to
> do it ...

 Well, the core seems to be already separated -- see drivers/net/7990.c.
I haven't yet checked how suitable it is and many front-end drivers use it
already.

 For the I/O ASIC front-end I'm going to check if the ASIC is capable of
mapping the LANCE more sensibly before starting any further work.  The
current configuration is a major loss, doubling the CPU's work and I can't
see any reasonable explanation for such a setup.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
