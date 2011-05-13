Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:23:23 +0200 (CEST)
Received: from bombadil.infradead.org ([18.85.46.34]:39022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491839Ab1EMPXS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 17:23:18 +0200
Received: from canuck.infradead.org ([134.117.69.58])
        by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
        id 1QKuCn-0000Wn-Nt; Fri, 13 May 2011 15:23:05 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1QKuCm-0003aV-FW; Fri, 13 May 2011 15:23:04 +0000
Received: by twins (Postfix, from userid 1000)
        id 0C1DC8130A56; Fri, 13 May 2011 17:23:02 +0200 (CEST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Paris <eparis@redhat.com>
Cc:     Ingo Molnar <mingo@elte.hu>, James Morris <jmorris@namei.org>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        kees.cook@canonical.com, agl@chromium.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <1305299455.2076.26.camel@localhost.localdomain>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
         <1305169376-2363-1-git-send-email-wad@chromium.org>
         <20110512074850.GA9937@elte.hu>
         <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
         <20110512130104.GA2912@elte.hu>
         <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
         <20110513121034.GG21022@elte.hu>
         <1305299455.2076.26.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Fri, 13 May 2011 17:23:01 +0200
Message-ID: <1305300181.2466.72.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Fri, 2011-05-13 at 11:10 -0400, Eric Paris wrote:
> Then again, I certainly don't see a
> reason that this syscall hardening patch should be held up while a whole
> new concept in computer security is contemplated... 

Which makes me wonder why this syscall hardening stuff is done outside
of LSM? Why isn't is part of the LSM so that say SELinux can have a
syscall bitmask per security context?

Making it part of the LSM also avoids having to add this prctl().
