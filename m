Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MIm3M26929
	for linux-mips-outgoing; Tue, 22 Jan 2002 10:48:03 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MIltP26923;
	Tue, 22 Jan 2002 10:47:55 -0800
Received: from nevyn.them.org (NEVYN.RES.CMU.EDU [128.2.145.6]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA05263; Tue, 22 Jan 2002 09:46:38 -0800 (PST)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16T4rf-0004UZ-00; Tue, 22 Jan 2002 12:37:43 -0500
Date: Tue, 22 Jan 2002 12:37:43 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>, Ralf Baechle <ralf@oss.sgi.com>,
   Ulrich Drepper <drepper@redhat.com>, Mike Uhler <uhler@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
Message-ID: <20020122123743.A17232@nevyn.them.org>
References: <m3elkoa5dw.fsf@myware.mynet><20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020119162415.B31028@dea.linux-mips.net><m3d703thl6.fsf@myware.mynet><01be01c1a2d7$6ec299c0$0deca8c0@Ulysses> <15437.14361.918255.115877@gladsmuir.algor.co.uk> <002001c1a33e$d9936560$0deca8c0@Ulysses> <20020122102128.A11455@nevyn.them.org> <007601c1a35e$b3e3f940$0deca8c0@Ulysses> <20020122113420.A14284@nevyn.them.org> <00c001c1a367$69c10160$0deca8c0@Ulysses> <20020122121330.A16110@nevyn.them.org> <00cc01c1a36b$15cbf200$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <00cc01c1a36b$15cbf200$0deca8c0@Ulysses>
User-Agent: Mutt/1.3.23i
X-MIME-Autoconverted: from 8bit to quoted-printable by sgi.com id JAA05263
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g0MIltP26924
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 22, 2002 at 06:34:42PM +0100, Kevin D. Kissell wrote:
> > > > Perhaps I'm mangling terminology.  LinuxThreads is a one-to-one
> mapping
> > > > of kernel threads to user threads.  All the kernel threads, and thus
> > > > all the user threads, share the same memory region - including the
> > > > stack region.  Their stacks are differentiated solely by different
> > > > values in the stack pointer register.  Thus I don't think what you're
> > > > suggesting is possible.
> > >
> > > I don't see how fork() semantics can be preserved unless
> > > the stack regions are replicated (copy-on-write) on a fork().
> > > Under ATT and BSD Unix (which is where I did most of
> > > my kernel hacking in the old days) that was the *only*
> > > way to get a new kernel thread, so it was "obvious"
> > > that my proposed hack would work.  Linux does have
> > > the clone() function as well, and if LinuxThreads are
> > > implemented in terms of clone(foo, stakptr, CLONE_VM, arg),
> > > you are correct, the proposed scheme would not work
> > > without modification.
> >
> > Which it is.  Fork shares no memory regions;
> 
> Oh, come on.  If it doesn't share text regions, it's completely
> brain dead!

They aren't shared, they're duplicated.  They use the same physical
memory, and the same virtual addresses, but the page table entries are
separate.  That's what I meant.  No copy of the page table is common on
fork(), AFAIK.

> > vfork/clone share all memory regions.  AFAIK there is no
> > share-heap-but-not-stack option in Linux.
> 
> Yeah.  Not that it matters, but I had misremebered there being
> finer grained control than that on clone().  Probably confused
> it with something that someone overlaid on Mach once upon a time...
> 
> Anyway, do you see a hole or a serious performance
> problem with my modified proposal (explicit mmap()
> to create the necessary storage)?

Same problem as with clone.  I recommend the clone manpage; it says:

       CLONE_VM
              If CLONE_VM is set, the calling process and the child processes run in the same
              memory space.  In particular, memory writes performed by the calling process or
              by the child process are also visible in the other process.  Moreover, any mem­
              ory mapping or unmapping performed with mmap(2) or munmap(2) by  the  child  or
              calling process also affects the other process.

              If CLONE_VM is not set, the child process runs in a separate copy of the memory
              space of the calling process at the time of clone.  Memory writes or file  map­
              pings/unmappings  performed by one of the processes do not affect the other, as
              with fork(2).

That is, if any memory OR MAPPING is shared, they all are.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
