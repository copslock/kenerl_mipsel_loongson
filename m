Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 10:54:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:25995 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578333AbXLRKyI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Dec 2007 10:54:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBIAmxgN019554;
	Tue, 18 Dec 2007 10:49:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBIAmYqq019552;
	Tue, 18 Dec 2007 11:48:34 +0100
Date:	Tue, 18 Dec 2007 11:48:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas@koeller.dyndns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: timer irq setup
Message-ID: <20071218104834.GA19316@linux-mips.org>
References: <200712171135.24569.thomas@koeller.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712171135.24569.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 17, 2007 at 11:35:22AM +0100, Thomas Koeller wrote:

> In arch/mips/kernel/traps.c, per_cpu_trap_init() contains
> code to set up the global cp0_compare_irq variable. Does
> this make sense? I'd say that either the irq setup should
> be moved to trap_init(), or cp0_compare_irq should be
> changed to a per-cpu variable, depending on what the original
> intention was.

Technically it would be legal to route the timer interrupt to a different
interrupt for each of possibly multiple processors, that's why it's done
in per_cpu_trap_init().

Obviously the rest of the code isn't quite there and also to best of my
knowledge all actual implementations use the same interrupt across all
cores.  So something like a global variable and a paranoia check in
per_cpu_trap_init() to ensure all CPUs really use the same interrupt
would seem reasonable.

  Ralf
