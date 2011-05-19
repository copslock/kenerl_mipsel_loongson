Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 06:07:30 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:63010 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1ESEHY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 06:07:24 +0200
Received: by fxm14 with SMTP id 14so2165300fxm.36
        for <multiple recipients>; Wed, 18 May 2011 21:07:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.59.146 with SMTP id l18mr3231792fah.58.1305778035619; Wed,
 18 May 2011 21:07:15 -0700 (PDT)
Received: by 10.223.101.204 with HTTP; Wed, 18 May 2011 21:07:15 -0700 (PDT)
In-Reply-To: <20110517131902.GF21441@elte.hu>
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
Date:   Wed, 18 May 2011 21:07:15 -0700
Message-ID: <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call filtering
From:   Will Drewry <wad@chromium.org>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>,
        Roland McGrath <roland@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>,
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
        Thomas Gleixner <tglx@linutronix.de>,
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
X-archive-position: 30075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips

On Tue, May 17, 2011 at 6:19 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Tue, 2011-05-17 at 14:42 +0200, Ingo Molnar wrote:
>> > * Steven Rostedt <rostedt@goodmis.org> wrote:
>> >
>> > > On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
>> > > > * Steven Rostedt <rostedt@goodmis.org> wrote:
>> > > >
>> > > > > I'm a bit nervous about the 'active' role of (trace_)events, because of the
>> > > > > way multiple callbacks can be registered. How would:
>> > > > >
>> > > > >       err = event_x();
>> > > > >       if (err == -EACCESS) {
>> > > > >
>> > > > > be handled? [...]
>> > > >
>> > > > The default behavior would be something obvious: to trigger all callbacks and
>> > > > use the first non-zero return value.
>> > >
>> > > But how do we know which callback that was from? There's no ordering of what
>> > > callbacks are called first.
>> >
>> > We do not have to know that - nor do the calling sites care in general. Do you
>> > have some specific usecase in mind where the identity of the callback that
>> > generates a match matters?
>>
>> Maybe I'm confused. I was thinking that these event_*() are what we
>> currently call trace_*(), but the event_*(), I assume, can return a
>> value if a call back returns one.
>
> Yeah - and the call site can treat it as:
>
>  - Ugh, if i get an error i need to abort whatever i was about to do
>
> or (more advanced future use):
>
>  - If i get a positive value i need to re-evaluate the parameters that were
>   passed in, they were changed

Do event_* that return non-void exist in the tree at all now?  I've
looked at the various tracepoint macros as well as some of the other
handlers (trace_function, perf_tp_event, etc) and I'm not seeing any
places where a return value is honored nor could be.  At best, the
perf_tp_event can be short-circuited it in the hlist_for_each, but
it'd still need a way to bubble up a failure and result in not calling
the trace/event that the hook precedes.

Am I missing something really obvious?  I don't feel I've gotten a
good handle on exactly how all the tracing code gets triggered, so
perhaps I'm still a level (or three) too shallow. (I can see the asm
hooks for trace functions and I can see where that translates to
registered calls - like trace_function - but I don't see how the
hooked calls can be trivially aborted).

As is, I'm not sure how the perf and ftrace infrastructure could be
reused cleanly without a fair number of hacks to the interface and a
good bit of reworking.  I can already see a number of challenges
around reusing the sys_perf_event_open interface and the fact that
reimplementing something even as simple as seccomp mode=1 seems to
require a fair amount of tweaking to avoid from being leaky.  (E.g.,
enabling all TRACE_EVENT()s for syscalls will miss unhooked syscalls
so either acceptance matching needs to be propagated up the stack
along with some seccomp-like task modality or seccomp-on-perf would
have to depend on sys_enter events with syscall number predicate
matching and fail when a filter discard applies to all active events.)

At present, I'm leaning back towards the v2 series (plus the requested
minor changes) for the benefit of code clarity and its fail-secure
behavior.  Even just considering the reduced case of seccomp mode 1
being implemented on the shared infrastructure, I feel like I missing
something that makes it viable.  Any clues?

If not, I don't think a seccomp mode 2 interface via prctl would be
intractable if the long term movement is to a ftrace/perf backend - it
just means that the in-kernel code would change to wrap whatever the
final design ended up being.

Thanks and sorry if I'm being dense!

>> Thus, we now have the ability to dynamically attach function calls to
>> arbitrary points in the kernel that can have an affect on the code that
>> called it. Right now, we only have the ability to attach function calls to
>> these locations that have passive affects (tracing/profiling).
>
> Well, they can only have the effect that the calling site accepts and handles.
> So the 'effect' is not arbitrary and not defined by the callbacks, it is
> controlled and handled by the calling code.
>
> We do not want invisible side-effects, opaque hooks, etc.
>
> Instead of that we want (this is the getname() example i cited in the thread)
> explicit effects, like:
>
>  if (event_vfs_getname(result))
>        return ERR_PTR(-EPERM);
>
>> But you say, "nor do the calling sites care in general". Then what do
>> these calling sites do with the return code? Are we limiting these
>> actions to security only? Or can we have some other feature. [...]
>
> Yeah, not just security. One other example that came up recently is whether to
> panic the box on certain (bad) events such as NMI errors. This too could be
> made flexible via the event filter code: we already capture many events, so
> places that might conceivably do some policy could do so based on a filter
> condition.

This sounds great - I just wish I could figure out how it'd work :)

>> [...] I can envision that we can make the Linux kernel quite dynamic here
>> with "self modifying code". That is, anywhere we have "hooks", perhaps we
>> could replace them with dynamic switches (jump labels). Maybe events would
>> not be the best use, but they could be a generic one.
>
> events and explicit function calls and explicit side-effects are pretty much
> the only thing that are acceptable. We do not want opaque hooks and arbitrary
> side-effects.
>
>> Knowing what callback returned the result would be beneficial. Right now, you
>> are saying if the call back return anything, just abort the call, not knowing
>> what callback was called.
>
> Yeah, and that's a feature: that way a number of conditions can be attached.
> Multiple security frameworks may have effect on a task or multiple tools might
> set policy action on a given event.
>
> Thanks,
>
>        Ingo
>
