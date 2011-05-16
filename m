Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 14:55:50 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:43441 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491024Ab1EPMzo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 14:55:44 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QLxKM-0005XY-S3
        from <mingo@elte.hu>; Mon, 16 May 2011 14:55:15 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id C1D953E250F; Mon, 16 May 2011 14:55:03 +0200 (CEST)
Date:   Mon, 16 May 2011 14:55:05 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Will Drewry <wad@chromium.org>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110516125505.GE7128@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
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
X-archive-position: 30041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Will Drewry <wad@chromium.org> wrote:

> I agree with you on many of these points!  However, I don't think that the 
> views around LSMs, perf/ftrace infrastructure, or the current seccomp 
> filtering implementation are necessarily in conflict.  Here is my 
> understanding of how the different worlds fit together and where I see this 
> patchset living, along with where I could see future work going.  Perhaps I'm 
> being a trifle naive, but here goes anyway:
> 
> 1. LSMs provide a global mechanism for hooking "security relevant"
> events at a point where all the incoming user-sourced data has been
> preprocessed and moved into userspace.  The hooks are called every
> time one of those boundaries are crossed.

> 2. Perf and the ftrace infrastructure provide global function tracing
> and system call hooks with direct access to the caller's registers
> (and memory).

No, perf events are not just global but per task as well. Nor are events 
limited to 'tracing' (generating a flow of events into a trace buffer) - they 
can just be themselves as well and count and generate callbacks.

The generic NMI watchdog uses that kind of event model for example, see 
kernel/watchdog.c and how it makes use of struct perf_event abstractions to do 
per CPU events (with no buffrs), or how kernel/hw_breakpoint.c uses it for per 
task events and integrates it with the ptrace hw-breakpoints code.

Ideally Peter's one particular suggestion is right IMO and we'd want to be able 
for a perf_event to just be a list of callbacks, attached to a task and barely 
more than a discoverable, named notifier chain in its slimmest form.

In practice it's fatter than that right now, but we should definitely factor 
out that aspect of it more clearly, both code-wise and API-wise. 
kernel/watchdog.c and kernel/hw_breakpoint.c shows that such factoring out is 
possible and desirable.

> 3. seccomp (as it exists today) provides a global system call entry
> hook point with a binary per-process decision about whether to provide
> "secure computing" behavior.
> 
> When I boil that down to abstractions, I see:
> A. Globally scoped: LSMs, ftrace/perf
> B. Locally/process scoped: seccomp

Ok, i see where you got the idea that you needed to cut your surface of 
abstraction at the filter engine / syscall enumeration level - i think you were 
thinking of it in the ftrace model of tracepoints, not in the perf model of 
events.

No, events are generic and as such per task as well, not just global.

I've replied to your other mail with more specific suggestions of how we could 
provide your feature using abstractions that share code more widely. Talking 
specifics will i hope help move the discussion forward! :-)

Thanks,

	Ingo
