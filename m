Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Jan 2007 00:40:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15245 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578857AbXAUAkm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Jan 2007 00:40:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0L0F1rS010016;
	Sun, 21 Jan 2007 00:17:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0L0Ewwq010015;
	Sun, 21 Jan 2007 00:14:58 GMT
Date:	Sun, 21 Jan 2007 00:14:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Running Linux on FPGA
Message-ID: <20070121001457.GA9123@linux-mips.org>
References: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 20, 2007 at 11:42:37PM +0000, sathesh babu wrote:

> Hi,
>   I am trying to run Linux-2.6.18.2 ( with preemption enable) kernel on FPGA board which has MIPS24KE processor runs at 12 MHZ. Programmed the timer to give interrupt at every 10msec.
>   I am seeing some inconsistence behavior during boot up processor. Some times it stops after "NET: Registered protocol family 17" and "VFS: Mounted root (jffs2 filesystem).".
>   Could some give some pointers why the behavior is random.
>   Is it OK to program the timer to 10 msec? or should it be more.

The overhead of timer interrupts at this low clockrate is significant
so I recommend to minimize the timer interrupt rate as far as possible.
This is really a tradeoff between latency and overhead and matters
much less on hardcores which run at hundreds of MHz.  For power sensitive
applications lowering the interrupt rate can also help.  And that's alredy
pretty much what you need to know, that is a 10ms  timer is fine.

Btw, is this coincidentally on a CoreFPGA 2 or 3 CPU card on a Malta board?

  Ralf
