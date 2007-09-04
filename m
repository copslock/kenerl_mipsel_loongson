Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 11:21:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28049 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024674AbXIDKVs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 11:21:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l84ALkDF023853;
	Tue, 4 Sep 2007 11:21:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l84ALj8C023852;
	Tue, 4 Sep 2007 11:21:45 +0100
Date:	Tue, 4 Sep 2007 11:21:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc:	Adrian Bunk <bunk@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: 2.6.23-rc4-mm1: mips compile error
Message-ID: <20070904102144.GA23736@linux-mips.org>
References: <20070831215822.26e1432b.akpm@linux-foundation.org> <20070901154441.GJ9260@stusta.de> <20070904052734.GA2991@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070904052734.GA2991@Krystal>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 04, 2007 at 01:27:34AM -0400, Mathieu Desnoyers wrote:

> >   CC      arch/mips/kernel/asm-offsets.s
> > In file included from include2/asm/processor.h:22,
> >                  from include2/asm/thread_info.h:15,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/thread_info.h:21,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/preempt.h:9,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/spinlock.h:49,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/seqlock.h:29,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/time.h:8,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/timex.h:57,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/include/linux/sched.h:52,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.23-rc4-mm1/arch/mips/kernel/asm-offsets.c:13:
> > include2/asm/system.h:415:39: error: asm-generic/cmpxchg-local.h: No such file or directory
> > make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
> > 
> > <--  snip  -->
> > 
> 
> Hello,
> 
> It is because
> "Add cmpxchg64 and cmpxchg64_local to mips" has been added to the
> git-mips.patch, but it depends on 
> "add-cmpxchg-local-to-generic-for-up.patch" which is not merged yet.
> 
> It was an error in my series file.
> add-cmpxchg-local-to-generic-for-up.patch should come before these
> patches:
> 
> i386-cmpxchg64-80386-80486-fallback.patch
> add-cmpxchg64-to-alpha.patch
> add-cmpxchg64-to-mips.patch
> add-cmpxchg64-to-powerpc.patch
> add-cmpxchg64-to-x86_64.patch

I had add-cmpxchg64-to-mips.patch queued myself also but removed it a few
days ago, so next -mm (if it's not out yet?) should be ok again.

  Ralf
