Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2011 11:57:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41260 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491034Ab1A1K5s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jan 2011 11:57:48 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0SAvMh9028661;
        Fri, 28 Jan 2011 11:57:22 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0SAvK39028659;
        Fri, 28 Jan 2011 11:57:20 +0100
Date:   Fri, 28 Jan 2011 11:57:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Earl Chew <echew@ixiacom.com>
Cc:     linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Publishing mips_hpt_frequency in /proc/cpuinfo
Message-ID: <20110128105720.GA28544@linux-mips.org>
References: <4D424D4B.5090002@ixiacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D424D4B.5090002@ixiacom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 27, 2011 at 08:59:55PM -0800, Earl Chew wrote:

> The CPU frequency is known to the Linux kernel. For example:
> 
> > CPU revision is: 00019374 (MIPS 24Kc)
> > Atheros AR7161 rev 2, CPU:680.000 MHz, AHB:170.000 MHz, DDR:340.000 MHz
> > ...
> > Calibrating delay loop... 452.19 BogoMIPS (lpj=2260992)
> 
> Unfortunately that information is not available from userspace:
> 
> > cpu model               : MIPS 24Kc V7.4
> > BogoMIPS                : 452.19
> 
> This makes it difficult to use CPU timers (rdhwr) from user space
> applications.
> 
> 
> Is there any reason not to publish mips_hpt_frequency in /proc/cpuinfo ?

The CPU clock frequency may change at any time due to clockscaling  A
process might be rescheduled to another CPU running at a different clock
rate.  A suspended process might miss counter wraparounds.

This right approach is to handle this in a virtual syscall, something like
vsys_clock_gettime().

  Ralf
