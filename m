Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 03:14:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8884 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861457AbaGVBOvpBbRs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 03:14:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7F8B56A97D29D;
        Tue, 22 Jul 2014 02:14:43 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Jul 2014 02:14:44 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 21 Jul
 2014 18:14:41 -0700
Message-ID: <53CDBB01.7040007@imgtec.com>
Date:   Mon, 21 Jul 2014 18:14:41 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     David Rientjes <rientjes@google.com>
CC:     Max Filippov <jcmvbkbc@gmail.com>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-xtensa@linux-xtensa.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com> <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41409
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

On 07/21/2014 05:58 PM, David Rientjes wrote:
> On Thu, 17 Jul 2014, Max Filippov wrote:
>
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> Provide hooks that allow architectures with aliasing cache to align
>> mapping address of high pages according to their color. Such architectures
>> may enforce similar coloring of low- and high-memory page mappings and
>> reuse existing cache management functions to support highmem.
>>
> Typically a change like this would be proposed along with a change to an
> architecture which would define this new ARCH_PKMAP_COLORING and have its
> own overriding definitions.  Based on who you sent this patch to, it looks
> like that would be mips and xtensa.  Now the only question is where are
> those patches to add the alternate definitions for those platforms?
Yes, there is one, at least for MIPS. This stuff can be a common ground 
for both platforms (MIPS and XTENSA)

>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> [ Max: extract architecture-independent part of the original patch, clean
>>    up checkpatch and build warnings. ]
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>> Changes v1->v2:
>> - fix description
>>
>>   mm/highmem.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/highmem.c b/mm/highmem.c
>> index b32b70c..6898a8b 100644
>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -44,6 +44,14 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
>>    */
>>   #ifdef CONFIG_HIGHMEM
>>   
>> +#ifndef ARCH_PKMAP_COLORING
>> +#define set_pkmap_color(pg, cl)		/* */
> This is typically done with do {} while (0).
>
>> +#define get_last_pkmap_nr(p, cl)	(p)
>> +#define get_next_pkmap_nr(p, cl)	(((p) + 1) & LAST_PKMAP_MASK)
>> +#define is_no_more_pkmaps(p, cl)	(!(p))
> That's not gramatically proper.
>
>> +#define get_next_pkmap_counter(c, cl)	((c) - 1)
>> +#endif
>> +
>>   unsigned long totalhigh_pages __read_mostly;
>>   EXPORT_SYMBOL(totalhigh_pages);
>>   
>> @@ -161,19 +169,24 @@ static inline unsigned long map_new_virtual(struct page *page)
>>   {
>>   	unsigned long vaddr;
>>   	int count;
>> +	int color __maybe_unused;
>> +
>> +	set_pkmap_color(page, color);
>> +	last_pkmap_nr = get_last_pkmap_nr(last_pkmap_nr, color);
>>   
>>   start:
>>   	count = LAST_PKMAP;
>>   	/* Find an empty entry */
>>   	for (;;) {
>> -		last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
>> -		if (!last_pkmap_nr) {
>> +		last_pkmap_nr = get_next_pkmap_nr(last_pkmap_nr, color);
>> +		if (is_no_more_pkmaps(last_pkmap_nr, color)) {
>>   			flush_all_zero_pkmaps();
>>   			count = LAST_PKMAP;
>>   		}
>>   		if (!pkmap_count[last_pkmap_nr])
>>   			break;	/* Found a usable entry */
>> -		if (--count)
>> +		count = get_next_pkmap_counter(count, color);
> And that's not equivalent at all, --count decrements the auto variable and
> then tests it for being non-zero.  Your get_next_pkmap_counter() never
> decrements count.
David, the statements

             count = get_next_pkmap_counter(count, color);
             if (count > 0)

are extended in STANDARD (non colored) case to

             count = (count - 1);
             if (count > 0)

which are perfect equivalent of

             if (--count)

>
>> +		if (count > 0)
>>   			continue;
>>   
>>   		/*
