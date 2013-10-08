Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 10:24:18 +0200 (CEST)
Received: from ni.piap.pl ([195.187.100.4]:45262 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6839455Ab3JHIYPDUN-l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 10:24:15 +0200
Received: from ni.piap.pl (localhost.localdomain [127.0.0.1])
        by ni.piap.pl (Postfix) with ESMTP id 3838544027A;
        Tue,  8 Oct 2013 10:24:14 +0200 (CEST)
Received: by ni.piap.pl (Postfix, from userid 1015)
        id 332F444029F; Tue,  8 Oct 2013 10:24:14 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-media@vger.kernel.org
References: <m3eh82a1yo.fsf@t19.piap.pl> <m361t9a31i.fsf@t19.piap.pl>
        <20131007142429.GG3098@linux-mips.org>
Date:   Tue, 08 Oct 2013 10:24:13 +0200
In-Reply-To: <20131007142429.GG3098@linux-mips.org> (Ralf Baechle's message of
        "Mon, 7 Oct 2013 16:24:29 +0200")
MIME-Version: 1.0
Message-ID: <m3li24891u.fsf@t19.piap.pl>
Content-Type: text/plain
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.44/RELEASE,
         bases: 20131008 #11178143, check: 20131008 clean
Return-Path: <khalasa@ni.piap.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khalasa@piap.pl
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

Ralf Baechle <ralf@linux-mips.org> writes:

> That's fine.  You just need to ensure that there are no virtual
> aliases.

Does this include virtual aliasing between a 4 KB TLB-mapped page and
a kseg0 address? I don't really have two TLBs pointing to the same page.

> One way to do so is to increase the page size to 16kB.

Right, this way we will have a unique mapping from the virtual address
to the data cache, as the cache size (per way) is 8 KB here. Is it the
correct fix in this situation?

> Note that there is a variant of the 24K which has a VIPT cache but uses
> hardware to resolve cache aliases.  That is, from a kernel cache management
> perspective it behaves like a PIPT cache.

It seems it's not the case here. What I have here is:
CPU revision is: 00019374 (MIPS 24Kc)
SoC: Atheros AR7161 rev 2
Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes

> However as I understand what you're mapping to userspace is actually
> device memory, right?

Not exactly - I'm using PCI DMA to userspace SG buffers in RAM.

The userspace first allocates the buffers in normal RAM (with vmalloc()
or something, there is an mmap ioctl() for this), the address returned
is 0x7xxxxxxx. Then the buffers (which consist of several pages each)
are presented to the hw driver which obtains separate (kernel) mapping
for each page (kseg0) and does dma_map_sg() and so on. The driver also
simply writes to the buffers. This isn't a problem, though - only the
incoherence between TLB and kseg0 is.

The problem is the userspace doesn't see the kernel writes - The
0x7xxxxxxx TLB-mapped pages are read-cached and not invalidated while
the kernel writes to the same pages using kseg0 addresses.

Thanks for looking at this.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
