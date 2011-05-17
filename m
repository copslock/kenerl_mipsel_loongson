Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 14:42:57 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:52623 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490989Ab1EQMmx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 14:42:53 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QMJbT-00065A-1G
        from <mingo@elte.hu>; Tue, 17 May 2011 14:42:29 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 6A5F03E2533; Tue, 17 May 2011 14:42:12 +0200 (CEST)
Date:   Tue, 17 May 2011 14:42:12 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20110517124212.GB21441@elte.hu>
References: <1305290370.2466.14.camel@twins>
 <1305290612.2466.17.camel@twins>
 <20110513125452.GD3924@elte.hu>
 <1305292132.2466.26.camel@twins>
 <20110513131800.GA7883@elte.hu>
 <1305294935.2466.64.camel@twins>
 <20110513145737.GC32688@elte.hu>
 <1305563026.5456.19.camel@gandalf.stny.rr.com>
 <20110516165249.GB10929@elte.hu>
 <1305565422.5456.21.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305565422.5456.21.camel@gandalf.stny.rr.com>
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
X-archive-position: 30061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> > > way multiple callbacks can be registered. How would:
> > > 
> > > 	err = event_x();
> > > 	if (err == -EACCESS) {
> > > 
> > > be handled? [...]
> > 
> > The default behavior would be something obvious: to trigger all callbacks and 
> > use the first non-zero return value.
> 
> But how do we know which callback that was from? There's no ordering of what 
> callbacks are called first.

We do not have to know that - nor do the calling sites care in general. Do you 
have some specific usecase in mind where the identity of the callback that 
generates a match matters?

Thanks,

	Ingo
