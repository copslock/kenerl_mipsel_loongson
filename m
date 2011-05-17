Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 20:35:44 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:54592 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491069Ab1EQSfj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 20:35:39 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QMP6s-0005Uh-99
        from <mingo@elte.hu>; Tue, 17 May 2011 20:35:11 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 0CDFC3E2533; Tue, 17 May 2011 20:34:58 +0200 (CEST)
Date:   Tue, 17 May 2011 20:34:59 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     James Morris <jmorris@namei.org>
Cc:     Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
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
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110517183459.GB16689@elte.hu>
References: <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
 <20110516150837.GA513@elte.hu>
 <alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
 <20110517131058.GE21441@elte.hu>
 <alpine.LRH.2.00.1105172317060.5404@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1105172317060.5404@tundra.namei.org>
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
X-archive-position: 30072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* James Morris <jmorris@namei.org> wrote:

> On Tue, 17 May 2011, Ingo Molnar wrote:
> 
> > I'm not sure i get your point.
> 
> Your example was not complete as described.  After an apparently simple 
> specification, you've since added several qualifiers and assumptions, [...]

I havent added any qualifiers really (i added examples/description), the opt-in 
method i mentioned in my first mail should be pretty robust:

 | Firstly, using the filter code i deny the various link creation syscalls so 
 | that sandboxed code cannot escape for example by creating a symlink to 
 | outside the permitted VFS namespace. (Note: we opt-in to syscalls, that way 
 | new syscalls added by new kernels are denied by defalt. The current symlink 
 | creation syscalls are not opted in to.)

> [...] and I still doubt that it's complete.

I could too claim that i doubt that the SELinux kernel implementation is 
secure!

So how about we both come up with specific examples about how it's not secure, 
instead of going down the fear-uncertainty-and-doubt road? ;-)

> A higher level goal would look like
> 
> "Allow a sandbox app access only to approved resources, to contain the 
> effects of flaws in the app", or similar.

I see what you mean.

I really think that "restricting sandboxed code to only open files within a 
given VFS namespace boundary" is the most useful highlevel description here - 
which is really a subset of a "allow a sandbox app access only to an easily 
approved set of files" highlevel concept.

There's no "to contain ..." bit here: *all* of the sandboxed app code is 
untrusted, so there's no 'remote attacker' and we do not limit our threat to 
flaws in the app. We want to contain apps to within a small subset of Linux 
functionality, and we want to do that within regular apps (without having to be 
superuser), full stop.

> Note that this includes a threat model (remote attacker taking control of the 
> app) and a general and fully stated strategy for dealing with it.

Attacker does not have to be remote - most sandboxing concepts protect against 
locally installed plugins/apps/applets. In sandboxing the whole app is 
considered untrusted - not just some flaw in it, abused remotely.

> From there, you can start to analyze how to implement the goal, at which 
> point you'd start thinking about configuration, assumptions, filesystem 
> access, namespaces, indirect access (e.g. via sockets, rpc, ipc, shared 
> memory, invocation).

Sandboxed code generally does not have access to anything fancy like that - if 
it is added then all possible side effects have to be examined.

Thanks,

	Ingo
