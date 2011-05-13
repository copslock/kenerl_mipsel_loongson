Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 14:55:30 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:43698 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491829Ab1EMMzZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 14:55:25 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QKrtP-0003SP-7l
        from <mingo@elte.hu>; Fri, 13 May 2011 14:55:00 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id D7D583E233D; Fri, 13 May 2011 14:54:50 +0200 (CEST)
Date:   Fri, 13 May 2011 14:54:52 +0200
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
Message-ID: <20110513125452.GD3924@elte.hu>
References: <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <1305289146.2466.8.camel@twins>
 <20110513122646.GA3924@elte.hu>
 <1305290370.2466.14.camel@twins>
 <1305290612.2466.17.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305290612.2466.17.camel@twins>
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
X-archive-position: 29986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2011-05-13 at 14:39 +0200, Peter Zijlstra wrote:
> > 
> > >       event_vfs_getname(result);
> > >       result = check_event_vfs_getname(result); 
> 
> Another fundamental difference is how to treat the callback chains for
> these two.
> 
> Observers won't have a return value and are assumed to never fail,
> therefore we can always call every entry on the callback list.
> 
> Active things otoh do have a return value, and thus we need to have
> semantics that define what to do with that during callback iteration,
> when to continue and when to break. Thus for active elements its
> impossible to guarantee all entries will indeed be called.

I think the sanest semantics is to run all active callbacks as well.

For example if this is used for three stacked security policies - as if 3 LSM 
modules were stacked at once. We'd call all three, and we'd determine that at 
least one failed - and we'd return a failure.

Even if the first one failed already we'd still want to trigger *all* the 
failures, because security policies like to know when they have triggered a 
failure (regardless of other active policies) and want to see that failure 
event (if they are logging such events).

So to me this looks pretty similar to observer callbacks as well, it's the 
natural extension to an observer callback chain.

Observer callbacks are simply constant functions (to the caller), those which 
never return failure and which never modify any of the parameters.

It's as if you argued that there should be separate syscalls/facilities for 
handling readonly files versus handling read/write files.

Thanks,

	Ingo
