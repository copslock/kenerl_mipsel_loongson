Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 12:39:33 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:10476 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021829AbXCJMjV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Mar 2007 12:39:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2ACbTQD000606;
	Sat, 10 Mar 2007 12:37:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2ACbTEM000605;
	Sat, 10 Mar 2007 12:37:29 GMT
Date:	Sat, 10 Mar 2007 12:37:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Cleanup FPU ownership management
Message-ID: <20070310123729.GB500@linux-mips.org>
References: <20070310.012319.52129805.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070310.012319.52129805.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 10, 2007 at 01:23:19AM +0900, Atsushi Nemoto wrote:

> Currently preempt_disable/preempt_enable are scattered in FPU
> ownership management code.  This patch makes own_fpu() and lost_fpu()
> can save/restore FPU context in itself and make these functions (and
> init_fpu() too) preempt-proof.  This makes the FPU management codes
> much readable.  Also this patch introduce raw_cpu_has_fpu macro which
> is to be used if the caller did not need atomic context.

And this one dropped also.

  Ralf
