Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 19:03:56 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:45211 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491048Ab1EPRDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 19:03:53 +0200
X-Authority-Analysis: v=1.1 cv=u/eXSd3k4P+OuNmbl5aZU3ellt6eTxbOnGssQLT4hSY= c=1 sm=0 a=zw1CKeOhDhoA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=meVymXHHAAAA:8 a=qu7KTCGUqNwWotNdVIEA:9 a=2Gd5F0lVsVKXEtuiM40A:7 a=PUjeQqilurYA:10 a=jeBq3FmKZ4MA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:55545] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id DD/FC-28963-FE851DD4; Mon, 16 May 2011 17:03:46 +0000
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
In-Reply-To: <20110516165249.GB10929@elte.hu>
References: <1305289146.2466.8.camel@twins> <20110513122646.GA3924@elte.hu>
         <1305290370.2466.14.camel@twins> <1305290612.2466.17.camel@twins>
         <20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
         <20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
         <20110513145737.GC32688@elte.hu>
         <1305563026.5456.19.camel@gandalf.stny.rr.com>
         <20110516165249.GB10929@elte.hu>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 16 May 2011 13:03:42 -0400
Message-ID: <1305565422.5456.21.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> > way multiple callbacks can be registered. How would:
> > 
> > 	err = event_x();
> > 	if (err == -EACCESS) {
> > 
> > be handled? [...]
> 
> The default behavior would be something obvious: to trigger all callbacks and 
> use the first non-zero return value.


But how do we know which callback that was from? There's no ordering of
what callbacks are called first.

> 
> > [...] Would we need a way to prioritize which call back gets the return 
> > value? One way I guess would be to add a check_event option, where you pass 
> > in an ENUM of the event you want:
> > 
> > 	event_x();
> > 	err = check_event_x(MYEVENT);
> > 
> > If something registered itself as "MYEVENT" to event_x, then you get the 
> > return code of MYEVENT. If the MYEVENT was not registered, a -ENODEV or 
> > something could be returned. I'm sure we could even optimize it such a way if 
> > no active events have been registered to event_x, that check_event_x() will 
> > return -ENODEV without any branches.
> 
> I would keep it simple and extensible - that way we can complicate it when the 
> need arises! :)

The above is rather trivial to implement. I don't think it complicates
anything.

-- Steve
