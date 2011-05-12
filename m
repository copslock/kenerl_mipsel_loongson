Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 12:50:14 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:36706 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491164Ab1ELKuI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2011 12:50:08 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QKTSR-0000NH-23
        from <mingo@elte.hu>; Thu, 12 May 2011 12:49:32 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 0DDB83E2526; Thu, 12 May 2011 12:49:11 +0200 (CEST)
Date:   Thu, 12 May 2011 12:49:16 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Kees Cook <kees.cook@canonical.com>
Cc:     Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Eric Paris <eparis@redhat.com>, agl@chromium.org,
        jmorris@namei.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
Message-ID: <20110512104916.GJ9937@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
 <20110512092424.GO28888@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110512092424.GO28888@outflux.net>
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
X-archive-position: 29954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Kees Cook <kees.cook@canonical.com> wrote:

> Hi,
> 
> On Thu, May 12, 2011 at 09:48:50AM +0200, Ingo Molnar wrote:
> > 1) We already have a specific ABI for this: you can set filters for events via 
> >    an event fd.
> > 
> >    Why not extend that mechanism instead and improve *both* your sandboxing
> >    bits and the events code? This new seccomp code has a lot more
> >    to do with trace event filters than the minimal old seccomp code ...
> 
> Would this require privileges to get the event fd to start with? [...]

No special privileges with the default perf_events_paranoid value.

> [...] If so, I would prefer to avoid that, since using prctl() as shown in 
> the patch set won't require any privs.

and we could also explicitly allow syscall events without any privileges, 
regardless of the setting of 'perf_events_paranoid' config value.

Obviously a sandboxing host process wants to run with as low privileges as it 
can.

Thanks,

	Ingo
