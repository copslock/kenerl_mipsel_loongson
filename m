Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MIvwC27200
	for linux-mips-outgoing; Tue, 22 Jan 2002 10:57:58 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MIvnP27197;
	Tue, 22 Jan 2002 10:57:49 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16T5B5-0004j3-00; Tue, 22 Jan 2002 12:57:47 -0500
Date: Tue, 22 Jan 2002 12:57:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>, Ralf Baechle <ralf@oss.sgi.com>,
   Ulrich Drepper <drepper@redhat.com>, Mike Uhler <uhler@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
Message-ID: <20020122125747.A18040@nevyn.them.org>
References: <15437.14361.918255.115877@gladsmuir.algor.co.uk> <002001c1a33e$d9936560$0deca8c0@Ulysses> <20020122102128.A11455@nevyn.them.org> <007601c1a35e$b3e3f940$0deca8c0@Ulysses> <20020122113420.A14284@nevyn.them.org> <00c001c1a367$69c10160$0deca8c0@Ulysses> <20020122121330.A16110@nevyn.them.org> <00cc01c1a36b$15cbf200$0deca8c0@Ulysses> <20020122123743.A17232@nevyn.them.org> <00d801c1a36c$ef0719e0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00d801c1a36c$ef0719e0$0deca8c0@Ulysses>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 22, 2002 at 06:47:55PM +0100, Kevin D. Kissell wrote:
> > > Anyway, do you see a hole or a serious performance
> > > problem with my modified proposal (explicit mmap()
> > > to create the necessary storage)?
> >
> > Same problem as with clone.  I recommend the clone manpage; it says:
> >
> >        CLONE_VM
> >               If CLONE_VM is set, the calling process and the child
> processes run in the same
> >               memory space.  In particular, memory writes performed by the
> calling process or
> >               by the child process are also visible in the other process.
> Moreover, any mem­
> >               ory mapping or unmapping performed with mmap(2) or munmap(2)
> by  the  child  or
> >               calling process also affects the other process.
> >
> >               If CLONE_VM is not set, the child process runs in a separate
> copy of the memory
> >               space of the calling process at the time of clone.  Memory
> writes or file  map­
> >               pings/unmappings  performed by one of the processes do not
> affect the other, as
> >               with fork(2).
> >
> > That is, if any memory OR MAPPING is shared, they all are.
> 
> Daniel, you didn't read my message.  The per-thread memory
> would be allocated *after* the clone() in pthread_create().
> More specifically, pthread_create() would set it up so that
> the function passed to clone for invocation was in fact a
> wrapper that sets up the memory and thread data before
> invoking the application function passed to pthread_create().
> 
> Now, if the idea is that the clone() system call is supposed
> to cause the thread to be born, like Athena, full-grown from
> the head of Zeus, with the analog to the thread register
> already set up when it leaves the kernel, then I would be inclined
> to concede that we need to change the ABI, the kernel, and
> compilers, and I would ask just what we get for our trouble.
> But if we are permitted the pthreads abstraction, there's a
> lot that can be done transparently.

No, you didn't read my manpage quote, Kevin.  Or we're just talking
past each other.  The problem is not that existing mappings are shared,
but that "any memory mapping or unmapping performed with mmap(2)
or munmap(2) by the child or calling process also affects the other
process".  That is, if the child maps some private storage, the parent
will see it too.  Thus we can not use the private storage as a
thread-local storage unless we already have some thread-local way to
say where it is for this particular thread, and we're back where we
started.

Does that make sense, or am I missing your objection?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
