Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MCTSRw022773
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 05:29:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MCTS0M022772
	for linux-mips-outgoing; Mon, 22 Jul 2002 05:29:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MCTMRw022763
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 05:29:23 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA03605;
	Mon, 22 Jul 2002 14:30:42 +0200 (MET DST)
Date: Mon, 22 Jul 2002 14:30:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Current CVS (2.4.19-rc1) broken on DECstations
In-Reply-To: <20020719175712.A651@excalibur.cologne.de>
Message-ID: <Pine.GSO.3.96.1020722142359.2373B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 19 Jul 2002, Karsten Merker wrote:

> Thanks, the LANCE works again with your patch, but I have discovered another
> problem: hwclock does not work (it did wth earlier kernels).
> 
> "hwclock --show" results in
> 
> hwclock: ioctl() to /dev/rtc to turn on update interrupts failed unexpectedly,
> errno=25: Inappropriate ioctl for device.

 You need updated util-linux.  I've sent a fix to Andries and it's already
present in the current release.  So please just get util-linux 2.11t from
the usual place or grab a patched version of 2.11q from my site (I had no
time to build a newer version, yet). 

 The problem is not specific to the DECstation, though. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
