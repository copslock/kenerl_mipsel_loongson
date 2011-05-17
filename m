Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 15:19:35 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:46166 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491068Ab1EQNTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 15:19:30 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QMKAy-0000CQ-GB
        from <mingo@elte.hu>; Tue, 17 May 2011 15:19:06 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id AAA4D3E2533; Tue, 17 May 2011 15:18:57 +0200 (CEST)
Date:   Tue, 17 May 2011 15:19:02 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110517131902.GF21441@elte.hu>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305637528.5456.723.camel@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
X-archive-position: 30065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2011-05-17 at 14:42 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
> > > > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > 
> > > > > I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> > > > > way multiple callbacks can be registered. How would:
> > > > > 
> > > > > 	err = event_x();
> > > > > 	if (err == -EACCESS) {
> > > > > 
> > > > > be handled? [...]
> > > > 
> > > > The default behavior would be something obvious: to trigger all callbacks and 
> > > > use the first non-zero return value.
> > > 
> > > But how do we know which callback that was from? There's no ordering of what 
> > > callbacks are called first.
> > 
> > We do not have to know that - nor do the calling sites care in general. Do you 
> > have some specific usecase in mind where the identity of the callback that 
> > generates a match matters?
> 
> Maybe I'm confused. I was thinking that these event_*() are what we
> currently call trace_*(), but the event_*(), I assume, can return a
> value if a call back returns one.

Yeah - and the call site can treat it as:

 - Ugh, if i get an error i need to abort whatever i was about to do

or (more advanced future use):

 - If i get a positive value i need to re-evaluate the parameters that were 
   passed in, they were changed

> Thus, we now have the ability to dynamically attach function calls to 
> arbitrary points in the kernel that can have an affect on the code that 
> called it. Right now, we only have the ability to attach function calls to 
> these locations that have passive affects (tracing/profiling).

Well, they can only have the effect that the calling site accepts and handles. 
So the 'effect' is not arbitrary and not defined by the callbacks, it is 
controlled and handled by the calling code.

We do not want invisible side-effects, opaque hooks, etc.

Instead of that we want (this is the getname() example i cited in the thread) 
explicit effects, like:

 if (event_vfs_getname(result))
	return ERR_PTR(-EPERM);

> But you say, "nor do the calling sites care in general". Then what do
> these calling sites do with the return code? Are we limiting these
> actions to security only? Or can we have some other feature. [...]

Yeah, not just security. One other example that came up recently is whether to 
panic the box on certain (bad) events such as NMI errors. This too could be 
made flexible via the event filter code: we already capture many events, so 
places that might conceivably do some policy could do so based on a filter 
condition.

> [...] I can envision that we can make the Linux kernel quite dynamic here 
> with "self modifying code". That is, anywhere we have "hooks", perhaps we 
> could replace them with dynamic switches (jump labels). Maybe events would 
> not be the best use, but they could be a generic one.

events and explicit function calls and explicit side-effects are pretty much 
the only thing that are acceptable. We do not want opaque hooks and arbitrary 
side-effects.

> Knowing what callback returned the result would be beneficial. Right now, you 
> are saying if the call back return anything, just abort the call, not knowing 
> what callback was called.

Yeah, and that's a feature: that way a number of conditions can be attached. 
Multiple security frameworks may have effect on a task or multiple tools might 
set policy action on a given event.

Thanks,

	Ingo
