Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 21:20:47 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:49517 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012783AbbBFUUp6xW1s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 21:20:45 +0100
Received: by mail-lb0-f170.google.com with SMTP id z11so6786718lbi.1
        for <linux-mips@linux-mips.org>; Fri, 06 Feb 2015 12:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=W3Yo1V6FG9rpzSuPJKYJw3kKAYehaNuGMFqMQUoJejI=;
        b=M1pGiKq1NXoeQo0Sin/UPDWZC/6efk04gRs1SHf8oWiKMEwGJxqHVmt0Kwrli2IyLH
         q6+lbGebYMtQujDV1v5OhvfIOR0wU8QMIbYGrSYDEEEO5nIocTDH/P/yEcPpAo8KOsMu
         +8fjny688SPCk2F+FdBj/dFEmUHbWSCD10ASs0TQitP1/4dsrinWNXCsx73n0Qc2oUmf
         4/RBxZoSi4Mt+9VrblZcu091aNfSvwUMdZiLIAq9gBdbYbPEJ3S96TbEZpfeiMaEAhZN
         ngsNBx7OWG+jjphKNPKc/5TsuJhFftG5H3XSSEdSTWG5Wlt1dkKCXfh0ekhaLXX/A3nu
         g7Og==
X-Gm-Message-State: ALoCoQlZue/IcM8EIz/nHETyNrOJ8pcromv/iCXA9Sxp9pkwhJTQpbXGqQtRhZINhk9hewm5hNUs
X-Received: by 10.152.37.5 with SMTP id u5mr4689111laj.109.1423254040852; Fri,
 06 Feb 2015 12:20:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.152.205.98 with HTTP; Fri, 6 Feb 2015 12:20:20 -0800 (PST)
In-Reply-To: <CAGXu5jKuLUCwptoL=5Hcz7ME-SKdVcuYoRPw+JJ2nktz5273-w@mail.gmail.com>
References: <cover.1409954077.git.luto@amacapital.net> <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
 <20150205211916.GA31367@altlinux.org> <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
 <20150205214027.GB31367@altlinux.org> <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
 <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
 <20150205233945.GA31540@altlinux.org> <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
 <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
 <20150206023249.GB31540@altlinux.org> <CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com>
 <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
 <CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com>
 <CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com>
 <CALCETrUmMA9sK4SJCSiF24iAiPLMBf=-JBw6TcLV+aLt_eN=Sw@mail.gmail.com> <CAGXu5jKuLUCwptoL=5Hcz7ME-SKdVcuYoRPw+JJ2nktz5273-w@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 6 Feb 2015 12:20:20 -0800
Message-ID: <CALCETrW5Vfj2-yEDyr26xof_gY_U-OW9tzUQStWUYnKM1vwskA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
To:     Kees Cook <keescook@chromium.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45759
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

On Fri, Feb 6, 2015 at 12:16 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Feb 6, 2015 at 12:12 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Fri, Feb 6, 2015 at 12:07 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Fri, Feb 6, 2015 at 11:32 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>> On Fri, Feb 6, 2015 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
>>>>> And especially since a ptracer
>>>>> can change syscalls during syscall-enter-stop to any syscall it wants,
>>>>> bypassing seccomp. This condition is already documented.
>>>>
>>>> If a ptracer (using PTRACE_SYSCALL) were to get the entry callback
>>>> before seccomp, then this oddity would go away, which might be a good
>>>> thing.  A ptracer could change the syscall, but seccomp would based on
>>>> what the ptracer changed the syscall to.
>>>
>>> I want kill events to trigger immediately. I don't want to leave the
>>> ptrace surface available on a SECCOMP_RET_KILL. So maybe it can be
>>> seccomp phase 1, then ptrace, then seccomp phase 2? And pass more
>>> information between phases to determine how things should behave
>>> beyond just "skip"?
>>
>> I thought so too, originally, but I'm far less convinced now, for two reasons:
>>
>> 1. I think that a lot of filters these days use RET_ERRNO heavily, so
>> this won't benefit them.
>>
>> 2. I'm not convinced it really reduces the attack surface for anyone.
>> Unless your filter is literally "return SECCOMP_RET_KILL", then the
>> seccomp-filtered task can always cause the ptracer to get a pair of
>> syscall notifications.  Also, the task can send itself signals (using
>> page faults, breakpoints, etc) and cause ptrace events via other
>> paths.
>
> What are you thinking for a solution?
>

I'm writing a patch now.  It's an ABI break, but this thread seems to
show that the ABI was somewhat useless before the split-phase changes,
and it's differently broken now, so I would be surprised if the change
broke anything that was currently working.  I'll send it later today,
hopefully.

> As for capping SECCOMP_RET_ERRNO to MAX_ERRNO, how about this (sorry
> if gmail butchers the paste):
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 4ef9687ac115..c88148d20bd5 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -629,7 +629,9 @@ static u32 __seccomp_phase1_filter(int this_syscall, struct
>
>         switch (action) {
>         case SECCOMP_RET_ERRNO:
> -               /* Set the low-order 16-bits as a errno. */
> +               /* Set the low-order bits as a errno. */
> +               if (data > MAX_ERRNO)
> +                       data = MAX_ERRNO;
>                 syscall_set_return_value(current, task_pt_regs(current),
>                                          -data, 0);
>                 goto skip;
>

I'm fine with this, but I'm not entirely convinced it solves a
problem.  SECCOMP_RET_ERRNO | 5000 didn't work before, and it doesn't
work now.  Admittedly, the new failure mode is possibly better.

--Andy
