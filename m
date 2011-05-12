Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 15:01:51 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:41708 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491174Ab1ELNBo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2011 15:01:44 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QKVVw-0008PC-P6
        from <mingo@elte.hu>; Thu, 12 May 2011 15:01:17 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id CB3B83E2526; Thu, 12 May 2011 15:01:04 +0200 (CEST)
Date:   Thu, 12 May 2011 15:01:04 +0200
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
Message-ID: <20110512130104.GA2912@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
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
X-archive-position: 29959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* James Morris <jmorris@namei.org> wrote:

> On Thu, 12 May 2011, Ingo Molnar wrote:
> 
> > 2) Why should this concept not be made available wider, to allow the 
> >    restriction of not just system calls but other security relevant components 
> >    of the kernel as well?
> 
> Because the aim of this is to reduce the attack surface of the syscall 
> interface.

What i suggest achieves the same, my argument is that we could aim it to be 
even more flexible and even more useful.

> LSM is the correct level of abstraction for general security mediation, 
> because it allows you to take into account all relevant security information 
> in a race-free context.

I don't care about LSM though, i find it poorly designed.

The approach implemented here, the ability for *unprivileged code* to define 
(the seeds of ...) flexible security policies, in a proper Linuxish way, which 
is inherited along the task parent/child hieararchy and which allows nesting 
etc. is a *lot* more flexible.

What Will implemented here is pretty huge in my opinion: it turns security from 
a root-only kind of weird hack into an essential component of its APIs, 
available to *any* app not just the select security policy/mechanism chosen by 
the distributor ...

If implemented properly this could replace LSM in the long run.

As a prctl() hack bound to seccomp (which, by all means, is a natural extension 
to the current seccomp ABI, so perfectly fine if we only want that scope), that 
is much less likely to happen.

And if we merge the seccomp interface prematurely then interest towards a more 
flexible approach will disappear, so either we do it properly now or it will 
take some time for someone to come around and do it ...

Also note that i do not consider the perf events ABI itself cast into stone - 
and we could very well add a new system call for this, independent of perf 
events. I just think that the seccomp scope itself is exciting but looks 
limited to what the real potential of this could be.

> >    This too, if you approach the problem via the events code, will be a natural 
> >    end result, while if you approach it from the seccomp prctl angle it will be
> >    a limited hack only.
> 
> I'd say it's a well-defined and readily understandable feature.

Note, it was me who suggested this very event-filter-engine design a year ago, 
when the first submission still used a crude bitmap of allowed seccomp 
syscalls:

  http://lwn.net/Articles/332974/

Funnily enough, back then you wrote this:

  " I'm concerned that we're seeing yet another security scheme being designed on 
    the fly, without a well-formed threat model, and without taking into account 
    lessons learned from the seemingly endless parade of similar, failed schemes. "

so when and how did your opinion of this scheme turn from it being an "endless 
parade of failed schemes" to it being a "well-defined and readily 
understandable feature"? :-)

The idea itself has not changed since last year, what happened is that the 
filter engine got a couple of new features and Will has separated it out and 
has implemented a working prototype for sandboxing.

What i do here is to suggest *further* steps down the same road, now that we 
see that this scheme can indeed be used to implement sandboxing ... I think 
it's a valid line of inquiry.

Thanks,

	Ingo
