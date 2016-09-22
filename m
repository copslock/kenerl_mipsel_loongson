Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 00:13:39 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33926 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbcIVWNcCR0Z0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 00:13:32 +0200
Received: by mail-wm0-f66.google.com with SMTP id l132so16241123wmf.1
        for <linux-mips@linux-mips.org>; Thu, 22 Sep 2016 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=uE8/6MAQt/VI7nSXWA6vav/AGNbr1Onxs8YUe2y2zFA=;
        b=wh4mXHVW9YveCmbnsP/qBmRKQAyOEw85sBrJ9JfhwfAP21uUnuevEpDUZL3JLqL947
         NjKAv7upEuepWrA6ET2Mv3a6JZwiovwmXBPTLgZtLv4O5RkQnkkUU8mqHvs3V1PjcOGk
         0PPPNGAPMuZI0++nNdgCUCS9DivQY3QaEc5kJqP955E5xqGJOa0jsfYSOBLJKxVAsGBB
         Ynm7tr9cJNmrT1y+xWp27ZxRWbNDH+KCVU+3zWo3nQyTaOexgcu4MXjer6g7oukSTmw9
         0HS7qJuDx3YKpayN8jpEsHP3VsLYg1WH+2KhFfORIjZUfVD2U7udsZliws7c2ih3IbJV
         R1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=uE8/6MAQt/VI7nSXWA6vav/AGNbr1Onxs8YUe2y2zFA=;
        b=f41Eg7r14UoYD7aqSEyqPGQ3BSFYUNbMW5QQKiNdvfobOf3UC1+CAUAGhIUN2pIRyr
         l9REHJAA9LbSMreWV6V3ncH83/gq9uOSzOf66yf/OX2l2wkwgZIJW2RxVxWN7LGHxIGL
         9x0yK4x2TcyJCr8vtN0scqL5bmfhNnhkdTB2og1lh86OwrjR5FrJGS/EV3JkCW9hLKGX
         jzgvpWqQ6j7rJHXyIjsCtOZAN2eyNRYcgCvzrs50GezQZuJZXS05c3ea4yNTwI8LB/4y
         1eQ+YAsEqFvZYQuglQIJMVPast0CJVytlvMJ31Ln//d2gCXZsvbTNAa1dGUtW6Eym7T3
         F/ww==
X-Gm-Message-State: AA6/9RnRChdieRDM6zPQn6yCbYMfIUSJ3mAHCX4MjA3trsDdjG17q6/iOjzHoMv7iq0R/A==
X-Received: by 10.28.16.148 with SMTP id 142mr70335wmq.5.1474582406611;
        Thu, 22 Sep 2016 15:13:26 -0700 (PDT)
Received: from Unknown (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id n7sm4051197wjs.34.2016.09.22.15.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 15:13:26 -0700 (PDT)
In-Reply-To: <57E44F59.5050600@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <0d915756776de050b8a92b5bb5d4e7ffbe784d66.1472747205.git-series.james.hogan@imgtec.com> <20160921132656.GF14137@linux-mips.org> <57E2CE5B.8020406@imgtec.com> <20160922211527.GB7352@jhogan-linux.le.imgtec.org> <57E44F59.5050600@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 7/9] MIPS: uprobes: Flush icache via kernel address
From:   James Hogan <james.hogan@imgtec.com>
Date:   Thu, 22 Sep 2016 23:13:27 +0100
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-ID: <7C466D41-C786-48E0-9BFB-1024D6F9AFFC@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 22 September 2016 22:38:33 BST, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
>On 09/22/2016 02:15 PM, James Hogan wrote:
>> On Wed, Sep 21, 2016 at 11:15:55AM -0700, Leonid Yegoshin wrote:
>>> On 09/21/2016 06:26 AM, Ralf Baechle wrote:
>>>> On Thu, Sep 01, 2016 at 05:30:13PM +0100, James Hogan wrote:
>>>>
>>>>> Update arch_uprobe_copy_ixol() to use the kmap_atomic() based
>kernel
>>>>> address to flush the icache with flush_icache_range(), rather than
>the
>>>>> user mapping. We have the kernel mapping available anyway and this
>>>>> avoids having to switch to using the new
>__flush_icache_user_range() for
>>>>> the sake of Enhanced Virtual Addressing (EVA) where
>flush_icache_range()
>>>>> will become ineffective on user addresses.
>>>>>
>>>>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>>>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>>>> Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
>>>>> Cc: linux-mips@linux-mips.org
>>>>> ---
>>>>>    arch/mips/kernel/uprobes.c | 13 ++++---------
>>>>>    1 file changed, 4 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/arch/mips/kernel/uprobes.c
>b/arch/mips/kernel/uprobes.c
>>>>> index 8452d933a645..9a507ab1ea38 100644
>>>>> --- a/arch/mips/kernel/uprobes.c
>>>>> +++ b/arch/mips/kernel/uprobes.c
>>>>> @@ -301,19 +301,14 @@ int set_orig_insn(struct arch_uprobe
>*auprobe, struct mm_struct *mm,
>>>>>    void __weak arch_uprobe_copy_ixol(struct page *page, unsigned
>long vaddr,
>>>>>    				  void *src, unsigned long len)
>>>>>    {
>>>>> -	void *kaddr;
>>>>> +	void *kaddr, kstart;
>>>>>    
>>>>>    	/* Initialize the slot */
>>>>>    	kaddr = kmap_atomic(page);
>>>>> -	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
>>>>> +	kstart = kaddr + (vaddr & ~PAGE_MASK);
>>>>> +	memcpy(kstart, src, len);
>>>>> +	flush_icache_range(kstart, kstart + len);
>>>>>    	kunmap_atomic(kaddr);
>>>>> -
>>>>> -	/*
>>>>> -	 * The MIPS version of flush_icache_range will operate safely on
>>>>> -	 * user space addresses and more importantly, it doesn't require
>a
>>>>> -	 * VMA argument.
>>>>> -	 */
>>>>> -	flush_icache_range(vaddr, vaddr + len);
>>>> I can't convince myself this is right wrt. to cache aliases ...
>>>>
>>>>     Ralf
>>>>
>>> It is incorrect if there is I-cache aliasing (very rare) and there
>is no
>>> HIGHMEM cache aliasing fix (not fixed). But top tree Linux doesn't
>work
>>> with I-cache aliasing either.
>> Well its pretty trivial to just use the newly introduced
>> __flush_icache_user_range() on the user address instead of using
>> flush_icache_range().
>
>It may not work - you should flush kernel Dcache but user Icache and 
>__flush_icache_user_range() doesn't do it.

well it'll do a protected dcache flush (i.e. using CACHEE with EVA). Would kmap/kunmap or variants (fixed to work with aliasing dcache) be able to take care of colouring / further flushing?

In any case, simply changing to the user_ one is a no-op compared to leaving as is where patch 9 would probably break it on EVA by making it operate only on kernel addresses.

Cheers
James

> Some CPU may accept an 
>aliasing CACHE instruction and flush both colors and it can work in
>this 
>case.
>
>Besides that, I had no time to research - does uprobe keep data on the 
>same page as code? If yes, then we may want to make a special flush 
>sequence for cache aliasing systems here. (User-Dcache, Write-to-page, 
>Kernel-Dcache, User-Icache).
>
>- Leonid


--
James Hogan
