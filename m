Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4SGpXnC026197
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 28 May 2002 09:51:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4SGpXrd026196
	for linux-mips-outgoing; Tue, 28 May 2002 09:51:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4SGpOnC025527;
	Tue, 28 May 2002 09:51:25 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA29319;
	Tue, 28 May 2002 09:51:32 -0700
Message-ID: <3CF3B52B.508@mvista.com>
Date: Tue, 28 May 2002 09:49:47 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: William Jhun <wjhun@ayrnetworks.com>
CC: linux-mips@oss.sgi.com, ralf@oss.sgi.com, davem@redhat.com
Subject: Re: [PATCH] include/asm-mips/pci.h: More optimal cache behavior, added "prep" routines
References: <20020525131806.A4073@ayrnetworks.com> <20020525150302.A8264@ayrnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

William Jhun wrote:

> On Sat, May 25, 2002 at 01:18:06PM -0700, William Jhun wrote:
> 
>>When preparing a buffer for a DMA transfer, we've found it's more
>>optimal to only do a wback_inv if the direction is not known
>>(PCIDMA_BIDIRECTIONAL), only a wback if transfer is to the device
>>(PCIDMA_TO_DEVICE), and only an invalidate if from the device
>>(PCIDMA_FROM_DEVICE). Such a modification has made a small (yet
>>significant) improvement for one of our network drivers during a packet
>>forwarding rate test.
>>
> 
> *sigh*. On the platform we were testing on, we used our own cache code
> (rm7k with tertiary cache support) which has been well-tested for over a
> year now. In these routines, we implement dma_cache_wback and only do
> invalidates (no flush) for dma_cache_wback_inv. Now that I'm looking
> around in cache support for other MIPS CPUs, I see that all the _wback
> calls are not implemented and that many (or all?) of the _inv calls also
> flush the caches.
> 
> The patch below leaves the existing funtions alone and just adds the two
> pci_dma_prep_{sg,single}() calls.
> 
> My question is: why are these dma_cache_wback calls not implemented? And
> how come dma_cache_inv is treated the same as dma_cache_wback_inv? Are
> we doing something wrong by implementing these calls in our cache code
> as they are described?
> 


   In theory cache_wback and cache_inv are doing different things.  In 
practice, however, since the call must be made *before* dma transfer starts so 
the effects are same.  Of course, _inv() version is more efficient if it is 
implemented.

Jun
