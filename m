Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 14:22:25 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:32976 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490977Ab1ESMWV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2011 14:22:21 +0200
X-Authority-Analysis: v=1.1 cv=u/eXSd3k4P+OuNmbl5aZU3ellt6eTxbOnGssQLT4hSY= c=1 sm=0 a=zw1CKeOhDhoA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=96LpcRIPPE6gtVX9q74A:9 a=PUjeQqilurYA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:60239] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id BC/7E-28963-07B05DD4; Thu, 19 May 2011 12:22:14 +0000
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Drewry <wad@chromium.org>
Cc:     Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
References: <20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
         <20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
         <20110513145737.GC32688@elte.hu>
         <1305563026.5456.19.camel@gandalf.stny.rr.com>
         <20110516165249.GB10929@elte.hu>
         <1305565422.5456.21.camel@gandalf.stny.rr.com>
         <20110517124212.GB21441@elte.hu>
         <1305637528.5456.723.camel@gandalf.stny.rr.com>
         <20110517131902.GF21441@elte.hu>
         <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 19 May 2011 08:22:08 -0400
Message-ID: <1305807728.11267.25.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Wed, 2011-05-18 at 21:07 -0700, Will Drewry wrote:

> Do event_* that return non-void exist in the tree at all now?  I've
> looked at the various tracepoint macros as well as some of the other
> handlers (trace_function, perf_tp_event, etc) and I'm not seeing any
> places where a return value is honored nor could be.  At best, the
> perf_tp_event can be short-circuited it in the hlist_for_each, but
> it'd still need a way to bubble up a failure and result in not calling
> the trace/event that the hook precedes.

No, none of the current trace hooks have return values. That was what I
was talking about how to implement in my previous emails.

-- Steve
