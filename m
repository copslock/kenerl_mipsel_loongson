Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA792007 for <linux-archive@neteng.engr.sgi.com>; Wed, 8 Apr 1998 17:15:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id RAA9343335
	for linux-list;
	Wed, 8 Apr 1998 17:15:07 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA9537158;
	Wed, 8 Apr 1998 17:14:59 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id RAA25476; Wed, 8 Apr 1998 17:14:57 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA26582;
	Thu, 9 Apr 1998 02:14:53 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA13722;
	Tue, 7 Apr 1998 17:04:31 +0200
Message-ID: <19980407170430.40396@uni-koblenz.de>
Date: Tue, 7 Apr 1998 17:04:30 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Lmbench results for Linux/MIPS 2.1.90
References: <19980322075452.09681@uni-koblenz.de> <199803230530.VAA12819@fir.engr.sgi.com> <19980405120602.27673@uni-koblenz.de> <199804061635.JAA08082@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804061635.JAA08082@fir.engr.sgi.com>; from William J. Earl on Mon, Apr 06, 1998 at 09:35:12AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Apr 06, 1998 at 09:35:12AM -0700, William J. Earl wrote:

>       You could or some suitable higher-order bit into the system call number
> to distinguish the two cases (and mask it off in syscall before indexing
> the system call table).  Since you have the system call number in a register,
> that should be pretty cheap to check.
> 
>      Instead of changing the calling sequence, perhaps you could
> do the fetching in a special assembly subroutine, and have the trap
> handler notice if $epc is in the routine at the instruction which fetches
> from the user space.  If so, it could change $epc to some recovery address
> in the assembly routine, which would return the fault indication.
> (There would probably be multiple load instructions in a fully
> unrolled routine, but that would just be more locations to accept 
> as valid exception points.)  This takes cycles out of the normal
> path, at the cost of cycles in the trap path (for kernel traps only,
> and then only for cases which are going to turn into EFAULT anyway).

Nice trick.  It's what the entire Linux kernel is already using :-)  In
Linux 2.0 all pointers to userland had to be verified by a routine named
verify_area.  That routine was implemented by walking the tables of valid
memory mappings.  It accounted for upto 20% of the kernel's processing time
for certain applications and was not threadsafe for example for the
following scenario:

 - Thread A makes a syscall which tries to access the userspace.  The
   kernel verifies the pointer and find it to be ok.  The kernel then uses
   the pointer to access userspace and catches a pagefault.
 - Due to the pagefault the scheduler now elects another thread B which is
   sharing it's memory mappings with the process A, similar to sproc(2)
   created threads under IRIX.  Thread B unmaps the area which just has
   been passed by process A to the kernel
 - The scheduler reruns process A again which uses the now invalid pointer
   to access the userspace.  Next scene, ungracefull death of a process:

   [...]
        printk(KERN_ALERT "Unable to handle kernel paging request at virtual "
               "address %08lx, epc == %08lx, ra == %08lx\n",
               address, regs->cp0_epc, regs->regs[31]);
        die_if_kernel("Oops", regs, writeaccess);
	do_exit(SIGKILL);
   [...]

Implementing things as you suggest not only made things threadsafe, it also
eleminated the fraction of CPU time for verify_area almost completly.  That's
all that is left:

[...]
#define __access_ok(addr,size,mask) \
        (((__signed__ long)((mask)&(addr | size | (addr+size)))) >= 0)
#define __access_mask (-(long)(get_fs().seg))

#define access_ok(type,addr,size) \
__access_ok(((unsigned long)(addr)),(size),__access_mask)

extern inline int verify_area(int type, const void * addr, unsigned long size)
{
        return access_ok(type,addr,size) ? 0 : -EFAULT;
}
[...]

Linux uses a special ELF section to collect all the fixup routines and data
which makes it easy to keep the table of potencially faulting instructions
in sorted order.  That way the exception handler can search the tables using
binary search and still handle the error case pretty fast.

Anyway, there are other more worthwile victims than the syscall handler.
The TCP bandwidth via loopback is half of what IRIX does, that's
unacceptable :-)

   Ralf
