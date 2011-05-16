Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 02:37:37 +0200 (CEST)
Received: from tundra.namei.org ([65.99.196.166]:40122 "EHLO tundra.namei.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491015Ab1EPAhc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 02:37:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by tundra.namei.org (8.13.1/8.13.1) with ESMTP id p4G0a50X022105;
        Sun, 15 May 2011 20:36:06 -0400
Date:   Mon, 16 May 2011 10:36:05 +1000 (EST)
From:   James Morris <jmorris@namei.org>
To:     Ingo Molnar <mingo@elte.hu>
cc:     Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20110513121034.GG21022@elte.hu>
Message-ID: <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com> <1305169376-2363-1-git-send-email-wad@chromium.org> <20110512074850.GA9937@elte.hu> <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org> <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org> <20110513121034.GG21022@elte.hu>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jmorris@namei.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jmorris@namei.org
Precedence: bulk
X-list: linux-mips

On Fri, 13 May 2011, Ingo Molnar wrote:

> Say i'm a user-space sandbox developer who wants to enforce that sandboxed code 
> should only be allowed to open files in /home/sandbox/, /lib/ and /usr/lib/.
> 
> It is a simple and sensible security feature, agreed? It allows most code to 
> run well and link to countless libraries - but no access to other files is 
> allowed.

Not really.

Firstly, what is the security goal of these restrictions?  Then, are the 
restrictions complete and unbypassable?

How do you reason about the behavior of the system as a whole?


> I argue that this is the LSM and audit subsystems designed right: in the long 
> run it could allow everything that LSM does at the moment - and so much more 
> ...

Now you're proposing a redesign of the security subsystem.  That's a 
significant undertaking.

In the meantime, we have a simple, well-defined enhancement to seccomp 
which will be very useful to current users in reducing their kernel attack 
surface.

We should merge that, and the security subsystem discussion can carry on 
separately.


- James
-- 
James Morris
<jmorris@namei.org>
