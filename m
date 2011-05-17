Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 15:05:49 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:50862 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491090Ab1EQNFm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2011 15:05:42 +0200
X-Authority-Analysis: v=1.1 cv=y6zMVzRGPZqd+EkIbWgKRW0ZY5+85Abqc3bXR1aXymM= c=1 sm=0 a=zw1CKeOhDhoA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=meVymXHHAAAA:8 a=VbrLmbB3NDBXB4HtCbgA:9 a=wqySLxIxk_T244i_9UQA:7 a=PUjeQqilurYA:10 a=jeBq3FmKZ4MA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:51682] helo=[192.168.23.10])
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 7A/AF-15019-99272DD4; Tue, 17 May 2011 13:05:35 +0000
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20110517124212.GB21441@elte.hu>
References: <1305290370.2466.14.camel@twins>
         <1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
         <1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
         <1305294935.2466.64.camel@twins> <20110513145737.GC32688@elte.hu>
         <1305563026.5456.19.camel@gandalf.stny.rr.com>
         <20110516165249.GB10929@elte.hu>
         <1305565422.5456.21.camel@gandalf.stny.rr.com>
         <20110517124212.GB21441@elte.hu>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 17 May 2011 09:05:28 -0400
Message-ID: <1305637528.5456.723.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Tue, 2011-05-17 at 14:42 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
> > > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> > > > way multiple callbacks can be registered. How would:
> > > > 
> > > > 	err = event_x();
> > > > 	if (err == -EACCESS) {
> > > > 
> > > > be handled? [...]
> > > 
> > > The default behavior would be something obvious: to trigger all callbacks and 
> > > use the first non-zero return value.
> > 
> > But how do we know which callback that was from? There's no ordering of what 
> > callbacks are called first.
> 
> We do not have to know that - nor do the calling sites care in general. Do you 
> have some specific usecase in mind where the identity of the callback that 
> generates a match matters?

Maybe I'm confused. I was thinking that these event_*() are what we
currently call trace_*(), but the event_*(), I assume, can return a
value if a call back returns one.

Thus, we now have the ability to dynamically attach function calls to
arbitrary points in the kernel that can have an affect on the code that
called it. Right now, we only have the ability to attach function calls
to these locations that have passive affects (tracing/profiling).

But you say, "nor do the calling sites care in general". Then what do
these calling sites do with the return code? Are we limiting these
actions to security only? Or can we have some other feature. I can
envision that we can make the Linux kernel quite dynamic here with "self
modifying code". That is, anywhere we have "hooks", perhaps we could
replace them with dynamic switches (jump labels). Maybe events would not
be the best use, but they could be a generic one.

Knowing what callback returned the result would be beneficial. Right
now, you are saying if the call back return anything, just abort the
call, not knowing what callback was called.

-- Steve
