Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HCBtRw022497
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 05:11:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HCBt4r022496
	for linux-mips-outgoing; Wed, 17 Jul 2002 05:11:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HCBlRw022487
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 05:11:47 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.11.6) with ESMTP id g6HCGjW12579;
	Wed, 17 Jul 2002 14:16:45 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id OAA00433;
	Wed, 17 Jul 2002 14:16:45 +0200 (MET DST)
Message-Id: <200207171216.OAA00433@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card? 
In-reply-to: Your message of "Wed, 17 Jul 2002 11:05:24 +0200."
             <Pine.GSO.3.96.1020717105027.13355F-100000@delta.ds2.pg.gda.pl> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jul 2002 14:16:45 +0200
From: "Houten K.H.C. van (Karel)" <karel@kpn.com>
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Maciej,


> > KN05 V2.1k
> > >>cnfg
> >  3: KN05     DEC      V2.1k    TCF0  (256 MB)
> >                                      (enet: 08-00-2b-37-63-76)
> >                                      (SCSI = 7)
> >  1: PMAZ-AA  DEC      V5.3d    TCF0  (SCSI = 7)
> 
>  Well, you have a mixed system, so it's quite possible PMAZ-A support does
> not work reliably anywhere.  I don't have such a card, but specs are
> available and the support code is about one screen long.  So it should be
> fairly trivial to verify -- I'll look at it. 
What do you mean by a mixed system?
 
>  Also you have a KN05 system, which doesn't help, unfortunately.  The KN05
> module implements aggressive posting of uncached (read: iomem) writes (see
> also /proc/interrupts on your system) and synchronization primitives are
> non-existent.  Since for half a year there is no agreement on how generic
> synchronization should look like for MIPS, I'm more and more tempted to
> add a local hack which at least will let DECstations to perform reliably.
> It's quite possible the lack of synchronization is the lone reason of your
> problems. 

Well, if there is anything I could do to help you by testing things,
I'm eager to do so. 

I also have a 5000/200 system. Would it be interesting to put the
PMAZ-AA into that system, and see how it behaves?

Regards,
Karel.


-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
