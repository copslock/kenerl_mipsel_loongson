Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 20:38:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35238 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133942AbWEBTij (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 20:38:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k42JcdqK003602;
	Tue, 2 May 2006 20:38:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k42Jcci7003601;
	Tue, 2 May 2006 20:38:38 +0100
Date:	Tue, 2 May 2006 20:38:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim <jimssubs@telus.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: how do i get register state from process before interrupt?
Message-ID: <20060502193838.GA3474@linux-mips.org>
References: <4456960D.70403@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4456960D.70403@telus.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 01, 2006 at 04:13:17PM -0700, Jim wrote:

> I have a number of processes and drivers on a SB1250 card
> and I suspect one of the drivers is misbehaving such that
> user processes are not getting a chance to run.  I implemented
> a rudimentary watchdog in the timer interrupt which is kicked
> by one such user process if things when things are fine.
> How would I capture the register state of the process
> that was running before the interrupt is run?  I'm on
> linux 2.4.18.

You can find a struct pt_regs at

  (unsigned long)task_stack_page(p) + THREAD_SIZE - 32

  Ralf
