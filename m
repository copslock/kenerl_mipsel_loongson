Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 17:53:32 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23260 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023186AbXILQxa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 17:53:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8CGrURX010259;
	Wed, 12 Sep 2007 17:53:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8CGrU3P010258;
	Wed, 12 Sep 2007 17:53:30 +0100
Date:	Wed, 12 Sep 2007 17:53:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: does the SAVE_ALL nesting in kernel?
Message-ID: <20070912165330.GH4571@linux-mips.org>
References: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 12, 2007 at 10:21:53AM +0800, zhuzhenhua wrote:

>             i have a mips board,  and the SDRAM speed(bus clock) is not too
> fast.
>              so i want change  the SAVE_ALL and RESTORE_ALL to use
> internal-ram(high speed).
>             i just wonder whether the SAVE_ALL netsting in kernel  for mips
> arch?
>             if not, i think  maybe 1k byte for SAVE_ALL is enough( 32regs
> X4, and some cp0_regs).
>             but if  the SAVE_ALL nesting, maybe i need to keep a stack in
> internal-ram.
>             thanks for any hints．

Nesting works but due to the use of k0/k1 you need to ensure SAVE_ALL is
only invoked with interrupts disabled.

  Ralf
