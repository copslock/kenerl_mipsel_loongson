Received:  by oss.sgi.com id <S305168AbQCHUWW>;
	Wed, 8 Mar 2000 12:22:22 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:43577 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQCHUWH>; Wed, 8 Mar 2000 12:22:07 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA06936; Wed, 8 Mar 2000 12:25:23 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA00723
	for linux-list;
	Wed, 8 Mar 2000 12:10:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA18083
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 12:10:05 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06810
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 12:10:04 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA04767;
	Wed, 8 Mar 2000 12:09:58 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA07519;
	Wed, 8 Mar 2000 12:09:56 -0800 (PST)
Message-ID: <042401bf893a$b15465b0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Cc:     "Linux SGI" <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: FP emulation patch available
Date:   Wed, 8 Mar 2000 21:12:49 +0100
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

>For the records (Sharp Mobilon HC-4500):
>
>Philips PR31700 (identical to Toshiba TMPR3912) @ 73.7 MHz, Implementation 0x22
>(same as R46[45]0), Revision 0x10 (does anybody know what R46[45]0 have?).
>
>Based on an R300A core with some ISA-II extensions, 1KB instruction cache, and
>4KB write-through data cache, 32 TLB entries.

If Philips/Tosh are really aliasing the PrID of the R4650, sombody has
done something Deeply Evil (and probably in violation of one agreement
or another).  I'm checking with MIPS HQ on this, and hoping that in fact
the R4650 value in the source code is in error.

If the Implementations *do* collide, we can still cope as long as the
revision codes do not.  The cpu_probe code first looks for a match
on Implementation+Revision, and then, that failing, looks for a match
on implementation alone.   So we could contrive to have 0x2210
resolve to CPU_R3900 and all other 0x22xx values to the R4650.
But I don't like it one bit.

>Back on topic:
>
>My Mobilon dies horribly with the screen going blank and even a soft reset
>doesn't revive it. All that helps is to remove all batteries. No error messages
>can be seen.
>
>My DS 5000/133 (R3000A) with FPU disabled and FPU emulation shows:
> Illegal instruction 00000034 at 801ce924, ...
>
>System.map shows:
> 801ce920 b dsemul_insns
> 801ce928 b dsemul_cpc
>
>Looks like your trick in mips_dsemul() doesn't work too well for ISA-I CPUs. Do
>you have an idea for an alternative?


Yes, and I should have thought of it earlier. The original Algorithmics
implementation, in fact, used the system call trap vector instead of the
Trap instruction vector to implement the trampoline for the delay slot
emulation.   Although I try to make sure that interrupts are disabled
during the operation, I was less than 100% confident that I could prevent
the Linux scheduler from executing, and stealing a seldom-used vector
seemed more prudent at the time.   In retrospect, I think I probably should
have generated an Address Error.  It'll be a pretty small hack - I'll see if I
can't turn it around this weekend.

FWIW, the current version of the emulator presumably might not have
paniced on you - I recently put the trampoline code on the user stack
where it belongs, so it can execute in user mode.   I haven't got around
to mentioning it on the web page, but you can find the patch on
ftp.paralogos.com in /pub/linux/mips/kernel with a fairly self-evident file
name.

            Kevin K.
