Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 15:18:38 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:58960 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491818Ab1EMNSe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 15:18:34 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QKsFn-0005vG-UB
        from <mingo@elte.hu>; Fri, 13 May 2011 15:18:09 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 8A07A3E233D; Fri, 13 May 2011 15:17:56 +0200 (CEST)
Date:   Fri, 13 May 2011 15:18:00 +0200
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
        linux-arm-kernel@lists.infradead.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110513131800.GA7883@elte.hu>
References: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <1305289146.2466.8.camel@twins>
 <20110513122646.GA3924@elte.hu>
 <1305290370.2466.14.camel@twins>
 <1305290612.2466.17.camel@twins>
 <20110513125452.GD3924@elte.hu>
 <1305292132.2466.26.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305292132.2466.26.camel@twins>
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
X-archive-position: 29988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> > I think the sanest semantics is to run all active callbacks as well.
> > 
> > For example if this is used for three stacked security policies - as if 3 LSM 
> > modules were stacked at once. We'd call all three, and we'd determine that at 
> > least one failed - and we'd return a failure. 
> 
> But that only works for boolean functions where you can return the
> multi-bit-or of the result. What if you need to return the specific
> error code.

Do you mean that one filter returns -EINVAL while the other -EACCES?

Seems like a non-problem to me, we'd return the first nonzero value.

> Also, there's bound to be other cases where people will want to employ
> this, look at all the various notifier chain muck we've got, it already
> deals with much of this -- simply because users need it.

Do you mean it would be easy to abuse it? What kind of abuse are you most 
worried about?

> Then there's the whole indirection argument, if you don't need
> indirection, its often better to not use it, I myself much prefer code
> to look like:
> 
>    foo1(bar);
>    foo2(bar);
>    foo3(bar);
> 
> Than:
> 
>    foo_notifier(bar);
> 
> Simply because its much clearer who all are involved without me having
> to grep around to see who registers for foo_notifier and wth they do
> with it. It also makes it much harder to sneak in another user, whereas
> its nearly impossible to find new notifier users.
> 
> Its also much faster, no extra memory accesses, no indirect function
> calls, no other muck.

But i suspect this question has been settled, given the fact that even pure 
observer events need and already process a chain of events? Am i missing 
something about your argument?

Thanks,

	Ingo
