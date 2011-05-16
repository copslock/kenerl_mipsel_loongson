Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 17:09:10 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:44866 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491041Ab1EPPJG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 17:09:06 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QLzPY-0001y2-SW
        from <mingo@elte.hu>; Mon, 16 May 2011 17:08:50 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 3E5DA3E250F; Mon, 16 May 2011 17:08:33 +0200 (CEST)
Date:   Mon, 16 May 2011 17:08:37 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     James Morris <jmorris@namei.org>
Cc:     Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
Message-ID: <20110516150837.GA513@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
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
X-archive-position: 30044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* James Morris <jmorris@namei.org> wrote:

> On Fri, 13 May 2011, Ingo Molnar wrote:
> 
> > Say i'm a user-space sandbox developer who wants to enforce that sandboxed 
> > code should only be allowed to open files in /home/sandbox/, /lib/ and 
> > /usr/lib/.
> > 
> > It is a simple and sensible security feature, agreed? It allows most code 
> > to run well and link to countless libraries - but no access to other files 
> > is allowed.
> 
> Not really.
> 
> Firstly, what is the security goal of these restrictions? [...]

To do what i described above? Namely:

 " Sandboxed code should only be allowed to open files in /home/sandbox/, /lib/
   and /usr/lib/ "

> [...]  Then, are the restrictions complete and unbypassable?

If only the system calls i mentioned are allowed, and if the sandboxed VFS 
namespace itself is isolated from the rest of the system (no bind mounts, no 
hard links outside the sandbox, etc.) then its goal is to not be bypassable - 
what use is a sandbox if the sandbox can be bypassed by the sandboxed code?

There's a few ways how to alter (and thus bypass) VFS namespace lookups: 
symlinks, chdir, chroot, rename, etc., which (as i mentioned) have to be 
excluded by default or filtered as well.

> How do you reason about the behavior of the system as a whole?

For some usecases i mainly want to reason about what the sandboxed code can do 
and can not do, within a fairly static and limited VFS namespace environment.

I might not want to have a full-blown 'physical barrier' for all objects 
labeled as inaccessible to sandboxed code (or labeled as accessible to 
sandboxed code).

Especially as manipulating file labels is not also slow (affects all files) but 
is also often an exclusively privileged operation even for owned files, for no 
good reason. For things like /lib/ and /usr/lib/ it also *has* to be a 
privileged operation.

> > I argue that this is the LSM and audit subsystems designed right: in the 
> > long run it could allow everything that LSM does at the moment - and so 
> > much more ...
> 
> Now you're proposing a redesign of the security subsystem.  That's a 
> significant undertaking.

It certainly is.

> In the meantime, we have a simple, well-defined enhancement to seccomp which 
> will be very useful to current users in reducing their kernel attack surface.
> 
> We should merge that, and the security subsystem discussion can carry on 
> separately.

Is that the development and merge process along which the LSM subsystem got 
into its current state?

Thanks,

	Ingo
