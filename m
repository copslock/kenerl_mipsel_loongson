Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 16:58:22 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:43303 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491839Ab1EMO6T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 16:58:19 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QKtoG-0001PT-AR
        from <mingo@elte.hu>; Fri, 13 May 2011 16:57:46 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 386C33E2533; Fri, 13 May 2011 16:57:33 +0200 (CEST)
Date:   Fri, 13 May 2011 16:57:37 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     James Morris <jmorris@namei.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20110513145737.GC32688@elte.hu>
References: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <1305289146.2466.8.camel@twins>
 <20110513122646.GA3924@elte.hu>
 <1305290370.2466.14.camel@twins>
 <1305290612.2466.17.camel@twins>
 <20110513125452.GD3924@elte.hu>
 <1305292132.2466.26.camel@twins>
 <20110513131800.GA7883@elte.hu>
 <1305294935.2466.64.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305294935.2466.64.camel@twins>
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
X-archive-position: 29991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Peter Zijlstra <peterz@infradead.org> wrote:

> Cut the microblaze list since its bouncy.
> 
> On Fri, 2011-05-13 at 15:18 +0200, Ingo Molnar wrote:
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> > > > I think the sanest semantics is to run all active callbacks as well.
> > > > 
> > > > For example if this is used for three stacked security policies - as if 3 LSM 
> > > > modules were stacked at once. We'd call all three, and we'd determine that at 
> > > > least one failed - and we'd return a failure. 
> > > 
> > > But that only works for boolean functions where you can return the
> > > multi-bit-or of the result. What if you need to return the specific
> > > error code.
> > 
> > Do you mean that one filter returns -EINVAL while the other -EACCES?
> > 
> > Seems like a non-problem to me, we'd return the first nonzero value.
> 
> Assuming the first is -EINVAL, what then is the value in computing the
> -EACCESS? Sounds like a massive waste of time to me.

No, because the common case is no rejection - this is a security mechanism. So 
in the normal case we would execute all 3 anyway, just to determine that all 
return 0.

Are you really worried about the abnormal case of one of them returning an 
error and us calculating all 3 return values?

> > > Also, there's bound to be other cases where people will want to employ
> > > this, look at all the various notifier chain muck we've got, it already
> > > deals with much of this -- simply because users need it.
> > 
> > Do you mean it would be easy to abuse it? What kind of abuse are you most 
> > worried about?
> 
> I'm not worried about abuse, I'm saying that going by the existing
> notifier pattern always visiting all entries on the callback list is
> undesired.

That is because many notifier chains are used in an 'event consuming' manner - 
they are responding to things like hardware events and are called in an 
interrupt-handler alike fashion most of the time.

> > > Then there's the whole indirection argument, if you don't need
> > > indirection, its often better to not use it, I myself much prefer code
> > > to look like:
> > > 
> > >    foo1(bar);
> > >    foo2(bar);
> > >    foo3(bar);
> > > 
> > > Than:
> > > 
> > >    foo_notifier(bar);
> > > 
> > > Simply because its much clearer who all are involved without me having
> > > to grep around to see who registers for foo_notifier and wth they do
> > > with it. It also makes it much harder to sneak in another user, whereas
> > > its nearly impossible to find new notifier users.
> > > 
> > > Its also much faster, no extra memory accesses, no indirect function
> > > calls, no other muck.
> > 
> > But i suspect this question has been settled, given the fact that even pure 
> > observer events need and already process a chain of events? Am i missing 
> > something about your argument?
> 
> I'm saying that there's reasons to not use notifiers passive or active.
> 
> Mostly the whole notifier/indirection muck comes up once you want
> modules to make use of the thing, because then you need dynamic
> management of the callback list.

But your argument assumes that we'd have a chain of functions to call, like 
regular notifiers.

While the natural model here would be to have a list of registered event 
structs for that point, with different filters but basically the same callback 
mechanism (a call into the filter engine in essence).

Also note that the common case would be no event registered - and we'd 
automatically optimize that case via the existing jump labels optimization.

> (Then again, I'm fairly glad we don't have explicit callbacks in kernel/cpu.c 
> for all the cpu-hotplug callbacks :-)
> 
> Anyway, I oppose for the existing events to gain an active role.

Why if 'being active' is optional and useful?

Thanks,

	Ingo
