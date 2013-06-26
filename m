Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 21:03:43 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:56359 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827473Ab3FZTDmpYTka (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 21:03:42 +0200
Message-ID: <51CB3B04.1070903@imgtec.com>
Date:   Wed, 26 Jun 2013 12:03:32 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com> <20130626145234.GB7171@linux-mips.org> <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com> <20130626162302.GE7171@linux-mips.org> <nh7ue18fnbn1tbs2wsphlis9.1372265400519@email.android.com> <20130626175015.GH7171@linux-mips.org>
In-Reply-To: <20130626175015.GH7171@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
X-SEF-Processed: 7_3_0_01192__2013_06_26_20_03_36
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37149
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

Ralf,

On 06/26/2013 10:50 AM, Ralf Baechle wrote:
> On Wed, Jun 26, 2013 at 04:50:03PM +0000, Leonid Yegoshin wrote:
>
>> EVA has actually INCREASE in user address space - I right now run system with 2GB phys memory and 3GB of user virtual memory address space. Work in progress is to verify that GLIBC accepts addresses above 2GB.
> I took the 0x40000000 for a KSEG0-equivalent because you previously
> mentioned the value of 0x80000000.

I wrote about kernel address layout. With EVA a user address layout is a 
different beast.
In EVA, user may have access, say [0x00000000 - 0xBFFFFFFF] through TLB and
kernel may have access, say [0x00000000 - 0xDFFFFFFF] unmapped. But 
segment shifts are applied to each KSEG.

>
>> Yes, it is all about increasing phys and user memory and avoiding 64bits. Many solutions dont justify 64bit chip (chip space increase, performance degradation and increase in DMA addresses for devices).
> Fair enough - but in the end the increasing size of metadata and pagetables
> which has to reside in lowmem will become the next bottleneck and highmem
> I/O performance has never been great, is on most kernel developers shit list
> and performance optimizations for highmem are getting killed whenever they
> are getting into the way.

EVA doesn't use HIGHMEM. Kernel has a direct access to all memory in, 
say 3GB (3.5GB?).
Malta model gives only 2GB because of PCI bridge loop problem.

>
> So I'd say EVA gives you something like 1.5GB of memory at most with good
> performance and a 2GB userspace and something like 0.5GB, maybe 0.75GB
> with a 3GB userspace.  Beyond that you need highmem and that's where things,
> especially kernel programming get more complicated and slower.

Ralf, PTE and page table sizes depends from page size and HUGE page 
table implementation.
With EVA the ratio of usable and service (PTE + page table) memory is 
the same as legacy MIPS
and independs from used user space size. Right now I am running SOAK 
tests + additional
"thrash" instance for 1500MB on 2GB physical Malta memory and see:

...
Thrash v0.3 thrashing over 1500 megabytes
...
vmstat
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo in    cs us sy 
id wa
10  0      0 950480 252384 107856    0    0     1    18 166   132 75 25  
0  0

See: swap si/so == 0.

I use 16KB pages.

>
>    Ralf

- Leonid.
