Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 22:14:43 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:33736 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab1EXUOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2011 22:14:35 +0200
X-Authority-Analysis: v=1.1 cv=u/eXSd3k4P+OuNmbl5aZU3ellt6eTxbOnGssQLT4hSY= c=1 sm=0 a=zw1CKeOhDhoA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=cm27Pg_UAAAA:8 a=Nhl_-d5xMr2zQsrJhTsA:9 a=PUjeQqilurYA:10 a=zv9_9hqRWm8A:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:59733] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id C4/C9-28963-E911CDD4; Tue, 24 May 2011 20:14:27 +0000
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     Will Drewry <wad@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20110524200815.GD27634@elte.hu>
References: <1305563026.5456.19.camel@gandalf.stny.rr.com>
         <20110516165249.GB10929@elte.hu>
         <1305565422.5456.21.camel@gandalf.stny.rr.com>
         <20110517124212.GB21441@elte.hu>
         <1305637528.5456.723.camel@gandalf.stny.rr.com>
         <20110517131902.GF21441@elte.hu>
         <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
         <1305807728.11267.25.camel@gandalf.stny.rr.com>
         <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
         <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
         <20110524200815.GD27634@elte.hu>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 24 May 2011 16:14:22 -0400
Message-ID: <1306268062.1465.79.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Tue, 2011-05-24 at 22:08 +0200, Ingo Molnar wrote:
> * Will Drewry <wad@chromium.org> wrote:

> But there could be a perf_tp_event_ret() or perf_tp_event_check() entry that 
> code like seccomp which wants to use event results can use.

We should name it something else. The "perf_tp.." is a misnomer as it
has nothing to do with performance monitoring. "dynamic_event_.." maybe,
as it is dynamic to the affect that we can use jump labels to enable or
disable it.

-- Steve
