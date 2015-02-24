Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 00:15:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11573 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006911AbbBXXPm69IP0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 00:15:42 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3D310E87BFAD;
        Tue, 24 Feb 2015 23:15:33 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 24 Feb
 2015 23:15:37 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 24 Feb
 2015 15:15:22 -0800
Message-ID: <54ED060A.4010206@imgtec.com>
Date:   Tue, 24 Feb 2015 15:15:22 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Zenon Fortuna <zenon.fortuna@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with non-DMA
 I/O.
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com> <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org> <54ECE7CE.4040407@imgtec.com> <alpine.LFD.2.11.1502242140220.17311@eddie.linux-mips.org> <54ECF3E6.9080606@imgtec.com> <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45941
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

On 02/24/2015 02:50 PM, Maciej W. Rozycki wrote:
> On Tue, 24 Feb 2015, Leonid Yegoshin wrote:
>
>>>    For simplicity perhaps on SMP we should just always use hit operations
>>> regardless of the size requested.
>> High performance folks may not like doing a lot of stuff for 8MB VMA release
>> instead of flushing 64KB.
>   What kind of a use case is that, what does it do?
>
>
cacheflush() calls flush_icache_range(). And we see:

linux-yegoshin:/space/yegoshin/MIPS-kernel/linux-mips.org/linux-mti% gid 
flush_icache_range | grep -v arch/
include/asm-generic/cacheflush.h:20:#define flush_icache_range(start, 
end)        do { } while (0)
fs/binfmt_flat.c:787:    flush_icache_range(start_code, end_code);
fs/exec.c:823:        flush_icache_range(addr, addr + len);
kernel/module.c:2886:        flush_icache_range((unsigned 
long)mod->module_init,
kernel/module.c:2889:    flush_icache_range((unsigned long)mod->module_core,
mm/nommu.c:532:    flush_icache_range(mm->brk, brk);
mm/nommu.c:1441:        flush_icache_range(region->vm_start, 
region->vm_end);
drivers/misc/lkdtm.c:346:    flush_icache_range((unsigned long)dst, 
(unsigned long)dst + EXEC_SIZE);
drivers/misc/lkdtm.c:361:    flush_icache_range((unsigned long)dst, 
(unsigned long)dst + EXEC_SIZE);
drivers/misc/lkdtm.c:519:        flush_icache_range((unsigned long)ptr,
kernel/debug/debug_core.c:243:    flush_icache_range(addr, addr + 
BREAK_INSTR_SIZE);
kernel/debug/gdbstub.c:383:            flush_icache_range(addr, addr + 
length);
drivers/video/console/sticore.c:254:    flush_icache_range(start, end);
Documentation/cachetlb.txt:369:  void flush_icache_range(unsigned long 
start, unsigned long end)

It is not for VMA release, I was wrong here, but there are still some 
interesting use cases for flush_icache_range().


Note: it is not cacheflush() bug, it is bug in r4k_on_each_cpu(). I have 
a patch named

Author: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Mon Apr 1 20:10:30 2013 -0700

     MIPS: Cache flush functions are reworked.

     This patch is a preparation for EVA support in kernel.

     However, it also fixes a bug then index cacheop was not ran
     on multiple CPUs with unsafe index cacheops (flush_cache_vmap,
     flush_icache_range, flush_cache_range, __flush_cache_all).

     Additionally, it optimizes a usage of index and address cacheops for
     address range flushes depending from address range size.

     Because of that reasons it is a separate patch from EVA support.

     Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
     Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
     (cherry picked from commit 6b05dd71da1136fbad0ce642790c4c99343f05e7)

but it is still doesn't go through LMO.

- Leonid.
