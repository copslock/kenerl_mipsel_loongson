Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 17:07:59 +0000 (GMT)
Received: from p508B6CC5.dip.t-dialin.net ([IPv6:::ffff:80.139.108.197]:20107
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225432AbTLMRH7>; Sat, 13 Dec 2003 17:07:59 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBDH7uoK021596;
	Sat, 13 Dec 2003 18:07:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBDH7pnk021595;
	Sat, 13 Dec 2003 18:07:51 +0100
Date: Sat, 13 Dec 2003 18:07:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Horton <phorton@bitbox.co.uk>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2 - area of problem
Message-ID: <20031213170751.GB13271@linux-mips.org>
References: <3FD99C34.9090001@bitbox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD99C34.9090001@bitbox.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 12, 2003 at 10:45:08AM +0000, Peter Horton wrote:

> More info on the random segmentation faults and data corruption on my Qube2.
> 
> 2.4.21 from CVS is the first kernel to exhibit the problem. I tracked it 
> down to the cache handling changes that went in between 2.4.20 and 2.4.21.
> 
> By (not very scientifically) removing flush_dcache_page() and 
> re-instating flush_page_to_ram() I managed to get the 2.4.21 kernel 
> stable (see attached patch). Applying a similiar patch to 2.4.23 (CVS 
> HEAD) allows me to run 2.4.23 too.
> 
> I don't know how to track the problem any further - the kernel's cache 
> handling is a bit out of my league.
> 
> Anyone got a clue stick they can point me in the right direction with ?

Can you put a printk into c-r4k.c and print the value of the
shm_align_mask variable?  I want to make sure it's got a sane value on
your box.  Also the first few lines of your bootup messages with the
processor and cache stuff would be useful.

  Ralf
