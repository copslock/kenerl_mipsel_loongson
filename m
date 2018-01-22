Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 17:41:14 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:52926 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991068AbeAVQlGD7gUH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2018 17:41:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 22 Jan 2018 16:37:57 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 22 Jan
 2018 08:36:45 -0800
Subject: Re: [PATCH 00/14] MIPS: memblock: Switch arch code to NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>,
        <goran.ferenc@mips.com>, <david.daney@cavium.com>,
        <paul.gortmaker@windriver.com>, <paul.burton@mips.com>,
        <alex.belits@cavium.com>, <Steven.Hill@cavium.com>
CC:     <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <2fd1f530-e6c6-a528-5827-c3ecc8b4a81c@mips.com>
Date:   Mon, 22 Jan 2018 16:36:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1516639067-452059-13900-84184-12
X-BESS-VER: 2017.17.1-r1801152154
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189240
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi Serge,

On 17/01/18 22:22, Serge Semin wrote:
> Even though it's common to see the architecture code using both
> bootmem and memblock early memory allocators, it's not good for
> multiple reasons. First of all, it's redundant to have two
> early memory allocator while one would be more than enough from
> functionality and stability points of view. Secondly, some new
> features introduced in the kernel utilize the methods of the most
> modern allocator ignoring the older one. It means the architecture
> code must keep the both subsystems up synchronized with information
> about memory regions and reservations, which leads to the code
> complexity increase, that obviously increases bugs probability.
> Finally it's better to keep all the architectures code unified for
> better readability and code simplification. All these reasons lead
> to one conclusion - arch code should use just one memory allocator,
> which is supposed to be memblock as the most modern and already
> utilized by the most of the kernel platforms. This patchset is
> mostly about it.
> 
> One more reason why the MIPS arch code should finally move to
> memblock is a BUG somewhere in the initialization process, when
> CMA is activated:
> 
> [    0.248762] BUG: Bad page state in process swapper/0  pfn:01f93
> [    0.255415] page:8205b0ac count:0 mapcount:-127 mapping:  (null) index:0x1
> [    0.263172] flags: 0x40000000()
> [    0.266723] page dumped because: nonzero mapcount
> [    0.272049] Modules linked in:
> [    0.275511] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.88-module #5
> [    0.282900] Stack : 00000000 00000000 80b6dd6a 0000003a 00000000 00000000 80930000 8092bff4
>            86073a14 80ac88c7 809f21ac 00000000 00000001 80b6998c 00000400 00000000
>            80a00000 801822e8 80b6dd68 00000000 00000002 00000000 809f8024 86077ccc
>            80b80000 801e9328 809fcbc0 00000000 00000400 00010000 86077ccc 86073a14
>            00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>            ...
> [    0.323148] Call Trace:
> [    0.325935] [<8010e7c4>] show_stack+0x8c/0xa8
> [    0.330859] [<80404814>] dump_stack+0xd4/0x110
> [    0.335879] [<801f0bc0>] bad_page+0xfc/0x14c
> [    0.340710] [<801f0e04>] free_pages_prepare+0x1f4/0x330
> [    0.346632] [<801f36c4>] __free_pages_ok+0x2c/0x104
> [    0.352154] [<80b23a40>] init_cma_reserved_pageblock+0x5c/0x74
> [    0.358761] [<80b29390>] cma_init_reserved_areas+0x1b4/0x240
> [    0.365170] [<8010058c>] do_one_initcall+0xe8/0x27c
> [    0.370697] [<80b14e60>] kernel_init_freeable+0x200/0x2c4
> [    0.376828] [<808faca4>] kernel_init+0x14/0x104
> [    0.381939] [<80107598>] ret_from_kernel_thread+0x14/0x1c
> 
> The bugus pfn seems to be the one allocated for bootmem allocator
> pages and hasn't been freed before letting the CMA working with its
> areas. Anyway the bug is solved by this patchset.
> 
> Another reason why this patchset is useful is that it fixes the fdt
> reserved-memory nodes functionality for MIPS. Really it's bug to have
> the fdt reserved nodes scanning before the memblock is
> fully initialized (calling early_init_fdt_scan_reserved_mem before
> bootmem_init is called). Additionally no-map flag of the
> reserved-memory node hasn't been taking into account. This patchset
> fixes all of these.
> 
> As you probably remember I already did another attempt to merge a
> similar functionality into the kernel. This time the patchset got
> to be less complex (14 patches vs 21 last time) and fixes the
> platform code like SGI IP27 and Loongson3, which due to being
> NUMA introduce its own memory initialization process. Although
> I have much doubt in SGI IP27 code operability in the first place,
> since it got prom_meminit() method of early memory initialization,
> which hasn't been called at any other place in the kernel. It must
> have been left there unrenamed after arch/mips/mips-boards/generic
> code had been discarded.
> 
> Here are the list of folks, who agreed to perform some tests of
> the patchset:
> Alexander Sverdlin <alexander.sverdlin@nokia.com> - Octeon2
> Matt Redfearn <matt.redfearn@mips.com> - Loongson3, etc


I have applied and tested these patches on various platforms that we 
have available here, and the kernel appears to boot and get to userspace 
as normal on the following platforms:

UTM8 (Cavium Octeon III)
Creator CI20
Creator CI40
Loongson3a
MIPS Boston
MIPS Malta
MIPS SEAD3

Aside from the CONFIG_RELOCATABLE stuff, this looks pretty tidy to me.

Thanks,
Matt


> Joshua Kinard <kumba@gentoo.org> - IP27
> Marcin Nowakowski <marcin.nowakowski@mips.com>
> Thanks to you all in regards and for everybody, who will be involved
> in reviewing and testing.
> 
> The patchset is applied on top of kernel 4.15-rc8 and can be found
> submitted at my repo:
> https://github.com/fancer/Linux-kernel-MIPS-memblock-project
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Serge Semin (14):
>    MIPS: memblock: Add RESERVED_NOMAP memory flag
>    MIPS: memblock: Surely map BSS kernel memory section
>    MIPS: memblock: Reserve initrd memory in memblock
>    MIPS: memblock: Discard bootmem initialization
>    MIPS: memblock: Add reserved memory regions to memblock
>    MIPS: memblock: Reserve kdump/crash regions in memblock
>    MIPS: memblock: Mark present sparsemem sections
>    MIPS: memblock: Simplify DMA contiguous reservation
>    MIPS: memblock: Allow memblock regions resize
>    MIPS: memblock: Perform early low memory test
>    MIPS: memblock: Print out kernel virtual mem layout
>    MIPS: memblock: Discard bootmem from Loongson3 code
>    MIPS: memblock: Discard bootmem from SGI IP27 code
>    MIPS: memblock: Deactivate bootmem allocator
> 
>   arch/mips/Kconfig                       |   2 +-
>   arch/mips/include/asm/bootinfo.h        |   1 +
>   arch/mips/kernel/prom.c                 |   8 +-
>   arch/mips/kernel/setup.c                | 218 +++++++++------------
>   arch/mips/loongson64/loongson-3/numa.c  |  16 +-
>   arch/mips/mm/init.c                     |  47 +++++
>   arch/mips/sgi-ip27/ip27-memory.c        |   9 +-
>   7 files changed, 153 insertions(+), 148 deletions(-)
> 
