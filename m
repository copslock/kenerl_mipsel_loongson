Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0JJ0Dq07949
	for linux-mips-outgoing; Sat, 19 Jan 2002 11:00:13 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0JJ08P07939
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 11:00:08 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0JHxst28110;
	Sat, 19 Jan 2002 17:59:54 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.2/8.11.2) id g0JCRqv01223;
	Sat, 19 Jan 2002 12:27:52 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15433.26184.411289.161787@gladsmuir.algor.co.uk>
Date: Sat, 19 Jan 2002 12:27:52 +0000
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Kevin D. Kissell" <kevink@mips.com>, Ulrich Drepper <drepper@redhat.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <20020118201139.A847@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet>
	<20020118101908.C23887@lucon.org>
	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
	<20020118201139.A847@lucon.org>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


H . J . Lu (hjl@lucon.org) writes:

> > It would, in principle, be possible to save/restore k0
> > or k1 (but not both) if no other clever solution can be found.  
> > There are other VM OSes that manage to do so for MIPS, 
> > for other outside-the-old-ABI reasons.  It does, of course,
> > add some instructions and some memory traffic to the 
> > low-level exception handling , and we would have to look 
> > at whether we would want to make such a feature standard 
> > or specific to a "thread-ready" kernel build.
> 
> I like the read-only k0 idea. We just need to make a system call to
> tell kernel what value to put in k0 before returning to the user space.
> It shouldn't be too hard to implement. I will try it next week.

You could, I guess, wire a TLB entry to map the thread register into
the highest virtual memory region of the machine (the top of 'kseg2'),
which is accessible in a single instruction as a negative offset from
$0.  The kernel can write it through kseg0 or 64-bit equivalent, if
you're a bit careful about cache aliases.

Reading something out of the cache is pretty cheap: would that be
close enough to a 'register' to do the job?  There's no change to
critical routines, that way.

Dominic Sweetman
Algorithmics Ltd.
