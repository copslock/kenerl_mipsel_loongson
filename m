Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2009 09:01:34 +0100 (BST)
Received: from smtp-out.google.com ([216.239.33.17]:44475 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024856AbZEGIB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 May 2009 09:01:27 +0100
Received: from spaceape13.eur.corp.google.com (spaceape13.eur.corp.google.com [172.28.16.147])
	by smtp-out.google.com with ESMTP id n4781OXC004524
	for <linux-mips@linux-mips.org>; Thu, 7 May 2009 09:01:24 +0100
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1241683284; bh=FkwDFjbNTpPqDB7uxbxMXybST3k=;
	h=DomainKey-Signature:MIME-Version:In-Reply-To:References:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-System-Of-Record; b=hVr5TaDeNaC5mCWsdp
	WwoDU+5xcfid4V0LgYwQULxPAs9/r0Uv5mtID2MvzRka6cDoFKBPlLaUJu7/v89N8Fg
	Q==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=P9hY1gy9V71P4o+gsW8ZHu2QTENEskCMUgojNfS5D3b+yF9g44b7mZhHj26mNYShw
	yrYvmRzHwoz+FQ/IQSWcg==
Received: from yx-out-1718.google.com (yxh36.prod.google.com [10.190.2.228])
	by spaceape13.eur.corp.google.com with ESMTP id n4781MP6016609
	for <linux-mips@linux-mips.org>; Thu, 7 May 2009 01:01:22 -0700
Received: by yx-out-1718.google.com with SMTP id 36so1691288yxh.46
        for <linux-mips@linux-mips.org>; Thu, 07 May 2009 01:01:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.48.20 with SMTP id a20mr4062820ybk.91.1241683281796; Thu, 
	07 May 2009 01:01:21 -0700 (PDT)
In-Reply-To: <20090507070312.DCC5EFC39E@magilla.sf.frob.com>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	 <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	 <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	 <20090506212913.GC4861@elte.hu>
	 <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	 <20090507070312.DCC5EFC39E@magilla.sf.frob.com>
Date:	Thu, 7 May 2009 01:01:21 -0700
Message-ID: <904b25810905070101u5abad0dagf8642a6950b1911@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From:	=?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?= 
	<markus@google.com>
To:	Roland McGrath <roland@redhat.com>
Cc:	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
Return-Path: <markus@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus@google.com
Precedence: bulk
X-list: linux-mips

On Thu, May 7, 2009 at 00:03, Roland McGrath <roland@redhat.com> wrote:
>
> That is not a "ptrace problem" per se at all.  It's an intrinsic problem
> with any method based on "generic" syscall interception, if the filtering
> and enforcement decisions depend on examining user memory.

Yes, this is indeed the main problem that we are aware of. It can be
avoided by suspending all threads during user memory inspection, but
that's a horrible price to pay (also: see below for an alternative
approach, that could in principle be adapted to use with ptrace)

> The only reason seccomp does not have this "reliability problem" is that
> its filtering is trivial and depends only on registers (in fact, only on
> one register, the syscall number).

Simplicity is really the beauty of seccomp. It is very easy to verify
that it does the right thing from a security point of view, because
any attempt to call unsafe system calls results in the kernel
terminating the program. This is much preferable over most ptrace
solutions which is more difficult to audit for correctness.

The downside is that the sandbox'd code needs to delegate execution of
most of its system calls to a monitor process. This is slow and rather
awkward. Although due to the magic of clone(), (almost) all system
calls can in fact be serialized, sent to the monitor process, have
their arguments safely inspected, and then executed on behalf of the
sandbox'd process. Details are tedious but we believe they are
solvable with current kernel APIs.

The other issue is performance. For system calls that are known to be
safe, we would rather not pay the penalty of redirecting them. A
kernel patch that made seccomp more efficient for these system calls
would be very welcome, and we will post such a patch for discussion
shortly.

> If you want to do checks that depend on shared or volatile state, then
> syscall interception is really not the proper mechanism for you.

We agree that syscall interception is a poor abstraction level for a
sandbox. But in the short term, we need to work with the APIs that are
available in today's kernels. And we believe that seccomp is one of
the more promising API that are currently available to us.


Markus
