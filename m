Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 14:57:40 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:49902 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490989Ab1EQM5f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 14:57:35 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QMJpf-0002NF-Ma
        from <mingo@elte.hu>; Tue, 17 May 2011 14:57:09 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 616503E2533; Tue, 17 May 2011 14:56:57 +0200 (CEST)
Date:   Tue, 17 May 2011 14:57:00 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Will Drewry <wad@chromium.org>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
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
Message-ID: <20110517125700.GD21441@elte.hu>
References: <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <1305299455.2076.26.camel@localhost.localdomain>
 <20110514073015.GB9307@elte.hu>
 <BANLkTi=1CBKevjg3+fYFZF9zWtQVw-W9hQ@mail.gmail.com>
 <20110516124304.GC7128@elte.hu>
 <BANLkTimcYyTxUDN4QysyOitTJYJP9ZavZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTimcYyTxUDN4QysyOitTJYJP9ZavZA@mail.gmail.com>
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
X-archive-position: 30062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Will Drewry <wad@chromium.org> wrote:

> > This is *far* more generic still yields the same short-term end result as 
> > far as your sandboxing is concerned.
> 
> Almost :/ [...]

Hey that's a pretty good result from a subsystem that was not written with your 
usecase in mind *at all* ;-)

> [...]  I still need to review the code you've pointed out, but, at present, 
> the ftrace hooks occur after the seccomp and syscall auditing hooks.  This 
> means that that code is exposed no matter what in this model.  To trim the 
> exposed surface to userspace, we really need those early hooks.  While I can 
> see both hacky and less hacky approaches around this, it stills strikes me 
> that the seccomp thread flag and early interception are good to reuse.  One 
> option might be to allow seccomp to be a secure-syscall event source, but I 
> suspect that lands more on the hack-y side of the fence :)

Agreed, there should be no security compromise imposed on your usecase, at all.

You could move the event callback sooner into the syscall-entry sequence to 
make sure it's the highest priority thing to process?

There's no semantic dependency on its current location so this can be changed 
AFAICS.

Thanks,

	Ingo
