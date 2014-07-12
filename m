Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 11:10:44 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:51284 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859957AbaGLJKmXbeXS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jul 2014 11:10:42 +0200
Received: by mail-ig0-f171.google.com with SMTP id l13so252299iga.4
        for <multiple recipients>; Sat, 12 Jul 2014 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=L04Ao0cd8hHQrkR+2jvZAPCG5+7bHF2nBa/QvOKg/6Q=;
        b=M7zA/3mYT90uIJXGtLUQ+33dKkFQMevbFlwgpCjfuMFr2xF3pvYWF39w5X1Cq+VJqh
         BIZNYAO+baZZgK4MbWL8v7gsYiUAGs/BSLEn+9w3hpodStbcR9s3wCnarHmmrgBv8Cs9
         qIEPjRk5t0M5cjVXOprUCI8h+q6NcaUrQ9teGcmVlfkw9apsOHuw9Z3MBQYaO5DCGYHo
         slcrjWY6Zg3YDAUVwSgTB3oSxLSQRSO7JDodL1f+Iw0Y86aUm5xfxrKK3KusUG3O/372
         gc8m/+cj8WxX6w7Tf3H7M9iGYol3/wH8m8fK1khul5Q4ZnqCvvfuggPa0B8oP3KpLI/l
         Bu6Q==
MIME-Version: 1.0
X-Received: by 10.42.15.70 with SMTP id k6mr10173147ica.53.1405156235990; Sat,
 12 Jul 2014 02:10:35 -0700 (PDT)
Received: by 10.64.65.40 with HTTP; Sat, 12 Jul 2014 02:10:35 -0700 (PDT)
In-Reply-To: <CAGXxSxV2KWiArguRRKWcbC82sZJweyjiDBBpJdWPne_Ag_Z_+w@mail.gmail.com>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
        <1405048453-12633-1-git-send-email-chenj@lemote.com>
        <20140711155631.GE8187@pburton-laptop>
        <CAGXxSxV2KWiArguRRKWcbC82sZJweyjiDBBpJdWPne_Ag_Z_+w@mail.gmail.com>
Date:   Sat, 12 Jul 2014 17:10:35 +0800
X-Google-Sender-Auth: o-Yt7MBvJ-pvk_0xD15d76iVp80
Message-ID: <CAAhV-H5z1Xu5Mg0X68Yf_mpi8ZBg96TEYLkk4_2_Grb8=ET05Q@mail.gmail.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
From:   Huacai Chen <chenhc@lemote.com>
To:     Chen Jie <chenj@lemote.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41156
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

Hi, Paul,

You means my patch (http://patchwork.linux-mips.org/patch/7297/) is
the correct way?

Another question: Your patch
(http://patchwork.linux-mips.org/patch/7307/) remove
preempt_disable()/preempt_enable() in init_fpu(). It will cause
problems if there is another function call init_fpu() because it is
previously preempt-safe. Maybe introduce a new function (e.g.
__init_fpu()) is a better way?

Huacai

On Sat, Jul 12, 2014 at 7:28 AM, Chen Jie <chenj@lemote.com> wrote:
> 2014-07-11 23:56 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
>> On Fri, Jul 11, 2014 at 11:14:13AM +0800, chenj wrote:
>>> do_ade may be invoked with preempt enabled. do_cpu will be invoked with
>>> preempt enabled. When it's preempted(in do_ade/do_cpu), TIF_USEDFPU will be
>>> cleared, when it returns to do_ade/do_cpu, the fpu is actually disabled.
>>>
>>> e.g.
>>> In do_ade()
>>>   emulate_load_store_insn():
>>>     BUG_ON(!is_fpu_owner()); <-- This assertion may be breaked.
>>>
>>> In do_cpu()
>>>   enable_restore_fp_context():
>>>     was_fpu_owner = is_fpu_owner();
>>
>> Preemption should indeed be disabled around the assignment & use of the
>> was_fpu_owner variable, but note that you can only hit the problem if
>> using MSA. One of the MSA fixes I just submitted also fixes this along
>> with another instance of the problem:
>>
>>   http://patchwork.linux-mips.org/patch/7307/
>>
>> I prefer my patch to this since it disables preemption for less time,
>> in addition to fixing the !used_math() case.
>>
>> In emulate_load_store_insn I believe the correct fix is simply to remove
>> that BUG_ON. The code is about to give up FPU ownership anyway, so it's
>> not like there is any requirement being violated if it was already lost.
> Yes, you're right.
>
> """ /* arch/mips/kernel/unaligned.c */
> lose_fpu(1);    /* Save FPU state for the emulator. */
> res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1, &fault_addr);
> own_fpu(1);     /* Restore FPU state. */
> """
>
> Going deep into the code, I find lost_fpu(1) will save fpu context if
> owns fpu (otherwise, if preempted, the fpu context will be saved in
> process switch), then fpu_emulator_cop1Handler manipulates the saved
> fpu context, own_fpu(1) restores it.
>
> So, remove "BUG_ON(!is_fpu_owner())" is OK.
>
