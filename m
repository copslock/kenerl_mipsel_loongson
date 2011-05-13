Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2011 22:35:29 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:55754 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab1ENUfY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 May 2011 22:35:24 +0200
Received: from klappe2.localnet (p5B229A80.dip.t-dialin.net [91.34.154.128])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0LpRkv-1Ppb990wJJ-00epDK; Sat, 14 May 2011 22:33:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call filtering
Date:   Fri, 13 May 2011 21:35:34 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.37; KDE/4.3.2; x86_64; ; )
Cc:     Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
        jmorris@namei.org, Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@elte.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        microblaze-uclinux@itee.uq.edu.au,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
        Roland McGrath <roland@redhat.com>,
        Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
        linuxppc-dev@lists.ozlabs.org, Oleg Nesterov <oleg@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        agl@chromium.org, "David S. Miller" <davem@davemloft.net>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com> <1305169376-2363-1-git-send-email-wad@chromium.org>
In-Reply-To: <1305169376-2363-1-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201105132135.34741.arnd@arndb.de>
X-Provags-ID: V02:K0:imCGCTPCS00AcR4n08q2vLItxEsqDe7oOxPcsVf5hAr
 YTG7UHbK99DiquM5IGvf5AQFbi64spCGfpFpGMmaAPX+BdWLfo
 tmqIsrhFbjZKtCezM0hl6AAxUR7h5djdja1zhauUUWkAkDYoJG
 dU5/lEytX8sDToXn3dEiPKkgnbLJVbZW8QS6MpymWZj0rKGpJL
 KiAasm+o2USftMEoNOQtg==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips

On Thursday 12 May 2011, Will Drewry wrote:
> This change adds a new seccomp mode based on the work by
> agl@chromium.org in [1]. This new mode, "filter mode", provides a hash
> table of seccomp_filter objects.  When in the new mode (2), all system
> calls are checked against the filters - first by system call number,
> then by a filter string.  If an entry exists for a given system call and
> all filter predicates evaluate to true, then the task may proceed.
> Otherwise, the task is killed (as per seccomp_mode == 1).

I've got a question about this: Do you expect the typical usage to disallow
ioctl()? Given that ioctl alone is responsible for a huge number of exploits
in various drivers, while certain ioctls are immensely useful (FIONREAD,
FIOASYNC, ...), do you expect to extend the mechanism to filter specific
ioctl commands in the future?

	Arnd
