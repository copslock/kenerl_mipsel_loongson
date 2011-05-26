Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2011 11:15:46 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:49838 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491068Ab1EZJPk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 May 2011 11:15:40 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QPWf4-0008Q3-3j
        from <mingo@elte.hu>; Thu, 26 May 2011 11:15:24 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 6A7C33E2534; Thu, 26 May 2011 11:15:16 +0200 (CEST)
Date:   Thu, 26 May 2011 11:15:18 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Drewry <wad@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, "Serge E. Hallyn" <serge@hallyn.com>,
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
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110526091518.GE26775@elte.hu>
References: <20110517131902.GF21441@elte.hu>
 <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
 <1305807728.11267.25.camel@gandalf.stny.rr.com>
 <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
 <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
 <1306254027.18455.47.camel@twins>
 <20110524195435.GC27634@elte.hu>
 <alpine.LFD.2.02.1105242239230.3078@ionos>
 <20110525150153.GE29179@elte.hu>
 <alpine.LFD.2.02.1105251836030.3078@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1105251836030.3078@ionos>
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
X-archive-position: 30154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > If anything then that should tell you something that events and 
> > seccomp are not just casually related ...
> 
> They happen to have the hook at the same point in the source and 
> for pure coincidence it works because the problem to solve is 
> extremly simplistic. And that's why the diffstat is minimalistic, 
> but that does not prove anything.

Here are the diffstats of the various versions of this proposed 
security feature:

       bitmask (2009):  6 files changed,  194 insertions(+), 22 deletions(-)
 filter engine (2010): 18 files changed, 1100 insertions(+), 21 deletions(-)
 event filters (2011):  5 files changed,   82 insertions(+), 16 deletions(-)

The third variant, 'event filters', is actually the most 
sophisticated one of all and it is not simplistic at all.

The main reason why the diffstat is small is because it reuses over 
ten thousand lines of pre-existing kernel code intelligently. Are you 
interpreting that as some sort of failure of the patch? I think it's 
a very good thing.

To demonstrate the non-simplicity of the feature:

 - These security rules/filters can be sophisticated like:

   sys_close() rule protecting against the closing of 
   stdin/stdout/stderr:

                  "fd == 0 || fd == 1 || fd == 2"

   sys_ioperm() rule allowing port 0x80 access but nothing else:

                  "from != 128 || num != 1"

   sys_listen() rule limiting the max accept() backlog to 16 entries:

                  "backlog > 16"

   sys_mprotect(), sys_mmap[2](), sys_unmap() and sys_mremap() rule
   protecting the first 1 MB NULL pointer guard range:

                  "addr < 0x00100000"

   sys_setscheduler() rule protecting against the switch to 
   non-SCHED_OTHER scheduler policies:

                  "policy != 0"

   Most of these examples are finegrained access restrictions that 
   AFAIK are not possible with any of the LSM based security measures 
   that Linux offers today.

 - These security rules/filters can be safely used and installed by 
   unprivileged userspace, allowing arbitrary end user apps to define 
   their own, flexible security policies.

 - These security rules/filters get automatically inherited into child 
   tasks and child tasks cannot mess with them - they cannot even 
   query/observe that these filters *exist*.

 - These security rules/filters nest on each other in basically 
   arbitrary depth, giving us a working, implemented, stackable LSM
   concept.

 - These security rules/filters can be extended to arbitrary more 
   object lifetime events in the future, without changing the ABI.

 - These security rules/filters, unlike most LSM rules, can execute
   not just within hardirqs but also within deeply atomic contexts
   such as NMI contexts, putting far less restrictions on what can
   be security/access checked.

 - Access permission violations can be set up to generate events of
   the violations into a scalable ring-buffer, providing unprivileged
   security-auditing functionality to the managing task(s).

I'd call that anything but 'simplistic'.

Thanks,

	Ingo
