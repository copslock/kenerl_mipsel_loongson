Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2014 09:09:20 +0200 (CEST)
Received: from mail-qa0-f41.google.com ([209.85.216.41]:54532 "EHLO
        mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859949AbaHEHJLFt1Hd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2014 09:09:11 +0200
Received: by mail-qa0-f41.google.com with SMTP id j7so530016qaq.0
        for <multiple recipients>; Tue, 05 Aug 2014 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SZ02Ug0rf9UQREIbY2FPfmFsX5NrBAJdTuzR0LTE9AE=;
        b=HD0LOjoutfmkcNR22oxTGIrH6ctJME5njupOE1/rjb5TC1HuMpi7L7B1jPss/szrqv
         K+3WsJJFTOETG0Ae0dqRIdVJ794GYYoKQjKewKNJr5y5J5cItCmY90A7hZEyHeQCdLNo
         Ktv9LvCFOh2LNfAJLXFjaXDYtnEhBZREJynh0XV/GlFZbhZ4MgPn/iYBL/iUfEqSu56Z
         9YGoc3N8vXWuD12V8ih1T09asMwG3MU9yJicm2zH2ReQE9Y+J3OxkxKX2Lu9wXjyQKy1
         baOyx35xkkpsalAPFbovMFtGgCcZz0peqKuvAbCfaO5ldRguwXsU9hubZsnftCvKS0JP
         oc/A==
MIME-Version: 1.0
X-Received: by 10.140.48.161 with SMTP id o30mr2365808qga.68.1407222544988;
 Tue, 05 Aug 2014 00:09:04 -0700 (PDT)
Received: by 10.140.105.119 with HTTP; Tue, 5 Aug 2014 00:09:04 -0700 (PDT)
In-Reply-To: <53DF864B.6000702@imgtec.com>
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com>
        <2357839.vPXx615ci5@radagast>
        <53D9674E.4000507@caviumnetworks.com>
        <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com>
        <53D99854.8090109@caviumnetworks.com>
        <53DA2E66.20200@imgtec.com>
        <53DA7E03.9090306@caviumnetworks.com>
        <20140802213538.GC19066@hall.aurel32.net>
        <53DF5BB2.70502@imgtec.com>
        <20140804130506.GA27352@hall.aurel32.net>
        <53DF864B.6000702@imgtec.com>
Date:   Tue, 5 Aug 2014 15:09:04 +0800
X-Google-Sender-Auth: UzeO-zPWc6vsNXBgPzFMsiZpEKU
Message-ID: <CAAhV-H56MhaMvjX1T4uj=DhC9vgibVvAOa+-u5n_s1cwP4EHzw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
From:   Huacai Chen <chenhc@lemote.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        David Daney <ddaney@caviumnetworks.com>,
        James Hogan <james@albanarts.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41882
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

Now what should we do? My original patch is not perfect, but it has
already merged into Ralf's tree (but hasn't merged in Linus's tree).
Let me send Ralf a new version of this patch? Or let David send
another patch on top of my original one?

Huacai

On Mon, Aug 4, 2014 at 9:10 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On 04/08/14 14:05, Aurelien Jarno wrote:
>> On Mon, Aug 04, 2014 at 11:08:50AM +0100, James Hogan wrote:
>>> Hi Aurelien,
>>>
>>> On 02/08/14 22:35, Aurelien Jarno wrote:
>>>> On Thu, Jul 31, 2014 at 10:33:55AM -0700, David Daney wrote:
>>>>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>>>>> index f99ec587..341add1 100644
>>>>> --- a/arch/mips/mm/tlbex.c
>>>>> +++ b/arch/mips/mm/tlbex.c
>>>>> @@ -1299,6 +1299,8 @@ static void build_r4000_tlb_refill_handler(void)
>>>>>         }
>>>>>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>>>>>         uasm_l_tlb_huge_update(&l, p);
>>>>> +       if (!use_bbit_insns())
>>>>> +               UASM_i_LW(&p, K0, 0, K1);
>>>>>         build_huge_update_entries(&p, htlb_info.huge_pte, K1);
>>>>>         build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
>>>>>                                    htlb_info.restore_scratch);
>>>>
>>>> This patch fixes the issue, thanks. That said it doesn't look fully
>>>> correct. The test should be done the same way as for
>>>> build_fast_tlb_refill_handler. For example the fast handler is not
>>>> called on a 32-bit machine with bbit instructions, so it would need
>>>> to reload K0.
>>>
>>> In the non fast case build_is_huge_pte() will still use bbit1 if
>>> available after restoring K0, and I don't think the bbit1 would clobber
>>> K0 when the branch is taken, so I think the test for !use_bbit_insns()
>>> is correct.
>>>
>> Oh you are right! Therefore this second patch is:
>>
>> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
>
> Likewise:
>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>
> Cheers
> James
>
>> Tested-by: Aurelien Jarno <aurelien@aurel32.net>
>>
>
>
