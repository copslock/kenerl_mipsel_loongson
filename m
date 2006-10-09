Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 14:53:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36800 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039425AbWJINx2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 14:53:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k99DrYjA030702;
	Mon, 9 Oct 2006 14:53:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k99DrXWK030701;
	Mon, 9 Oct 2006 14:53:33 +0100
Date:	Mon, 9 Oct 2006 14:53:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <KevinK@mips.com>
Cc:	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ret_from_irq adjustment
Message-ID: <20061009135332.GA14048@linux-mips.org>
References: <20061009.012423.59032950.anemo@mba.ocn.ne.jp> <006501c6eb07$4fbf66c0$8003a8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006501c6eb07$4fbf66c0$8003a8c0@Ulysses>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 08, 2006 at 08:26:44PM +0200, Kevin D. Kissell wrote:

> While setting up ra "by hand" and transferring control via the jr
> is a reasonable optimization, you're otherwise breaking things for SMTC.
> While the comments are misleading (they accurately described an earlier
> version of the code), the function being called here is ipi_decode(), which
>  needs a pt_regs * in the first argument (hence the copy of the sp), and 
> the pointer to the IPI message descriptor in the second.
> 
> Do you have access to a 34K to test changes to SMTC?  I'd have
> expected this one to have been pretty quickly fatal.

Second reply after a closer look at the patch.

ipi_decode() has lost it's pt_regs argument like most of the interrupt
related functions, so Atushi's patch was right.  Any interrupt handler
that wants to get a pointer to the register frame can do so by calling
get_irq_regs().

The cleanup did actually work so well I'm tempted to use the same
strategy also for the CU and RI exception handlers which would make the
FPU exception handler look a whole lot more friendly.

So with Atsushi's patch applied VSMP and SMTC with only two TCs activated
are working again.  It still crashes with 5 TCs enabled:

Cpu 1
$ 0   : 00000000 18102000 00000000 8041ed44
$ 4   : 00000000 00000000 8041ec88 00000000
$ 8   : 00000000 18001c00 8010de78 80430000
$12   : 80420000 fffffffb ffffffff 0000000a
$16   : 00000000 00000001 8041ec04 8041ec08
$20   : 803b0000 8041ed40 80380000 18102000
$24   : 00000000 810c3b11
$28   : 810c2000 810c3b58 00000100 80108bdc
Hi    : 00000009
Lo    : fbe7d600
epc   : 80132b74 profile_tick+0x20/0xb4     Not tainted
ra    : 80108bdc local_timer_interrupt+0x10/0x30
Status: 1100a603    KERNEL EXL IE

  Ralf
