Received:  by oss.sgi.com id <S305158AbQBPKwK>;
	Wed, 16 Feb 2000 02:52:10 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:25167 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBPKvn>;
	Wed, 16 Feb 2000 02:51:43 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA05719; Wed, 16 Feb 2000 02:47:11 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA52135
	for linux-list;
	Wed, 16 Feb 2000 02:40:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA66026
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 16 Feb 2000 02:40:44 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06688
	for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 02:40:48 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA00085;
	Wed, 16 Feb 2000 02:40:38 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA22938;
	Wed, 16 Feb 2000 02:40:31 -0800 (PST)
Message-ID: <003101bf786a$8c44d150$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>,
        <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: Indy crashes
Date:   Wed, 16 Feb 2000 11:42:29 +0100
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

Ralf Baechle writes:
>On Tue, Feb 15, 2000 at 11:23:49PM +0100, Kevin D. Kissell wrote:
>>                                   The R5000 manual states that there
>> should be "at least two integer instructions between" any
>> instruction modifying the PageMask, EntryHi, or EntryLo[01]
>> registers and the subsequent tlbw[ir] or tlbp.  That's different
>> from the R4000.  In the current Linux arch/mips/head.S file, 
>> this interval does not seem to be respected by any of the TLB 
>> miss handlers.  Indeed, the default except_vec0_r4000 handler,
>> which I believe is what is used if an R5000 is detected, has 
>> the sequence
>> 
>>         mtc0    k1, CP0_ENTRYLO1                # load it
>>         b       1f
>>          tlbwr                                  # write random tlb entry
>> 1:
>>         nop
>>         eret
>> 
>> wherin the purpose of the branch is obscure (I imagine
>> it fixed a bug seen somewhere on some CPU but it
>> makes me rather queasy)  but wherein in any case we 
>> do not seem to be assured 2 issues between the mtc0 
>> and the tlbwr.  It should be OK for an R4000, but not for 
>> an R5000.
>
>No, it's not a bug workaround.  The reason for this branch is that the
>R4000 and R4400 have a penalty of three cycles for a taken branch.  So
>the branch above is equivalent with 
>
> mtc0 k1, CP0_ENTRYLO1
> nop
> tlbwr
> nop
> nop
> nop
> eret
>
>Funky trick, isn't it?  I don't have the the R4600 / R5000 docs at hand
>but as I understood them the above code should also work just perfect
>for them.

No.  Not as I read the specs.  There are three problems here.

First, the question is *not* one of no-ops between the TLBWR
and the ERET, but of no-ops between the MTC0 and the
TLBWR - re-read the quoted text above from my previous
message.  So the code may well be broken as I conjectured
even if your assumption about the branch delay was valid.

Second, the R5000 and R4600 piprlines are not as deep
as those of the R4000/4400.   The R5000 documentation
calls out a branch implementation with a *single* delay cycle.
I quote: "The one cycle branch delay is a result of the branch
comparison logic operating during the 1A pipeline stage of
the branch.  This allows the branch target address calculated
in the previous stage to be used for the instruction access in
the following 1I phase."   So even if the execution of the
branch were inserting delay between the MTC0 and the
TLBWR as you seemed to assume, it might not be inserting
as much delay as you think.

Thirdly, this whole thread underscores why "clever" solutions that 
depend on implementation features of particular CPUs should 
be avoided whenever possible. If you want to be assured of
getting a delay cycle in a MIPS instruction stream, you should
use a "SSNOP", (sll r0,r0,1 as opposed to the "nop" sll r0,r0,0),
which forces delays even in superscalar implementations.

>> So someone with the ability to reproduce the R5000
>> problem should really try sticking a nop between the
>> mtc0 and the branch (sigh) to see if that stabilizes 
>> the system.

I still think this would be a good idea.  Further, from Bill Earl's
comment on this same thread, it sounds like, to be conservative,
 trap_init() in arch/mips/kernel/traps.c needs to detect the R5000
case and patch in except_vec0_r45k_bvahwbug instead
of except_vec0_r4000, and that furthermore a nop (or ssnop) 
be added between the MTC0 and the branch of 
except_vec0_r45k_bvahwbug.

>Talking about CPU bugs - the R5230 and maybe it's relatives needs a nasty
>workaround.  I think I only put the workaround into the Cobalt kernel.
>Of course IDT doesn't admit that this bug even exists ...


Um, why should they, when IDT didn't do the R5230?  ;-)
Seriously, did you mean to refer to the R323xx from IDT,
or to QED as the design house for the R5230?  I have been 
running 2.2.12 on an R5260 for months and it has been very 
stable.   To which bug and which workaround are you referring?


            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
