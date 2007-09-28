Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 13:47:28 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49608 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029214AbXI1MrZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 13:47:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8SClPwJ009748
	for <linux-mips@linux-mips.org>; Fri, 28 Sep 2007 13:47:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8SClOXC009747
	for linux-mips@linux-mips.org; Fri, 28 Sep 2007 13:47:24 +0100
Date:	Fri, 28 Sep 2007 13:47:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: [tglx@linutronix.de: [PATCH] clockevents: fix bogus next_event
	reset for oneshot broadcast devices]
Message-ID: <20070928124724.GA8732@linux-mips.org>
References: <20070927221956.GA19990@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070927221956.GA19990@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 27, 2007 at 11:19:56PM +0100, Ralf Baechle wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 28 Sep 2007 00:17:04 +0200
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>
> Subject: [PATCH] clockevents: fix bogus next_event reset for oneshot
> 	broadcast devices
> Content-Type: text/plain
> 
> In periodic broadcast mode the next_event member of the broadcast device
> structure is set to KTIME_MAX in the interrupt handler. This is wrong,
> as we calculate the next periodic interrupt with this variable.
> 
> Remove it.
> 
> Noticed by Ralf. MIPS is the first user of this mode, it does not affect
> existing users.

Which is a different from what I was using, so that throws somewhat of a
wrench into some of the MIPS dyntick mechanics.  But it doesn't change
the fact that this fix is correct.

  Ralf
