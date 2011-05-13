Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:03:07 +0200 (CEST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:34609 "EHLO mx3.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491839Ab1EMPDD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 17:03:03 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx3.mail.elte.hu with esmtp (Exim)
        id 1QKtsl-0008Me-ST
        from <mingo@elte.hu>; Fri, 13 May 2011 17:02:30 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id BE4C93E233D; Fri, 13 May 2011 17:02:15 +0200 (CEST)
Date:   Fri, 13 May 2011 17:02:15 +0200
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
Message-ID: <20110513150215.GD32688@elte.hu>
References: <20110512074850.GA9937@elte.hu>
 <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
 <20110512130104.GA2912@elte.hu>
 <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
 <20110513121034.GG21022@elte.hu>
 <1305289146.2466.8.camel@twins>
 <20110513122646.GA3924@elte.hu>
 <1305290370.2466.14.camel@twins>
 <20110513124902.GC3924@elte.hu>
 <1305294936.2466.65.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305294936.2466.65.camel@twins>
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
X-archive-position: 29992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2011-05-13 at 14:49 +0200, Ingo Molnar wrote:
> > 
> > So given that by your own admission it makes sense to share the facilities at 
> > the low level, i also argue that it makes sense to share as high up as 
> > possible. 
> 
> I'm not saying any such thing, I'm saying that it might make sense to
> observe active objects and auto-create these observation points. That
> doesn't make them similar or make them share anything.

Well, they would share the lowest level call site:

	result = check_event_vfs_getname(result);

You call it 'auto-generated call site', i call it a shared (single line) call 
site. The same thing as far as the lowest level goes.

Now (the way i understood it) you'd want to stop the sharing right after that. 
I argue that it should go all the way up.

Note: i fully agree that there should be events where filters can have no 
effect whatsoever. For example if this was written as:

	check_event_vfs_getname(result);

Then it would have no effect. This is decided by the subsystem developers, 
obviously. So whether an event is 'active' or 'passive' can be enforced at the 
subsystem level as well.

As far as the event facilities go, 'no effect observation' is a special-case of 
'active observation' - just like read-only files are a special case of 
read-write files.

Thanks,

	Ingo
