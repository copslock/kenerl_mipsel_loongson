Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 14:57:14 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:34777 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226929AbVGSN46>; Tue, 19 Jul 2005 14:56:58 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6ILq4md005132
	for <linux-mips@linux-mips.org>; Mon, 18 Jul 2005 17:52:05 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6IApltD001128;
	Mon, 18 Jul 2005 06:51:47 -0400
Date:	Mon, 18 Jul 2005 06:51:47 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Chau <dchau@mazunetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Why is mmap()ed reserved memory so slow?
Message-ID: <20050718105147.GA12254@linux-mips.org>
References: <42D836F8.8030209@mazunetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D836F8.8030209@mazunetworks.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 15, 2005 at 06:21:44PM -0400, David Chau wrote:

> I'm working on a driver for the Broadcom 1250, and I am using reserved 
> memory for some data buffers. The board comes with 256 MB of RAM, so I 
> boot Linux with "mem=253M" to reserve some RAM at the top of memory, and 
> then mmap() /dev/mem starting at 253 MB.
> 
> The problem is that accessing this memory is ridiculously slow. A simple 
> benchmark revealed that it takes about 200 cycles to read a 64-bit 
> number.

mmap will create uncached mappings for anything above the highest RAM
address.

> If I mmap() /dev/zero instead, a read takes under 3 cycles.

Because you have a cache hits.  No RAM is that fast.

Above 200 cycles really is how horribly slow RAM is compared to a moderatly
clocked system.

> For those of you who knows how the Linux VM works, could you tell me why 
> the memory access is so slow? It look like it might be invoking the 
> page-fault handler on every read. How can I make memory access faster?

  Ralf
