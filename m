Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:11:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52106 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022453AbXFDPLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:11:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l54FAnw6030351;
	Mon, 4 Jun 2007 16:10:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l54FAm90030350;
	Mon, 4 Jun 2007 16:10:48 +0100
Date:	Mon, 4 Jun 2007 16:10:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify watch.S and remove arch/mips/lib-{32,64}
Message-ID: <20070604151048.GA30128@linux-mips.org>
References: <20070605.000239.31638706.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070605.000239.31638706.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 05, 2007 at 12:02:39AM +0900, Atsushi Nemoto wrote:

> Unify lib-{32,64}/watch.S into lib/watch.S and remove lib-{32,64}
> completely.
> 
> The old 64-bit __watch_set() expected an physical address and the old
> 32-bit __watch_set() expected a KSEG0 virtual address.  The new
> unified __watch_set() is based on the 64-bit one.  Since there is no
> real user of the __watch_set(), this incompatibility would not cause
> any problem.

I think we can simply drop the entire watchpoint support.  This was
only ever working on R4000/R4400 and even there only somewhat useful
for kernel debugging.  So if we ever use watchpoint support I think
something needs to be developed from scratch.

  Ralf
