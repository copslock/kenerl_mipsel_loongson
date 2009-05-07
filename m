Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2009 08:14:31 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:54512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024804AbZEGHOY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 May 2009 08:14:24 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n4773IcS017251;
	Thu, 7 May 2009 03:03:18 -0400
Received: from gateway.sf.frob.com (vpn-12-104.rdu.redhat.com [10.11.12.104])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4773Deq012280;
	Thu, 7 May 2009 03:03:16 -0400
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id 2405A357B; Thu,  7 May 2009 00:03:13 -0700 (PDT)
Received: by magilla.sf.frob.com (Postfix, from userid 5281)
	id DCC5EFC39E; Thu,  7 May 2009 00:03:12 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Roland McGrath <roland@redhat.com>
To:	=?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?= 
	<markus@google.com>
X-Fcc:	~/Mail/linus
Cc:	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
In-Reply-To: Markus Gutschke ( =?ISO-8859-1?Q?=E9=A1=A7=E5=AD=E5=A4?=)'s message of  Wednesday, 6 May 2009 14:46:02 -0700 <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	<20090506212913.GC4861@elte.hu>
	<904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20090507070312.DCC5EFC39E@magilla.sf.frob.com>
Date:	Thu,  7 May 2009 00:03:12 -0700 (PDT)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

> Ptrace has performance and/or reliability problems when used to
> sandbox threaded applications due to potential race conditions when
> inspecting system call arguments. We hope that we can avoid this
> problem with seccomp.

ptrace certainly has performance issues.  I take it the only "reliability
problems" you are talking about are MT races with modifications to user
memory that is relevant to a system call.  (Is there something else?)
That is not a "ptrace problem" per se at all.  It's an intrinsic problem
with any method based on "generic" syscall interception, if the filtering
and enforcement decisions depend on examining user memory.  By the same
token, no such method has a "reliability problem" if the filtering checks
only examine the registers (or other thread-synchronous state).

In the sense that I mean, seccomp is "generic syscall interception" too.
(That is, the checks/enforcement are "around" the call, rather than inside
it with direct atomicity controls binding the checks and uses together.)
The only reason seccomp does not have this "reliability problem" is that
its filtering is trivial and depends only on registers (in fact, only on
one register, the syscall number).

If you want to do checks that depend on shared or volatile state, then
syscall interception is really not the proper mechanism for you.  (Likely
examples include user memory, e.g. for file names in open calls, or ioctl
struct contents, etc., fd tables or filesystem details, etc.)  For that
you need mechanisms that look at stable kernel copies of user data that
are what the syscall will actually use, such as is done by audit, LSM, etc.

If you only have checks confined to thread-synchronous state such as the
user registers, then you don't have any "reliability problem" regardless
of the the particular syscall interception mechanism you use.  (ptrace has
many problems for this or any other purpose, but this is not one of them.)
That's unless you are referring to some other "reliability problem" that
I'm not aware of.  (And I'll leave aside the "is it registers or is it
user memory?" issue on ia64 as irrelevant, since, you know, it's ia64.)

If syscall interception is indeed an appropriate mechanism for your needs
and you want something tailored more specifically to your exact use in
future kernels, a module doing this would be easy to implement using the
utrace API.  (That might be a "compelling use" of utrace by virtue of the
Midas brand name effect, if nothing else. ;-)


Thanks,
Roland
