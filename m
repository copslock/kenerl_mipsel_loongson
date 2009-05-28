Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 15:46:16 +0100 (BST)
Received: from www.tglx.de ([62.245.132.106]:46897 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024466AbZE1OqJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 May 2009 15:46:09 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id n4SEjbUG023045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2009 16:45:38 +0200
Date:	Thu, 28 May 2009 16:45:37 +0200 (CEST)
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Steven Rostedt <rostedt@goodmis.org>
cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Mc Guire <der.herr@hofr.at>, wuzj@lemote.com
Subject: Re: [PATCH] mips-specific ftrace support
In-Reply-To: <alpine.DEB.2.00.0905280948410.27708@gandalf.stny.rr.com>
Message-ID: <alpine.LFD.2.00.0905281644210.3397@localhost.localdomain>
References: <73465d64a9a6773936f5eab3735a69f651c13187.1243458732.git.wuzj@lemote.com> <alpine.DEB.2.00.0905280948410.27708@gandalf.stny.rr.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.93.2/9397/Wed May 27 16:48:50 2009 on www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Thu, 28 May 2009, Steven Rostedt wrote:
> On Thu, 28 May 2009, wuzhangjin@gmail.com wrote:
> Could you possibly break this patch up into porting the tracers one by 
> one. That is:
> 
> First patch: make function tracing work.
> Second patch: make dynamic tracing work.
> Third patch: add Function graph tracing.
> Forth patch: the time stamp updates
> 
> This would make things a lot easier to review, and if one of the changes 
> breaks something, it will be easier to bisect.

> >  include/linux/clocksource.h    |    4 +-
> >  kernel/sched_clock.c           |    2 +-
> >  kernel/trace/ring_buffer.c     |    3 +-
> >  kernel/trace/trace_clock.c     |    2 +-
> >  scripts/Makefile.build         |    1 +
> >  scripts/recordmcount.pl        |   31 +++-

The changes to these generic files need to be separate as well.

Thanks,

	tglx
