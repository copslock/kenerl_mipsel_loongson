Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2011 09:06:30 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:47432 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490975Ab1ENHGY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 May 2011 09:06:24 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QL8v7-0004In-Jk
        from <mingo@elte.hu>; Sat, 14 May 2011 09:05:55 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id CB7A63E252E; Sat, 14 May 2011 09:05:39 +0200 (CEST)
Date:   Sat, 14 May 2011 09:05:42 +0200
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110514070542.GA9307@elte.hu>
References: <1305289146.2466.8.camel@twins>
 <20110513122646.GA3924@elte.hu>
 <1305290370.2466.14.camel@twins>
 <1305290612.2466.17.camel@twins>
 <20110513125452.GD3924@elte.hu>
 <1305292132.2466.26.camel@twins>
 <20110513131800.GA7883@elte.hu>
 <1305294935.2466.64.camel@twins>
 <20110513145737.GC32688@elte.hu>
 <1305300443.2466.77.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305300443.2466.77.camel@twins>
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
X-archive-position: 30024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2011-05-13 at 16:57 +0200, Ingo Molnar wrote:
> > this is a security mechanism
> 
> Who says? [...]

Kernel developers/maintainers of the affected code.

We have security hooks all around the kernel, which can deny/accept execution 
at various key points, but we do not have 'execute arbitrary user-space defined 
(safe) scripts' callbacks in general.

But yes, if a particular callback point is defined widely enough to allow much 
bigger intervention into the flow of execution, then more is possible as well.

> [...] and why would you want to unify two separate concepts only to them 
> limit it to security that just doesn't make sense.

I don't limit them to security - the callbacks themselves are either for 
passive observation or, at most, for security accept/deny callbacks.

It's decided by the subsystem maintainers what kind of user-space control power 
(or observation power) they want to allow, not me.

I would just like to not stop the facility itself at the 'observe only' level, 
like you suggest.

Thanks,

	Ingo
