Received:  by oss.sgi.com id <S305160AbQBOXTQ>;
	Tue, 15 Feb 2000 15:19:16 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:59225 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBOXSq>;
	Tue, 15 Feb 2000 15:18:46 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA07408; Tue, 15 Feb 2000 15:14:15 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA54855
	for linux-list;
	Tue, 15 Feb 2000 14:28:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA88401
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 15 Feb 2000 14:28:52 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA22358
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Feb 2000 14:24:21 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA17249;
	Tue, 15 Feb 2000 14:21:55 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA03662;
	Tue, 15 Feb 2000 14:21:53 -0800 (PST)
Message-ID: <006501bf7803$59855ad0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Cc:     "Ralf Baechle" <ralf@oss.sgi.com>, <linux@cthulhu.engr.sgi.com>,
        <linux-mips@fnet.fr>, <linux-mips@vger.rutgers.edu>
Subject: Re: Indy crashes
Date:   Tue, 15 Feb 2000 23:23:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>> The problem may be in the assumption made even in the
>> most recent 2.3.x code that a hit-writeback-invalidate cache
>> operation on the secondary cache automagically affects the
>> primary.  That's the way it is on the R4000/4400, but that's
>
>In that case it doesn't affect the NEC DDB Vrc-5074, since there's no L2.


If it isn't the cache, and it tracks the CPU type, the next thing
I suspect is a pipe hazard.   The R5000 manual states that there
should be "at least two integer instructions between" any
instruction modifying the PageMask, EntryHi, or EntryLo[01]
registers and the subsequent tlbw[ir] or tlbp.  That's different
from the R4000.  In the current Linux arch/mips/head.S file, 
this interval does not seem to be respected by any of the TLB 
miss handlers.  Indeed, the default except_vec0_r4000 handler,
which I believe is what is used if an R5000 is detected, has 
the sequence

        mtc0    k1, CP0_ENTRYLO1                # load it
        b       1f
         tlbwr                                  # write random tlb entry
1:
        nop
        eret

wherin the purpose of the branch is obscure (I imagine
it fixed a bug seen somewhere on some CPU but it
makes me rather queasy)  but wherein in any case we 
do not seem to be assured 2 issues between the mtc0 
and the tlbwr.  It should be OK for an R4000, but not for 
an R5000.

So someone with the ability to reproduce the R5000
problem should really try sticking a nop between the
mtc0 and the branch (sigh) to see if that stabilizes 
the system.

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68

    
