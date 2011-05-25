Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2011 19:44:27 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:58084 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491192Ab1EYRoU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2011 19:44:20 +0200
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
        id 1QPI7q-0005jP-VE; Wed, 25 May 2011 17:44:07 +0000
Received: by twins (Postfix, from userid 1000)
        id 2B29881BF4B4; Wed, 25 May 2011 19:43:23 +0200 (CEST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Drewry <wad@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20110525150153.GE29179@elte.hu>
References: <20110517124212.GB21441@elte.hu>
         <1305637528.5456.723.camel@gandalf.stny.rr.com>
         <20110517131902.GF21441@elte.hu>
         <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
         <1305807728.11267.25.camel@gandalf.stny.rr.com>
         <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
         <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
         <1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
         <alpine.LFD.2.02.1105242239230.3078@ionos> <20110525150153.GE29179@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Wed, 25 May 2011 19:43:22 +0200
Message-ID: <1306345402.21578.100.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Wed, 2011-05-25 at 17:01 +0200, Ingo Molnar wrote:
> > We do _NOT_ make any decision based on the trace point so what's the
> > "pre-existing" active role in the syscall entry code?
> 
> The seccomp code we are discussing in this thread. 

That isn't pre-existing, that's proposed.

But face it, you can argue until you're blue in the face, but both tglx
and I will NAK any and all patches that extend perf/ftrace beyond the
passive observing role.

Your arguments appear to be as non-persuasive to us as ours are to you,
so please drop this endeavor and let the security folks sort it on their
own and let's get back to doing useful work. 
