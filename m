Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JH7iRw004162
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 10:07:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JH7iqx004161
	for linux-mips-outgoing; Fri, 19 Jul 2002 10:07:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JH7bRw004149
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 10:07:38 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.11.6) with ESMTP id g6JH8Gr02138;
	Fri, 19 Jul 2002 19:08:16 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id TAA04858;
	Fri, 19 Jul 2002 19:08:16 +0200 (MET DST)
Message-Id: <200207191708.TAA04858@sparta.research.kpn.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card? 
In-reply-to: Your message of "Thu, 18 Jul 2002 18:39:09 +0200."
             <Pine.GSO.3.96.1020718173747.14993E-100000@delta.ds2.pg.gda.pl> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Date: Fri, 19 Jul 2002 19:08:16 +0200
From: "Houten K.H.C. van (Karel)" <karel@kpn.com>
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Maciej,

"Maciej W. Rozycki" writes:
>
> OK, more writeback fixes.  Please get the following patches: 
>
>- patch-mips-2.4.18-20020530-mb-wb-8.gz,
>
>- patch-mips-2.4.18-20020625-wbflush-7.gz
>
>from 'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/' and replace the hack I
>sent you yesterday with the following real fix.  After applying the three
>patches you need to rebuild the kernel from scratch, i.e. do `make
>oldconfig dep clean boot modules' as the two above patches modify the
>kernel's configuration.
>
> Please report if this works or not. 

Yes! Now I can use the TC PMAZ-AA without problems. I've copied
some data around, without any problems. Fsck found no problems
on the fs on that drive.

Thanks a lot.

Will these patches go into the oss CVS (2.4) tree?

BTW: Are your patches to the declance driver in a way that we can use
one unified driver for the /240 and the /200 systems? I still use
the driver modified by Dave for my /200 kernels.

Regards,
Karel.
