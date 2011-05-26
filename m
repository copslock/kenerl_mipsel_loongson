Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2011 10:36:00 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:55162 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491072Ab1EZIfz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 May 2011 10:35:55 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QPW2T-0007m4-6h
        from <mingo@elte.hu>; Thu, 26 May 2011 10:35:34 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id F418D3E2534; Thu, 26 May 2011 10:35:10 +0200 (CEST)
Date:   Thu, 26 May 2011 10:35:13 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     James Morris <jmorris@namei.org>, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
        Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        agl@chromium.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110526083513.GC26775@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
 <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
 <20110526062752.GA14622@localhost.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110526062752.GA14622@localhost.ucw.cz>
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
X-archive-position: 30152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Pavel Machek <pavel@ucw.cz> wrote:

>   On Mon 2011-05-16 10:36:05, James Morris wrote:
> > On Fri, 13 May 2011, Ingo Molnar wrote:
> > How do you reason about the behavior of the system as a whole?
> > 
> > 
> > > I argue that this is the LSM and audit subsystems designed right: in the long 
> > > run it could allow everything that LSM does at the moment - and so much more 
> > > ...
> > 
> > Now you're proposing a redesign of the security subsystem.  That's a 
> > significant undertaking.
> > 
> > In the meantime, we have a simple, well-defined enhancement to seccomp 
> > which will be very useful to current users in reducing their kernel attack 
> > surface.
> 
> Well, you can do the same with subterfugue, even without kernel 
> changes. But that's ptrace -- slow. (And it already shows that 
> syscall based filters are extremely tricky to configure).

Yes, if you use syscall based filters to implement access to 
underlying objects where the access methods do not capture essential 
lifetime events properly (such as files) they you'll quickly run into 
trouble achieving a secure solution.

But you can robustly use syscall filters to control the underlying 
primary *resource*: various pieces of kernel code with *negative* 
utility to the current app - which have no use to the app but pose 
risks in terms of potential exploits in them.

But you can use event filters to implement arbitrary security 
policies robustly.

For example file objects: if you generate the right events for a 
class of objects then you can control access to them very robustly.

It's not a surprise that this is what SELinux does primarily: it has 
lifetime event hooks at the inode object (and socket, packet, etc.) 
level and captures those access attempts and validates them against 
the permissions of that object, in light of the accessing task's 
credentials.

Exactly that can be done with Will's patch as well, if its potential 
scope of event-checking points is not stupidly limited to the syscall 
boundary alone ...

Thanks,

	Ingo
