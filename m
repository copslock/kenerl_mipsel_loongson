Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 10:49:25 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:24035 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225215AbUC3JtY>; Tue, 30 Mar 2004 10:49:24 +0100
Received: from sprocket.localnet ([192.168.1.27] helo=bitbox.co.uk)
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1B8FrQ-0003ot-00; Tue, 30 Mar 2004 10:48:44 +0100
Message-ID: <4069427A.9000400@bitbox.co.uk>
Date: Tue, 30 Mar 2004 10:48:42 +0100
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC: pdh@colonel-panic.org, linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
References: <20040326184317.GA3661@skeleton-jack>	<20040327.224952.74755860.anemo@mba.ocn.ne.jp>	<20040328130400.GA28177@skeleton-jack> <20040330.153842.48794669.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20040330.153842.48794669.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:

>>>>>>On Sun, 28 Mar 2004 14:04:00 +0100, Peter Horton <pdh@colonel-panic.org> said:
>>>>>>            
>>>>>>
>pdh> I've ditched the original Cobalt hack in c-r4k.c, and am using
>pdh> the patch below instead. Seems to work okay ...
>
>+	for (; addr < (void *) end; addr += PAGE_SIZE)
>+		flush_data_cache_page((unsigned long) addr);
>
>dma_cache_wback() will be more efficient ?
>  
>
Well technically it should be dma_cache_wback_inv(), though they equate 
to the same function currently.

It would be more efficient, but the dma_cache_*() functions are only 
available under CONFIG_DMA_NONCOHERENT, and our problem has nothing to 
do with DMA coherency at all.

All we really need to do is add a flush_dcache_range(from,to) function. 
I'm working on this at the moment.

>Also, I personally think replacing all insb/insw/insl is a bit
>overkill.  I'd prefer redefine insb/insw/insl in asm-mips/ide.h, but
>I'm not sure it is enough. (really all ins[bwl] should take care of
>the cache inconsistency?)
>
>  
>
There maybe other block drivers (SCSI?) that use insb/insw/insl that 
would also cause us grief, but we could provide both versions of the 
functions and select them as necessary.

P.
