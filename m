Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6H904Rw003391
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 02:00:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6H903ao003390
	for linux-mips-outgoing; Wed, 17 Jul 2002 02:00:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6H8xuRw003288
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 01:59:57 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA15068;
	Wed, 17 Jul 2002 11:05:24 +0200 (MET DST)
Date: Wed, 17 Jul 2002 11:05:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karel van Houten <karel@kpn.com>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
In-Reply-To: <200207161659.SAA17040@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1020717105027.13355F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karel,

> Usually I get SCSI bus problems when using the second chain.
> Even with devices that don't give any problems when connected to
> the on-board bus. Here is my boot log, with the scsi errors.
> In this case, I could use the disk on esp1, but I don't know
> if I can trust this...
> 
> KN05 V2.1k
> >>cnfg
>  3: KN05     DEC      V2.1k    TCF0  (256 MB)
>                                      (enet: 08-00-2b-37-63-76)
>                                      (SCSI = 7)
>  1: PMAZ-AA  DEC      V5.3d    TCF0  (SCSI = 7)

 Well, you have a mixed system, so it's quite possible PMAZ-A support does
not work reliably anywhere.  I don't have such a card, but specs are
available and the support code is about one screen long.  So it should be
fairly trivial to verify -- I'll look at it. 

 Also you have a KN05 system, which doesn't help, unfortunately.  The KN05
module implements aggressive posting of uncached (read: iomem) writes (see
also /proc/interrupts on your system) and synchronization primitives are
non-existent.  Since for half a year there is no agreement on how generic
synchronization should look like for MIPS, I'm more and more tempted to
add a local hack which at least will let DECstations to perform reliably.
It's quite possible the lack of synchronization is the lone reason of your
problems. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
