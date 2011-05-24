Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 21:01:12 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:48341 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab1EXTBG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2011 21:01:06 +0200
Received: by fxm14 with SMTP id 14so6390059fxm.36
        for <multiple recipients>; Tue, 24 May 2011 12:00:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.76.129 with SMTP id c1mr4064608fak.107.1306263656179; Tue,
 24 May 2011 12:00:56 -0700 (PDT)
Received: by 10.223.86.71 with HTTP; Tue, 24 May 2011 12:00:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1105241823540.3078@ionos>
References: <20110513125452.GD3924@elte.hu>
        <1305292132.2466.26.camel@twins>
        <20110513131800.GA7883@elte.hu>
        <1305294935.2466.64.camel@twins>
        <20110513145737.GC32688@elte.hu>
        <1305563026.5456.19.camel@gandalf.stny.rr.com>
        <20110516165249.GB10929@elte.hu>
        <1305565422.5456.21.camel@gandalf.stny.rr.com>
        <20110517124212.GB21441@elte.hu>
        <1305637528.5456.723.camel@gandalf.stny.rr.com>
        <20110517131902.GF21441@elte.hu>
        <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
        <1305807728.11267.25.camel@gandalf.stny.rr.com>
        <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
        <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
        <1306254027.18455.47.camel@twins>
        <alpine.LFD.2.02.1105241823540.3078@ionos>
Date:   Tue, 24 May 2011 14:00:56 -0500
Message-ID: <BANLkTimTjudsCi-xg0TUtzy_M236m3qm8Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call filtering
From:   Will Drewry <wad@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wad@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips

On Tue, May 24, 2011 at 11:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 24 May 2011, Peter Zijlstra wrote:
>
>> On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
>> >  include/linux/ftrace_event.h  |    4 +-
>> >  include/linux/perf_event.h    |   10 +++++---
>> >  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
>> >  kernel/seccomp.c              |    8 ++++++
>> >  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
>> >  5 files changed, 82 insertions(+), 16 deletions(-)
>>
>> I strongly oppose to the perf core being mixed with any sekurity voodoo
>> (or any other active role for that matter).
>
> Amen. We have enough crap to cleanup in perf/ftrace already, so we
> really do not need security magic added to it.

Thanks for the quick responses!

I agree, but I'm left a little bit lost now w.r.t. the comments around
reusing the ABI.  If perf doesn't make sense (which certainly seems
wrong from a security interface perspective), then the preexisting
ABIs I know of for this case are as follows:
- /sys/kernel/debug/tracing/*
- prctl(PR_SET_SECCOMP* (or /proc/...)

Both would require expansion.  The latter was reused by the original
patch series.  The former doesn't expose much in the way of per-task
event filtering -- ftrace_pids doesn't translate well to
ftrace_syscall_enter-based enforcement.  I'd expect we'd need
ftrace_event_call->task_events (like ->perf_events), and either
explore them in ftrace_syscall_enter or add a new tracepoint handler,
ftrace_task_syscall_enter, via something like TRACE_REG_TASK_REGISTER.
 It could then do whatever it wanted with the successful or
unsuccessful matching against predicates, stacking or not, which could
be used for a seccomp-like mechanism.  However, bubbling that change
up to the non-existent interfaces in debug/tracing could be a
challenge too (Registration would require an alternate flow like perf
to call TRACE_REG_*? Do they become
tracing/events/subsystem/event/task/<tid>/<filter_string_N>? ...?).

This is all just a matter of programming... but at this point, I'm not
seeing the clear shared path forward.  Even with per-task ftrace
access in debug/tracing, that would introduce a reasonably large
change to the system and add a new ABI, albeit in debug/tracing.  If
the above (or whatever the right approach is) comes into existence,
then any prctl(PR_SET_SECCOMP) ABI could have the backend
implementation to modify the same data.  I'm not putting it like this
to say that I'm designing to be obsolete, but to show that the defined
interface wouldn't conflict if ftrace does overlap more in the future.
 Given the importance of a clearly defined interface for security
functionality, I'd be surprised to see all the pieces come together in
the near future in such a way that a transition would be immediately
possible -- I'm not even sure what the ftrace roadmap really is!

Would it be more desirable to put a system call filtering interface on
a miscdev (like /dev/syscall_filter) instead of in /proc or prctl (and
not reuse seccomp at all)?  I'm not clear what the onus is to justify
a change in the different ABI areas, but I see system call filtering
as an important piece of system security and would like to determine
if there is a viable path forward, or if this will need to be
revisited in another 2 years.

thanks again!
will
