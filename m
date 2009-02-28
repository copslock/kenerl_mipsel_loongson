Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2009 07:32:08 +0000 (GMT)
Received: from mx2.mail.elte.hu ([157.181.151.9]:55983 "EHLO mx2.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S20808938AbZB1HcG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Feb 2009 07:32:06 +0000
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LdJfy-00052B-3y
	from <mingo@elte.hu>; Sat, 28 Feb 2009 08:32:00 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id DD0843E2132; Sat, 28 Feb 2009 08:31:55 +0100 (CET)
Date:	Sat, 28 Feb 2009 08:31:54 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Roland McGrath <roland@redhat.com>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-ID: <20090228073154.GG9351@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com> <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
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
X-archive-position: 21982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Roland McGrath <roland@redhat.com> wrote:

> +#ifdef CONFIG_COMPAT
> +		if (is_compat_task())
>  			syscall = mode1_syscalls_32;
>  #endif

btw., shouldnt is_compat_task() expand to 0 in the 
!CONFIG_COMPAT case? That way we could remove this #ifdef too. 
(and move the first #ifdef inside the array initialization so 
that we always have a mode1_syscalls_32[] array.)

	Ingo
