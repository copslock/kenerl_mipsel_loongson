Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Apr 2008 18:34:15 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:62114 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20106025AbYD0ReN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 27 Apr 2008 18:34:13 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3RHXF5X005620
	for <linux-mips@linux-mips.org>; Sun, 27 Apr 2008 10:33:21 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3RHXxoj012774;
	Sun, 27 Apr 2008 18:33:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3RHXxvl012773;
	Sun, 27 Apr 2008 18:33:59 +0100
Date:	Sun, 27 Apr 2008 18:33:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix some sparse warnings on traps.c and irq-msc01.c
Message-ID: <20080427173359.GC13083@linux-mips.org>
References: <20080426.015530.78704907.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080426.015530.78704907.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 26, 2008 at 01:55:30AM +0900, Atsushi Nemoto wrote:

> * Declare board_bind_eic_interrupt, board_watchpoint_handler in traps.h
> * Make msc_bind_eic_interrupt static and fix its argument types.
> * Make msc_levelirq_type, msc_edgeirq_type static.

Dropped into the 2.6.26 queue.  Thanks!

  Ralf
