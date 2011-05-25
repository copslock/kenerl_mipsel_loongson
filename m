Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2011 17:02:44 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:44181 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491192Ab1EYPCk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 May 2011 17:02:40 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QPFay-0006k4-Do
        from <mingo@elte.hu>; Wed, 25 May 2011 17:02:01 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 323E93E2517; Wed, 25 May 2011 17:01:53 +0200 (CEST)
Date:   Wed, 25 May 2011 17:01:53 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Drewry <wad@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110525150153.GE29179@elte.hu>
References: <20110517124212.GB21441@elte.hu>
 <1305637528.5456.723.camel@gandalf.stny.rr.com>
 <20110517131902.GF21441@elte.hu>
 <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
 <1305807728.11267.25.camel@gandalf.stny.rr.com>
 <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
 <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
 <1306254027.18455.47.camel@twins>
 <20110524195435.GC27634@elte.hu>
 <alpine.LFD.2.02.1105242239230.3078@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1105242239230.3078@ionos>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
        -2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
        [score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 24 May 2011, Ingo Molnar wrote:
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
> > > >  include/linux/ftrace_event.h  |    4 +-
> > > >  include/linux/perf_event.h    |   10 +++++---
> > > >  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
> > > >  kernel/seccomp.c              |    8 ++++++
> > > >  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
> > > >  5 files changed, 82 insertions(+), 16 deletions(-) 
> > > 
> > > I strongly oppose to the perf core being mixed with any sekurity voodoo
> > > (or any other active role for that matter).
> > 
> > I'd object to invisible side-effects as well, and vehemently so. But note how 
> > intelligently it's used here: it's explicit in the code, it's used explicitly 
> > in kernel/seccomp.c and the event generation place in 
> > kernel/trace/trace_syscalls.c.
> > 
> > So this is a really flexible solution IMO and does not extend events with some 
> > invisible 'active' role. It extends the *call site* with an open-coded active 
> > role - which active role btw. already pre-existed.
> 
> We do _NOT_ make any decision based on the trace point so what's the
> "pre-existing" active role in the syscall entry code?

The seccomp code we are discussing in this thread.

> I'm all for code reuse and reuse of interfaces, but this is completely
> wrong. Instrumentation and security decisions are two fundamentally
> different things and we want them kept separate. Instrumentation is
> not meant to make decisions. Just because we can does not mean that it
> is a good idea.

Instrumentation does not 'make decisions': the calling site, which is 
already emitting both the event and wants to do decisions based on 
the data that also generates the event wants to do decisions.

Those decisions *will be made* and you cannot prevent that, the only 
open question is can it reuse code intelligently, which code it is 
btw. already calling for observation reasons?

( Note that pure observers wont be affected and note that pure 
  observation call sites are not affected either. )

> So what the current approach does is:
> 
>  - abuse the existing ftrace syscall hook by adding a return value to
>    the tracepoint.
> 
>    So we need to propagate that for every tracepoint just because we
>    have a single user.

This is a technical criticism i share with you and i think it can be 
fixed - i outlined it to Will yesterday.

And no, if done cleanly it's not 'abuse' to reuse code. Could we wait 
for the first clean iteration of this patch instead of rushing 
judgement prematurely?

>  - abuse the perf per task mechanism
> 
>    Just because we have per task context in perf does not mean that we
>    pull everything and the world which requires per task context into
>    perf. The security folks have per task context already so security
>    related stuff wants to go there.

We do not pull 'everything and the world' in, but code that wants to 
process events in places that already emit events surely sounds 
related to me :-)

>  - abuse the perf/ftrace interfaces
> 
>    One of the arguments was that perf and ftrace have permission which
>    are not available from the existing security interfaces. That's not
>    at all a good reason to abuse these interfaces. Let the security
>    folks sort out the problem on their end and do not impose any
>    expectations on perf/ftrace which we have to carry around forever.
> 
> Yes, it can be made working with a relatively small patch, but it has
> a very nasty side effect: 
> 
>   You add another user space visible ABI to the existing perf/ftrace
>   mess which needs to be supported forever.

What mess? I'm not aware of a mess - other than the ftrace API which 
is not used by this patch.

> Brilliant, we have already two ABIs (perf/ftrace) to support and at
> the same time we urgently need to solve the problem of better
> integration of those two. So adding a third completely unrelated
> component with a guaranteed ABI is just making this even more complex.

So your solution is to add yet another ABI for seccomp and to keep 
seccomp a limited hack forever, just because you are not interested 
in security?

I think we want fewer ABIs and more flexible/reusable facilities.

> We can factor out the filtering code and let the security dudes 
> reuse it for their own purposes. That makes them to have their own 
> interfaces and does not impose any restrictions upon the 
> tracing/perf ones. And really security stuff wants to be integrated 
> into the existing security frameworks and not duct taped into 
> perf/trace just because it's a conveniant hack around limitiations 
> of the existing security stuff.

You are missing what i tried to point out in earlier discussions: 
from a security design POV this isnt just about the system call 
boundary. If this seccomp variant is based on events then it could 
grow proper security checks in other places as well, in places where 
we have some sort of object observation event anyway.

So this is opens up possibilities to reuse and unify code on a very 
broad basis.

> You really should stop to see everything as a nail just because the 
> only tool you have handy is the perf hammer. perf is about 
> instrumentation and we don't want to violate the oldest principle 
> of unix to have simple tools which do one thing and do it good.

That is one of the most misunderstood principles of Unix.

The original Unix tool landscape was highly *integrated* and 
*unified*, into a very tight codebase that was maintained together. 
Yes, there were different, atomic, simple commands but it was all 
done together and it was a coherent whole and pleasant to use!

People misunderstood this as a license to fragment the heck out 
functionality and build 'simple and stupid' tools that fit nowhere 
really and use different, incompatible principles not synced with 
each other. That is wrong and harmful.

So yes, over-integration is obviously wrong - but so is needless 
fragmentation.

Anyway, i still reserve judgement on this seccomp bit but the patches 
so far looked very promising with a very surprisingly small diffstat. 

If anything then that should tell you something that events and 
seccomp are not just casually related ...

> Even swiss army knifes have the restriction that you can use only 
> one tool at a time unless you want to stick the corkscrew through 
> your palm when you try to cut bread.

I'm not sure what you are arguing here - do you pine for the DOS days 
where you could only use one command at a time?

Thanks,

	Ingo
