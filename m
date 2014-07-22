Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 11:55:05 +0200 (CEST)
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40895 "EHLO
        mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861447AbaGVJpElO8w- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 11:45:04 +0200
Received: by mail-oa0-f46.google.com with SMTP id m1so9201884oag.5
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=noUImqck6YeiVwu3Ci0Q043xbQa1YPf7eqfF5beVG50=;
        b=bNIjp5AtW4MrojrGs1zVbY2p7z0txUfR9Iqs7qTXQj7pukGT8h7W7ReJXEbzaVRf04
         p9JCPCj25NbT6UCQJ9Sgr/JNYZEK0optYaeRSAdI2R9Ns8zVISrQXGnWZrUSDOHiWMoE
         i0PtREnAFQ1n381YIysnCdu+LeQU0ggUFBa/AMMeWmyCMwxqECvYXi+lKr8Y6nhMvN2o
         0ojdrjQLBjlxrKCVy6EMebqYTuAz9USc7aNt+0OGqFKmH+fzp+Ckp0SQ49eksO5Pusql
         UYDlJ73Jnmg9FnC9EIr15zVkrsBmgV2Xa1gaT+sz59bLSrXAsQ+DZFO3U64gPi6cZaw3
         l34g==
MIME-Version: 1.0
X-Received: by 10.182.52.197 with SMTP id v5mr14039908obo.85.1406022290955;
 Tue, 22 Jul 2014 02:44:50 -0700 (PDT)
Received: by 10.76.130.47 with HTTP; Tue, 22 Jul 2014 02:44:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com>
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com>
        <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com>
Date:   Tue, 22 Jul 2014 13:44:50 +0400
Message-ID: <CAMo8BfKL2gAxidf3M_vdxSJJSh9=1JoJLt+WD8mv7S=h+OCJuw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

Hi David,

On Tue, Jul 22, 2014 at 4:58 AM, David Rientjes <rientjes@google.com> wrote:
> On Thu, 17 Jul 2014, Max Filippov wrote:
>
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> Provide hooks that allow architectures with aliasing cache to align
>> mapping address of high pages according to their color. Such architectures
>> may enforce similar coloring of low- and high-memory page mappings and
>> reuse existing cache management functions to support highmem.
>>
>
> Typically a change like this would be proposed along with a change to an
> architecture which would define this new ARCH_PKMAP_COLORING and have its
> own overriding definitions.  Based on who you sent this patch to, it looks
> like that would be mips and xtensa.  Now the only question is where are
> those patches to add the alternate definitions for those platforms?

I'm going to post xtensa series shortly, and I saw corresponding changes
for MIPS in the following patch:
http://permalink.gmane.org/gmane.linux.kernel.mm/107654

>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> [ Max: extract architecture-independent part of the original patch, clean
>>   up checkpatch and build warnings. ]
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>> Changes v1->v2:
>> - fix description
>>
>>  mm/highmem.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/highmem.c b/mm/highmem.c
>> index b32b70c..6898a8b 100644
>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -44,6 +44,14 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
>>   */
>>  #ifdef CONFIG_HIGHMEM
>>
>> +#ifndef ARCH_PKMAP_COLORING
>> +#define set_pkmap_color(pg, cl)              /* */
>
> This is typically done with do {} while (0).

Will fix.

>> +#define get_last_pkmap_nr(p, cl)     (p)
>> +#define get_next_pkmap_nr(p, cl)     (((p) + 1) & LAST_PKMAP_MASK)
>> +#define is_no_more_pkmaps(p, cl)     (!(p))
>
> That's not gramatically proper.

Just no_more_pkmaps maybe?

>> +#define get_next_pkmap_counter(c, cl)        ((c) - 1)
>> +#endif
>> +
>>  unsigned long totalhigh_pages __read_mostly;
>>  EXPORT_SYMBOL(totalhigh_pages);
>>
>> @@ -161,19 +169,24 @@ static inline unsigned long map_new_virtual(struct page *page)
>>  {
>>       unsigned long vaddr;
>>       int count;
>> +     int color __maybe_unused;
>> +
>> +     set_pkmap_color(page, color);
>> +     last_pkmap_nr = get_last_pkmap_nr(last_pkmap_nr, color);
>>
>>  start:
>>       count = LAST_PKMAP;
>>       /* Find an empty entry */
>>       for (;;) {
>> -             last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
>> -             if (!last_pkmap_nr) {
>> +             last_pkmap_nr = get_next_pkmap_nr(last_pkmap_nr, color);
>> +             if (is_no_more_pkmaps(last_pkmap_nr, color)) {
>>                       flush_all_zero_pkmaps();
>>                       count = LAST_PKMAP;
>>               }
>>               if (!pkmap_count[last_pkmap_nr])
>>                       break;  /* Found a usable entry */
>> -             if (--count)
>> +             count = get_next_pkmap_counter(count, color);
>
> And that's not equivalent at all, --count decrements the auto variable and
> then tests it for being non-zero.  Your get_next_pkmap_counter() never
> decrements count.

Yes, it's not literally equivalent, but it does the same thing: count gets
decreased by 1 and for loop iterates until count reaches zero.
get_next_pkmap_counter has no side effects, which is good. And count
is not supposed to go below zero anyway, but sure I can change the below
condition to 'if (count)'.

>> +             if (count > 0)
>>                       continue;
>>
>>               /*

-- 
Thanks.
-- Max
