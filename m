Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 15:56:03 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:50926 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491837Ab1EMNzz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 15:55:55 +0200
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1QKsqJ-0005lz-16; Fri, 13 May 2011 13:55:47 +0000
Received: by twins (Postfix, from userid 1000)
        id EB1ED81309F0; Fri, 13 May 2011 15:55:35 +0200 (CEST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@elte.hu>
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
In-Reply-To: <20110513131800.GA7883@elte.hu>
References: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
         <20110512130104.GA2912@elte.hu>
         <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
         <20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
         <20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
         <1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
         <1305292132.2466.26.camel@twins>  <20110513131800.GA7883@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Fri, 13 May 2011 15:55:35 +0200
Message-ID: <1305294935.2466.64.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

Cut the microblaze list since its bouncy.

On Fri, 2011-05-13 at 15:18 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> > > I think the sanest semantics is to run all active callbacks as well.
> > > 
> > > For example if this is used for three stacked security policies - as if 3 LSM 
> > > modules were stacked at once. We'd call all three, and we'd determine that at 
> > > least one failed - and we'd return a failure. 
> > 
> > But that only works for boolean functions where you can return the
> > multi-bit-or of the result. What if you need to return the specific
> > error code.
> 
> Do you mean that one filter returns -EINVAL while the other -EACCES?
> 
> Seems like a non-problem to me, we'd return the first nonzero value.

Assuming the first is -EINVAL, what then is the value in computing the
-EACCESS? Sounds like a massive waste of time to me.

> > Also, there's bound to be other cases where people will want to employ
> > this, look at all the various notifier chain muck we've got, it already
> > deals with much of this -- simply because users need it.
> 
> Do you mean it would be easy to abuse it? What kind of abuse are you most 
> worried about?

I'm not worried about abuse, I'm saying that going by the existing
notifier pattern always visiting all entries on the callback list is
undesired.

> > Then there's the whole indirection argument, if you don't need
> > indirection, its often better to not use it, I myself much prefer code
> > to look like:
> > 
> >    foo1(bar);
> >    foo2(bar);
> >    foo3(bar);
> > 
> > Than:
> > 
> >    foo_notifier(bar);
> > 
> > Simply because its much clearer who all are involved without me having
> > to grep around to see who registers for foo_notifier and wth they do
> > with it. It also makes it much harder to sneak in another user, whereas
> > its nearly impossible to find new notifier users.
> > 
> > Its also much faster, no extra memory accesses, no indirect function
> > calls, no other muck.
> 
> But i suspect this question has been settled, given the fact that even pure 
> observer events need and already process a chain of events? Am i missing 
> something about your argument?

I'm saying that there's reasons to not use notifiers passive or active.

Mostly the whole notifier/indirection muck comes up once you want
modules to make use of the thing, because then you need dynamic
management of the callback list.

(Then again, I'm fairly glad we don't have explicit callbacks in
kernel/cpu.c for all the cpu-hotplug callbacks :-)

Anyway, I oppose for the existing events to gain an active role.
