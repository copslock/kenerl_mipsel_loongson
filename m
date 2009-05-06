Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 23:22:03 +0100 (BST)
Received: from smtp-out.google.com ([216.239.45.13]:5765 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024646AbZEFWV4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 23:21:56 +0100
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id n46MLr8x002865
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 15:21:53 -0700
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1241648513; bh=s5W7Tl6ctMCyFetY68PouBorUZ8=;
	h=DomainKey-Signature:MIME-Version:In-Reply-To:References:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-System-Of-Record; b=YTEp78vrxCd44OO1/5
	JEextSu6F9sXsu3H85yYYUIs0OsBYoiumy5GWowKyd5CsYBYVII5OCdMMZqH2zt7Qrg
	g==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=K0JOaFQUASKXjiCsQ1IaavIg0qPM1ofMrO8Feot/eWlulMbteumNNp6G8H/BqF0By
	uZLZe0mvX2PzjYz4IIzBQ==
Received: from gxk20 (gxk20.prod.google.com [10.202.11.20])
	by zps78.corp.google.com with ESMTP id n46MLYJ4021903
	for <linux-mips@linux-mips.org>; Wed, 6 May 2009 15:21:52 -0700
Received: by gxk20 with SMTP id 20so838090gxk.14
        for <linux-mips@linux-mips.org>; Wed, 06 May 2009 15:21:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.139.1 with SMTP id r1mr3172911ybn.137.1241648511534; Wed, 
	06 May 2009 15:21:51 -0700 (PDT)
In-Reply-To: <20090506221319.GA11493@elte.hu>
References: <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	 <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	 <20090506212913.GC4861@elte.hu>
	 <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	 <20090506215450.GA9537@elte.hu>
	 <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
	 <20090506221319.GA11493@elte.hu>
Date:	Wed, 6 May 2009 15:21:51 -0700
Message-ID: <904b25810905061521v62b3ddd6l14deb614d203385a@mail.gmail.com>
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
X-archive-position: 22654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus@google.com
Precedence: bulk
X-list: linux-mips

On Wed, May 6, 2009 at 15:13, Ingo Molnar <mingo@elte.hu> wrote:
> doing a (per arch) bitmap of harmless syscalls and replacing the
> mode1_syscalls[] check with that in kernel/seccomp.c would be a
> pretty reasonable extension. (.config controllable perhaps, for
> old-style-seccomp)
>
> It would probably be faster than the current loop over
> mode1_syscalls[] as well.

This would be a great option to improve performance of our sandbox. I
can detect the availability of the new kernel API dynamically, and
then not intercept the bulk of the system calls. This would allow the
sandbox to work both with existing and with newer kernels.

We'll post a kernel patch for discussion in the next few days,


Markus
