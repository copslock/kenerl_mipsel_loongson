Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2003 18:35:30 +0100 (BST)
Received: from p508B5A53.dip.t-dialin.net ([IPv6:::ffff:80.139.90.83]:32646
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224802AbTF2Rf0>; Sun, 29 Jun 2003 18:35:26 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5THZODB012106;
	Sun, 29 Jun 2003 19:35:24 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5THZN5O012103;
	Sun, 29 Jun 2003 19:35:23 +0200
Date: Sun, 29 Jun 2003 19:35:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: fpga dsp <fpga_dsp@yahoo.com.au>
Cc: linux-mips@linux-mips.org
Subject: Re: schedule() and mipsel processor
Message-ID: <20030629173522.GC9469@linux-mips.org>
References: <20030628025749.40346.qmail@web41205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628025749.40346.qmail@web41205.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 28, 2003 at 12:57:49PM +1000, fpga dsp wrote:

> I may ask a stupid question here but I have problem of calling any functions such as interruptible_sleep_on_timeout, sleep_on ... in a timer handler, the kernel just crash straight away in the function schedule(). Now I go and do a diff between kern/sched.c on i686 source and mipsel source. clearly , they are different. So the question is from kernel programming point of view, the bottom-half of interrupt handler is still considered interrupt handler? I don't see any platform dependent code in the scheduler at all. So why a mips scheduler is different from intel scheduler ?

Bs.  There was no need to change kernel/sched.c at all so you're probably
simply diffing the wrong versions.

  Ralf
