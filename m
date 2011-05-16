Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 14:03:42 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:39376 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491019Ab1EPMDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 14:03:35 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QLwVs-0003a4-T8
        from <mingo@elte.hu>; Mon, 16 May 2011 14:03:10 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 345163E250F; Mon, 16 May 2011 14:03:02 +0200 (CEST)
Date:   Mon, 16 May 2011 14:03:02 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Eric Paris <eparis@redhat.com>, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. PeterAnvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, kees.cook@canonical.com,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
        Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        agl@chromium.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 callfiltering
Message-ID: <20110516120302.GB7128@elte.hu>
References: <1305299880.2076.31.camel@localhost.localdomain>
 <AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
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
X-archive-position: 30037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* David Laight <David.Laight@ACULAB.COM> wrote:

> [...] unfortunately it worked by looking at the user-space buffers on system 
> call entry - and a multithreaded program can easily arrange to update them 
> after the initial check! [...]

Such problems of reliability/persistency of security checks is exactly one of 
my arguments why this should not be limited to the syscall boundary, if you 
read the example i have provided in this discussion.

Thanks,

	Ingo
