Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2011 08:28:05 +0200 (CEST)
Received: from ksp.mff.cuni.cz ([195.113.26.206]:39172 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490955Ab1EZG2A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2011 08:28:00 +0200
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5F468F0A11; Thu, 26 May 2011 08:27:59 +0200 (CEST)
Date:   Thu, 26 May 2011 06:27:52 +0000
From:   Pavel Machek <pavel@ucw.cz>
To:     James Morris <jmorris@namei.org>
Cc:     Ingo Molnar <mingo@elte.hu>, linux-mips@linux-mips.org,
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
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
        call filtering
Message-ID: <20110526062752.GA14622@localhost.ucw.cz>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com> <1305169376-2363-1-git-send-email-wad@chromium.org> <20110512074850.GA9937@elte.hu> <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org> <20110512130104.GA2912@elte.hu> <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org> <20110513121034.GG21022@elte.hu> <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

  On Mon 2011-05-16 10:36:05, James Morris wrote:
> On Fri, 13 May 2011, Ingo Molnar wrote:
> How do you reason about the behavior of the system as a whole?
> 
> 
> > I argue that this is the LSM and audit subsystems designed right: in the long 
> > run it could allow everything that LSM does at the moment - and so much more 
> > ...
> 
> Now you're proposing a redesign of the security subsystem.  That's a 
> significant undertaking.
> 
> In the meantime, we have a simple, well-defined enhancement to seccomp 
> which will be very useful to current users in reducing their kernel attack 
> surface.

Well, you can do the same with subterfugue, even without kernel
changes. But that's ptrace -- slow. (And it already shows that syscall
based filters are extremely tricky to configure).

If yu want speed, seccomp+server for non-permitted operations seems like reasonable way.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
