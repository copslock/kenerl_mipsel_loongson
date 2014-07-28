Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2014 22:24:41 +0200 (CEST)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:38715 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821703AbaG1UXj5bl0b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2014 22:23:39 +0200
Received: by mail-lb0-f181.google.com with SMTP id 10so6239347lbg.12
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 13:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4GPXMxLxy6uSWoX5rtRSweDLVXD07XfUCC+lpi1SkT4=;
        b=ShPsTR/UNcP2IPmqJu2u3mi29krmxboHr4MDk7yEr4U+K0guAop8WHIkE+9rvu5e1v
         1x/F5x2ZPB/C1oLkT9fnEr7YhaBSp6C/Pnminm3wqZE31XnpmY67gZQoE9D0hqnCqRVr
         HVIas3jZAI9vrfPXqWXeRQQxbhNnI8agYKkLfmVTC0MgLMtA2ia2gXWG501diIx/syEJ
         +Ol7m6SsCW2pY2CLKpsMAkXPb78MCyv+5U9OEu9Vji67DtsnvoHn/zs1GunosOdpdqoZ
         oyxJaXdxix2sJiki7s4CklXa+dc+UTANy5BWMJ3USTfCtU21+/Mjf+4PrByJHa2tDBC6
         mNYg==
X-Gm-Message-State: ALoCoQnaxW6HWZj1OAZi5VvwYfmDLZOGdzUfukrV1n0cu0ei4IaSZ5Duf5pD3zPBNs0lwRC4T1dR
X-Received: by 10.112.87.41 with SMTP id u9mr5438366lbz.97.1406579013846; Mon,
 28 Jul 2014 13:23:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Mon, 28 Jul 2014 13:23:13 -0700 (PDT)
In-Reply-To: <20140728173723.GA20993@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 28 Jul 2014 13:23:13 -0700
Message-ID: <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41720
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

On Mon, Jul 28, 2014 at 10:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> Hi Andy,
>
> I am really sorry for delay.
>
> This is on top of the recent change from Kees, right? Could me remind me
> where can I found the tree this series based on? So that I could actually
> apply these changes...

https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath

The first four patches are already applied there.

>
> On 07/21, Andy Lutomirski wrote:
>>
>> +long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
>> +                             unsigned long phase1_result)
>>  {
>>       long ret = 0;
>> +     u32 work = ACCESS_ONCE(current_thread_info()->flags) &
>> +             _TIF_WORK_SYSCALL_ENTRY;
>> +
>> +     BUG_ON(regs != task_pt_regs(current));
>>
>>       user_exit();
>>
>> @@ -1458,17 +1562,20 @@ long syscall_trace_enter(struct pt_regs *regs)
>>        * do_debug() and we need to set it again to restore the user
>>        * state.  If we entered on the slow path, TF was already set.
>>        */
>> -     if (test_thread_flag(TIF_SINGLESTEP))
>> +     if (work & _TIF_SINGLESTEP)
>>               regs->flags |= X86_EFLAGS_TF;
>
> This looks suspicious, but perhaps I misread this change.
>
> If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
> But we should always call user_exit() unconditionally?

Damnit.  I read that every function called by user_exit, and none of
them give any indication of why they're needed for traced syscalls but
not for untraced syscalls.  On a second look, it seems that TIF_NOHZ
controls it.  I'll update the code to call user_exit iff TIF_NOHZ is
set.  If that's still wrong, then I don't see how the current code is
correct either.

>
> And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
> actually cleared on a 32bit kernel if we step over sysenter insn?

I don't follow.  If TIF_SINGLESTEP, then phase1 will return a nonzero
value, and phase2 will set TF.

I admit I don't really understand all the TF machinations.

--Andy
