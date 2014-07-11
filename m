Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 01:29:17 +0200 (CEST)
Received: from smtpbg302.qq.com ([184.105.206.27]:55739 "EHLO smtpbg302.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859946AbaGKX3MVrLY7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 01:29:12 +0200
X-QQ-mid: bizesmtp9t1405121338t220t123
Received: from mail-lb0-f177.google.com (unknown [209.85.217.177])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 12 Jul 2014 07:28:55 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF22B00A0000000
X-QQ-FEAT: cmGmvuI1AHDWnb+tlXKARhZkDVJ61PkdmOkDO4RCcspsPmQuQHQl7WWdj+BNM
        XPOVuy3Vz6oi0aOJAqqwhKNdG4mGvbLc5mRHiem3FQOWbv+qZdO/KaLXjFJalKlQ5Stj5C3
        k1LWygtJDubbgEXXdR9sJbNdXxkA8tVGJi83nlWmmskxkONdzQ==
X-QQ-GoodBg: 0
Received: by mail-lb0-f177.google.com with SMTP id u10so1338864lbd.22
        for <multiple recipients>; Fri, 11 Jul 2014 16:28:53 -0700 (PDT)
X-Received: by 10.152.43.17 with SMTP id s17mr1497558lal.81.1405121333557;
 Fri, 11 Jul 2014 16:28:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.200.39 with HTTP; Fri, 11 Jul 2014 16:28:32 -0700 (PDT)
In-Reply-To: <20140711155631.GE8187@pburton-laptop>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
 <1405048453-12633-1-git-send-email-chenj@lemote.com> <20140711155631.GE8187@pburton-laptop>
From:   Chen Jie <chenj@lemote.com>
Date:   Sat, 12 Jul 2014 07:28:32 +0800
Message-ID: <CAGXxSxV2KWiArguRRKWcbC82sZJweyjiDBBpJdWPne_Ag_Z_+w@mail.gmail.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-FName: 9618AB956AF14FB9B4D38D37037D904D
X-QQ-LocalIP: 112.95.241.173
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

2014-07-11 23:56 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
> On Fri, Jul 11, 2014 at 11:14:13AM +0800, chenj wrote:
>> do_ade may be invoked with preempt enabled. do_cpu will be invoked with
>> preempt enabled. When it's preempted(in do_ade/do_cpu), TIF_USEDFPU will be
>> cleared, when it returns to do_ade/do_cpu, the fpu is actually disabled.
>>
>> e.g.
>> In do_ade()
>>   emulate_load_store_insn():
>>     BUG_ON(!is_fpu_owner()); <-- This assertion may be breaked.
>>
>> In do_cpu()
>>   enable_restore_fp_context():
>>     was_fpu_owner = is_fpu_owner();
>
> Preemption should indeed be disabled around the assignment & use of the
> was_fpu_owner variable, but note that you can only hit the problem if
> using MSA. One of the MSA fixes I just submitted also fixes this along
> with another instance of the problem:
>
>   http://patchwork.linux-mips.org/patch/7307/
>
> I prefer my patch to this since it disables preemption for less time,
> in addition to fixing the !used_math() case.
>
> In emulate_load_store_insn I believe the correct fix is simply to remove
> that BUG_ON. The code is about to give up FPU ownership anyway, so it's
> not like there is any requirement being violated if it was already lost.
Yes, you're right.

""" /* arch/mips/kernel/unaligned.c */
lose_fpu(1);    /* Save FPU state for the emulator. */
res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1, &fault_addr);
own_fpu(1);     /* Restore FPU state. */
"""

Going deep into the code, I find lost_fpu(1) will save fpu context if
owns fpu (otherwise, if preempted, the fpu context will be saved in
process switch), then fpu_emulator_cop1Handler manipulates the saved
fpu context, own_fpu(1) restores it.

So, remove "BUG_ON(!is_fpu_owner())" is OK.
