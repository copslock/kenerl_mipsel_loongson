Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2011 18:17:33 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:59553 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491177Ab1JQQR2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Oct 2011 18:17:28 +0200
Received: by gyd10 with SMTP id 10so3622163gyd.36
        for <multiple recipients>; Mon, 17 Oct 2011 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ARUvrYy8mqH88BXTyHdjc57zKx2D6716ZbxyKEUk8S4=;
        b=Pd71hz5g9Iu02CcT0pchFmMyQVVgMDxaMxgbfLhE61SxxqyvC6rQEHgJpqZHnRF4x3
         A0xImZb5pFt+BC0D4HPMgDOg6b8tI4BZVQPusmTWCLpsmIrcau6XpWfnbMUgbaQakvV1
         R/CQdqpm/c9rTWJ5504qkX8gggD40FxXzDKSA=
MIME-Version: 1.0
Received: by 10.42.161.70 with SMTP id s6mr39669956icx.40.1318868241792; Mon,
 17 Oct 2011 09:17:21 -0700 (PDT)
Received: by 10.42.170.1 with HTTP; Mon, 17 Oct 2011 09:17:21 -0700 (PDT)
In-Reply-To: <20111017145702.GC10290@linux-mips.org>
References: <CANudz+sswjeOP-JZfJnp5c+J0HAmY2OgCVJkdq9WK51ackb8vw@mail.gmail.com>
        <20111017145702.GC10290@linux-mips.org>
Date:   Tue, 18 Oct 2011 00:17:21 +0800
Message-ID: <CANudz+u7TjnaoD0z41qQuUR4EdrmypnRhpupOCi4uKRzt2ZGiA@mail.gmail.com>
Subject: Re: some questions about translation lookaside buffer
From:   loody <miloody@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12058

hi ralf:
Thanks for your reply :)
2011/10/17 Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Oct 17, 2011 at 07:36:11PM +0800, loody wrote:
>
>> Dear all:
>> I have some questions about local_flush_tlb_one.
>> 1. what will happen if I use local_flush_tlb_one to flush a page that
>> doesn't exist in translation lookaside buffer entries.
>>
>> The index return by read_c0_index(), should be negative.
>> but this function seems not handle the case that idx < 0.
>>
>> 2. as I know, translation lookaside buffer is a place to keep record
>> the memory mapping, it doesn't like cache have place to store the
>> data.
>>     a. If the entry is cacheable, what we only to do is flush the cache?
>>     b. if the entry is uncached, there is nothing to do?
>> if above b is correct, what will happen if we have an entry that is
>> uncached and dirty?
>
> If c0_index contains a value < 0 (or rather one with bit 31 set) then
> there is nothing that needs to be flushed.
but how about the case of c0_index >= 0, I found the code tried to
write the index with entry_lo0 and entry_lo1 as 0.
it seems clear the PFN part of the index. So it is the flush action?

>
> Note that MIPS D-cache (I-caches don't get written back so are not of
> concern) are tagged with a physical address so cache handling is no
> consideration for local_flush_tlb_one or any of the other TLB flush
> functions.
why tlb flush functions don't need to take care cache handling?
if tlb flush don't need to care cache, what is tlb flush used for,
since tlb is nothing but a place to do the address translation, right?

-- 
Appreciate your help,
