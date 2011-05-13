Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 02:20:31 +0200 (CEST)
Received: from tundra.namei.org ([65.99.196.166]:46849 "EHLO tundra.namei.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491766Ab1EMAU0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 02:20:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by tundra.namei.org (8.13.1/8.13.1) with ESMTP id p4D0IqQM003478;
        Thu, 12 May 2011 20:18:52 -0400
Date:   Fri, 13 May 2011 10:18:52 +1000 (EST)
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
In-Reply-To: <20110512130104.GA2912@elte.hu>
Message-ID: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com> <1305169376-2363-1-git-send-email-wad@chromium.org> <20110512074850.GA9937@elte.hu> <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org> <20110512130104.GA2912@elte.hu>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jmorris@namei.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jmorris@namei.org
Precedence: bulk
X-list: linux-mips

On Thu, 12 May 2011, Ingo Molnar wrote:
> Funnily enough, back then you wrote this:
> 
>   " I'm concerned that we're seeing yet another security scheme being designed on 
>     the fly, without a well-formed threat model, and without taking into account 
>     lessons learned from the seemingly endless parade of similar, failed schemes. "
> 
> so when and how did your opinion of this scheme turn from it being an "endless 
> parade of failed schemes" to it being a "well-defined and readily 
> understandable feature"? :-)

When it was defined in a way which limited its purpose to reducing the 
attack surface of the sycall interface.


- James
-- 
James Morris
<jmorris@namei.org>
