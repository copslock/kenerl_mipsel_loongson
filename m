Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2007 11:20:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:966 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021960AbXFLKUu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Jun 2007 11:20:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5CAIxWR030225;
	Tue, 12 Jun 2007 11:19:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5CAIxv5030224;
	Tue, 12 Jun 2007 11:18:59 +0100
Date:	Tue, 12 Jun 2007 11:18:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS 20Kc and WAIT instruction
Message-ID: <20070612101859.GA29075@linux-mips.org>
References: <466D1BBF.6030403@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466D1BBF.6030403@aurel32.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 11, 2007 at 11:54:07AM +0200, Aurelien Jarno wrote:

> The latest kernels from kernel.org or linux-mips.org do not enter low
> power mode when the CPU is idle on a MIPS 20Kc CPU.
> 
> Looking at the code in arch/mips/kernel/cpu-probe.c, the "case"
> corresponding to the 20Kc CPU is commented out:
> 
>         case CPU_5KC:
> /*      case CPU_20KC:*/
>         case CPU_24K:
> 
> According to the datasheet this CPU supports the WAIT instruction, so I
> don't really understand why it is disabled in the kernel. Does anybody
> know why?

CPU_20KC is MIPS64 so by definition supports a WAIT instruction - even
though an implementation would be legal as per architecture spec.

As for why it's commented out, I don't know.  The original patch to add
support was submitted by Carsten Langgaard (ex-carstenl@mips.com) in 2002
and already had the CPU_20KC commented out.  As for why one would do
something like that - my guess is as good as your's :-)  Trying to find
out more.

  Ralf
