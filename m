Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 00:54:25 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61373 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022939AbXCYAyX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Mar 2007 00:54:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2P0sI3b000833;
	Sun, 25 Mar 2007 00:54:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2P0sHOd000832;
	Sun, 25 Mar 2007 00:54:17 GMT
Date:	Sun, 25 Mar 2007 00:54:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	bora.sahin@ttnet.net.tr
Cc:	linux-mips@linux-mips.org
Subject: Re: Measuring time
Message-ID: <20070325005417.GA692@linux-mips.org>
References: <200703242025.10303.bora.sahin@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200703242025.10303.bora.sahin@ttnet.net.tr>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 24, 2007 at 08:25:10PM +0200, bora.sahin@ttnet.net.tr wrote:

> I want to meause the time between irq_enter and my consumer driver read 
> routine. How can I do that or which toool should I use?

That's a very specific question so standard tools don't seem to be
applicable.  I suggest you simple use the CPU's count register to meassure
the time.  It can be used like:

#include <linux/kernel.h>
#include <asm/mipsregs.h>

void foo(void)
{
	unsigned int start, end;

	start = read_c0_counter();
	printk("Goodbye, cruel world ...\n");
	end = read_c0_counter();

	printk("Time for printk: %d\n", end - start);
}

Note that some very old MIPS processors don't have such a counter.  Also
in some cores the counter will increment once per cycle on others it will
increment every 2nd cycle and on yet others such as the RM5230 this is
configurable.  So you may want to check your processor manual.

The cp0 counter is the timer of choice for this meassurement because it's
very high resolution and can can be accessed with low overhead making
it ideal for the very short time you want to meassure.

Cheers,

  Ralf
