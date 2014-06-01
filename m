Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jun 2014 10:31:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37692 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817115AbaFAIbtn-uus (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Jun 2014 10:31:49 +0200
Date:   Sun, 1 Jun 2014 09:31:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
cc:     linux-mips@linux-mips.org, blogic@openwrt.org
Subject: Re: [PATCH 2/2] MIPS: fix DECStation build for L1_CACHE_SHIFT
 value
In-Reply-To: <alpine.LFD.2.11.1404010105130.27402@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1405310947180.30121@eddie.linux-mips.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org> <1390327294-2618-2-git-send-email-florian@openwrt.org> <alpine.LFD.2.11.1404010105130.27402@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 1 Apr 2014, Maciej W. Rozycki wrote:

> > When support for the DECStation is enabled, it will default to use a
> > MIPS R3000 class processor. This will cause an intentional build failure
> > to popup because MIPS_L1_CACHE_SHIFT and cpu_dcache_line_size()
> > disagree. Fix this by selecting MIPS_L1_CACHE_SHIFT_2 when we build
> > targetting a MIPS R3000 CPU to fix that build failure and satisfy all
> > requirements.
> > 
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> 
> Acked-by: Maciej W. Rozycki <macro@linux-mips.org>
> 
>  This actually boots -- Ralf, please apply.

 Having done further investigation I need to withdraw my ack; I see these 
patches went nowhere so far, so please keep the status quo.  The thing is 
while the size of an individual cache entry (i.e. data+tag) is indeed 4 
bytes on the R2000 and R3000 DECstations their cache controllers do not 
necessarily operate on single entries only.  Some models do fills on 
multiple aligned entries at once.  So while the stride of 4 bytes is 
adequate for invalidation, it is not necessarily so for good performance.

 Specifically:

* in DECstation 2100 and 3100 systems [1]:

"The CPU maintains the direct-mapped instruction cache and the 
direct-mapped, write-through data cache.  Each cache is 64 KBytes in 
capacity with a 4-byte line size."

* in DECstation 5000/200 systems [2]:

"The instruction and data caches are configured with a four-word line size 
with loads and stores nominally completing in one cycle.  Instruction and 
data cache fills take advantage of page mode memory cycles to complete a 
four-word fill in 11 access latency cycles, 4 data transfer cycles, plus 
miss and memory latency overhead.  This results in a peak memory read 
bandwidth of 21 MBytes/second with a 25 MHz system clock."

* in DECstation 5000/120, 5000/125 and Personal DECstation 5000/20 and 
  5000/125 systems (CPU daughtercards are interchangeable between these 
  systems) [4]:

"The CPU subsystem contains 64 KB each of instruction cache and data 
cache.  The caches are direct-mapped, write-through caches, each 
containing 16K word entries.  A cache word entry contains 32 bits of 
instruction or data, 13 tag bits, a valid flag bit, and byte-parity bits.  
The tag bits hold the high-order part of the physical address in system 
memory of the cached word.  The low-order bits of the system memory 
address of the cached word are the same as its address in the cache; they 
form the cache index.  The dual cache is implemented in fast SRAM.  The 
R3000A can fetch one instruction and load one data word in each cycle."

* in DECstation 5000/240 systems [3]:

"The caches are direct-mapped, write-through caches, each containing 16K 
word entries.  A cache word entry contains 32 bits of instruction or data, 
16 tag bits, a valid flag bit, and byte-parity bits.  The tag bits hold 
the high-order part of the physical address of the cached word in system 
memory.  The low-order bits of the system memory address of the cached 
word are the same as its address in the cache; they form the cache index. 
(Physically, each cache entry contains a total of 60 bits; the unused bits 
are additional tag and parity bits needed in implementations with smaller 
caches.) [...]

"A cache load fills eight consecutive cache words on an eight-word 
boundary.  The MB contains dual eight-word buffers -- a read buffer and a 
prefetch buffer.  For a cache load, the MB performs a page-mode read from 
memory to fill its read buffer, at one word per 40-ns memory system cycle 
after the 8-cycle page mode read latency.  When the read buffer is full, 
the MB writes the eight locations to cache, in eight 25-ns CPU/cache 
cycles.  When the cache line is on a 16-word boundary, the MB also fills 
the prefetch buffer, so that the next cache line can be available for a 
subsequent cache load without referencing system memory (unless one of the 
prefetched words is invalidated by a processor write to the location)." 

 Our code in r3k_cache_lsize only calculates how many bytes in the cache 
get invalidated at a time.  That's of course useful for optimising cache 
invalidations (that we don't do at the moment anyway), but has nothing to 
do with the optimising for cache prefetches.  A different sizing algorithm 
would have to be used -- not that difficult to invent too, and maybe worth 
adding for informational purposes if nothing else.

 All in all it looks to me like not only MIPS_L1_CACHE_SHIFT_2 shouldn't 
be set for R2000 and R3000 DECstations, but MIPS_L1_CACHE_SHIFT_4 
shouldn't be either.  Instead MIPS_L1_CACHE_SHIFT_6 looks like the right 
choice for good performance with the DECstation 5000/240 system since we 
don't handle individual family members with separate configurations 
(MIPS_L1_CACHE_SHIFT_5 would do for the 5000/200).  R4k DECstations would 
remain using MIPS_L1_CACHE_SHIFT_4, although it is quite possible that the 
MB chip they also have does similar prefetching for their secondary cache 
(there's that mysterious PF bit in its control and status register).

 References:

[1] Workstation Systems Engineering: "DECstation 3100 Desktop Workstation 
    Functional Specification", Revision 1.3, August 28, 1990, Digital 
    Equipment Corporation, section 6.1: "Processor", p. 4.

[2] Workstation Systems Engineering: "DECstation 5000/200 KN02 System 
    Module Functional Specification", Revision 1.3, August 27, 1990, 
    Digital Equipment Corporation, section 4.3: "Processor Subsystem", p. 
    4.

[3] Worksystems Base Product Marketing: "Personal DECstation Series 
    Technical Overview", Version 1.0, December, 1991, Digital Equipment 
    Corporation, section 2.2.3: "The Personal DECstation 5000 CPU 
    Subsystem", p. 8.

[4] Worksystems Base Product Marketing: "DECstation 5000 Model 240 
    Workstation Technical Overview", Version 1.0, December, 1991, Digital 
    Equipment Corporation, section 2.2.4: "Cache Architecture, 
    Implementation, and Operation", pp. 8-9.

  Maciej
