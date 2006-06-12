Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2006 23:58:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14556 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133885AbWFLW6t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2006 23:58:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5CMwnd2009189;
	Mon, 12 Jun 2006 23:58:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5CMwm4m009188;
	Mon, 12 Jun 2006 23:58:48 +0100
Date:	Mon, 12 Jun 2006 23:58:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Performance counters and profiling on MIPS
Message-ID: <20060612225848.GA7163@linux-mips.org>
References: <20060607172252.47981.qmail@web31512.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607172252.47981.qmail@web31512.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 07, 2006 at 10:22:52AM -0700, Jonathan Day wrote:

> Two quick and semi-related questions for the Gurus of
> the MIPS. First off, it would appear that profiling on
> any of the Broadcom MIPS processors is broken. I get
> the following warnings when compiling the
> platform-specific irq.c file:

This is ZBus-based profiling which also isn't supported by the standard
profiling tool oprofile.  Oprofile is using the performance counters of
the processor itself.

> My second question is with regards to accessing the
> performance counters and timestamp counters from
> userspace. On some architectures, this is as simple as
> using a single macro.
> 
> In the case of the ix86 architecture (yuk!), the
> timestamp counters can be read with nothing more than
> an rdtsc() call, as follows:
> 
> asm volatile ("rdtsc" : "=a"(*(elg_ui4
> *)&clock_value),
>                 "=d"(*(((elg_ui4 *)&clock_value)+1)));
> 
> What is the closest equiv. for the MIPS processors?

On most R4000-style processors (that includes the SB1 core of the Sibyte
chips) applications can access the cycle counter through an
mfc0 $reg, $c0_count instruction.  However mfc0 is a priviledged
instruction, so that doesn't work for code that doesn't have kernel
priviledges.

For release 2 of the MISP32 / MIPS64 architecture there is a new
instruction, rdhwr which an application - so the OS permits it - can
use to read c0_count.

Now there are two problems with that approach in your case:

 o SB1 implements release 0.95 of the MIPS64 architecture, SB1A release 1.
   Iow these cores don't have rdhwr.
 o In general on a multiprocessor system you don't have a guarantee that
   the count registers of all processors are running at the same speed or
   were set to the same value at any time.
      This is more of a general problem; in case of the BCM1250 the cores
   are actually running at the same speed and afair are synchronized by
   the reset.

  Ralf
