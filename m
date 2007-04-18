Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 12:30:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54679 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021716AbXDRLat (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 12:30:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3IBUlNR020490;
	Wed, 18 Apr 2007 12:30:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3IBUkYM020488;
	Wed, 18 Apr 2007 12:30:46 +0100
Date:	Wed, 18 Apr 2007 12:30:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Retry {save,restore}_fp_context if failed in atomic context.
Message-ID: <20070418113046.GC3938@linux-mips.org>
References: <20070416.231944.41198415.anemo@mba.ocn.ne.jp> <20070416.233235.75185596.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070416.233235.75185596.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 16, 2007 at 11:32:35PM +0900, Atsushi Nemoto wrote:

> > The save_fp_context()/restore_fp_context() might sleep on accessing
> > user stack and therefore might lose FPU ownership in middle of them.
> > 
> > If these function failed due to "in_atomic" test in do_page_fault,
> > touch the sigcontext area in non-atomic context and retry these
> > save/restore operation.
> > 
> > This is a replacement of a (broken) fix which was titled "Allow CpU
> > exception in kernel partially".
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> And this is for 2.6.20-stable.

Both applied, also to older -stable branches except 2.6.16.  In case of
2.6.16 it would have been more time consuming than justifyable and since
the bug this patch fixes is comparable to what we had before starting the
whole surgery I have no problem to leave 2.6.16 as it is.  Anybody still
using 2.6.16 should upgrade anyway ...

  Ralf
