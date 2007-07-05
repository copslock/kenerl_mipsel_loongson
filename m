Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 15:29:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16564 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022072AbXGEO27 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jul 2007 15:28:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l65ESwmQ020002;
	Thu, 5 Jul 2007 15:28:58 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l65ESw2S020001;
	Thu, 5 Jul 2007 15:28:58 +0100
Date:	Thu, 5 Jul 2007 15:28:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: diffs between lmo and mainline
Message-ID: <20070705142858.GB19885@linux-mips.org>
References: <20070705.223050.65192436.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070705.223050.65192436.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 05, 2007 at 10:30:50PM +0900, Atsushi Nemoto wrote:
> commit b0e05a32a745a6e3ec5203f28a6bc044653e411a
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Thu Jun 21 00:22:34 2007 +0100
> 
>     [MIPS] Fix scheduling latency issue on 24K, 34K and 74K cores
>     
>     The idle loop goes to sleep using the WAIT instruction if !need_resched().
>     This has is suffering from from a race condition that if if just after
>     need_resched has returned 0 an interrupt might set TIF_NEED_RESCHED but
>     we've just completed the test so go to sleep anyway.  This would be
>     trivial to fix by just disabling interrupts during that sequence as in:
>     
>             local_irq_disable();
>             if (!need_resched())
>                     __asm__("wait");
>             local_irq_enable();
>     
>     but the processor architecture leaves it undefined if a processor calling
>     WAIT with interrupts disabled will ever restart its pipeline and indeed
>     some processors have made use of the freedom provided by the architecture
>     definition.  This has been resolved and the Config7.WII bit indicates that
>     the use of WAIT is safe on 24K, 24KE and 34K cores.  It also is safe on
>     74K EA so enable the use of WAIT with interrupts disabled for all 74K
>     cores.

Turned out that the 74K doesn't quite behave as I was hoping for so this
one can't go as it is either.

  Ralf
