Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 22:56:28 +0100 (BST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:43915 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024638AbZEFV4W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 May 2009 22:56:22 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1M1p4p-0003wl-Jl
	from <mingo@elte.hu>; Wed, 06 May 2009 23:55:06 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id D45DC3E213A; Wed,  6 May 2009 23:54:49 +0200 (CEST)
Date:	Wed, 6 May 2009 23:54:50 +0200
From:	Ingo Molnar <mingo@elte.hu>
To:	Markus Gutschke =?utf-8?B?KOmhp+Wtn+WLpCk=?= <markus@google.com>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-ID: <20090506215450.GA9537@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com> <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain> <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com> <20090506212913.GC4861@elte.hu> <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Markus Gutschke (顧孟勤) <markus@google.com> wrote:

> On Wed, May 6, 2009 at 14:29, Ingo Molnar <mingo@elte.hu> wrote:
> > That's a pretty interesting usage. What would be fallback mode you
> > are using if the kernel doesnt have seccomp built in? Completely
> > non-sandboxed? Or a ptrace/PTRACE_SYSCALL based sandbox?
> 
> Ptrace has performance and/or reliability problems when used to 
> sandbox threaded applications due to potential race conditions 
> when inspecting system call arguments. We hope that we can avoid 
> this problem with seccomp. It is very attractive that kernel 
> automatically terminates any application that violates the very 
> well-defined constraints of the sandbox.
> 
> In general, we are currently exploring different options based on 
> general availability, functionality, and complexity of 
> implementation. Seccomp is a good middle ground that we expect to 
> be able to use in the medium term to provide an acceptable 
> solution for a large segment of Linux users. Although the 
> restriction to just four unfiltered system calls is painful.

Which other system calls would you like to use? Futexes might be 
one, for fast synchronization primitives?

	Ingo
