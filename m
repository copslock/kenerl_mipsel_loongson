Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 22:00:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61002 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008019AbbFJUAUQznD2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2015 22:00:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 83AD1DC5E0FBB;
        Wed, 10 Jun 2015 21:00:08 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 10 Jun
 2015 21:00:11 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Wed, 10 Jun
 2015 21:00:11 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 10 Jun
 2015 13:00:09 -0700
Message-ID: <55789749.3070700@imgtec.com>
Date:   Wed, 10 Jun 2015 13:00:09 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <david.daney@cavium.com>,
        <cernekee@gmail.com>, <linux-kernel@vger.kernel.org>,
        <macro@codesourcery.com>, <markos.chandras@imgtec.com>,
        <kumba@gentoo.org>
Subject: Re: [PATCH] MIPS: bugfix of local_r4k_flush_icache_range - added
 L2 flush
References: <20150528203724.28800.63700.stgit@ubuntu-yegoshin> <20150610102805.GF2753@linux-mips.org>
In-Reply-To: <20150610102805.GF2753@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 06/10/2015 03:28 AM, Ralf Baechle wrote:
> On Thu, May 28, 2015 at 01:37:24PM -0700, Leonid Yegoshin wrote:
>
>> ...
> I was wondering why there was a cache flush at all so I dove into git
> history and found:
>
> commit 4676f9359fa5190ee6f42bbf2c27d28beb14d26a
> Author: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Date:   Tue Jan 21 09:48:48 2014 +0000
>
>      MIPS: mm: c-r4k: Flush scache to avoid cache aliases
>      
>      There is a chance for the secondary cache to have memory
>      aliases. This can happen if the bootloader is in a non-EVA mode
>      (or even in EVA mode but with different mapping from the kernel)
>      and the kernel switching to EVA afterwards. It's best to flush
>      the icache to avoid having the secondary CPUs fetching stale
>      data from it.
>      
>      Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>      Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>
> flush_icache_range() really only is meant to deal with I-cache coherency
> issues as they appear during normal kernel operation, that is code is
> modified and will be executed from RAM.  I doesn't know about aliases
> and it's not meant to know.

1) OK, here is an explanation of memory aliasing (don't mix with cache 
aliasing).

Memory blocks bigger than 512MB should be put somewhere above 512MB 
physical address due to IO hole but we still need some memory at 
physical address 0x0000000. Board designers often prefer using masking 
of some address bits to MIRROR 256-512MB into 0x00000000 from a primary 
memory space location (for Malta - physical address 0x80000000). It 
decreases latency by some bus clocks (which are not CPU clocks but slowly).

So, in Malta the word at physical address 0x00000000-256MB is the same 
as word at physical address 0x80000000-0x90000000 (other boards may have 
another location). But cache subsystem knows NOTHING about it and caches 
that memory twice. This is a memory aliasing and it may cause a lot of 
trouble if system uses both aliasing address ranges. But it is pretty 
often that system initially uses low block 0x00000000->512MB during core 
startup and later switches to primary address space. So, some full L1D 
and L2 cache flush is needed after cache is initialized. However, after 
creation of exception handler code it is still needed additionally a 
flush of that code too, in L1D/I and including L2 in EVA, to avoid 
memory aliasing problem.

2) This patch actually notices that EJTAG and NMI exception handlers 
work with Status.ERL bit and pull exception handler code from uncachable 
memory, so a flushing exception handlers down to memory (including L2) 
is needed for that because of different reason. Actually, it is a result 
of debugging NMI with U-Boot. It is just by chance that it uses the same 
code and solution as EVA flushing.

>
> As I understand you only need this on startup.  Making this function work
> for your special use results in a performance penalty for every other user
> of this function.

Function local_r4k_flush_icache_range() can be used only at startup, 
before SMP is inialized. Original code has comment above this function:

/* This function is used only for local CPU only while boot etc */

I don't know why it disappeared.

>
> How about reverting this commit and calling __flush_cache_all() to
> make sure your kernel code gets flushed out to the other end of the
> universe - or memory, what ever comes first?

That function may call SMP IPI in some vendor CPUs and is not suitable.

But I agree that name local_r4k_flush_icache_range() is a not good now 
and it may be changed to something more appropriate. I am just not good 
in name changing game.

- Leonid.

>
>    Ralf
