Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SFN6p13396
	for linux-mips-outgoing; Mon, 28 Jan 2002 07:23:06 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SFN3P13390
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 07:23:03 -0800
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16VCgM-0006nP-00; Mon, 28 Jan 2002 08:22:50 -0600
Message-ID: <3C556CC2.FD6EB35@cotw.com>
Date: Mon, 28 Jan 2002 09:22:42 -0600
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: A linuxthreads bug on mips?
References: <20020125234542.A31028@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> Here is a modified ex2.c which only uses one conditional variable. It
> works fine on x86. But it leads to dead lock on mips where both
> producer and consumer are suspended. Is this testcase correct?

H. J.,

I ran the program on the PC and a MIPS le NEC vr5432. It worked fine on
both machines.

I do not run the pthread library on the SGI site because it dead locks.
I rebuilt the pthread lib natively on my MIPS box and use that lib in
place of the lib provided in the RPM on the SGI site.
(I suspect it is a cross compilation problem rather than a problem in
the pthread lib.)

I believe others have also posted about deadlocks with the pthread lib
on the SGI site.

Scott
