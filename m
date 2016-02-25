Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 06:32:23 +0100 (CET)
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37272 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007280AbcBYFcUatrWb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 06:32:20 +0100
Received: by mail-wm0-f50.google.com with SMTP id g62so11828342wme.0;
        Wed, 24 Feb 2016 21:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Dh6xIv7Gsnc+ndelpEjvqSFHOHw7196Z55ElJPetK/s=;
        b=RUDsaXb6TIywvPWBF2CQoEbmC8SrJdqBwD/n/FTYbx7gBWln1QXa0CZSj3uGcSRdvA
         jvb6pg4Zpw6Q2ImAyiXx8ATYiydChGOtwBtksExwemJTNc+YFvOS7c77jZFPrGU83Ems
         RTLRd+gYQSgfxGCda1gVV3DzrhscWnWGvO+CZOrINm/M09u6eCZLqhOoeCiFiswOoIXR
         fw+5qRyTKZAXezZ+eZluEFgrpJdJLYqOeLda6BCdO3xNOhqVKhEqtUywlaVQfH0E4qXZ
         1G14iKP7bEISBUCEkDqqB0wb1CHLlNOrntfZef8MbRPPsx7+/QU1yTNq/WOtNqW6Pcdo
         0RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Dh6xIv7Gsnc+ndelpEjvqSFHOHw7196Z55ElJPetK/s=;
        b=jq3PzgWbE3AGYk37ssGdge7nwhxQN2XOi1AaOPXcS83QYLnYD6MBkFKpBkRnYN66ap
         kzK1IWxl3OQslC62LPtCh4wsDuwlZJ1hDrs8or6WQimSmT4iXSmK0WUJygaGktdia+ln
         IHD5rry+0u/n/c81/TzoSTrnAwNv20RIZUPiELZO6IbNiOxPvAwV5X+b8iGKOIWqArUT
         MLXPtuMgskZ4IfMO90g95bQmJ8hLzTDOieQH5mg3JLXYdoUqCsYJ1lhPjuNynDWYdgvs
         TnF29VLSb1mregIh7fyf233xQ9F1TCclxxNXgzWelenYtQeLn6eRfg03MrVwKiJrZTpY
         6Qsg==
X-Gm-Message-State: AG10YOTQRzV+6u1eh2zt1mBecYATgzOpVuee9ZDytyGGZr2tCVbVsrgPxTO5Y5UMLhsla+ufuuABChUnXkU39A==
MIME-Version: 1.0
X-Received: by 10.194.60.100 with SMTP id g4mr42141302wjr.30.1456378335237;
 Wed, 24 Feb 2016 21:32:15 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Wed, 24 Feb 2016 21:32:15 -0800 (PST)
In-Reply-To: <56CE5382.4090800@gmail.com>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-2-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250029390.15885@tp.orcam.me.uk>
        <56CE5382.4090800@gmail.com>
Date:   Thu, 25 Feb 2016 13:32:15 +0800
X-Google-Sender-Auth: uCYDIofrKiRnS7WSPlGK2iVdluY
Message-ID: <CAAhV-H7MDTRWoDx-j-DHH1UnUmhb1CFK1go-W+Qxz+8W21qrhg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: tlbex: Fix bugs in tlbchange handler
From:   Huacai Chen <chenhc@lemote.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, David and Maciej,

I *do* have answered your quesition, which you can see here:
https://patchwork.linux-mips.org/patch/12240/

When unaligned access triggered, do_ade() will access user address
with EXL=1, and that may trigger tlb refill.

Huacai

On Thu, Feb 25, 2016 at 9:06 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 02/24/2016 04:40 PM, Maciej W. Rozycki wrote:
>>
>> On Wed, 24 Feb 2016, Huacai Chen wrote:
>>
>>> If a tlb miss triggered when EXL=1, tlb refill exception is treated as
>>> tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
>>> register doesn't contain a valid value. This may not be a problem for
>>> VTLB since it is fully-associative. However, FTLB is set-associative so
>>> not every tlb entry is valid for a specific address. Thus, we should
>>> use tlbwr instead of tlbwi when tlbp fails.
>>
>>
>>   Can you please explain exactly why this change is needed?  You're
>> changing pretty generic code which has worked since forever.  So why is a
>> change suddenly needed?  Our kernel entry/exit code has been written such
>> that no mapped memory is accessed with EXL=1 so no TLB exception is
>> expected to ever happen in these circumstances.  So what's your scenario
>> you mean to address?  Your patch description does not explain it.
>>
>
> I asked this exact same question back on Jan. 26, when the patch was
> previously posted.
>
> No answer was given, all we got was the same thing again with no
> explanation.
>
> David Daney
>
>
>
>
>>> @@ -1913,7 +1935,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct
>>> uasm_label **l,
>>>         uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
>>>         uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
>>>         build_update_entries(p, tmp, ptr);
>>> +       uasm_i_mfc0(p, ptr, C0_INDEX);
>>> +       uasm_il_bltz(p, r, ptr, label_tail_miss);
>>> +       uasm_i_nop(p);
>>>         build_tlb_write_entry(p, l, r, tlb_indexed);
>>> +       uasm_il_b(p, r, label_leave);
>>> +       uasm_i_nop(p);
>>> +       uasm_l_tail_miss(l, *p);
>>> +       build_tlb_write_entry(p, l, r, tlb_random);
>>>         uasm_l_leave(l, *p);
>>>         build_restore_work_registers(p);
>>>         uasm_i_eret(p); /* return from trap */
>>
>>
>>   Specifically you're causing a performance hit here, which is a fast
>> path,
>> for everyone.  If you have a scenario that needs this change, then please
>> make it conditional on the circumstances and keep the handler unchanged in
>> all the other cases.
>>
>>    Maciej
>>
>>
>>
>
>
