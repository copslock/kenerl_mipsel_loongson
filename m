Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f31HLx614410
	for linux-mips-outgoing; Sun, 1 Apr 2001 10:21:59 -0700
Received: from hermes.research.kpn.com (hermes.research.kpn.com [139.63.192.8])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f31HLsM14407
	for <linux-mips@oss.sgi.com>; Sun, 1 Apr 2001 10:21:54 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K1WAD15Q2E000Q0N@research.kpn.com> for
 linux-mips@oss.sgi.com; Sun, 1 Apr 2001 19:21:52 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id TAA13517; Sun,
 01 Apr 2001 19:21:50 +0200 (MET DST)
Date: Sun, 01 Apr 2001 19:21:50 +0200
From: "Houten K.H.C. van (Karel)" <K.H.C.vanHouten@research.kpn.com>
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Subject: Re: rpm crashing on RH 7.0 indy
In-reply-to: "Your message of Wed, 28 Mar 2001 15:50:34 +0200."
 <Pine.GSO.3.96.1010328154420.24847A-100000@delta.ds2.pg.gda.pl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>,
   Keith M Wesolowski <wesolows@foobazco.org>, David Jez <dave.jez@seznam.cz>,
   Karel van Houten <vhouten@kpn.com>, linux-mips@oss.sgi.com
Reply-to: vhouten@kpn.com
Message-id: <200104011721.TAA13517@sparta.research.kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Maciej,

"Maciej W. Rozycki" writes:
>On Wed, 28 Mar 2001, Carsten Langgaard wrote:
>
>> Have the kernel fix made it into the CVS.
>> If not, could you please resent it.
>
> I do not consider it clean enough for inclusion into the official kernel
>at this stage.  It works, though.
>
> When appropriately cleaned up, I'll submit it to Linus as it's not
>MIPS-specific and affects all systems -- mmap() fails equally badly on an
>i386, for example.  No time to work on the patch at the moment, sorry.

I applied this patch to a 2.4.2 CVS checkout, and indeed,
the crashing rpm problem vanished.

Thanks Maciej!

Regards, 
Karel.
