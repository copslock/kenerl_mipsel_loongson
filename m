Received:  by oss.sgi.com id <S305166AbQCHTAW>;
	Wed, 8 Mar 2000 11:00:22 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10032 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQCHTAA>; Wed, 8 Mar 2000 11:00:00 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA00894; Wed, 8 Mar 2000 11:03:16 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA25886; Wed, 8 Mar 2000 10:59:29 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA44066
	for linux-list;
	Wed, 8 Mar 2000 10:43:13 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA53940
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 10:43:03 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA02672
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 10:43:02 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port69.duesseldorf.ivm.de [195.247.65.69])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA09244;
	Wed, 8 Mar 2000 19:42:49 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000308194339.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <025701bf88e2$c648a7e0$0ceca8c0@satanas.mips.com>
Date:   Wed, 08 Mar 2000 19:43:39 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: FP emulation patch available
Cc:     Linux SGI <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi Kevin,

On 08-Mar-00 Kevin D. Kissell wrote:
> Anyway, the my CPU detection would certainly not have worked for
> a Mobilon.   But it ought to have worked for a DECstation.  What
> CPU does it have?   In addition to the cpu_probe() routine itself,
> arch/mips/kernel/cpu_probe.c contains a table that describes the
> CPU's that are recognized, and in principle it "knows" all the CPUs
> that were recognized by the old assembler code in head.S, plus
> a couple more (R4300 and MIPS 4Kc/5Kc).   The problem may
> be a CPU that is mis-identified, or it may be that the options in the
> table associated with that CPU are incorrectly defined.  Please
> let me know what CPU and "PrID" the system has.

Been there, done that. It was just a missing case statement that got lost during
the merge :-)

For the records (Sharp Mobilon HC-4500):

Philips PR31700 (identical to Toshiba TMPR3912) @ 73.7 MHz, Implementation 0x22
(same as R46[45]0), Revision 0x10 (does anybody know what R46[45]0 have?).

Based on an R300A core with some ISA-II extensions, 1KB instruction cache, and
4KB write-through data cache, 32 TLB entries.

Back on topic:

My Mobilon dies horribly with the screen going blank and even a soft reset
doesn't revive it. All that helps is to remove all batteries. No error messages
can be seen.

My DS 5000/133 (R3000A) with FPU disabled and FPU emulation shows:
 Illegal instruction 00000034 at 801ce924, ...

System.map shows:
 801ce920 b dsemul_insns
 801ce928 b dsemul_cpc

Looks like your trick in mips_dsemul() doesn't work too well for ISA-I CPUs. Do
you have an idea for an alternative?

-- 
Regards,
Harald
