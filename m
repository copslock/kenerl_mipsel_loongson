Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JBe2Rw022337
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 04:40:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JBe2rJ022336
	for linux-mips-outgoing; Fri, 19 Jul 2002 04:40:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JBdqRw022321
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 04:39:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA08021;
	Fri, 19 Jul 2002 13:40:53 +0200 (MET DST)
Date: Fri, 19 Jul 2002 13:40:52 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@skynet.ie>
cc: vhouten@kpn.com, linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
In-Reply-To: <62037.63.84.187.40.1027074088.squirrel@www.csn.ul.ie>
Message-ID: <Pine.GSO.3.96.1020719123022.6067A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dave,

> about 30 mins coding should be able to hack around the two cards in one
> system issue :-) (Flo did some work already).

 Of course, if you have them, then don't hesitate to do that.  I'm going
to clean the driver up soon, but it's not a priority for me.

> only esp_virt_buffer and  scsi_current_length globals are used for the
> PMAZ-A as far as I know, and only in the read path between
> pmaz_dma_init_read and pmaz_dma_drain, also maybe the pmaz_cmd_buffer when
> I look at it.

 Exactly.

> if there is nowhere in the esp to place them perhaps a priv void * needs
> to be added to the NCR core code and used to store this stuff, I meant to
> do it at the time, but twas 2 years ago and at the moment I'm nearly as
> far away from my DecStation as physically possible and not getting any
> closer for the forseeable :-)

 No need to, "struct NCR_ESP" provides esp_id which may be used to index
private data.

> My reason of course was I didn't really know much about TC and that such a
> card existed orignally, and the original code only handled one IO-ASIC
> (which I think is okay)...

 Well, existing hardware permits up to six TC cards to be put into a
single system.  That's the limit for Alpha systems; for the DECstation,
the limit is three (and you have an additional one onboard).

 Additionally, there exist dual-channel SCSI cards, namely PMAZB-A and
PMAZC-A, of which the former uses NCR 53C84 chips and the latter one uses
NCR 53C84F ones which are handled by the NCR53C9x.c driver.  So
theoretically up to 14 HBAs of this type may exist in a single system (2
are onboard on most TC Alphas). ;-)

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
