Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 23:57:28 +0200 (CEST)
Received: from mail-ve0-f171.google.com ([209.85.128.171]:53340 "EHLO
        mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843091AbaFKV5ZRmvcX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 23:57:25 +0200
Received: by mail-ve0-f171.google.com with SMTP id jz11so856032veb.30
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 14:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=796Zab2ysF8DyjKjfwyP49kjGC/a5BjUnfOLrHaOXCc=;
        b=OtQ8yiOswF5UELFaFaaokzt0VylC9JyAKSz5KUsYZgHOPnvBpn9fE0h0Aw1DOcNa56
         Byop8Rxnc/tFf4UDxICw4N0l9YL7ducOcrjOX8cyo5KW4Gxeyj9Pl3StVH20pgn1S9qs
         nFoyGfdH2Qdfzzga8uEomyXkHbOwaIvW3BoCQMtsXEYHnvs5LW9ZelVt4H7fEh8o6uqJ
         8kYhZRKlIIg9oiUbfOR+OsPx6pJm1YfdbE7Nxq6PRaOSgAlz6i64SP/61vi6CnnNSP2X
         NahM5njbBdXx65p7A6agUigzbCnC4+LLrQ1M1DG6J7EfQth5VagCzXdMIh7E+Mjd5cUk
         hv5w==
X-Gm-Message-State: ALoCoQnqTh9eU0BvM3X2H801tMbyJvt7/zw8s4ZpRc2a0VkDZYVzSLi0Lj3T7qMzuRJMzlXDqWbC
X-Received: by 10.58.211.133 with SMTP id nc5mr7698124vec.28.1402523839013;
 Wed, 11 Jun 2014 14:57:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.58.91.40 with HTTP; Wed, 11 Jun 2014 14:56:58 -0700 (PDT)
In-Reply-To: <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
References: <cover.1402517933.git.luto@amacapital.net> <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
 <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 11 Jun 2014 14:56:58 -0700
Message-ID: <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Wed, Jun 11, 2014 at 2:29 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Jun 11, 2014 at 1:23 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On my VM, getpid takes about 70ns.  Before this patch, adding a
>> single-instruction always-accept seccomp filter added about 134ns of
>> overhead to getpid.  With this patch, the overhead is down to about
>> 13ns.
>
> interesting.
> Is this the gain from patch 4 into patch 5 or from patch 0 to patch 5?
> 13ns is still with seccomp enabled, but without filters?

13ns is with the simplest nonempty filter.  I hope that empty filters
don't work.

>
>> I'm not really thrilled by this patch.  It has two main issues:
>>
>> 1. Calling into code in kernel/seccomp.c from assembly feels ugly.
>>
>> 2. The x86 64-bit syscall entry now has four separate code paths:
>> fast, seccomp only, audit only, and slow.  This kind of sucks.
>> Would it be worth trying to rewrite the whole thing in C with a
>> two-phase slow path approach like I'm using here for seccomp?
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> ---
>>  arch/x86/kernel/entry_64.S | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/seccomp.h    |  4 ++--
>>  2 files changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
>> index f9e713a..feb32b2 100644
>> --- a/arch/x86/kernel/entry_64.S
>> +++ b/arch/x86/kernel/entry_64.S
>> @@ -683,6 +683,45 @@ sysret_signal:
>>         FIXUP_TOP_OF_STACK %r11, -ARGOFFSET
>>         jmp int_check_syscall_exit_work
>>
>> +#ifdef CONFIG_SECCOMP
>> +       /*
>> +        * Fast path for seccomp without any other slow path triggers.
>> +        */
>> +seccomp_fastpath:
>> +       /* Build seccomp_data */
>> +       pushq %r9                               /* args[5] */
>> +       pushq %r8                               /* args[4] */
>> +       pushq %r10                              /* args[3] */
>> +       pushq %rdx                              /* args[2] */
>> +       pushq %rsi                              /* args[1] */
>> +       pushq %rdi                              /* args[0] */
>> +       pushq RIP-ARGOFFSET+6*8(%rsp)           /* rip */

>> +       pushq %rax                              /* nr and junk */
>> +       movl $AUDIT_ARCH_X86_64, 4(%rsp)        /* arch */

It wouldn't shock me if this pair of instructions were
microarchitecturally bad.  Maybe I can save a few more cycles by using
bitwise arithmetic or a pair of movls and explicit rsp manipulation
here.  I haven't tried.

>> +       movq %rsp, %rdi
>> +       call seccomp_phase1
>
> the assembler code is pretty much repeating what C does in
> populate_seccomp_data(). Assuming the whole gain came from
> patch 5 why asm version is so much faster than C?
>
> it skips SAVE/RESTORE_REST... what else?
> If the most of the gain is from all patches combined (mainly from
> 2 phase approach) then why bother with asm?

The whole gain should be patch 5, but there are three things going on here.

The biggest win is skipping int_ret_from_sys_call.  IRET sucks.
There's some extra win from skipping SAVE/RESTORE_REST, but I haven't
benchmarked that.  I would guess it's on the order of 5ns.  In theory
a one-pass implementation could skip int_ret_from_sys_call, but that
will be awkward to implement correctly.

The other benefit is generating seccomp_data in assembly.  It saves
about 7ns.  This is likely due to avoiding all the indirection in
syscall_xyz and to avoiding prodding at flags to figure out the arch
token.

Fiddling with branch prediction made no difference that I could measure.

>
> Somehow it feels that the gain is due to better branch prediction
> in asm version. If you change few 'unlikely' in C to 'likely', it may
> get to the same performance...
>
> btw patches #1-3 look good to me. especially #1 is nice.

Thanks :)

--Andy
