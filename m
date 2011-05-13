Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 15:09:31 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:43143 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491818Ab1EMNJY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 15:09:24 +0200
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1QKs75-0004sW-Vs; Fri, 13 May 2011 13:09:04 +0000
Received: by twins (Postfix, from userid 1000)
        id C3F3281309F0; Fri, 13 May 2011 15:08:52 +0200 (CEST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@elte.hu>
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
In-Reply-To: <20110513125452.GD3924@elte.hu>
References: <1305169376-2363-1-git-send-email-wad@chromium.org>
         <20110512074850.GA9937@elte.hu>
         <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
         <20110512130104.GA2912@elte.hu>
         <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
         <20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
         <20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
         <1305290612.2466.17.camel@twins>  <20110513125452.GD3924@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Fri, 13 May 2011 15:08:52 +0200
Message-ID: <1305292132.2466.26.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> I think the sanest semantics is to run all active callbacks as well.
> 
> For example if this is used for three stacked security policies - as if 3 LSM 
> modules were stacked at once. We'd call all three, and we'd determine that at 
> least one failed - and we'd return a failure. 

But that only works for boolean functions where you can return the
multi-bit-or of the result. What if you need to return the specific
error code.

Also, there's bound to be other cases where people will want to employ
this, look at all the various notifier chain muck we've got, it already
deals with much of this -- simply because users need it.

Then there's the whole indirection argument, if you don't need
indirection, its often better to not use it, I myself much prefer code
to look like:

   foo1(bar);
   foo2(bar);
   foo3(bar);

Than:

   foo_notifier(bar);

Simply because its much clearer who all are involved without me having
to grep around to see who registers for foo_notifier and wth they do
with it. It also makes it much harder to sneak in another user, whereas
its nearly impossible to find new notifier users.

Its also much faster, no extra memory accesses, no indirect function
calls, no other muck.
