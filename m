Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 10:17:35 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57954 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491134Ab1DEIR3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Apr 2011 10:17:29 +0200
Received: by wyb28 with SMTP id 28so117363wyb.36
        for <multiple recipients>; Tue, 05 Apr 2011 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=buN8xNYhHszaPsj64ATi3eB2TW8hU9D34YukIiaX6No=;
        b=QFw/paywn4YqVxWwWWckH8/uBNuZas1BLYpe2pdxRIvCgKwpfDzZF80dAbI2nZXmjU
         UhLIwVKq6qIBasJHcjWIoo0yiegPGlU3QG3O4gid8rfAXBef3Ric9Hvkty8xHzhFg6eW
         UuAWXuW+QvABwcB+0quK/0D1iAxB99+xm1CdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H9pS1gdiR0dmoX0XJ9yma1s5zmcfpV2Gq6JE1tpIoEcRSOFIbIza0x55vNpiiiu63b
         n+2MuZno1c2DLAu914DWMt2TB3SB+VoeX7YBPt0VDhgqz7t5MHtEepDbDhcospU2bvpc
         0fvThpXpy81q6M0rHbBqbQ9ILuU8BdtTMeYdk=
MIME-Version: 1.0
Received: by 10.227.163.13 with SMTP id y13mr2230082wbx.56.1301991443445; Tue,
 05 Apr 2011 01:17:23 -0700 (PDT)
Received: by 10.227.37.160 with HTTP; Tue, 5 Apr 2011 01:17:23 -0700 (PDT)
In-Reply-To: <afc622a1003230511o108556f4s5d1282bd3122b3d9@mail.gmail.com>
References: <28c262361003230146o7bca61e6h3af2062b1172fdb2@mail.gmail.com>
        <afc622a1003230511o108556f4s5d1282bd3122b3d9@mail.gmail.com>
Date:   Tue, 5 Apr 2011 17:17:23 +0900
Message-ID: <BANLkTimKw3mg8N-gBxh3jbo9msaHOF3qPA@mail.gmail.com>
Subject: Re: data consistency of high page
From:   NamJae Jeon <linkinjeon@gmail.com>
To:     Minchan Kim <minchan.kim@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <linkinjeon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linkinjeon@gmail.com
Precedence: bulk
X-list: linux-mips

Hi.

As you know, there is cache operation about highpage in arm arch.

arch/arm/mm/flush.c
-----------------------------------------------------------------------------------------------
if (!PageHighMem(page)) {
                __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
        } else {
                void *addr = kmap_high_get(page);
                if (addr) {
                        __cpuc_flush_dcache_area(addr, PAGE_SIZE);
                        kunmap_high(page);
                } else if (cache_is_vipt()) {
                        /* unmapped pages might still be cached */
                        addr = kmap_atomic(page);
                        __cpuc_flush_dcache_area(addr, PAGE_SIZE);
                        kunmap_atomic(addr);
                }
        }
-------------------------------------------------------------------------------------------------

currently, mips kernel just return without cache operation.

Would you plz tell me your opinion ?

Thanks.


2010/3/23 NamJae Jeon <linkinjeon@gmail.com>:
> Hi. Ralf.
>
> I'm Namjae.jeon. nice to meet you.
>
> I face cache aliasing problem on mips 34ke.
>
> Our target cache is 34kB 4way i/d-cache , 32bytes linesize.
>
> As you know, there is possibility of cache aliasing on 8kB per way.
>
> But mips arch of kernel mainline can not properly  handile this case.
>
> For example, highmem handling in __fluash_dcache_page function is just return.
>
> So, if argument page is page in highmem, it can not flush in dcache line.
>
> I want to listen your opinion.
>
> Thanks.
>
>
> 2010/3/23 Minchan Kim <minchan.kim@gmail.com>:
>> Hi, Ralf.
>>
>> Below is thread long time ago.
>> At that time, we can't end up the problem by some reason.
>> Sorry for that.
>>
>> The problem would occur, again.
>>
>> On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>>> On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:
>>>
>>>> Many code of kernel fs usually allocate high page and flush.
>>>> But flush_dcache_page of mips checks PageHighMem to avoid flush
>>>> so that data consistency is broken, I think.
>>>
>>> What processor and cache configuration?
>>>
>>>> I found it's by you and Atsushi-san on 585fa724.
>>>> Why do we need the check?
>>>> Could you elaborte please?
>>>
>>> The if statement exists because __flush_dcache_page would crash if a page
>>> is not mapped.  This of course isn't correct but that wasn't a problem
>>> since highmem still is only supported on machines that don't have aliases.
>>>
>>>  Ralf
>>>
>>
>> Our system is following as.
>>
>> mips 34ke
>> primary i-cache 32kB VIPT 4way 32 byte line size.
>> primary d-cache 32kB 4way  32 bytes linesize
>>
>> If you have further questions, Namjae, Could you follow question of Ralf?
>>
>> --
>> Kind regards,
>> Minchan Kim
>>
>
