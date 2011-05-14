Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2011 09:30:59 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:54886 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490975Ab1ENHax (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 May 2011 09:30:53 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QL9Iu-0007eQ-CZ
        from <mingo@elte.hu>; Sat, 14 May 2011 09:30:25 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 9B3563E252E; Sat, 14 May 2011 09:30:16 +0200 (CEST)
Date:   Sat, 14 May 2011 09:30:15 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Eric Paris <eparis@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        kees.cook@canonical.com, agl@chromium.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110514073015.GB9307@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <1305299455.2076.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305299455.2076.26.camel@localhost.localdomain>
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
X-archive-position: 30025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Eric Paris <eparis@redhat.com> wrote:

> [dropping microblaze and roland]
> 
> lOn Fri, 2011-05-13 at 14:10 +0200, Ingo Molnar wrote:
> > * James Morris <jmorris@namei.org> wrote:
> 
> > It is a simple and sensible security feature, agreed? It allows most code to 
> > run well and link to countless libraries - but no access to other files is 
> > allowed.
> 
> It's simple enough and sounds reasonable, but you can read all the discussion 
> about AppArmour why many people don't really think it's the best. [...]

I have to say most of the participants of the AppArmour flamefests were dead 
wrong, and it wasnt the AppArmour folks who were wrong ...

The straight ASCII VFS namespace *makes sense*, and yes, the raw physical 
objects space that SELinux uses makes sense as well.

And no, i do not subscribe to the dogma that it is not possible to secure the 
ASCII VFS namespace: it evidently is possible, if you know and handle the 
ambiguitites. It is also obviously true that the ASCII VFS namespaces we use 
every day are a *lot* more intuitive than the labeled physical objects space 
...

What all the security flamewars missed is the simple fact that being intuitive 
matters a *lot* not just to not annoy users, but also to broaden the effective 
number of security-conscious developers ...

> > Unfortunately this audit callback cannot be used for my purposes, because 
> > the event is single-purpose for auditd and because it allows no feedback 
> > (no deny/accept discretion for the security policy).
> > 
> > But if had this simple event there:
> > 
> > 	err = event_vfs_getname(result);
> 
> Wow it sounds so easy.  Now lets keep extending your train of thought
> until we can actually provide the security provided by SELinux.  What do
> we end up with?  We end up with an event hook right next to every LSM
> hook.  You know, the LSM hooks were placed where they are for a reason.
> Because those were the locations inside the kernel where you actually
> have information about the task doing an operation and the objects
> (files, sockets, directories, other tasks, etc) they are doing an
> operation on.
> 
> Honestly all you are talking about it remaking the LSM with 2 sets of
> hooks instead if 1.  Why? [...]

Not at all. I am taking about using *one* set of events, to keep the intrusion 
at the lowest possible level.

LSM could make use of them as well.

Obviously for pragmatic reasons that might not be feasible initially.

> [...]  It seems much easier that if you want the language of the filter 
> engine you would just make a new LSM that uses the filter engine for it's 
> policy language rather than the language created by SELinux or SMACK or name 
> your LSM implementation.

Correct, that is what i suggested.

Note that performance is a primary concern, so if certain filters are very 
popular then in practice this would come with support for a couple of 'built 
in' (pre-optimized) filters that the kernel can accelerate directly, so that we 
do not incure the cost of executing the filter preds for really common-sense 
security policies that almost everyone is using.

I.e. in the end we'd *roughly* end up with the same performance and security as 
we are today (i mean, SELinux and the other LSMs did a nice job of collecting 
the things that apps should be careful about), but the crutial difference isnt 
just the advantages i menioned, but the fact that the *development model* of 
security modules would be a *lot* more extensible.

So security efforts could move to a whole different level: they could move into 
key apps and they could integrate with the general mind-set of developers.

At least Will as an application framework developer cares, so that hope is 
justified i think.

> >  - unprivileged:  application-definable, allowing the embedding of security 
> >                   policy in *apps* as well, not just the system
> > 
> >  - flexible:      can be added/removed runtime unprivileged, and cheaply so
> > 
> >  - transparent:   does not impact executing code that meets the policy
> > 
> >  - nestable:      it is inherited by child tasks and is fundamentally stackable,
> >                   multiple policies will have the combined effect and they
> >                   are transparent to each other. So if a child task within a
> >                   sandbox adds *more* checks then those add to the already
> >                   existing set of checks. We only narrow permissions, never
> >                   extend them.
> > 
> >  - generic:       allowing observation and (safe) control of security relevant
> >                   parameters not just at the system call boundary but at other
> >                   relevant places of kernel execution as well: which 
> >                   points/callbacks could also be used for other types of event 
> >                   extraction such as perf. It could even be shared with audit ...
> 
> I'm not arguing that any of these things are bad things.  What you describe 
> is a new LSM that uses a discretionary access control model but with the 
> granularity and flexibility that has traditionally only existed in the 
> mandatory access control security modules previously implemented in the 
> kernel.
> 
> I won't argue that's a bad idea, there's no reason in my mind that a process 
> shouldn't be allowed to control it's own access decisions in a more flexible 
> way than rwx bits.  Then again, I certainly don't see a reason that this 
> syscall hardening patch should be held up while a whole new concept in 
> computer security is contemplated...

Note, i'm not actually asking for the moon, a pony and more.

I fully submit that we are yet far away from being able to do a full LSM via 
this mechanism.

What i'm asking for is that because the syscall point steps taken by Will look 
very promising so it would be nice to do *that* in a slightly more flexible 
scheme that does not condemn it to be limited to the syscall boundary and such 
...

Also, to answer you, do you say that by my argument someone should have stood 
up and said 'no' to the LSM mess that was introduced a couple of years ago and 
which caused so many problems:

 - kernel inefficiencies and user-space overhead

 - stalled security efforts

 - infighting

 - friction, fragmentation, overmodularization

 - non-stackability

 - security annoyances on the Linux desktop

 - probably *less* Linux security

and should have asked them to do something better designed instead?

Thanks,

	Ingo
