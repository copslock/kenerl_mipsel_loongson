Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 14:40:56 +0200 (CEST)
Received: from bombadil.infradead.org ([18.85.46.34]:45163 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491821Ab1EMMj6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 14:39:58 +0200
Received: from canuck.infradead.org ([134.117.69.58])
        by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
        id 1QKreX-00062e-8B; Fri, 13 May 2011 12:39:33 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1QKreW-0002OA-50; Fri, 13 May 2011 12:39:32 +0000
Received: by twins (Postfix, from userid 1000)
        id 4719A812FE74; Fri, 13 May 2011 14:39:30 +0200 (CEST)
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
In-Reply-To: <20110513122646.GA3924@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
         <1305169376-2363-1-git-send-email-wad@chromium.org>
         <20110512074850.GA9937@elte.hu>
         <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
         <20110512130104.GA2912@elte.hu>
         <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
         <20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
         <20110513122646.GA3924@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Fri, 13 May 2011 14:39:30 +0200
Message-ID: <1305290370.2466.14.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Fri, 2011-05-13 at 14:26 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, 2011-05-13 at 14:10 +0200, Ingo Molnar wrote:
> > >         err = event_vfs_getname(result);
> > 
> > I really think we should not do this. Events like we have them should be 
> > inactive, totally passive entities, only observe but not affect execution 
> > (other than the bare minimal time delay introduced by observance).
> 
> Well, this patchset already demonstrates that we can use a single event 
> callback for a rather useful purpose.

Can and should are two distinct things.

> Either it makes sense to do, in which case we should share facilities as much 
> as possible, or it makes no sense, in which case we should not merge it at all.

And I'm arguing we should _not_. Observing is radically different from
Affecting, at the very least the two things should have different
permission schemes. We should not confuse these two matters.

> > If you want another entity that is more active, please invent a new name for 
> > it and create a new subsystem for them, now you could have these active 
> > entities also have an (automatic) passive event side, but that's some detail.
> 
> Why should we have two callbacks next to each other:
> 
> 	event_vfs_getname(result);
> 	result = check_event_vfs_getname(result);
> 
> if one could do it all?

Did you actually read the bit where I said that check_event_* (although
I still think that name sucks) could imply a matching event_*?
