Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 16:42:22 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:60343 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491034Ab1EPOmR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 16:42:17 +0200
Received: by fxm14 with SMTP id 14so4152226fxm.36
        for <multiple recipients>; Mon, 16 May 2011 07:42:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.14.137 with SMTP id g9mr3481757faa.1.1305556927330; Mon,
 16 May 2011 07:42:07 -0700 (PDT)
Received: by 10.223.101.204 with HTTP; Mon, 16 May 2011 07:42:07 -0700 (PDT)
In-Reply-To: <20110516125505.GE7128@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
        <1305169376-2363-1-git-send-email-wad@chromium.org>
        <20110512074850.GA9937@elte.hu>
        <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
        <20110512130104.GA2912@elte.hu>
        <BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
        <20110516125505.GE7128@elte.hu>
Date:   Mon, 16 May 2011 09:42:07 -0500
Message-ID: <BANLkTimg5KsPA-JYS__hdnXZWg57fmvZnQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call filtering
From:   Will Drewry <wad@chromium.org>
To:     Ingo Molnar <mingo@elte.hu>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wad@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips

On Mon, May 16, 2011 at 7:55 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Will Drewry <wad@chromium.org> wrote:
>
>> I agree with you on many of these points!  However, I don't think that the
>> views around LSMs, perf/ftrace infrastructure, or the current seccomp
>> filtering implementation are necessarily in conflict.  Here is my
>> understanding of how the different worlds fit together and where I see this
>> patchset living, along with where I could see future work going.  Perhaps I'm
>> being a trifle naive, but here goes anyway:
>>
>> 1. LSMs provide a global mechanism for hooking "security relevant"
>> events at a point where all the incoming user-sourced data has been
>> preprocessed and moved into userspace.  The hooks are called every
>> time one of those boundaries are crossed.
>
>> 2. Perf and the ftrace infrastructure provide global function tracing
>> and system call hooks with direct access to the caller's registers
>> (and memory).
>
> No, perf events are not just global but per task as well. Nor are events
> limited to 'tracing' (generating a flow of events into a trace buffer) - they
> can just be themselves as well and count and generate callbacks.

I was looking at the perf_sysenter_enable() call, but clearly there is
more going on :)

> The generic NMI watchdog uses that kind of event model for example, see
> kernel/watchdog.c and how it makes use of struct perf_event abstractions to do
> per CPU events (with no buffrs), or how kernel/hw_breakpoint.c uses it for per
> task events and integrates it with the ptrace hw-breakpoints code.
>
> Ideally Peter's one particular suggestion is right IMO and we'd want to be able
> for a perf_event to just be a list of callbacks, attached to a task and barely
> more than a discoverable, named notifier chain in its slimmest form.
>
> In practice it's fatter than that right now, but we should definitely factor
> out that aspect of it more clearly, both code-wise and API-wise.
> kernel/watchdog.c and kernel/hw_breakpoint.c shows that such factoring out is
> possible and desirable.
>
>> 3. seccomp (as it exists today) provides a global system call entry
>> hook point with a binary per-process decision about whether to provide
>> "secure computing" behavior.
>>
>> When I boil that down to abstractions, I see:
>> A. Globally scoped: LSMs, ftrace/perf
>> B. Locally/process scoped: seccomp
>
> Ok, i see where you got the idea that you needed to cut your surface of
> abstraction at the filter engine / syscall enumeration level - i think you were
> thinking of it in the ftrace model of tracepoints, not in the perf model of
> events.
>
> No, events are generic and as such per task as well, not just global.
>
> I've replied to your other mail with more specific suggestions of how we could
> provide your feature using abstractions that share code more widely. Talking
> specifics will i hope help move the discussion forward! :-)

Agreed.  I'll digest both the watchdog code as well as your other
comments and follow up when I have a fuller picture in my head.

(I have a few initial comments I'll post in response to your other mail.)

Thanks!
will
