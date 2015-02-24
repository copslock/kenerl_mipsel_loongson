Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 01:56:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59948 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006864AbbBXA4cZJ-Jf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 01:56:32 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0FE4BA4215B3;
        Tue, 24 Feb 2015 00:56:23 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 24 Feb
 2015 00:56:26 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 23 Feb
 2015 16:56:24 -0800
Message-ID: <54EBCC38.7000702@imgtec.com>
Date:   Mon, 23 Feb 2015 16:56:24 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@chromium.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with non-DMA
 I/O.
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com>
In-Reply-To: <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45901
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

On 02/20/2015 11:17 AM, Kevin Cernekee wrote:
> On Thu, Feb 19, 2015 at 8:17 AM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> Flush the D-cache before the page is given to a process
>> as an executable (I-cache) page when the backing store
>> is non-DMA I/O.
>>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> This patch seems to make several different changes to the cache
> maintenance code all at once:
>
> 1) Add logic to handle virtually tagged D$
This is needed for 74K/1074K erratas. It is somehow was split from 
006a851b10a395955c153a145ad8241494d43688 which was accepted upstream but 
erratas not go through.

The HW behaviour is similar to virtually tagged D$ but it is a HW bug.

>   and perform extra flushes
> on TLB updates
As I understand, it is about adding __update_cache() in 
update_mmu_cache(), right?
If so, then - this code exists from the first git version of kernel from 
Mr. Linus.
It was deleted by mistake, I think.

>
> 2) Add new write barriers betwen D$/I$ or D$/L2 flushes
It is required. MIPS32/64 R2 specs say:

> "For implementations which implement multiple level of caches without 
> the inclusion property, the use of a SYNC
> instruction after the CACHE instruction is still needed whenever 
> writeback data has to be resident in the next level of
> memory hierarchy."

So, if we need to transfer instruction from D$ to L2 then we should use 
SYNC after CACHE D$ before operates with this data in L2. In other case 
the CACHE for L2 may go ahead of completion of D$ for the same line and 
flush a stale data.

The same is basically for transfer D$ --> I$ because in MIPS it is done 
via L2 or memory.


>
> 3) Make __flush_anon_page() play nice with HIGHMEM on systems with cache aliases
>
> and maybe a few more that I missed.
4) It is basically a revert of patch 64f23ab30b1fe which kills a 
performance in non Cavium Octeon CPUs, actually - any CPU which has no 
D$ cache snooping in I$.

But just revert is incorrect, the another proper stuff is required for 
correct operations.
>
> Would it be possible to split this out into individual commits, and
> include more comprehensive changelogs for each one describing the
> exact problem being solved?
I would ask Steven to do it. The original code dates back to 2.6.32 and 
it was packed/split in different patches multiple times. After a lot of 
split/join following patch acceptance/rejection we have what we have now.

In my opinion, the process of splitting into individual commits are 
something wrong - some patches are accepted and some - not, and we have 
a buggy code now. It should be packed into functional patches but each 
patch should be a single workable commit. If multiple patches are needed 
to fix a problem then result is sometime wrong.

>
> Also, it would be helpful to clarify how this relates to the use of
> swap (?) with a backing store that is non-DMA I/O.  Do you have an
> example of a situation where the existing code broke?  A play-by-play
> postmortem would make for interesting reading.

I guess, it is a little incorrect - this code is REQUIRED for non-DMA 
I/O with root FS or swap but it is not enough. Another patch is still 
needed to complete, see http://patchwork.linux-mips.org/patch/8635/

- Leonid.
