Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 20:06:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10399 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993361AbcGKSF7uke3V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 20:05:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 859C27CBF67D5;
        Mon, 11 Jul 2016 19:05:40 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 19:05:43 +0100
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 11 Jul
 2016 11:05:41 -0700
Message-ID: <5783DFF5.3060401@imgtec.com>
Date:   Mon, 11 Jul 2016 11:05:41 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     <yhb@ruijie.com.cn>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: We need to clear MMU contexts of all other processes
 when asid_cache(cpu) wraps to 0.
References: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn> <5783DF18.1080408@imgtec.com>
In-Reply-To: <5783DF18.1080408@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54284
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

> On 07/10/2016 06:04 AM, yhb@ruijie.com.cn wrote:
>> Subject: [PATCH] MIPS: We need to clear MMU contexts of all other 
>> processes
>>   when asid_cache(cpu) wraps to 0.
>>
>> Suppose that asid_cache(cpu) wraps to 0 every n days.
>> case 1:
>> (1)Process 1 got ASID 0x101.
>> (2)Process 1 slept for n days.
>> (3)asid_cache(cpu) wrapped to 0x101, and process 2 got ASID 0x101.
>> (4)Process 1 is woken,and ASID of process 1 is same as ASID of 
>> process 2.
>>
>> case 2:
>> (1)Process 1 got ASID 0x101 on CPU 1.
>> (2)Process 1 migrated to CPU 2.
>> (3)Process 1 migrated to CPU 1 after n days.
>> (4)asid_cache on CPU 1 wrapped to 0x101, and process 2 got ASID 0x101.
>> (5)Process 1 is scheduled, and ASID of process 1 is same as ASID of 
>> process 2.
>>
>> So we need to clear MMU contexts of all other processes when 
>> asid_cache(cpu) wraps to 0.
>>
>> Signed-off-by: yhb <yhb@ruijie.com.cn>
>>
>
I think a more clear description should be given here - there is no 
indication that wrap happens over 32bit integer.

And taking into account "n days" frequency - can we just kill all local 
ASIDs in all processes (additionally to local_flush_tlb_all) and enforce 
reassignment if wrap happens? It should be a very rare event, you are 
first to hit this.

It seems to be some localized stuff in get_new_mmu_context() instead of 
widespread patching.

- Leonid
