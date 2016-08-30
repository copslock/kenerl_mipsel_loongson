Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 20:53:13 +0200 (CEST)
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34521 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992009AbcH3SxG0KPVW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 20:53:06 +0200
Received: by mail-ua0-f171.google.com with SMTP id k90so49213475uak.1
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2016 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M+1JFwKSemojasYQGoO3cV1kv9bcJZT6ydIeqEeP2WA=;
        b=u5JjXzYT77efR2Ldfa7W1eHohh/sObGM+cEkqULpwEJQy+5xHbL29ug1DYBfzd8V17
         Tg1qeiAbW9X7UK2w/jYAzxESL5NRHD0E2/sXbBI9Csxm4owhT96h+2Frx2ap9HhxvBhq
         E7/5x5+bLezokMqQ7seAryS0845aoARDYUeY5XeGxRyPEztHmhbjcmKauqG+p7NCe4PA
         f8jqT4LupLuzZbS2KqHZOgkKfKDsup4SVvcnELmJjvvj3d9qYzgde4o0vJ4K67USGOUV
         hLd0PSJuqmxGNxSj7sPkkWkSn2lXFIymTComyje6hIPiKSM4hieDGUA5FV7FQik/veNO
         G2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M+1JFwKSemojasYQGoO3cV1kv9bcJZT6ydIeqEeP2WA=;
        b=ekUm6F90FClF6hmi4pORJDnCJ5uZlh7E7L7sUxPdl+XXzxwzKPJk7EZC/GmNTI4lai
         xLC5xmAT6Ua1Wlzw/98cde9LVapGcaUT3FbyaKMdHbqavFjnDOsA39lD37ODCeeEnFAA
         k/twq+pkLTutgijGyyZFAdbk1NFeRARRYhOY+NL6KMRG0jl6oFLHv7PVmFh2vlAdOhxj
         hEzVvhvoRHrtB0+T5BiWlFIa7WN2M8Udy54Eq30USYoQzDiVsKFBbuj5TTuNaErjWZLq
         0ew5EKR/09zaSAuhSawnGbQZm6iSRfhRHuPCfDkwwtgU1jruwOD2FBKmWA1dCQL2EuvB
         eLpA==
X-Gm-Message-State: AE9vXwOQb/LviD3mW+eHw+f7aAuTjcVxUD1UztZf5D/albT+jVT2FY1k1fDY6cFxoZRJDBn2oVlxI5ImaFLzz/up
X-Received: by 10.159.54.140 with SMTP id p12mr3142186uap.19.1472583180478;
 Tue, 30 Aug 2016 11:53:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.76.146 with HTTP; Tue, 30 Aug 2016 11:52:39 -0700 (PDT)
In-Reply-To: <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com> <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 30 Aug 2016 11:52:39 -0700
Message-ID: <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per syscall
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54868
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

On Tue, Aug 30, 2016 at 1:14 AM, Marcin Nowakowski
<marcin.nowakowski@imgtec.com> wrote:
>
>
> On 30.08.2016 01:55, Andy Lutomirski wrote:
>>
>> On Aug 29, 2016 11:30 AM, "Marcin Nowakowski"
>> <marcin.nowakowski@imgtec.com> wrote:
>>>
>>>
>>> Syscall metadata makes an assumption that only a single syscall number
>>> corresponds to a given method. This is true for most archs, but
>>> can break tracing otherwise.
>>>
>>> For MIPS platforms, depending on the choice of supported ABIs, up to 3
>>> system call numbers can correspond to the same call - depending on which
>>> ABI the userspace app uses.
>>
>>
>> MIPS isn't special here.  x86 does the same thing.  Why isn't this a
>> problem on x86?
>>
>
> Hi Andy,
>
> My understanding is that MIPS is quite different to what most other
> architectures do ...
> First of all x86 disables tracing of compat syscalls as that didn't work
> properly because of wrong mapping of syscall numbers to syscalls:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f431b634f
>
> Moreover, when trace_syscalls is initialised, the syscall metadata is
> updated to include the right syscall numbers. That uses arch_syscall_addr
> method, which has a default implementation in kernel/trace/trace_syscalls.c:
>
> unsigned long __init __weak arch_syscall_addr(int nr)
> {
>         return (unsigned long)sys_call_table[nr];
> }
>
> that works for x86 and only uses 'native' syscalls, ie. for x86_64 will not
> map any of the ia32_sys_call_table entries. So on one hand we have the code
> that disables tracing for x86_64 compat, on the other we only ensure that
> the native calls are mapped.
> It is quite different for MIPS where syscall numbers for different ABIs have
> distinct call numbers, so the following code maps the syscalls
> (for O32 -> 4xxx, N64 -> 5xxx, N32 -> 6xxx):

x86 has that, too.  There are three types of x86 syscalls: i386
(AUDIT_ARCH_I386, low nr), x86_64 (AUDIT_ARCH_X86_64, low nr, nr can
overlap i386 with differnt meanings), and x32 (AUDIT_ARCH_X86_64, high
nr).

>
> unsigned long __init arch_syscall_addr(int nr)
> {
>         if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux +
> __NR_N32_Linux_syscalls)
>                 return (unsigned long)sysn32_call_table[nr -
> __NR_N32_Linux];
>         if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux +
> __NR_64_Linux_syscalls)
>                 return (unsigned long)sys_call_table[nr - __NR_64_Linux];
>         if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux +
> __NR_O32_Linux_syscalls)
>                 return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
>         return (unsigned long) &sys_ni_syscall;
> }
>
> As a result when init_ftrace_syscalls() loops through all the possible
> syscall numbers,  it first finds an O32 implementation, then N64 and finally
> N32. As the current code doesn't expect multiple references to a given
> syscall number, it always overrides the metadata with the last found - as a
> result only N32 syscalls are mapped.

Okay, I think I see what's going on.  init_ftrace_syscalls() does:

        meta = find_syscall_meta(addr);

Unless I'm missing some reason why this is a sensible thing to do,
this seems overcomplicated and incorrect.  There is exactly one caller
of find_syscall_meta() and that caller knows the syscall number.  Why
doesn't it just look up the metadata by *number* instead of by syscall
implementation address?  There are plenty of architectures for which
multiple logically different syscalls can share an implementation
(e.g. pretty much everything that calls in_compat_syscall()).

Can't this be radically simplified by just calling
syscall_nr_to_meta() instead and deleting find_syscall_meta()?  Or is
there some reason that it makes sense for one syscall_metadata to have
multiple syscalls nrs?  (Also, keep in mind that, on x86, the nr is
insufficient to identify the syscall.  You really need to know both nr
and arch to identify the syscall, so sticking an array of syscall nrs
somewhere doesn't accurately express the x86 situation.)

--Andy
