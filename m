Received:  by oss.sgi.com id <S553832AbRCNWnz>;
	Wed, 14 Mar 2001 14:43:55 -0800
Received: from mx2.mips.com ([206.31.31.227]:33181 "EHLO mx2.mips.com")
	by oss.sgi.com with ESMTP id <S553830AbRCNWni>;
	Wed, 14 Mar 2001 14:43:38 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id OAA24642
	for <linux-mips@oss.sgi.com>; Wed, 14 Mar 2001 14:43:37 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA29541;
	Wed, 14 Mar 2001 14:43:34 -0800 (PST)
Message-ID: <011001c0acd8$c27a9220$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     <linux-mips@oss.sgi.com>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org> <00fc01c0acd3$c881ca80$0deca8c0@Ulysses>
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Date:   Wed, 14 Mar 2001 23:47:31 +0100
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

> "Correct" usage would be to enable those three instructions
> with a "-mcpu=nevada", or better still, "-mcpu=r5200" (for 
> consistency), and to enable the rest of the MIPS IV ISA 
> with "-mips4" instead of the archaic r8000 hack.

I should add "Correct", but not useful for 32-bit
kernels.  "-mips32", once that percolates through
the gcc food chain, would be *almost* perfect
for 32-bit Nevada kernels.  I say almost, because
while MIPS32 is 32-bit MIPS IV plus MADD, it also
has a handfull of instructions that are not supported 
by the R52xx, of which it is wildly improbable but 
theoretically possible that the multiply-subtracts
might somehow get emitted in compiled application
code. It should work just fine for kernel purposes, though.

Meanwhile, try piping objdump of a "-mmad" kernel
through "grep -i mad".  I'd be stunned if a single MADD
turned up.  If it gains nothing, but breaks builds, then
for heaven's sake banish -mmad from the kernel
makefiles!

            Regards,

            Kevin K.
