Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 17:45:46 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26569 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038798AbWKNRpo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 17:45:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAEHk9o4006209;
	Tue, 14 Nov 2006 17:46:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAEHk82X006208;
	Tue, 14 Nov 2006 17:46:08 GMT
Date:	Tue, 14 Nov 2006 17:46:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rewrite restore_fp_context/save_fp_context
Message-ID: <20061114174608.GA5740@linux-mips.org>
References: <20060208.015250.130239257.anemo@mba.ocn.ne.jp> <20060411.185449.126141341.nemoto@toshiba-tops.co.jp> <20060620.003746.78731943.anemo@mba.ocn.ne.jp> <20060829.225631.41630441.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829.225631.41630441.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 29, 2006 at 10:56:31PM +0900, Atsushi Nemoto wrote:

> The setup_sigcontect()/restore_sigcontext() might sleep on
> put_user()/get_user() with preemption disabled (i.e. atomic context).
> Sleeping in atomic context is not allowed.  This patch fixes this
> problem by rewriting restore_fp_context()/save_fp_context().

So with this patch applied the context will be copied around twice, first
save the fp registers to memory then copied from memory to userspace and
as the result the non-preemptible kernel will suffer from fixing the
preemptible ...

To me it looks like the real problem that setup_sigcontext and
restore_sigcontext need to disable preemption.  And the reason for that
is probably that 87d54649f67d8ffe0a8d8176de8c210a6c4bb4a7 around 2.6.9
took the wrong.  The better fix would probably have been to allow
at least some fp instructions from kernel mode.  The sole reason for
the die_if_kernel() call is to tell people attempting to put FPU code
into the kernel that they're screwing up.

  Ralf
