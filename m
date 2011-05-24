Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 22:11:32 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:52564 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491179Ab1EXUL3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2011 22:11:29 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QOxwP-0006y1-7N
        from <mingo@elte.hu>; Tue, 24 May 2011 22:11:04 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 12FC53E252E; Tue, 24 May 2011 22:10:54 +0200 (CEST)
Date:   Tue, 24 May 2011 22:10:53 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Drewry <wad@chromium.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110524201053.GE27634@elte.hu>
References: <1305565422.5456.21.camel@gandalf.stny.rr.com>
 <20110517124212.GB21441@elte.hu>
 <1305637528.5456.723.camel@gandalf.stny.rr.com>
 <20110517131902.GF21441@elte.hu>
 <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
 <1305807728.11267.25.camel@gandalf.stny.rr.com>
 <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
 <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
 <1306254027.18455.47.camel@twins>
 <20110524195435.GC27634@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110524195435.GC27634@elte.hu>
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
X-archive-position: 30141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
> > >  include/linux/ftrace_event.h  |    4 +-
> > >  include/linux/perf_event.h    |   10 +++++---
> > >  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
> > >  kernel/seccomp.c              |    8 ++++++
> > >  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
> > >  5 files changed, 82 insertions(+), 16 deletions(-) 
> > 
> > I strongly oppose to the perf core being mixed with any sekurity voodoo
> > (or any other active role for that matter).
> 
> I'd object to invisible side-effects as well, and vehemently so. But note how 
> intelligently it's used here: it's explicit in the code, it's used explicitly 
> in kernel/seccomp.c and the event generation place in 
> kernel/trace/trace_syscalls.c.
> 
> So this is a really flexible solution IMO and does not extend events with 
> some invisible 'active' role. It extends the *call site* with an open-coded 
> active role - which active role btw. already pre-existed.

Also see my other mail - i think this seccomp code is too tied in to the perf 
core and ABI - but this is fixable IMO.

The fundamental notion that a generator subsystem of events can use filter 
results as well (such as kernel/trace/trace_syscalls.c.) for its own purposes 
is pretty robust though.

Thanks,

	Ingo
