Received:  by oss.sgi.com id <S554023AbQLDSOk>;
	Mon, 4 Dec 2000 10:14:40 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:6918 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S554019AbQLDSOf>; Mon, 4 Dec 2000 10:14:35 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JXBFP7MBKQ0014XM@research.kpn.com> for
 linux-mips@oss.sgi.com; Mon, 4 Dec 2000 19:14:32 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id TAA06250; Mon,
 04 Dec 2000 19:14:30 +0100 (MET)
Date:   Mon, 04 Dec 2000 19:14:30 +0100
From:   "Houten K.H.C. van (Karel)" <K.H.C.vanHouten@research.kpn.com>
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Subject: Re: [SUCCESS] 2.4.0-test11 on Decstation 5000/150 (R4000)
In-reply-to: "Your message of Sun, 03 Dec 2000 17:04:30 +0100."
 <20001203170430.A1504@paradigm.rfc822.org>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com, K.H.C.vanHouten@research.kpn.com
Reply-to: K.H.C.vanHouten@kpn.com
Message-id: <200012041814.TAA06250@sparta.research.kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



Florian Lohoff writes:
>
>Hi,
>here is the short output - We needed to change ethernet, scsi
>initialization and the vmalloc bug ...
>
> ... successfull decstation boot of linux 2.4-test11

I did try some kernel compiles with my new toolchain on my decstation,
with the following result:

egcs-1.0.3a-1 / binutils-2.10.91-1lm : Userland compiles fine,
				       Kernel compile fails
egcs-1.0.2-9 / binutils-2.8.1-2D1 : Kernel compiles OK.

Florian, do you compile native? and with which compiler / binutils?

Has anyone else a working toolchain for native building on mipsel ?

Regards,
Karel.
