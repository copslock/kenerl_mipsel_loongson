Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 May 2011 08:43:12 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.8]:50079 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490968Ab1EOGnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 May 2011 08:43:07 +0200
Received: from klappe2.localnet (p549B631F.dip.t-dialin.net [84.155.99.31])
        by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
        id 0Lq2eS-1Pqoym1s36-00djcI; Sun, 15 May 2011 08:42:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call filtering
Date:   Sun, 15 May 2011 08:42:07 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.37; KDE/4.3.2; x86_64; ; )
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
References: <1304017638.18763.205.camel@gandalf.stny.rr.com> <201105132135.34741.arnd@arndb.de> <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
In-Reply-To: <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201105150842.07816.arnd@arndb.de>
X-Provags-ID: V02:K0:f4usqFz+G2Xqqw3c1bGJjp2l0I10M0PtSCwf08A10C3
 dx8gg30BDFrUg25Zlxruy2alsaOTN253cct9LuvJHr3QlRxxOf
 HHiXuuQsTNuXU7frNKvCLFJpiFISkc794o216MZOrKHJw2L/uD
 ustEekVp0LftEE/5gfUhR41eOonRjrZAR9LjK1WHKqRG+edjL+
 4R0lBjje++DALexouIO6A==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips

On Saturday 14 May 2011, Will Drewry wrote:
> Depending on integration, it could even be limited to ioctl commands
> that are appropriate to a known fd if the fd is opened prior to
> entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
> with a filter of "1" then narrowed through a later addition of
> something like "(fd == %u && (cmd == %u || cmd == %u))" or something
> along those lines.
> 
> Does that make sense?

Thanks for the explanation. This sounds like it's already doing all
we need.

	Arnd
