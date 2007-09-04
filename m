Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 06:29:30 +0100 (BST)
Received: from tomts36.bellnexxia.net ([209.226.175.93]:18574 "EHLO
	tomts36-srv.bellnexxia.net") by ftp.linux-mips.org with ESMTP
	id S20022527AbXIDF3W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 06:29:22 +0100
Received: from krystal.dyndns.org ([76.65.103.147])
          by tomts36-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20070904052735.LYMD7033.tomts36-srv.bellnexxia.net@krystal.dyndns.org>;
          Tue, 4 Sep 2007 01:27:35 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by krystal.dyndns.org with local; Tue, 04 Sep 2007 01:27:34 -0400
  id 002FDF1D.46DCECC6.00000CF0
Date:	Tue, 4 Sep 2007 01:27:34 -0400
From:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: 2.6.23-rc4-mm1: mips compile error
Message-ID: <20070904052734.GA2991@Krystal>
References: <20070831215822.26e1432b.akpm@linux-foundation.org> <20070901154441.GJ9260@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20070901154441.GJ9260@stusta.de>
X-Editor: vi
X-Info:	http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.6.21.3-grsec (i686)
X-Uptime: 01:22:29 up 36 days,  5:41,  4 users,  load average: 2.22, 1.58, 1.29
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <compudj@krystal.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@polymtl.ca
Precedence: bulk
X-list: linux-mips

* Adrian Bunk (bunk@kernel.org) wrote:
> On Fri, Aug 31, 2007 at 09:58:22PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.23-rc3-mm1:
> >...
> >  git-mips.patch
> >...
> >  git trees
> >...
> 
> <--  snip  -->
> 
> ...
>   CC      arch/mips/kernel/asm-offsets.s
> In file included from include2/asm/processor.h:22,
>                  from include2/asm/thread_info.h:15,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/thread_info.h:21,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/preempt.h:9,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/spinlock.h:49,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/seqlock.h:29,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/time.h:8,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/timex.h:57,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/sched.h:52,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/arch/mips/kernel/asm-offsets.c:13:
> include2/asm/system.h:415:39: error: asm-generic/cmpxchg-local.h: No such file or directory
> make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
> 
> <--  snip  -->
> 

Hello,

It is because
"Add cmpxchg64 and cmpxchg64_local to mips" has been added to the
git-mips.patch, but it depends on 
"add-cmpxchg-local-to-generic-for-up.patch" which is not merged yet.

It was an error in my series file.
add-cmpxchg-local-to-generic-for-up.patch should come before these
patches:

i386-cmpxchg64-80386-80486-fallback.patch
add-cmpxchg64-to-alpha.patch
add-cmpxchg64-to-mips.patch
add-cmpxchg64-to-powerpc.patch
add-cmpxchg64-to-x86_64.patch


Mathieu

> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
