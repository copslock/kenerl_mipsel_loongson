Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0JKgFm09284
	for linux-mips-outgoing; Sat, 19 Jan 2002 12:42:15 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0JKg7P09273
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 12:42:08 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B1608125C1; Sat, 19 Jan 2002 11:42:04 -0800 (PST)
Date: Sat, 19 Jan 2002 11:42:04 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: "Kevin D. Kissell" <kevink@mips.com>, Ulrich Drepper <drepper@redhat.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020119114204.A13939@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org> <01b801c1a081$3f6518e0$0deca8c0@Ulysses> <20020118201139.A847@lucon.org> <15433.26184.411289.161787@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15433.26184.411289.161787@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Sat, Jan 19, 2002 at 12:27:52PM +0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jan 19, 2002 at 12:27:52PM +0000, Dominic Sweetman wrote:
> 
> H . J . Lu (hjl@lucon.org) writes:
> 
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
> $0.  The kernel can write it through kseg0 or 64-bit equivalent, if
> you're a bit careful about cache aliases.

But it has to be a per thread value.

> 
> Reading something out of the cache is pretty cheap: would that be
> close enough to a 'register' to do the job?  There's no change to
> critical routines, that way.
> 

This is a patch against 2.4.16. Will this restore k1 to a known per
thread value?


H.J.
--- include/asm-mips/stackframe.h.thread	Wed Dec 12 12:34:53 2001
+++ include/asm-mips/stackframe.h	Sat Jan 19 11:36:38 2002
@@ -191,6 +191,7 @@ __asm__ (                               
 		lw	$2,  PT_R2(sp)
 
 #define RESTORE_SP_AND_RET                               \
+		lw	$27, PT_R27(sp);                 \
 		.set	push;				 \
 		.set	noreorder;			 \
 		lw	k0, PT_EPC(sp);                  \
@@ -229,6 +230,7 @@ __asm__ (                               
 		lw	$2,  PT_R2(sp)
 
 #define RESTORE_SP_AND_RET                               \
+		lw	$27, PT_R27(sp);                 \
 		lw	sp,  PT_R29(sp);                 \
 		.set	mips3;				 \
 		eret;					 \
@@ -237,6 +239,7 @@ __asm__ (                               
 #endif
 
 #define RESTORE_SP                                       \
+		lw	$27, PT_R27(sp);                 \
 		lw	sp,  PT_R29(sp);                 \
 
 #define RESTORE_ALL                                      \
