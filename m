Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 23:14:35 +0100 (BST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:32898 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024640AbZEFWO3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 May 2009 23:14:29 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1M1pMg-0006Tj-MO
	from <mingo@elte.hu>; Thu, 07 May 2009 00:13:22 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 963383E213A; Thu,  7 May 2009 00:13:19 +0200 (CEST)
Date:	Thu, 7 May 2009 00:13:19 +0200
From:	Ingo Molnar <mingo@elte.hu>
To:	Markus Gutschke =?utf-8?B?KOmhp+Wtn+WLpCk=?= <markus@google.com>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-ID: <20090506221319.GA11493@elte.hu>
References: <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain> <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com> <20090506212913.GC4861@elte.hu> <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com> <20090506215450.GA9537@elte.hu> <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Markus Gutschke (顧孟勤) <markus@google.com> wrote:

> On Wed, May 6, 2009 at 14:54, Ingo Molnar <mingo@elte.hu> wrote:
> > Which other system calls would you like to use? Futexes might be
> > one, for fast synchronization primitives?
> 
> There are a large number of system calls that "normal" C/C++ code 
> uses quite frequently, and that are not security sensitive. A 
> typical example would be gettimeofday(). But there are other 
> system calls, where the sandbox would not really need to inspect 
> arguments as the call does not expose any exploitable interface.
> 
> It is currently awkward that in order to use seccomp we have to 
> intercept all system calls and provide alternative implementations 
> for them; whereas we really only care about a comparatively small 
> number of security critical operations that we need to restrict.
> 
> Also, any redirected system call ends up incurring at least two 
> context switches, which is needlessly expensive for the large 
> number of trivial system calls. We are quite happy that read() and 
> write(), which are quite important to us, do not incur this 
> penalty.

doing a (per arch) bitmap of harmless syscalls and replacing the 
mode1_syscalls[] check with that in kernel/seccomp.c would be a 
pretty reasonable extension. (.config controllable perhaps, for 
old-style-seccomp)

It would probably be faster than the current loop over 
mode1_syscalls[] as well.

	Ingo
