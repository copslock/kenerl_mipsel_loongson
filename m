Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2009 09:17:08 +0100 (BST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:23963 "EHLO mx3.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S20025957AbZDSIRC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 19 Apr 2009 09:17:02 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LvSCj-0001ve-Ew
	from <mingo@elte.hu>; Sun, 19 Apr 2009 10:16:58 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 8D02E3E2138; Sun, 19 Apr 2009 10:16:39 +0200 (CEST)
Date:	Sun, 19 Apr 2009 10:16:41 +0200
From:	Ingo Molnar <mingo@elte.hu>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Stephen Rothwell <sfr@canb.auug.org.au>,
	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>,
	Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: mips build failure
Message-ID: <20090419081641.GA23906@elte.hu>
References: <20090419172436.6d0e741a.sfr@canb.auug.org.au> <1240126361.3423.5.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1240126361.3423.5.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
X-archive-position: 22372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> On Sun, 2009-04-19 at 17:24 +1000, Stephen Rothwell wrote:
> > Hi Ralf,
> > 
> > You probably already now about this, but our build (mips ip32_defconfig)
> > of Linus' tree (commit aefe6475720bd5eb8aacbc881488f3aa65618562 "Merge
> > branch 'upstream-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev") gets
> > these errors (we have actually been getting these errors since 2.6.30-rc1):
> > 
> > In file included from arch/mips/include/asm/compat.h:7,
> >                  from include/linux/compat.h:15,
> >                  from arch/mips/kernel/asm-offsets.c:12:
> > include/linux/seccomp.h: In function 'prctl_get_seccomp':
> > include/linux/seccomp.h:30: error: 'EINVAL' undeclared (first use in this function)
> > include/linux/seccomp.h:30: error: (Each undeclared identifier is reported only once
> > include/linux/seccomp.h:30: error: for each function it appears in.)
> > include/linux/seccomp.h: In function 'prctl_set_seccomp':
> > include/linux/seccomp.h:35: error: 'EINVAL' undeclared (first use in this function)
> > 
> 
> perhaps you can fix it like this:
> 
> include/linux/seccomp.h
> 
>  22 #else /* CONFIG_SECCOMP */
>  23 
>  24 +#include <asm-generic/errno-base.h>
>  25 
>  26 typedef struct { } seccomp_t;
> 
> in reality, there is a previous email sent by Ralf for it:
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/0904.2/01152.html

Yes, that looks like the right kind of fix.

Ralf, will you push that fix upstream, or should i do it?

Thanks,

	Ingo
