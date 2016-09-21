Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 20:16:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53820 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991970AbcIUSQQc9ttI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2016 20:16:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D0E24F24FB67C;
        Wed, 21 Sep 2016 19:15:55 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 21 Sep
 2016 19:16:00 +0100
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 21 Sep
 2016 11:15:56 -0700
Message-ID: <57E2CE5B.8020406@imgtec.com>
Date:   Wed, 21 Sep 2016 11:15:55 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 7/9] MIPS: uprobes: Flush icache via kernel address
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <0d915756776de050b8a92b5bb5d4e7ffbe784d66.1472747205.git-series.james.hogan@imgtec.com> <20160921132656.GF14137@linux-mips.org>
In-Reply-To: <20160921132656.GF14137@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55224
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

On 09/21/2016 06:26 AM, Ralf Baechle wrote:
> On Thu, Sep 01, 2016 at 05:30:13PM +0100, James Hogan wrote:
>
>> Update arch_uprobe_copy_ixol() to use the kmap_atomic() based kernel
>> address to flush the icache with flush_icache_range(), rather than the
>> user mapping. We have the kernel mapping available anyway and this
>> avoids having to switch to using the new __flush_icache_user_range() for
>> the sake of Enhanced Virtual Addressing (EVA) where flush_icache_range()
>> will become ineffective on user addresses.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
>> Cc: linux-mips@linux-mips.org
>> ---
>>   arch/mips/kernel/uprobes.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
>> index 8452d933a645..9a507ab1ea38 100644
>> --- a/arch/mips/kernel/uprobes.c
>> +++ b/arch/mips/kernel/uprobes.c
>> @@ -301,19 +301,14 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>   void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>>   				  void *src, unsigned long len)
>>   {
>> -	void *kaddr;
>> +	void *kaddr, kstart;
>>   
>>   	/* Initialize the slot */
>>   	kaddr = kmap_atomic(page);
>> -	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
>> +	kstart = kaddr + (vaddr & ~PAGE_MASK);
>> +	memcpy(kstart, src, len);
>> +	flush_icache_range(kstart, kstart + len);
>>   	kunmap_atomic(kaddr);
>> -
>> -	/*
>> -	 * The MIPS version of flush_icache_range will operate safely on
>> -	 * user space addresses and more importantly, it doesn't require a
>> -	 * VMA argument.
>> -	 */
>> -	flush_icache_range(vaddr, vaddr + len);
> I can't convince myself this is right wrt. to cache aliases ...
>
>    Ralf
>
It is incorrect if there is I-cache aliasing (very rare) and there is no 
HIGHMEM cache aliasing fix (not fixed). But top tree Linux doesn't work 
with I-cache aliasing either.

- Leonid.
