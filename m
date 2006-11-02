Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 13:44:13 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45494 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039228AbWKBNoL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Nov 2006 13:44:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA2DibVF017990;
	Thu, 2 Nov 2006 13:44:37 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA2DiaiG017989;
	Thu, 2 Nov 2006 13:44:36 GMT
Date:	Thu, 2 Nov 2006 13:44:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips irq cleanups
Message-ID: <20061102134436.GD16883@linux-mips.org>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp> <20061101184755.GC4736@linux-mips.org> <20061102.115153.25475422.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102.115153.25475422.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 02, 2006 at 11:51:53AM +0900, Atsushi Nemoto wrote:

> 1. replace set_irq_chip() with set_irq_chip_and_handler(..., handle_level_irq)
> 2. use generic_handle_irq() instead of __do_IRQ()

Another beneft of the new generic interrupt code will be for weird
multiplex devices like IOC3 which basically want to be treated as if they
have an interrupt controller on the PCI card itself.  The latest code now
enables the IOC3 metadriver to support that in a portable way.  The only
thing that's still missing is a portable way to allocate an interrupt
number.

> I'm still not sure for per-cpu type irq chips and egdg type irq chips,
> especially i8259.  The i8259 seems not suitable for handle_edge_irq or
> handle_level_irq yet.  The irq handling on SMP seems another maze ...

One step after another.

  Ralf
