Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 15:48:50 +0100 (BST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:64906 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023106AbZE1Osm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 15:48:42 +0100
Received: from gandalf ([74.67.89.75]) by hrndva-omta03.mail.rr.com
          with ESMTP
          id <20090528144836171.KZBL11340@hrndva-omta03.mail.rr.com>;
          Thu, 28 May 2009 14:48:36 +0000
Date:	Thu, 28 May 2009 10:48:35 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	Thomas Gleixner <tglx@linutronix.de>
cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Mc Guire <der.herr@hofr.at>, wuzj@lemote.com
Subject: Re: [PATCH] mips-specific ftrace support
In-Reply-To: <alpine.LFD.2.00.0905281644210.3397@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.0905281048130.24399@gandalf.stny.rr.com>
References: <73465d64a9a6773936f5eab3735a69f651c13187.1243458732.git.wuzj@lemote.com> <alpine.DEB.2.00.0905280948410.27708@gandalf.stny.rr.com> <alpine.LFD.2.00.0905281644210.3397@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


On Thu, 28 May 2009, Thomas Gleixner wrote:
> > >  include/linux/clocksource.h    |    4 +-
> > >  kernel/sched_clock.c           |    2 +-
> > >  kernel/trace/ring_buffer.c     |    3 +-
> > >  kernel/trace/trace_clock.c     |    2 +-
> > >  scripts/Makefile.build         |    1 +
> > >  scripts/recordmcount.pl        |   31 +++-
> 
> The changes to these generic files need to be separate as well.

Acked

-- Steve
