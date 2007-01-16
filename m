Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 13:00:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11237 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20040936AbXAPM77 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 12:59:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0GCvqTG025059;
	Tue, 16 Jan 2007 12:57:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0GCvMqH024921;
	Tue, 16 Jan 2007 12:57:22 GMT
Date:	Tue, 16 Jan 2007 12:57:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make I8259A_IRQ_BASE customizable
Message-ID: <20070116125722.GA24642@linux-mips.org>
References: <20070114.234142.41198466.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114.234142.41198466.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 14, 2007 at 11:41:42PM +0900, Atsushi Nemoto wrote:

> Move I8259A_IRQ_BASE from asm/i8259.h to asm/mach-generic/irq.h and
> make it really customizable.  And remove I8259_IRQ_BASE declared on
> some platforms.  Currently only NEC_CMBVR4133 is using custom
> I8259A_IRQ_BASE value.
> 
> Testing this patch on those platforms is greatly appreciated.  Thank
> you.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch depends on "Define MIPS_CPU_IRQ_BASE in generic header"
> patch which is in linux-queue tree.

Thanks, also in the queue.

  Ralf
