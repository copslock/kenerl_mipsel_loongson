Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 18:21:23 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:39758 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491171Ab1EXQVT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2011 18:21:19 +0200
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
        id 1QOuM1-0007jq-1z; Tue, 24 May 2011 16:21:09 +0000
Received: by twins (Postfix, from userid 1000)
        id 19A8881A7A39; Tue, 24 May 2011 18:20:28 +0200 (CEST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Drewry <wad@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
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
In-Reply-To: <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
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
         <1305807728.11267.25.camel@gandalf.stny.rr.com>
         <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
         <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Tue, 24 May 2011 18:20:27 +0200
Message-ID: <1306254027.18455.47.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
>  include/linux/ftrace_event.h  |    4 +-
>  include/linux/perf_event.h    |   10 +++++---
>  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
>  kernel/seccomp.c              |    8 ++++++
>  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
>  5 files changed, 82 insertions(+), 16 deletions(-) 

I strongly oppose to the perf core being mixed with any sekurity voodoo
(or any other active role for that matter).
