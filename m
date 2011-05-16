Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 18:53:39 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:33874 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491041Ab1EPQxb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 18:53:31 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QM12N-000309-Bv
        from <mingo@elte.hu>; Mon, 16 May 2011 18:53:03 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 99C093E250F; Mon, 16 May 2011 18:52:48 +0200 (CEST)
Date:   Mon, 16 May 2011 18:52:49 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110516165249.GB10929@elte.hu>
References: <1305289146.2466.8.camel@twins>
 <20110513122646.GA3924@elte.hu>
 <1305290370.2466.14.camel@twins>
 <1305290612.2466.17.camel@twins>
 <20110513125452.GD3924@elte.hu>
 <1305292132.2466.26.camel@twins>
 <20110513131800.GA7883@elte.hu>
 <1305294935.2466.64.camel@twins>
 <20110513145737.GC32688@elte.hu>
 <1305563026.5456.19.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305563026.5456.19.camel@gandalf.stny.rr.com>
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
X-archive-position: 30050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> way multiple callbacks can be registered. How would:
> 
> 	err = event_x();
> 	if (err == -EACCESS) {
> 
> be handled? [...]

The default behavior would be something obvious: to trigger all callbacks and 
use the first non-zero return value.

> [...] Would we need a way to prioritize which call back gets the return 
> value? One way I guess would be to add a check_event option, where you pass 
> in an ENUM of the event you want:
> 
> 	event_x();
> 	err = check_event_x(MYEVENT);
> 
> If something registered itself as "MYEVENT" to event_x, then you get the 
> return code of MYEVENT. If the MYEVENT was not registered, a -ENODEV or 
> something could be returned. I'm sure we could even optimize it such a way if 
> no active events have been registered to event_x, that check_event_x() will 
> return -ENODEV without any branches.

I would keep it simple and extensible - that way we can complicate it when the 
need arises! :)

Thanks,

	Ingo
