Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5I7ZxnC009248
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 00:35:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5I7ZxTn009247
	for linux-mips-outgoing; Tue, 18 Jun 2002 00:35:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5I7ZgnC009242
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 00:35:42 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA10979;
	Tue, 18 Jun 2002 00:38:24 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA00007;
	Tue, 18 Jun 2002 00:38:26 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5I7cQb05227;
	Tue, 18 Jun 2002 09:38:26 +0200 (MEST)
Message-ID: <3D0EE371.8C6D85FD@mips.com>
Date: Tue, 18 Jun 2002 09:38:25 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: __access_ok
References: <3D0DCDCB.252F5565@mips.com> <3D0E3E9C.4070702@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

That's true, lets do it right, thanks.

/Carsten


Jun Sun wrote:

> Just to be nit-picking, the end point should be (addr + size - 1).
>
> Jun
>
> Carsten Langgaard wrote:
>
> > The __access_ok macro in include/asm-mips64/uaccess.h need to be changed
> > in order to work correctly, it's a copy from the 32-bit kernel.
> > It's not good enough to simply check for the "sign bit" of the address.
> > The area between USEG (XUSEG) and KSEG0 will in 64-bit addressing mode
> > generate an address error, if
> > accessed. The size of the area depend on the number of virtual
> > addressing bits, implemented in the CPU.
> >
> > I have tried to come up with a patch, please see below. Any thought ?
> > I also changed the macro in arch/mips64/kernel/unaligned.c
> >
> > /Carsten
> >
> >
> > Index: include/asm-mips64//uaccess.h
> > ===================================================================
> > RCS file:
> > /home/repository/sw/linux-2.4.18/include/asm-mips64/uaccess.h,v
> > retrieving revision 1.1.1.1
> > diff -u -r1.1.1.1 uaccess.h
> > --- include/asm-mips64//uaccess.h       4 Mar 2002 11:13:26 -0000
> > 1.1.1.1
> > +++ include/asm-mips64//uaccess.h       17 Jun 2002 11:35:32 -0000
> > @@ -12,6 +12,8 @@
> >  #include <linux/errno.h>
> >  #include <linux/sched.h>
> >
> > +#include <asm/addrspace.h>
> > +
> >  #define STR(x)  __STR(x)
> >  #define __STR(x)  #x
> >
> > @@ -40,16 +42,23 @@
> >   * than tests.
> >   *
> >   * Address valid if:
> > - *  - "addr" doesn't have any high-bits set
> > - *  - AND "size" doesn't have any high-bits set
> > - *  - AND "addr+size" doesn't have any high-bits set
> > - *  - OR we are in kernel mode.
> > + *  - In user mode and "addr" and "addr+size" in USEG (or XUSEG).
> > + *  - OR we are in kernel mode and "addr" and "addr+size" isn't in the
> > + *    area between USEG (XUSEG) and KSEG0.
> >   */
> >  #define
> > __ua_size(size)                                                       \
> >         (__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 :
> > (size))
> >
> > -#define __access_ok(addr,size,mask)
> > \
> > -       (((signed long)((mask)&(addr | (addr + size) |
> > __ua_size(size)))) >= 0)
> > +static inline int
> > +__access_ok(unsigned long addr, unsigned long size, long mask)
> > +{
> > +       if (((mask) && ((addr | (addr+size)) >= KUSIZE)) ||
> > +           (((addr | (addr+size)) < K0BASE) &&
> > +            ((addr | (addr+size)) >= KUSIZE)))
> > +               return 0;
> > +       else
> > +               return 1;
> > +}
> >
> >  #define __access_mask ((long)(get_fs().seg))
> >
> >
> > Index: arch/mips64/kernel/unaligned.c
> > ===================================================================
> > RCS file:
> > /home/repository/sw/linux-2.4.18/arch/mips64/kernel/unaligned.c,v
> > retrieving revision 1.2
> > diff -u -r1.2 unaligned.c
> > --- arch/mips64/kernel/unaligned.c      23 May 2002 11:11:45 -0000
> > 1.2
> > +++ arch/mips64/kernel/unaligned.c      17 Jun 2002 11:51:30 -0000
> > @@ -89,11 +89,14 @@
> >  #define __STR(x)  #x
> >
> >  /*
> > - * User code may only access USEG; kernel code may access the
> > - * entire address space.
> > + * User code may only access USEG;
> > + * Kernel code may access the entire address space, except the area
> > between
> > + * USEG (XUSEG) and KSEG0.
> >   */
> > -#define check_axs(pc,a,s)                              \
> > -       if ((long)(~(pc) & ((a) | ((a)+(s)))) < 0)      \
> > +#define check_axs(pc,a,s)
> > \
> > +        if (((pc < KUSIZE) && (((a) | ((a)+(s))) >= KUSIZE))
> > ||               \
> > +           ((((a) | ((a)+(s))) < K0BASE) &&
> > \
> > +            (((a) | ((a)+(s))) >= KUSIZE)))
> > \
> >                 goto sigbus;
> >
> >
> >
> > --
> > _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> > |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> > | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
> >   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
> >                    Denmark            http://www.mips.com
> >
> >
> >
> >

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
