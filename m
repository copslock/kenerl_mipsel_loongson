Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 13:39:10 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:11027
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbULONjF>; Wed, 15 Dec 2004 13:39:05 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFDcs0K028662;
	Wed, 15 Dec 2004 14:38:54 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFDcpTb028661;
	Wed, 15 Dec 2004 14:38:51 +0100
Date: Wed, 15 Dec 2004 14:38:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel located in KSEG2 or KSEG3.
Message-ID: <20041215133851.GD27935@linux-mips.org>
References: <20041213181252.23074.qmail@web25104.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213181252.23074.qmail@web25104.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 13, 2004 at 07:12:52PM +0100, moreau francis wrote:

> To learn on Linux kernel, I've decided to port it on 
> particular board with (very) limited resources and
> based with a 4KC processor core. As far I see, I need
> at least a couple of mega bytes of memory to achieve
> my goal. 
> Unfortunately the only way to get this amount of mem
> is
> to execute linux in memory that can only be accessed
> through KSEG2 and KSEG3 !
> 
> Here is my board's mapping:
> 
> Physical Memory Map:
> 
> start        size       type
> -----------------------------
> 0x20000000 - 8MB    - SDRAM
> 0x30000000 - 16MB   - FLASH
> 0x40000000 - 16MB   - FLASH
> 0x50000000 - 2MB    - SRAM
> 
> 
> I looked into the memory init code and I don't think
> that it's possible to run linux in a segment different
> from KSEG0. Am I wrong ?

It's not.  The 4kc processor when running with the BEV bit in the status
register cleared will try to find it's exception vectors at address
KSEG0, so there would have to be *some* code mapped there.  With BEV=1
exception vectors would be located in the firmware as pointed out by
Steve in his answer.  Firmware means something like flashmemory and running
uncached, so will be prohibitivly slow.  I just can't believe a system to
be that missdesigned!

> I've noticed a CONFIG_MAPPED_KERNEL macro but it seems
> that it's only used to replicate kernel from mapped
> memory to KSEG0...

That's correct.  CONFIG_MAPPED_KERNEL was written to support large ccNUMA
systems (large meaning two or three digit numbers of processors) where
preferably each node should run it's own copy of the OS kernel.  It's
a missdesigned, therefore ineffective implementation that was also only
working because of some assumption on the way gcc generates tools.

  Ralf
