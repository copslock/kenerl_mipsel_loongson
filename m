Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 13:00:37 +0200 (CEST)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34149 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041619AbcFNLAfpZ2XY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 13:00:35 +0200
Received: by mail-oi0-f42.google.com with SMTP id d132so146672308oig.1
        for <linux-mips@linux-mips.org>; Tue, 14 Jun 2016 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6qcN587QYhoGihAHBBF12d1pClKpIA/mxBLFbizJuHM=;
        b=wjaRIFP067y1kstoMbhV1EmEzsqSZ0a7BpJKBiGIyE0RAaKQwiI+/aQVODIzbVfc2Q
         bisjF7DafceQ4l+a9KFEaKUz3pJgBvF6iC+fYSHEwacvHUzjGLiXj+hEDNCTXUXhK5as
         0jeEtFHQn/n5mm3fDTMFQw6H5E6o/Eu2YR8YVm1evNVxriU78aIh5MjC+scxF6ln6Mgl
         0Tvf8dCxaxeiEPdDldZ5rJUXm8l0eBwIMWMUwJ1Sap1eSdTA4F8616wCvseAKmCTdGQ3
         rY8hkuIt3WtqdX1wFD673m0yzt1Ocq8K0lHg9Xpz/0MIFkUVpDWULoOmUj/4XxMStIaA
         p6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6qcN587QYhoGihAHBBF12d1pClKpIA/mxBLFbizJuHM=;
        b=TPyjTb9FVyfSRMHThGKJnV7/kI5wsGXEysqsgvnVuNKUq8tseoTZ80eUoLJFFE7h1z
         jCwDKDRw9WUhHVYlJLtus5tYWXEWW20wJD6JFkpdZIaWuyhbGcgZlXJliFI7FeOzKvNP
         LgBFegM5MnljzYzSdFoyvuKq7c4GzGju9reDrsjicL45nmjj7ggqT2dnbuW2LPqGukt8
         6jiH2dfic4bjPFpgwLtidhoCOeRc+G+X9jJ9FkYsUOlKKRKKFwgiwYUmawlNpehIu+dv
         A5Y2ryvaII86vcY7hW2ALx3tZ3Pz6MXMxeeusAapKVnPqVX37FtARyn2Zzc31rX+eGug
         Fy9w==
X-Gm-Message-State: ALyK8tKoE1iNK59/7R2JdrkZIJ5PO9YI0UOohsxFdGwA6VIjDsz5SXW0VMpnWK6aQqNbuA0FcdhkmcJg98XotZhX
X-Received: by 10.157.35.22 with SMTP id j22mr9453983otb.98.1465871282488;
 Mon, 13 Jun 2016 19:28:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.199.148 with HTTP; Mon, 13 Jun 2016 19:27:42 -0700 (PDT)
In-Reply-To: <CALCETrVk-UauwaRtZZR0fKQO6kyAx-r=ZCurKRdhQk9nA-TqeQ@mail.gmail.com>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
 <1465506124-21866-7-git-send-email-keescook@chromium.org> <CALCETrVk-UauwaRtZZR0fKQO6kyAx-r=ZCurKRdhQk9nA-TqeQ@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 13 Jun 2016 19:27:42 -0700
Message-ID: <CALCETrUJr25COBeVs_KS1SVk2f7CFzYgDr7MttZanWsJnTk0-g@mail.gmail.com>
Subject: Re: [PATCH 06/14] x86/ptrace: run seccomp after ptrace
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54045
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

On Thu, Jun 9, 2016 at 3:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Jun 9, 2016 at 2:01 PM, Kees Cook <keescook@chromium.org> wrote:
>> This moves seccomp after ptrace on x86 to that seccomp can catch changes
>> made by ptrace. Emulation should skip the rest of processing too.
>>
>> We can get rid of test_thread_flag because there's no longer any
>> opportunity for seccomp to mess with ptrace state before invoking
>> ptrace.
>>
>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: x86@kernel.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>> ---
>>  arch/x86/entry/common.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> index df56ca394877..81c0e12d831c 100644
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -73,6 +73,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>
>>         struct thread_info *ti = pt_regs_to_thread_info(regs);
>>         unsigned long ret = 0;
>> +       bool emulated = false;
>>         u32 work;
>>
>>         if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>> @@ -80,11 +81,19 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>
>>         work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
>>
>> +       if (unlikely(work & _TIF_SYSCALL_EMU))
>> +               emulated = true;
>> +
>> +       if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
>> +           tracehook_report_syscall_entry(regs))
>> +               return -1L;
>> +
>> +       if (emulated)
>> +               return -1L;
>> +
>
> I think that this code will result in ptrace-induced skips calling the
> audit exit hook but not the audit entry hook.  I don't know whether
> this is a problem.  It's also worth making sure that ptracing a
> seccomp-skipped syscall calls the exit hook with the right regs.
>
> I suspect it's fine, but I want to think about it a little bit more.

I poked at it a bit and this seems to work correctly.
selftests/x86/ptrace_syscall.c exercises PTRACE_SYSCALL_EMU pretty
well, and it still passes.

--Andy
