Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBE5CPm13108
	for linux-mips-outgoing; Thu, 13 Dec 2001 21:12:25 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBE5CLo13104
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 21:12:21 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id UAA96483;
	Thu, 13 Dec 2001 20:12:11 -0800 (PST)
Date: Thu, 13 Dec 2001 20:12:10 -0800
From: Geoffrey Espin <espin@idiom.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: No bzImage target for MIPS
Message-ID: <20011213201210.A86040@idiom.com>
References: <20011213192846.A36207@idiom.com> <1901.1008301881@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <1901.1008301881@kao2.melbourne.sgi.com>; from Keith Owens on Fri, Dec 14, 2001 at 02:51:21PM +1100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith,

On Fri, Dec 14, 2001 at 02:51:21PM +1100, Keith Owens wrote:
> >#include "../../../fs/jffs2/zlib.c" /**/
> >#include "../../../lib/ctype.c"
> I am phasing out the practice of ../ in kernel include paths.  It is
> much better to do
> #include "zlib.c"
> #include "ctype.c"
> and the Makefile adds -I$(TOPDIR)/fs/jffs2 -I$(TOPDIR)/lib.  Then when

I'll check around the tree.  Doesn't matter to me.  Both have crappy
implications.  I hate it when -I's pile up... and you don't know which
directory takes precedence (esp. if there are duplicate names).

> >TOPDIR          = ../../..
> TOPDIR := $(shell cd ../../..; /bin/pwd)
> is better, it returns an absolute path instead of a relative one.

Hmmm, okay.  I probably shouldn't even have this macro.
I had hacked things earlier so I didn't have to run 'make' from linux/.

Thanks for the quick feedback, mate!

[I'll spare someone pointing out that I should have tried to use
linux/lib/vsprintf.c.  Missed it!  What a newbie.]

Geoff
-- 
Geoffrey Espin
espin@idiom.com
