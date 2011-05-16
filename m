Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 14:01:32 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:38430 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491023Ab1EPMBY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 14:01:24 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QLwTl-00034s-Ef
        from <mingo@elte.hu>; Mon, 16 May 2011 14:00:59 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id C7EF63E250F; Mon, 16 May 2011 14:00:44 +0200 (CEST)
Date:   Mon, 16 May 2011 14:00:43 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Drewry <wad@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
        jmorris@namei.org, Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        microblaze-uclinux@itee.uq.edu.au,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
        Roland McGrath <roland@redhat.com>,
        Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
        linuxppc-dev@lists.ozlabs.org, Oleg Nesterov <oleg@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        agl@chromium.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110516120043.GA7128@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <201105132135.34741.arnd@arndb.de>
 <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
 <201105150842.07816.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201105150842.07816.arnd@arndb.de>
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
X-archive-position: 30036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 14 May 2011, Will Drewry wrote:
> > Depending on integration, it could even be limited to ioctl commands
> > that are appropriate to a known fd if the fd is opened prior to
> > entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
> > with a filter of "1" then narrowed through a later addition of
> > something like "(fd == %u && (cmd == %u || cmd == %u))" or something
> > along those lines.
> > 
> > Does that make sense?
> 
> Thanks for the explanation. This sounds like it's already doing all
> we need.

One thing we could do more clearly here is to help keep the filter expressions 
symbolic - i.e. help resolve the various ioctl variants as well, not just the 
raw syscall parameter numbers.

But yes, access to the raw syscall parameters and the ability to filter them 
already gives us the ability to exclude/include specific ioctls in a rather 
flexible way.

Thanks,

	Ingo
