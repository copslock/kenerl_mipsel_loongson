Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0KKJNu29157
	for linux-mips-outgoing; Sun, 20 Jan 2002 12:19:23 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0KKJFP29147
	for <linux-mips@oss.sgi.com>; Sun, 20 Jan 2002 12:19:16 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D46F2125C0; Sun, 20 Jan 2002 11:19:12 -0800 (PST)
Date: Sun, 20 Jan 2002 11:19:12 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Machida Hiroyuki <machida@sm.sony.co.jp>, drepper@redhat.com,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020120111912.A6918@lucon.org>
References: <20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020118201139.A847@lucon.org> <20020120193843M.machida@sm.sony.co.jp> <002c01c1a1a9$b9f0de40$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002c01c1a1a9$b9f0de40$0deca8c0@Ulysses>; from kevink@mips.com on Sun, Jan 20, 2002 at 12:58:00PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jan 20, 2002 at 12:58:00PM +0100, Kevin D. Kissell wrote:
> > > I like the read-only k0 idea. We just need to make a system call to
> > > tell kernel what value to put in k0 before returning to the user space.
> > > It shouldn't be too hard to implement. I will try it next week.
> > > 
> > > H.J.
> > 
> > Please don't use k1, we already use k1 to implement fast
> > test-and-set method for MIPS1 machine.  We plan to mereg
> > the method into main glibc and kernel tree.
> 
> I don't read Japanese, but I've worked on similar
> methods for semaphores using k1, so I can guess
> roughly what you've done.   We'll have to be very
> careful if we want to have both a thread-register
> extended ABI *and* this approach to semaphores.
> The TLB miss handler must inevitably destroy one
> or the other of k0/k1, though it can avoid destroying
> both.  Thus the merge of thread-register+semaphore
> must not require that both be preserved on an
> arbitrary memory reference.  That may or may not
> be possible, so it would be good if you guys at
> Sony could post your code ASAP so we can see
> what can and cannot be merged.

As I understand, we don't need k1 based semaphore for MIPS II or above.
So many processors can still benefit from the thread register. We can
use a system call to implement loading a thread register. So it is
a trade off between system-call/k1 for thread-register/semaphore. We
can make it a configure time option. Since PS2 is already using k1 for
semaphore, I'd like to see it get merged in ASAP so that anything we
do won't break PS2.

> 
> This situation also behooves us to verify that
> k0/k1 are really and truly the only candidates
> for a thread register in MIPS.  I haven't been
> involved in any of the earlier discussions,
> and am not on the libc-hacker mailing list
> (and thus cannot post to it, by the way), but

You haven't missed anything. I changed it to the glibc alpha list.

> was it considered to simply use one of the
> static registers (say, s7/$23) in the existing
> ABI?  Assuming it was set up correctly at
> process startup, it would be preserved by
> pre-thread library and .o modules, and could
> be exploited by newly generated code.  Losing
> a static register would be a hit on code generation
> efficiency and performance, at least in principle.
> Was this the reason why the idea was rejected,
> or is there a more fundamental technical problem?

We never considered it since it is an invasive ABI change. Besides
the performance issue, it may break exist codes. I prefer k1 if all
possible.


H.J.
