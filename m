Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N2CIo08780
	for linux-mips-outgoing; Tue, 22 Jan 2002 18:12:18 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N2CDP08774
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 18:12:13 -0800
Received: (qmail 1279 invoked from network); 23 Jan 2002 01:12:10 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <tommy.christensen@eicon.com>; 23 Jan 2002 01:12:10 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16TBxR-0005ac-00; Tue, 22 Jan 2002 18:12:10 -0700
Date: Tue, 22 Jan 2002 18:12:09 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>,
   Ulrich Drepper <drepper@redhat.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: thread-ready ABIs
In-Reply-To: <3C4DDD24.4A0F24DE@eicon.com>
Message-ID: <Pine.LNX.3.96.1020122173006.21433A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tue, 22 Jan 2002, Tommy S. Christensen wrote:

> Well, why not use the stack?
> 
> I am not quite familiar with the requirements on this "thread register",
> but couldn't something like this be made to work:
>   #define TID *((sp & ~(STACK_SIZE-1)) + STACK_SIZE - TID_OFFSET)

Last time I looked at how pthreads worked it did use the stack pointer to
decide what the TID is. It got rather ugly because the stack on thread 0
was not under program control, so it had all sorts of unknown properties.
But that could be fixed with kernel support I think.

The only reason I can think of to have a *fast* thread-local variable is
to implement thread-local storage. This is a good thing for glibc and
multi-threaded programs - the ultimate implemenation would probably be to
have gcc know about it (if ia64 has dedicated hardware, it is not
unimaginable, and other compilers do implement this)

extern int errno __attribute__((thread_local));

On i386 this has often been done using fs/gs to point to a block of ram. 

However, I expect you could probably also base the thread-local ram on the
top/bottom of the stack which means each procedure can compute the
(constant!) base in a couple of instructions. The runtime can know how
much to set aside before it begins executing the new thread. Aligning SP
can be done in a kernel independent way for tid 0. 

I don't know if this is worse than making the TLB handler slower to free
up k0/k1, it entirely depends how many functions will be using thread
local stuff.. 

Jason
