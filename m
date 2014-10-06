Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 22:03:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27970 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010636AbaJFUDzgBwZB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 22:03:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B9C4056F39474;
        Mon,  6 Oct 2014 21:03:44 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 6 Oct
 2014 21:03:47 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 6 Oct
 2014 21:03:47 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 6 Oct
 2014 21:03:47 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 6 Oct 2014
 13:03:43 -0700
Message-ID: <5432F59F.9080709@imgtec.com>
Date:   Mon, 6 Oct 2014 13:03:43 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <david.daney@cavium.com>, <peterz@infradead.org>,
        <paul.gortmaker@windriver.com>, <davidlohr@hp.com>,
        <macro@linux-mips.org>, <chenhc@lemote.com>, <zajec5@gmail.com>,
        <james.hogan@imgtec.com>, <keescook@chromium.org>,
        <alex@alex-smith.me.uk>, <tglx@linutronix.de>,
        <blogic@openwrt.org>, <jchandra@broadcom.com>,
        <paul.burton@imgtec.com>, <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <manuel.lauss@gmail.com>,
        <akpm@linux-foundation.org>, <lars.persson@axis.com>
Subject: Re: [PATCH 2/3] MIPS: Setup an instruction emulation in VDSO protected
 page instead of user stack
References: <20141004030438.28569.85536.stgit@linux-yegoshin> <20141004031730.28569.38511.stgit@linux-yegoshin> <5432D9F8.9040004@gmail.com>
In-Reply-To: <5432D9F8.9040004@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42965
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

On 10/06/2014 11:05 AM, David Daney wrote:
> On 10/03/2014 08:17 PM, Leonid Yegoshin wrote:
>> Historically, during FPU emulation MIPS runs live BD-slot instruction 
>> in stack.
>> This is needed because it was the only way to correctly handle branch
>> exceptions with unknown COP2 instructions in BD-slot. Now there is
>> an eXecuteInhibit feature and it is desirable to protect stack from 
>> execution
>> for security reasons.
>> This patch moves FPU emulation from stack area to VDSO-located page 
>> which is set
>> write-protected for application access. VDSO page itself is now 
>> per-thread and
>> it's addresses and offsets are stored in thread_info.
>> Small stack of emulation blocks is supported because nested traps are 
>> possible
>> in MIPS32/64 R6 emulation mix with FPU emulation.
>>
>
> Can you explain how this per-thread mapping works.
>
> I am especially interested in what happens when a different thread 
> from the thread using the special mapping, issues flush_tlb_mm(), and 
> invalidates the TLBs on all CPUs.  How does the TLB entry for the 
> special mapping survive this?
>
>
This patch works as long as 'install_special_mapping()' doesn't change 
PTE itself but installs Page Fault handler. It is the only hidden 
dependency from common Linux code.

MIPS code allocates a page (copy of a standard 'VDSO' page) and links it 
to thread_info and handles all allocation/deallocation/thread creation 
via arch hooks. It does it only for thread which have a memory map, not 
for kernel threads. Oh, it does all stuff only if CPU has RI/XI 
capability - the HW execute inhibit feature, otherwise it works as is 
done today.

It still does attachment of a standard 'VDSO' page to memory map for 
accounting purpose, so /proc/.../maps shows [VDSO] page. However the new 
(per-thread) page is actually a shadow.

Then TLB refill happens it loads an empty PTE and subsequent TLBL (TLB 
load Page Fault) comes to MIPS C-code which recognizes 'VDSO' address 
and asks install_vdso_tlb() to fill TLB directly and marks ASID of it in 
memory map for this CPU.

At process (read - thread) reschedule there is a check that on this CPU 
some previous thread of the same memory map loads TLB via comparing 
ASIDs. If that happend and ASIDs are the same, then local_flush_tlb_page 
is called to eliminate this TLB because it has the same ASID but can 
have a different per-thread page.

Because PTE stays as 0x00..00 and never changes then this activity 
starts again after eviction of TLB due to some reason - either 
flush_tlb_mm(), either other flush or either eviction due to TLB array 
HW or SW replacements, but only if page is demanded again.

Now, the emulation part:  some stack of emulation blocks can be used 
from top of page. Each time during emulation of FPU instruction from 
BD-slot it takes a kernel VA of page and puts that into stack but 
changes a thread EPC to user VA of that block. It uses a cache flush via 
different addresses here (D-cache via kernel VA and I-cache via user VA) 
in case of cache aliasing and new functions is needed to avoid a huge 
performance loss from flush_cache_page(). It uses a regular 
flush_cache_sigtramp() in absence of cache aliasing because in some 
systems it can be much faster (via SYNCI).

Stack of emulation blocks is needed because I work on MIPS32/64 R6 
architecture kernel and there is a need for emulation of some removed 
MIPS R2 instructions. And a reentry of emulation may happens in some 
rare cases - FPU emulation and MIPS R2 emulation subsystems are 
different pieces.


Note: After Peter Zijlstra note about performance I am thinking about 
adding the check of situation then the same single thread is rescheduled 
again on the same CPU and don't flush TLB in this case. It just requires 
yet another array of process-ids or 'VDSO' pages - one element per CPU 
and I am weighting it against schedule time interval. Today array is max 
8 elements for MIPS but it can change in future. There is also a 
possibility to write a special TLB flush function which compares TLB 
element address with page address and skips TLB element eviction if 
address compares.

- Leonid.
