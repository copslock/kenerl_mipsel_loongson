Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2011 16:29:21 +0100 (CET)
Received: from ixqw-mail-out.ixiacom.com ([66.77.12.12]:4460 "EHLO
        ixqw-mail-out.ixiacom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491094Ab1A1P3S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jan 2011 16:29:18 +0100
Received: from [10.64.33.43] (10.64.33.43) by IXCA-HC1.ixiacom.com
 (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Fri, 28 Jan 2011
 07:29:11 -0800
Message-ID: <4D42E0C6.4060406@ixiacom.com>
Date:   Fri, 28 Jan 2011 07:29:10 -0800
From:   Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Publishing mips_hpt_frequency in /proc/cpuinfo
References: <4D424D4B.5090002@ixiacom.com> <20110128105720.GA28544@linux-mips.org> <alpine.LFD.2.00.1101281326000.31804@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1101281326000.31804@localhost6.localdomain6>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <EChew@ixiacom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echew@ixiacom.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> The CPU clock frequency may change at any time due to clockscaling  A
> process might be rescheduled to another CPU running at a different clock
> rate.  A suspended process might miss counter wraparounds.
>
> This right approach is to handle this in a virtual syscall, something like
> vsys_clock_gettime().

Thomas Gleixner wrote:
> Right. We had this discussion on x86 over and over and using a
> vsyscall is the correct approach. That's also a huge win in general if
> you can avoid going into the kernel to read the time. gettimeofday()
> and clock_gettime() belong to the most frequently called syscalls on
> any Linux system.

Ralf, Thomas,

Yes, I have seen that code on x86, and I completely agree with you both. The scenarios
that Ralf described pertinent, but for my currently application the win of
not going to the kernel that Thomas described is much more important.

I would very much like to go down the vsyscall route, but I can't see any
of that infrastructure in the arch/mips subdirectories.

It seems to me that that work has not been started for MIPS.  Am I mistaken ?

[ I'm trying to figure out where I should start. ]


Looking in /proc/cpuinfo for x86 I see:

> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 28
> model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
> stepping        : 10
> cpu MHz         : 1666.670

This makes available the clock frequency of the CPU. To get similar information
for MIPS, I need to rummage around inside dmesg:

> CPU revision is: 00019374 (MIPS 24Kc)
> Atheros AR7161 rev 2, CPU:680.000 MHz, AHB:170.000 MHz, DDR:340.000 MHz

Would you be averse to publishing additional CPU information (include cpu MHz)
in /proc/cpuinfo for MIPS ?


Earl
