Received:  by oss.sgi.com id <S553938AbRASIlA>;
	Fri, 19 Jan 2001 00:41:00 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:23313 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553917AbRASIks>; Fri, 19 Jan 2001 00:40:48 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JZ352PSWSA0004RT@research.kpn.com> for
 linux-mips@oss.sgi.com; Fri, 19 Jan 2001 09:40:46 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id JAA13979; Fri,
 19 Jan 2001 09:40:44 +0100 (MET)
Date:   Fri, 19 Jan 2001 09:40:44 +0100
From:   "Houten K.H.C. van (Karel)" <K.H.C.vanHouten@research.kpn.com>
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Subject: Re: [PATCH] make drivers/scsi/dec_esp.c check request_irq return code
 (240p3) (fwd)
In-reply-to: "Your message of Fri, 19 Jan 2001 09:31:54 +0100."
 <Pine.LNX.4.05.10101190931310.27117-100000@callisto.of.borg>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/MIPS Development <linux-mips@oss.sgi.com>,
        Rasmus Andersen <rasmus@jaquet.dk>,
        K.H.C.vanHouten@research.kpn.com
Reply-to: K.H.C.vanHouten@kpn.com
Message-id: <200101190840.JAA13979@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: exmh version 1.6.5 12/11/95
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi all,

Geert Forwarded:
> Date: Wed, 17 Jan 2001 23:18:52 +0100
> From: Rasmus Andersen <rasmus@jaquet.dk>
> To: linux-kernel@vger.kernel.org
> Subject: [PATCH] make drivers/scsi/dec_esp.c check request_irq return code
>     (240p3)
> 
> Hi.
> 
> (I have not been able to find a maintainer for this code.)
> 
> This patch makes drivers/scsi/dec_esp.c check the return code of
> request_irq. It applies cleanly against 240p3 and ac9.
> 
> In the search_tc_slot loop I made it continue the search on failure
> for one slot. Would this be correct?
> 
> Please comment.

Would this be the cause of the problem I have in my 5000/260
that I can only use the on-board SCSI interface, and not
the TC scsi card (which should use the same driver)?

I hope to be able to test this patch this weekend!

Regards,
Karel.
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
