Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0JNKl412173
	for linux-mips-outgoing; Sat, 19 Jan 2002 15:20:47 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0JNKiP12169
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 15:20:44 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA00950;
	Sat, 19 Jan 2002 14:20:33 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA11521;
	Sat, 19 Jan 2002 14:20:28 -0800 (PST)
Message-ID: <002a01c1a137$a35340a0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Dominic Sweetman" <dom@algor.co.uk>, "H . J . Lu" <hjl@lucon.org>
Cc: "Ulrich Drepper" <drepper@redhat.com>,
   "GNU libc hacker" <libc-hacker@sources.redhat.com>,
   <linux-mips@oss.sgi.com>
References: <m3elkoa5dw.fsf@myware.mynet><20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020118201139.A847@lucon.org> <15433.26184.411289.161787@gladsmuir.algor.co.uk>
Subject: Re: thread-ready ABIs
Date: Sat, 19 Jan 2002 23:21:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > > It would, in principle, be possible to save/restore k0
> > > or k1 (but not both) if no other clever solution can be found.  
> > > There are other VM OSes that manage to do so for MIPS, 
> > > for other outside-the-old-ABI reasons.  It does, of course,
> > > add some instructions and some memory traffic to the 
> > > low-level exception handling , and we would have to look 
> > > at whether we would want to make such a feature standard 
> > > or specific to a "thread-ready" kernel build.
> > 
> > I like the read-only k0 idea. We just need to make a system call to
> > tell kernel what value to put in k0 before returning to the user space.
> > It shouldn't be too hard to implement. I will try it next week.
> 
> You could, I guess, wire a TLB entry to map the thread register into
> the highest virtual memory region of the machine (the top of 'kseg2'),
> which is accessible in a single instruction as a negative offset from
> $0.

Funny you should mention this.  I was thinking about it
yesterday in this context as something else that I've seen 
done in some non-Linux MIPS OSes, and something that 
I think would be a better solution for CPU-specific fast 
storage in SMP configurations than some of the hacks that
I've seen proposed for SMP MIPS/Linux so far.
