Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2011 10:44:23 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:51789 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491072Ab1EZIoT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 May 2011 10:44:19 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QPWAX-0000uo-8V
        from <mingo@elte.hu>; Thu, 26 May 2011 10:43:55 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id C66493E2534; Thu, 26 May 2011 10:43:45 +0200 (CEST)
Date:   Thu, 26 May 2011 10:43:41 +0200
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
Message-ID: <20110526084341.GD26775@elte.hu>
References: <20110517131902.GF21441@elte.hu>
 <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
 <1305807728.11267.25.camel@gandalf.stny.rr.com>
 <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
 <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
 <1306254027.18455.47.camel@twins>
 <20110524195435.GC27634@elte.hu>
 <alpine.LFD.2.02.1105242239230.3078@ionos>
 <20110525150153.GE29179@elte.hu>
 <alpine.LFD.2.02.1105251836030.3078@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1105251836030.3078@ionos>
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
X-archive-position: 30153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > > We do _NOT_ make any decision based on the trace point so 
> > > what's the "pre-existing" active role in the syscall entry 
> > > code?
> > 
> > The seccomp code we are discussing in this thread.
> 
> That's proposed code and has absolutely nothing to do with the 
> existing trace point semantics.

So because it's proposed code it does not exist?

If the feature is accepted (and given Linus's opinion it's not clear 
at all it's accepted in any form) then it's obviously a very 
legitimate technical concern whether we do:

	ret = seccomp_check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

	... random code ...

	trace_syscall_event(p1, p2, p3, p4, p5);

Where seccomp_check_syscall_event() duplicates much of the machinery 
that is behind trace_syscall_event().

Or we do the more intelligent:

	ret = check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

Where we have the happy side effects of:

  - less code at the call site

  - (a lot of!) shared infrastructure between the proposed seccomp 
    code and event filters.

  - we'd also be able to trace at security check boundaries - which
    has obvious bug analysis advantages.

In fact i do not see *any* advantages in keeping this needlessly 
bloaty and needlessly inconsistently sampled form of instrumentation:

	ret = seccomp_check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

	... random code ...

	trace_syscall_event(p1, p2, p3, p4, p5);

Do you?

Thanks,

	Ingo
