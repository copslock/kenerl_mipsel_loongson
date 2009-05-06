Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 23:08:52 +0100 (BST)
Received: from smtp-out.google.com ([216.239.33.17]:11454 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024642AbZEFWIp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 23:08:45 +0100
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id n46M8g3c005623
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 23:08:43 +0100
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1241647723; bh=q3P0kMXFVVxLh7ZNuwYdy7EIE+k=;
	h=DomainKey-Signature:MIME-Version:In-Reply-To:References:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-System-Of-Record; b=TlBgcpgBi95ZWXAhCM
	IzZBbmngXlwoje0QNvesG4mLw8SaO3zsZwzTMwrpPbA/lQq7PIm0Y+uHEns31BN9wLc
	g==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=vlN1f6ehSs9cEwxJIcryrg1ZvM3s5THr1qvhnwCH9IuXHG8TjGtLY7bkTYDBI1BID
	joWhjdHK2OntygxxjM+gw==
Received: from yx-out-2324.google.com (yxl31.prod.google.com [10.190.3.223])
	by zps78.corp.google.com with ESMTP id n46M8fg1009357
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 15:08:41 -0700
Received: by yx-out-2324.google.com with SMTP id 31so195680yxl.79
        for <linux-mips@linux-mips.org>; Wed, 06 May 2009 15:08:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.128.11 with SMTP id f11mr3179422ybn.107.1241647721001; 
	Wed, 06 May 2009 15:08:41 -0700 (PDT)
In-Reply-To: <20090506215450.GA9537@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	 <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	 <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	 <20090506212913.GC4861@elte.hu>
	 <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	 <20090506215450.GA9537@elte.hu>
Date:	Wed, 6 May 2009 15:08:40 -0700
Message-ID: <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From:	=?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?= 
	<markus@google.com>
To:	Ingo Molnar <mingo@elte.hu>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-System-Of-Record: true
Return-Path: <markus@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus@google.com
Precedence: bulk
X-list: linux-mips

On Wed, May 6, 2009 at 14:54, Ingo Molnar <mingo@elte.hu> wrote:
> Which other system calls would you like to use? Futexes might be
> one, for fast synchronization primitives?

There are a large number of system calls that "normal" C/C++ code uses
quite frequently, and that are not security sensitive. A typical
example would be gettimeofday(). But there are other system calls,
where the sandbox would not really need to inspect arguments as the
call does not expose any exploitable interface.

It is currently awkward that in order to use seccomp we have to
intercept all system calls and provide alternative implementations for
them; whereas we really only care about a comparatively small number
of security critical operations that we need to restrict.

Also, any redirected system call ends up incurring at least two
context switches, which is needlessly expensive for the large number
of trivial system calls. We are quite happy that read() and write(),
which are quite important to us, do not incur this penalty.


Markus
