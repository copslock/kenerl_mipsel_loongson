Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 05:54:05 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36319 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006506AbcA0EyCB0UcZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 05:54:02 +0100
Received: by mail-wm0-f66.google.com with SMTP id l65so1105930wmf.3;
        Tue, 26 Jan 2016 20:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wbhbekgPDx6s0xk157tfoe9OdYLztbgNA+kzLyFI8fo=;
        b=AeRpHDYaZVquJd3DvkiW2QsfSeaTCy2KNHWoCSqPxZHD0VnFWVo+5k3eFpxxLtWSyz
         F1BvYpGeHchwN8prl4R8h32lckDiOjaej7gYv581CtPKTmIOa05hYBXyoPxlaihXTPXL
         lZ9aqyuRizEfpqh1pKCHJIxqvuPnqmk63zgDqff32oPeqF4bjY5N2pUlu4mYv+WZPbHq
         tdPYekUrV2XB32pYgc/nR+efUauQn5XR5mgC09P+EPyqgZ+R7dWPr/QOVTP5x4Ozfd4+
         3hV1273zur8VvX5/67+PfhVGezy+GOpibQMbHDZgmXglj74B9g0ThAmf0lB3kWBmHoH1
         //9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wbhbekgPDx6s0xk157tfoe9OdYLztbgNA+kzLyFI8fo=;
        b=mxPVLI2DjqmzBrAz7z8eU1l6ooFLuvsc3LMgcOytoiJuXMdRoo3kkPN8eZbsUZb9lE
         erUiN1TwYR0AE4b4QHRI3aAognCB/fCcgzph0uKeqLbBC4eE7ctWqQDNbpZNR8x0K4v8
         vTGh0lxPn/j8ZgwSc2ClbZHQunPXxdSMRw5k15/0xsY4/LEPG/aR+uR22KxUjnMP0N68
         +osf0MF5P6aRV/8SzUtftKKabQRuacwRghRuZfcpgNbQuEw7bJjROalBLA+AfMh/eAQ8
         TqyXgkR7NjGLnEK2tnt5SV+1MsN94xtanwHzwWZo4bK8W1VOioLFkauwppfsWxiFiwcc
         WOdQ==
X-Gm-Message-State: AG10YOROqwZbdVYtPYzDdiDSPhCSjTB93RjmVNyl7c7yBIocsWOlLAphrDcedGt9LuF/50esqmdVGXFqEKJzvQ==
MIME-Version: 1.0
X-Received: by 10.194.187.240 with SMTP id fv16mr26843689wjc.39.1453870436760;
 Tue, 26 Jan 2016 20:53:56 -0800 (PST)
Received: by 10.27.13.15 with HTTP; Tue, 26 Jan 2016 20:53:56 -0800 (PST)
In-Reply-To: <56A7E206.4040301@gmail.com>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
        <1453814784-14230-5-git-send-email-chenhc@lemote.com>
        <56A7E206.4040301@gmail.com>
Date:   Wed, 27 Jan 2016 12:53:56 +0800
X-Google-Sender-Auth: ZpuRklm4Tbtks_tXZMQ7odwOId0
Message-ID: <CAAhV-H6BB6wjaQfU+zqTFv=qHDprwKexR74+V1EUnyEbrJ3gFw@mail.gmail.com>
Subject: Re: [PATCH 4/6] MIPS: tlbex: Fix bugs in tlbchange handler
From:   Huacai Chen <chenhc@lemote.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51451
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

When unaligned access triggered, do_ade() will access user address
with EXL=1, and that may trigger tlb refill.

Huacai

On Wed, Jan 27, 2016 at 5:15 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 01/26/2016 05:26 AM, Huacai Chen wrote:
>>
>> If a tlb miss triggered when EXL=1,
>
>
> How is that possible?  The exception handlers are not in mapped memory, and
> we clear EXL very early in the exception handlers.
>
> In valid code, how are you getting TLB related exceptions when EXL=1?
>
>
>> tlb refill exception is treated as
>> tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
>> register doesn't contain a valid value. This may not be a problem for
>> VTLB since it is fully-associative. However, FTLB is set-associative so
>> not every tlb entry is valid for a specific address. Thus, we should
>> use tlbwr instead of tlbwi when tlbp fails.
>>
>> There is a similar case for huge page, so build_huge_tlb_write_entry()
>> is also modified. If wmode != tlb_random, that means the caller is tlb
>> invalid handler, we should select tlbr/tlbi depend on the tlbp result.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>   arch/mips/mm/tlbex.c | 31 ++++++++++++++++++++++++++++++-
>>   1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index d0975cd..da68ffb 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -173,7 +173,10 @@ enum label_id {
>>         label_large_segbits_fault,
>>   #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>>         label_tlb_huge_update,
>> +       label_tail_huge_miss,
>> +       label_tail_huge_done,
>>   #endif
>> +       label_tail_miss,
>>   };
>>
>>   UASM_L_LA(_second_part)
>> @@ -192,7 +195,10 @@ UASM_L_LA(_r3000_write_probe_fail)
>>   UASM_L_LA(_large_segbits_fault)
>>   #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>>   UASM_L_LA(_tlb_huge_update)
>> +UASM_L_LA(_tail_huge_miss)
>> +UASM_L_LA(_tail_huge_done)
>>   #endif
>> +UASM_L_LA(_tail_miss)
>>
>>   static int hazard_instance;
>>
>> @@ -706,8 +712,24 @@ static void build_huge_tlb_write_entry(u32 **p,
>> struct uasm_label **l,
>>         uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
>>         uasm_i_mtc0(p, tmp, C0_PAGEMASK);
>>
>> -       build_tlb_write_entry(p, l, r, wmode);
>> +       if (wmode == tlb_random) { /* Caller is TLB Refill Handler */
>> +               build_tlb_write_entry(p, l, r, wmode);
>> +               build_restore_pagemask(p, r, tmp, label_leave,
>> restore_scratch);
>> +               return;
>> +       }
>> +
>> +       /* Caller is TLB Load/Store/Modify Handler */
>> +       uasm_i_mfc0(p, tmp, C0_INDEX);
>> +       uasm_il_bltz(p, r, tmp, label_tail_huge_miss);
>> +       uasm_i_nop(p);
>> +       build_tlb_write_entry(p, l, r, tlb_indexed);
>> +       uasm_il_b(p, r, label_tail_huge_done);
>> +       uasm_i_nop(p);
>> +
>> +       uasm_l_tail_huge_miss(l, *p);
>> +       build_tlb_write_entry(p, l, r, tlb_random);
>>
>> +       uasm_l_tail_huge_done(l, *p);
>>         build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
>>   }
>>
>> @@ -2026,7 +2048,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct
>> uasm_label **l,
>>         uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
>>         uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
>>         build_update_entries(p, tmp, ptr);
>> +       uasm_i_mfc0(p, ptr, C0_INDEX);
>> +       uasm_il_bltz(p, r, ptr, label_tail_miss);
>> +       uasm_i_nop(p);
>>         build_tlb_write_entry(p, l, r, tlb_indexed);
>> +       uasm_il_b(p, r, label_leave);
>> +       uasm_i_nop(p);
>> +       uasm_l_tail_miss(l, *p);
>> +       build_tlb_write_entry(p, l, r, tlb_random);
>>         uasm_l_leave(l, *p);
>>         build_restore_work_registers(p);
>>         uasm_i_eret(p); /* return from trap */
>>
>
>
