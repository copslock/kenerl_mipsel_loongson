Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2006 01:17:31 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53456 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037517AbWIJARa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 10 Sep 2006 01:17:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8A0I4Pe000899;
	Sun, 10 Sep 2006 02:18:04 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8A0I31c000898;
	Sun, 10 Sep 2006 02:18:03 +0200
Date:	Sun, 10 Sep 2006 02:18:03 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: cpu_idle and cpu_wait
Message-ID: <20060910001803.GA826@linux-mips.org>
References: <20051117.011906.25910026.anemo@mba.ocn.ne.jp> <20051116184201.GJ3229@linux-mips.org> <20051118.122242.07017522.nemoto@toshiba-tops.co.jp> <20060608.010901.108121387.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608.010901.108121387.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 08, 2006 at 01:09:01AM +0900, Atsushi Nemoto wrote:

> [MIPS] reduce race between cpu_wait() and need_resched() checking
> 
> If a thread became runnable between need_resched() and the WAIT
> instruction, switching to the thread will delay until a next interrupt.
> Some CPUs can execute the WAIT instruction with interrupt disabled, so
> we can get rid of this race on them (at least UP case).

Applied but based on feedback from the 4K and 5K CPU designers I modified
your patch to continue using the old code.

  Ralf
