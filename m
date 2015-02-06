Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 01:09:35 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:47236 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012700AbbBFAJcoOLom (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 01:09:32 +0100
Received: by mail-lb0-f170.google.com with SMTP id w7so13174909lbi.1
        for <linux-mips@linux-mips.org>; Thu, 05 Feb 2015 16:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=z64PWdWIzoGWXJjf7lIO+jm3PijMIOfq2Qt/CkGOkkA=;
        b=MD3eb6I/JuJ93i0dumKywivi5WE09XA3UCpVIMHDBosHZ2QNxq/kQcT/7hqV6VQZEq
         tySPh5NDmQ+2bbPXCefxlDB2TUOgyrdE87WAdK95AgGKn0fiUDI+AdCfOWsCwb44rRQJ
         mWl6LN2fnunUHouHK5jiMgFd+t6Lc1H9S5RRxHzv7qiZjNePTlN6pLSGhNUYelxny8Kq
         SzyQqAK0e9lmGLD7soeWtGFA1t7yM4okEK7DT2xqa0nsx8a5eDqLrDgTNMyyichD1hWd
         ax93Kdy2y/80804EapTCNS/GP/djmtz8EJEYaD+S1dcNsmaIB5D1JpV+ShLOWZfpmdjR
         +clg==
X-Gm-Message-State: ALoCoQmyb8jOkyhQO6fH3t90sEQIUmAL1Sbx11m1m3i2UR/u7XxRSxPNw8UiE7m5/tGKWnItCYTi
X-Received: by 10.152.178.197 with SMTP id da5mr504732lac.87.1423181366599;
 Thu, 05 Feb 2015 16:09:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.152.205.98 with HTTP; Thu, 5 Feb 2015 16:09:06 -0800 (PST)
In-Reply-To: <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
References: <cover.1409954077.git.luto@amacapital.net> <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
 <20150205211916.GA31367@altlinux.org> <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
 <20150205214027.GB31367@altlinux.org> <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
 <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
 <20150205233945.GA31540@altlinux.org> <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 5 Feb 2015 16:09:06 -0800
Message-ID: <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
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
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45744
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

On Thu, Feb 5, 2015 at 3:49 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 5, 2015 at 3:39 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> On Thu, Feb 05, 2015 at 03:12:39PM -0800, Kees Cook wrote:
>>> On Thu, Feb 5, 2015 at 1:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> > On Thu, Feb 5, 2015 at 1:40 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>>> >> On Thu, Feb 05, 2015 at 01:27:16PM -0800, Kees Cook wrote:
>>> >>> On Thu, Feb 5, 2015 at 1:19 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>>> >>> > Hi,
>>> >>> >
>>> >>> > On Fri, Sep 05, 2014 at 03:13:54PM -0700, Andy Lutomirski wrote:
>>> >>> >> This splits syscall_trace_enter into syscall_trace_enter_phase1 and
>>> >>> >> syscall_trace_enter_phase2.  Only phase 2 has full pt_regs, and only
>>> >>> >> phase 2 is permitted to modify any of pt_regs except for orig_ax.
>>> >>> >
>>> >>> > This breaks ptrace, see below.
>>> >>> >
>> [...]
>>> >>> >> +             ret = seccomp_phase1(&sd);
>>> >>> >> +             if (ret == SECCOMP_PHASE1_SKIP) {
>>> >>> >> +                     regs->orig_ax = -1;
>>> >>> >
>>> >>> > How the tracer is expected to get the correct syscall number after that?
>>> >>>
>>> >>> There shouldn't be a tracer if a skip is encountered. (A seccomp skip
>>> >>> would skip ptrace.) This behavior hasn't changed, but maybe I don't
>>> >>> see what you mean? (I haven't encountered any problems with syscall
>>> >>> tracing as a result of these changes.)
>>> >>
>>> >> SECCOMP_RET_ERRNO leads to SECCOMP_PHASE1_SKIP, and if there is a tracer,
>>> >> it will get -1 as a syscall number.
>>> >>
>>> >> I've found this while testing a strace parser for
>>> >> SECCOMP_MODE_FILTER/SECCOMP_SET_MODE_FILTER, so the problem is quite real.
>>> >
>>> > Hasn't it always been this way?
>>>
>>> As far as I know, yes, it's always been this way. The point is to the
>>> skip the syscall, which is what the -1 signals. Userspace then reads
>>> back the errno.
>>
>> There is a clear difference: before these changes, SECCOMP_RET_ERRNO used
>> to keep the syscall number unchanged and suppress syscall-exit-stop event,
>> which was awful because userspace cannot distinguish syscall-enter-stop
>> from syscall-exit-stop and therefore relies on the kernel that
>> syscall-enter-stop is followed by syscall-exit-stop (or tracee's death, etc.).
>>
>> After these changes, SECCOMP_RET_ERRNO no longer causes syscall-exit-stop
>> events to be suppressed, but now the syscall number is lost.
>
> Ah-ha! Okay, thanks, I understand now. I think this means seccomp
> phase1 should not treat RET_ERRNO as a "skip" event. Andy, what do you
> think here?
>

I still don't quite see how this change caused this.  I can play with
it a bit more.  But RET_ERRNO *has* to be some kind of skip event,
because it needs to skip the syscall.

We could change this by treating RET_ERRNO as an instruction to enter
phase 2 and then asking for a skip in phase 2 without changing
orig_ax, but IMO this is pretty ugly.

I think this all kind of sucks.  We're trying to run ptrace after
seccomp, so ptrace is seeing the syscalls as transformed by seccomp.
That means that if we use RET_TRAP, then ptrace will see the
possibly-modified syscall, if we use RET_ERRNO, then ptrace is (IMO
correctly given the current design) showing syscall -1, and if we use
RET_KILL, then ptrace just sees the process mysteriously die.

I think it would be more useful and easier to understand if ptrace saw
syscalls as the traced process saw them, i.e. before seccomp
modification.  How would this meaningfully increase the attack
surface?  As far as ptrace is concerned, a syscall is just seven
numbers, and as long as a process can issue *any* syscall that seccomp
allows, then it can invoke the ptrace hooks.  I don't think the
entry/exit hooks care *at all* about the syscall nr or args.

Audit is a different story.  I think we should absolutely continue to
audit syscalls that actually happen, not syscalls that were requested.

Given this bug, I doubt we'd break anything if we changed it, since it
appears that it's already rather broken.  Also, changing it would make
me happy, because I want to add a SECCOMP_RET_MONITOR that freezes the
process, sends an event to a seccompfd, and then executes syscalls as
requested by the holder of the seccompfd.  Those syscalls would, in
turn, be filtered again through inner layers of seccomp.  One sticking
point would be that the current ptrace behavior is very hard to
reconcile with this type of feature.

--Andy
