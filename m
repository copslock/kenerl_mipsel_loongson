Received:  by oss.sgi.com id <S553828AbRCNWIN>;
	Wed, 14 Mar 2001 14:08:13 -0800
Received: from mx2.mips.com ([206.31.31.227]:18845 "EHLO mx2.mips.com")
	by oss.sgi.com with ESMTP id <S553825AbRCNWIA>;
	Wed, 14 Mar 2001 14:08:00 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id OAA24456;
	Wed, 14 Mar 2001 14:07:59 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA28323;
	Wed, 14 Mar 2001 14:07:56 -0800 (PST)
Message-ID: <00fc01c0acd3$c881ca80$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     <linux-mips@oss.sgi.com>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org>
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Date:   Wed, 14 Mar 2001 23:11:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > If it does, I can probably whip up a -mmad patch to binutils to allow
> > those opcodes - or I could introduce -mnevada, or whatever the
> > appropriate term would be, to mean "r8000 with the mad* extensions". 
> > In fact, that would probably be easiest, and sounds like the most
> > correct.
> 
> Don't think of the r8000; the kernel only uses the -mcpu=r8000 option
> because the Nevada CPUs have _somewhat_ similar scheduling properties
> to the R8000.  This of it as an independant ISA expension which can
> be used with an arbitrary MIPS processor - even a R3000 processor.

In the interests of historical accuracy and general pedantry,
let me point out that -mcpu=r8000 is in effect a rather klugy
way of saying "-mips4" to compilers that predate official
MIPS IV ISA support.  The R8000 was the first MIPS IV
CPU, followed by the R10000 and the R5000.  The "Nevada"
processors added three implementation specific instructions
to the MIPS IV ISA: MAD, MADU, and MUL (targeted multiply).
"Correct" usage would be to enable those three instructions
with a "-mcpu=nevada", or better still, "-mcpu=r5200" (for 
consistency), and to enable the rest of the MIPS IV ISA 
with "-mips4" instead of the archaic r8000 hack.

Note, furthermore, that -mmad needs to be handled with care: 
Prior to MIPS standardizing the instruction as part of 
MIPS32, there were four or five subtly (or not so subltly) 
different definitions of integer multiply-accumulate for MIPS.  
Most use the same opcode, but even those can differ in side 
effects (is the rd field interpreted, etc.). A R4650 madd operation
will probably behave equivalently on a Nevada CPU, 
but certainly not on a Vr41xx part, for example.

            Regards,

            Kevin K.
