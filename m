Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 11:11:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:31665 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026023AbXKNLLa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 11:11:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAEB4RUG020312;
	Wed, 14 Nov 2007 11:04:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAEB4R3S020311;
	Wed, 14 Nov 2007 11:04:27 GMT
Date:	Wed, 14 Nov 2007 11:04:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Kuk <david.kuk@entone.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: smp8634 add memory at dram1
Message-ID: <20071114110426.GA19693@linux-mips.org>
References: <473AB56B.2070107@entone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473AB56B.2070107@entone.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 14, 2007 at 04:44:27PM +0800, David Kuk wrote:

> After study about the memory configuration of sigma smp8634, i found 
> some difficult to accomplish the task.
> 
> so my question is if have two 128MB ram separately under dram0 and dram1 
> controller, where dram0 for linux and dram1 for video decoding. Now the 
> situation is the memory for linux is not enough and video decoding can 
> not use all of it's 128MB at dram1, what we plan to do is to share 64MB 
> at dram1 to the linux kernel as high memory, and only reserved 64MB at 
> dram1 for the video decoding.
> 
> first, in MIPS architecture, we found that the kseg0 and kseg1 are 
> mapped to 0x00000000-0x20000000, which include only dram0 controller, so 
> we wish to add the dram1 memory manually to the kernel using function 
> add_memory_region at setup.c , after booting up result the warning that 
> the memory larger than 512 need to configured the kernel support high 
> memory.
> 
> then when we configure the kernel to support high memory at menu 
> configure, the kernel when booting up will remind us our CPU do not 
> support high memory due to cache aliases.

This is really a software restriction.  I originally developped highmem for
MIPS on a Sibyte SB1250 which doesn't suffer from aliases so I didn't even
attempt to solve the cache aliasing issue.  The other platforms on whic
highmem used to be used was the E9000 family but it seem by now the users
of these platforms have all moved to full 64-bit kernels, so aside fo the
implementation restrictions has also started to bitrot a little.

What would be necessary to get it to work is to flush the page from cache at
kunmap() rsp.  kunmap_atomic() time.  That should do the trick though there
are significant further optimizations possible.

An alterantive to solve the aliasing issue would be to increase the
page size to 16K.  Again, the combination of highmem and 16K pages is
untested.

I don't know what processor core Sigma is using in this SOC.  In case its a
64-bit core, don't waste even a nanosecond on highmem, just go for a 64-bit
kernel, it's much less painful than highmem.

  Ralf
