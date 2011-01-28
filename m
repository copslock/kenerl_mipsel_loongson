Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2011 13:28:38 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:48301 "EHLO www.tglx.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491053Ab1A1M2f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jan 2011 13:28:35 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
        by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id p0SCSStB031011
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 28 Jan 2011 13:28:31 +0100
Date:   Fri, 28 Jan 2011 13:28:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Earl Chew <echew@ixiacom.com>, linux-mips@linux-mips.org
Subject: Re: Publishing mips_hpt_frequency in /proc/cpuinfo
In-Reply-To: <20110128105720.GA28544@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1101281326000.31804@localhost6.localdomain6>
References: <4D424D4B.5090002@ixiacom.com> <20110128105720.GA28544@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.3 at www.tglx.de
X-Virus-Status: Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Fri, 28 Jan 2011, Ralf Baechle wrote:
> On Thu, Jan 27, 2011 at 08:59:55PM -0800, Earl Chew wrote:
> 
> > The CPU frequency is known to the Linux kernel. For example:
> > 
> > > CPU revision is: 00019374 (MIPS 24Kc)
> > > Atheros AR7161 rev 2, CPU:680.000 MHz, AHB:170.000 MHz, DDR:340.000 MHz
> > > ...
> > > Calibrating delay loop... 452.19 BogoMIPS (lpj=2260992)
> > 
> > Unfortunately that information is not available from userspace:
> > 
> > > cpu model               : MIPS 24Kc V7.4
> > > BogoMIPS                : 452.19
> > 
> > This makes it difficult to use CPU timers (rdhwr) from user space
> > applications.
> > 
> > 
> > Is there any reason not to publish mips_hpt_frequency in /proc/cpuinfo ?
> 
> The CPU clock frequency may change at any time due to clockscaling  A
> process might be rescheduled to another CPU running at a different clock
> rate.  A suspended process might miss counter wraparounds.
> 
> This right approach is to handle this in a virtual syscall, something like
> vsys_clock_gettime().

Right. We had this discussion on x86 over and over and using a
vsyscall is the correct approach. That's also a huge win in general if
you can avoid going into the kernel to read the time. gettimeofday()
and clock_gettime() belong to the most frequently called syscalls on
any Linux system.

Thanks,

	tglx
