Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 22:08:51 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:52493 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491179Ab1EXUIq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2011 22:08:46 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QOxtq-0006MQ-3P
        from <mingo@elte.hu>; Tue, 24 May 2011 22:08:20 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 6004A3E252E; Tue, 24 May 2011 22:08:11 +0200 (CEST)
Date:   Tue, 24 May 2011 22:08:15 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Will Drewry <wad@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20110524200815.GD27634@elte.hu>
References: <1305563026.5456.19.camel@gandalf.stny.rr.com>
 <20110516165249.GB10929@elte.hu>
 <1305565422.5456.21.camel@gandalf.stny.rr.com>
 <20110517124212.GB21441@elte.hu>
 <1305637528.5456.723.camel@gandalf.stny.rr.com>
 <20110517131902.GF21441@elte.hu>
 <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
 <1305807728.11267.25.camel@gandalf.stny.rr.com>
 <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
 <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
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
X-archive-position: 30140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Will Drewry <wad@chromium.org> wrote:

> The change avoids defining a new trace call type or a huge number of internal 
> changes and hides seccomp.mode=2 from ABI-exposure in prctl, but the attack 
> surface is non-trivial to verify, and I'm not sure if this ABI change makes 
> sense. It amounts to:
> 
>  include/linux/ftrace_event.h  |    4 +-
>  include/linux/perf_event.h    |   10 +++++---
>  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
>  kernel/seccomp.c              |    8 ++++++
>  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
>  5 files changed, 82 insertions(+), 16 deletions(-)
> 
> And can be found here: http://static.dataspill.org/perf_secure/v1/

Wow, i'm very impressed how few changes you needed to do to support this!

So, firstly, i don't think we should change perf_tp_event() at all - the 
'observer' codepaths should be unaffected.

But there could be a perf_tp_event_ret() or perf_tp_event_check() entry that 
code like seccomp which wants to use event results can use.

Also, i'm not sure about the seccomp details and assumptions that were moved 
into the perf core. How about passing in a helper function to 
perf_tp_event_check(), where seccomp would define its seccomp specific helper 
function?

That looks sufficiently flexible. That helper function could be an 'extra 
filter' kind of thing, right?

Also, regarding the ABI and the attr.err_on_discard and attr.require_secure 
bits, they look a bit too specific as well.

attr.err_on_discard: with the filter helper function passed in this is probably 
not needed anymore, right?

attr.require_secure: this is basically used to *force* the creation of 
security-controlling filters, right? It seems to me that this could be done via 
a seccomp ABI extension as well, without adding this to the perf ABI. That 
seccomp call could check whether the right events are created and move the task 
to mode 2 only if that prereq is met - or something like that.

> If there is any interest at all, I can post it properly to this giant
> CC list. [...]

I'd suggest to trim the Cc: list aggressively - anyone interested in the 
discussion can pick it up on lkml - and i strongly suspect that most of the Cc: 
participants would want to be off the Cc: :-)

Thanks,

	Ingo
