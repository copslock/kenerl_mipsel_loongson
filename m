Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MIDer19785
	for linux-mips-outgoing; Tue, 22 Jan 2002 10:13:40 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MIDTP19777;
	Tue, 22 Jan 2002 10:13:29 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16T4UE-0004C5-00; Tue, 22 Jan 2002 12:13:30 -0500
Date: Tue, 22 Jan 2002 12:13:30 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>, Ralf Baechle <ralf@oss.sgi.com>,
   Ulrich Drepper <drepper@redhat.com>, Mike Uhler <uhler@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
Message-ID: <20020122121330.A16110@nevyn.them.org>
References: <m3elkoa5dw.fsf@myware.mynet><20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020119162415.B31028@dea.linux-mips.net><m3d703thl6.fsf@myware.mynet><01be01c1a2d7$6ec299c0$0deca8c0@Ulysses> <15437.14361.918255.115877@gladsmuir.algor.co.uk> <002001c1a33e$d9936560$0deca8c0@Ulysses> <20020122102128.A11455@nevyn.them.org> <007601c1a35e$b3e3f940$0deca8c0@Ulysses> <20020122113420.A14284@nevyn.them.org> <00c001c1a367$69c10160$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c001c1a367$69c10160$0deca8c0@Ulysses>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 22, 2002 at 06:08:12PM +0100, Kevin D. Kissell wrote:
> > Perhaps I'm mangling terminology.  LinuxThreads is a one-to-one mapping
> > of kernel threads to user threads.  All the kernel threads, and thus
> > all the user threads, share the same memory region - including the
> > stack region.  Their stacks are differentiated solely by different
> > values in the stack pointer register.  Thus I don't think what you're
> > suggesting is possible.
> 
> I don't see how fork() semantics can be preserved unless
> the stack regions are replicated (copy-on-write) on a fork().
> Under ATT and BSD Unix (which is where I did most of
> my kernel hacking in the old days) that was the *only*
> way to get a new kernel thread, so it was "obvious"
> that my proposed hack would work.  Linux does have
> the clone() function as well, and if LinuxThreads are
> implemented in terms of clone(foo, stakptr, CLONE_VM, arg),
> you are correct, the proposed scheme would not work
> without modification.

Which it is.  Fork shares no memory regions; vfork/clone share all
memory regions.  AFAIK there is no share-heap-but-not-stack option in
Linux.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
