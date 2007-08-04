Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2007 17:38:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46272 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024461AbXHDQid (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 4 Aug 2007 17:38:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l74GcWVf031626;
	Sat, 4 Aug 2007 17:38:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l74GcVRw031625;
	Sat, 4 Aug 2007 17:38:31 +0100
Date:	Sat, 4 Aug 2007 17:38:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: smtc_timer_broadcast ignores its arguments, make
	it void.
Message-ID: <20070804163831.GA31547@linux-mips.org>
References: <S20021645AbXG0Sih/20070727183837Z+1462@ftp.linux-mips.org> <023a01c7d087$02943c20$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023a01c7d087$02943c20$10eca8c0@grendel>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Kevin,

On Fri, Jul 27, 2007 at 09:47:47PM +0200, Kevin D. Kissell wrote:

> The argument to smtc_timer_broadcast() is supposed to be a VPE number.
> Somewhere between the earliest prototypes and the current linux-mips.org
> tree, it got hacked up to ignore the argument and broadcast to all TCs.
> There are still configurations out there, some of which I've worked on 
> pretty recently, where the platform code can be configured to either
> do global or VPE-local broadcasting of timer interrupts.  While we have
> determined that it's pretty important to ensure that, in an SMTC configuration,
> having the Count registers of all VPEs in sync is important to avoid timing
> glitches, skewing the starting Compare values should help even out the load
> and reduce contention for the locks on the scheduler queues. Getting rid
> of the argument to smtc_timer_broadcast() makes that impossible.  I'd 
> rather see the platform timer code iterate through the configured VPEs 
> and keep the argument.
> 
> The most recent smtc_timer_broadcast() I've worked on looks like:
> 
> void smtc_timer_broadcast(int vpe)
> {
>         int cpu;
>         int myTC = cpu_data[smp_processor_id()].tc_id;
> 
>         smtc_cpu_stats[smp_processor_id()].timerints++;
> 
>         for_each_online_cpu(cpu) {
>                 if (cpu_data[cpu].vpe_id == vpe &&
>                     cpu_data[cpu].tc_id != myTC)
>                         smtc_send_ipi(cpu, SMTC_CLOCK_TICK, 0);
>         }
> }

I don't mind adding the deleted bits back.

Take the fact that this happened as a life demonstration for unused stuff
of any kind being under is under permanent threat of deletion by some
maintainer, kernel janitor or whoever else in Linux ;-)

  Ralf
