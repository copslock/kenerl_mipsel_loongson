Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 04:23:00 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:57886 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819433AbaGNCWx5q0Iu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 04:22:53 +0200
Received: by mail-ig0-f172.google.com with SMTP id h15so1258841igd.11
        for <multiple recipients>; Sun, 13 Jul 2014 19:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5Nw+Vd/2OaTFtKThVrvabS+6oWjxlY2RfozPALauTyk=;
        b=nRdhVf+ZQEvlPuYRYpcUMiy97CX6ttO/Tp3U11upDfz0Zr5pqeTpmWbjUSVYYxEkws
         LGTl8r5uxw3kaZitL4lcxwWlYqlEs9ox8iG6rPVYEeqhpWIfl/D1BR97ej4gB0k2TR0c
         4sxcXnKHxMCWghVQwUiwIeKfINwKN5kY0vWnSDhWOr3u14khyLDPQJA1mjwzCEYUib0l
         QmkuVJREdaYrUZNny3BaZDFru1FAJKrwsRlkOHWbgghvWIPZGXc9SLvcNnBpewDKlK3U
         BcffoHfpbOtC2A4A3L6UjfYs9jhMWzyp82t1eNcjxVJlRYdAgQsdHjECuoJgoR5+wcDO
         piNg==
MIME-Version: 1.0
X-Received: by 10.42.65.7 with SMTP id j7mr18965234ici.11.1405304567491; Sun,
 13 Jul 2014 19:22:47 -0700 (PDT)
Received: by 10.64.65.40 with HTTP; Sun, 13 Jul 2014 19:22:47 -0700 (PDT)
In-Reply-To: <20140712093003.GF8187@pburton-laptop>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
        <1405048453-12633-1-git-send-email-chenj@lemote.com>
        <20140711155631.GE8187@pburton-laptop>
        <CAGXxSxV2KWiArguRRKWcbC82sZJweyjiDBBpJdWPne_Ag_Z_+w@mail.gmail.com>
        <CAAhV-H5z1Xu5Mg0X68Yf_mpi8ZBg96TEYLkk4_2_Grb8=ET05Q@mail.gmail.com>
        <20140712093003.GF8187@pburton-laptop>
Date:   Mon, 14 Jul 2014 10:22:47 +0800
X-Google-Sender-Auth: gfTR10fFZF__iFC6AkIwRT5-PkE
Message-ID: <CAAhV-H4PbCLam5jdUjCdn9X9+pL6HR5=8wT_6TPWMt31qv4gMA@mail.gmail.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Chen Jie <chenj@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41170
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

Hi, Ralf,

What do you think about? If you also prefer to totally remove the
BUG_ON(), I will send a new patch.

On Sat, Jul 12, 2014 at 5:30 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Sat, Jul 12, 2014 at 05:10:35PM +0800, Huacai Chen wrote:
>> Hi, Paul,
>>
>> You means my patch (http://patchwork.linux-mips.org/patch/7297/) is
>> the correct way?
>
> I believe you patch will fix the problem, but I think it would be better
> to remove the check for !preemptible() & the BUG_ON entirely.
>
>> Another question: Your patch
>> (http://patchwork.linux-mips.org/patch/7307/) remove
>> preempt_disable()/preempt_enable() in init_fpu(). It will cause
>> problems if there is another function call init_fpu() because it is
>> previously preempt-safe. Maybe introduce a new function (e.g.
>> __init_fpu()) is a better way?
>
> It may cause a problem if there were other callers, but there is only
> one caller of init_fpu (enable_restore_fp_context) and it needs to
> disable preemption for longer than the init_fpu function anyway. I see
> no value in keeping init_fpu as a wrapper that disables preemption
> when there would be nothing calling it.
>
> Thanks,
>     Paul
>
>> Huacai
>>
>> On Sat, Jul 12, 2014 at 7:28 AM, Chen Jie <chenj@lemote.com> wrote:
>> > 2014-07-11 23:56 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
>> >> On Fri, Jul 11, 2014 at 11:14:13AM +0800, chenj wrote:
>> >>> do_ade may be invoked with preempt enabled. do_cpu will be invoked with
>> >>> preempt enabled. When it's preempted(in do_ade/do_cpu), TIF_USEDFPU will be
>> >>> cleared, when it returns to do_ade/do_cpu, the fpu is actually disabled.
>> >>>
>> >>> e.g.
>> >>> In do_ade()
>> >>>   emulate_load_store_insn():
>> >>>     BUG_ON(!is_fpu_owner()); <-- This assertion may be breaked.
>> >>>
>> >>> In do_cpu()
>> >>>   enable_restore_fp_context():
>> >>>     was_fpu_owner = is_fpu_owner();
>> >>
>> >> Preemption should indeed be disabled around the assignment & use of the
>> >> was_fpu_owner variable, but note that you can only hit the problem if
>> >> using MSA. One of the MSA fixes I just submitted also fixes this along
>> >> with another instance of the problem:
>> >>
>> >>   http://patchwork.linux-mips.org/patch/7307/
>> >>
>> >> I prefer my patch to this since it disables preemption for less time,
>> >> in addition to fixing the !used_math() case.
>> >>
>> >> In emulate_load_store_insn I believe the correct fix is simply to remove
>> >> that BUG_ON. The code is about to give up FPU ownership anyway, so it's
>> >> not like there is any requirement being violated if it was already lost.
>> > Yes, you're right.
>> >
>> > """ /* arch/mips/kernel/unaligned.c */
>> > lose_fpu(1);    /* Save FPU state for the emulator. */
>> > res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1, &fault_addr);
>> > own_fpu(1);     /* Restore FPU state. */
>> > """
>> >
>> > Going deep into the code, I find lost_fpu(1) will save fpu context if
>> > owns fpu (otherwise, if preempted, the fpu context will be saved in
>> > process switch), then fpu_emulator_cop1Handler manipulates the saved
>> > fpu context, own_fpu(1) restores it.
>> >
>> > So, remove "BUG_ON(!is_fpu_owner())" is OK.
>> >
>
