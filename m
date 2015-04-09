Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2015 12:54:29 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:44680 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008090AbbDIKy1Jpp9m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2015 12:54:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id D70552E3EE;
        Thu,  9 Apr 2015 12:54:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id VB5ZZrISO-Sm; Thu,  9 Apr 2015 12:54:22 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id E62102E3EC;
        Thu,  9 Apr 2015 12:54:21 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id CC5B9E79;
        Thu,  9 Apr 2015 12:54:21 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id C0C4EC76;
        Thu,  9 Apr 2015 12:54:21 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
        by seth.se.axis.com (Postfix) with ESMTP id BDAD43E049;
        Thu,  9 Apr 2015 12:54:21 +0200 (CEST)
Received: from xmail2.se.axis.com ([10.0.5.74]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 9 Apr 2015 12:54:21 +0200
From:   Lars Persson <lars.persson@axis.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Lars Persson <larper@axis.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 9 Apr 2015 12:54:21 +0200
Subject: Re: [PATCH 0/2] New fix for icache coherency race
Thread-Topic: [PATCH 0/2] New fix for icache coherency race
Thread-Index: AdBys4kRBSeZUxAiSeGqPm6SYWNtJg==
Message-ID: <171D0CF6-78EB-4FA8-A213-2612A3680E5F@axis.com>
References: <1424956563-29535-1-git-send-email-larper@axis.com>
 <20150408225324.GH2896@NP-P-BURTON>
In-Reply-To: <20150408225324.GH2896@NP-P-BURTON>
Accept-Language: en-US, sv-SE
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Hi Paul

I guess you have run into the limitation of __update_cache() not supporting highmem pages. That could be caused by an omission in my patch that forgets to clear the PG_dcache_dirty flag in flush_icache_page. I will submit an incremental patch for this.

- Lars

> 9 apr 2015 kl. 00:53 skrev Paul Burton <paul.burton@imgtec.com>:
> 
>> On Thu, Feb 26, 2015 at 02:16:01PM +0100, Lars Persson wrote:
>> This patch set proposes an improved fix for the race condition that
>> originally was fixed in commit 2a4a8b1e5d9d ("MIPS: Remove race window
>> in page fault handling").
>> 
>> I have used the flush_icache_page API that is marked as deprecated in
>> Documentation/cachetlb.txt. There are strong reasons to keep this API
>> because it is not possible to implement an efficient and race-free
>> lazy flushing using the other APIs.
>> 
>> You can refer to a discussion about the same issue in arch/arm where
>> they chose to implement the solution in set_pte_at. In arch/mips we
>> could not do this because we lack information about the executability
>> of the mapping in set_pte_at() and thus we would have to flush all
>> pages to be safe.
>> 
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/030915.html
>> 
>> Lars Persson (2):
>>  Revert "MIPS: Remove race window in page fault handling"
>>  MIPS: Fix race condition in lazy cache flushing.
> 
> FYI these 2 patches prevent a linux-next based kernel booting on the
> Ingenic JZ4780-based CI20 board. I've not yet tried on the in-tree
> JZ4740-based qi_lb60 to see whether it's also affected, nor have I yet
> figured out what's going wrong. I'll hopefully dig into it tomorrow, but
> just a heads up!
> 
> The boot failure (using an initramfs, so no DMA or much I/O at all):
> 
>    [    4.618013] Freeing unused kernel memory: 5160K (803d6000 - 808e0000)
>    [    4.625211] CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80027924, ra == 8001db10
>    [    4.635881] Oops[#1]:
>    [    4.638149] CPU: 0 PID: 1 Comm: init Not tainted 4.0.0-rc7-next-20150408+ #334
>    [    4.645354] task: 8dc39568 ti: 8dc3a000 task.ti: 8dc3a000
>    [    4.650736] $ 0   : 00000000 00000001 00000001 00001000
>    [    4.655965] $ 4   : 00000000 00000001 808e0000 8df0b610
>    [    4.639347] $ 8   : 00000000 8d8f8160 00000000 00000000
>    [    4.644575] $12   : 00000000 00000118 00000040 ffff0000
>    [    4.649802] $16   : 81c649fc 77984000 00000004 8df013f8
>    [    4.655030] $20   : 81c649fc 00000000 00000000 00040000
>    [    4.638413] $24   : ff000000 80027920
>    [    4.643642] $28   : 8dc3a000 8dc3bd38 ffffffbf 8001db10
>    [    4.648871] Hi    : 3036f946
>    [    4.651740] Lo    : eeea49fc
>    [    4.654620] epc   : 80027924 r4k_blast_dcache_page_dc32+0x4/0x9c
>    [    4.638763]     Not tainted
>    [    4.641550] ra    : 8001db10 __update_cache+0xa4/0xd0
>    [    4.646585] Status: 10000403 KERNEL EXL IE
>    [    4.650767] Cause : 00800008
>    [    4.653634] BadVA : 00000000
>    [    4.656503] PrId  : 3ee1024f (Ingenic JZRISC)
>    [    4.639002] Process init (pid: 1, threadinfo=8dc3a000, task=8dc39568, tls=00000000)
>    [    4.646636] Stack : 3f916478 67caba37 58047621 77984000 58047621 77984000 8df0b610 800b777c
>              00400000 00031ec0 00000001 00400000 8d8f8178 8ddae840 8de8fbdc 81c649fc
>              8df013f8 8dc3be00 8de8fbe0 8008f7ac 8df09e38 8de9be40 fffffff8 8deeb000
>              00000000 00000000 00000000 00000040 803b9924 8dcd9000 77984000 800e2200
>              803ca320 800e1474 8df013f8 00000610 77984b50 00000000 8df00778 8df0b610
>              ...
>    [    4.638523] Call Trace:
>    [    4.640962] [<80027924>] r4k_blast_dcache_page_dc32+0x4/0x9c
>    [    4.646608] [<8001db10>] __update_cache+0xa4/0xd0
>    [    4.651305] [<800b777c>] do_set_pte+0x14c/0x174
>    [    4.655826] [<8008f7ac>] filemap_map_pages+0x2ac/0x384
>    [    4.639107] [<800b7a54>] handle_mm_fault+0x2b0/0x1020
>    [    4.644148] [<8001f460>] __do_page_fault+0x160/0x470
>    [    4.649102] [<80013e24>] resume_userspace_check+0x0/0x10
>    [    4.654395]
>    [    4.655876]
>    Code: 03e00008  00000000  24831000 <bc950000> bc950020  bc950040  bc950060  bc950080  bc9500a0
>    [    4.643978] ---[ end trace 672ef517bf5944f0 ]---
>    [    4.648581] Fatal exception: panic in 5 seconds
> 
> The next-20140408 based CI20 branch (currently including reverts of
> these 2 patches) if anyone wants to reproduce:
> 
>    https://github.com/paulburton/linux/tree/wip-ci20-v4.1
> 
> Thanks,
>    Paul
> 
>> arch/mips/include/asm/cacheflush.h |   35 ++++++++++++++++++++---------------
>> arch/mips/include/asm/pgtable.h    |   10 ++++++----
>> arch/mips/mm/cache.c               |   27 ++++++++-------------------
>> 3 files changed, 34 insertions(+), 38 deletions(-)
>> 
>> -- 
>> 1.7.10.4
>> 
