Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HKtJnC030514
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 13:55:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HKtJIW030513
	for linux-mips-outgoing; Mon, 17 Jun 2002 13:55:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HKt2nC030508
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 13:55:03 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA05660
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 13:57:49 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA06259;
	Mon, 17 Jun 2002 12:57:38 -0700
Message-ID: <3D0E3E9C.4070702@mvista.com>
Date: Mon, 17 Jun 2002 12:55:08 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: __access_ok
References: <3D0DCDCB.252F5565@mips.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Just to be nit-picking, the end point should be (addr + size - 1).

Jun

Carsten Langgaard wrote:

> The __access_ok macro in include/asm-mips64/uaccess.h need to be changed
> in order to work correctly, it's a copy from the 32-bit kernel.
> It's not good enough to simply check for the "sign bit" of the address.
> The area between USEG (XUSEG) and KSEG0 will in 64-bit addressing mode
> generate an address error, if
> accessed. The size of the area depend on the number of virtual
> addressing bits, implemented in the CPU.
> 
> I have tried to come up with a patch, please see below. Any thought ?
> I also changed the macro in arch/mips64/kernel/unaligned.c
> 
> /Carsten
> 
> 
> Index: include/asm-mips64//uaccess.h
> ===================================================================
> RCS file:
> /home/repository/sw/linux-2.4.18/include/asm-mips64/uaccess.h,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 uaccess.h
> --- include/asm-mips64//uaccess.h       4 Mar 2002 11:13:26 -0000
> 1.1.1.1
> +++ include/asm-mips64//uaccess.h       17 Jun 2002 11:35:32 -0000
> @@ -12,6 +12,8 @@
>  #include <linux/errno.h>
>  #include <linux/sched.h>
> 
> +#include <asm/addrspace.h>
> +
>  #define STR(x)  __STR(x)
>  #define __STR(x)  #x
> 
> @@ -40,16 +42,23 @@
>   * than tests.
>   *
>   * Address valid if:
> - *  - "addr" doesn't have any high-bits set
> - *  - AND "size" doesn't have any high-bits set
> - *  - AND "addr+size" doesn't have any high-bits set
> - *  - OR we are in kernel mode.
> + *  - In user mode and "addr" and "addr+size" in USEG (or XUSEG).
> + *  - OR we are in kernel mode and "addr" and "addr+size" isn't in the
> + *    area between USEG (XUSEG) and KSEG0.
>   */
>  #define
> __ua_size(size)                                                       \
>         (__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 :
> (size))
> 
> -#define __access_ok(addr,size,mask)
> \
> -       (((signed long)((mask)&(addr | (addr + size) |
> __ua_size(size)))) >= 0)
> +static inline int
> +__access_ok(unsigned long addr, unsigned long size, long mask)
> +{
> +       if (((mask) && ((addr | (addr+size)) >= KUSIZE)) ||
> +           (((addr | (addr+size)) < K0BASE) &&
> +            ((addr | (addr+size)) >= KUSIZE)))
> +               return 0;
> +       else
> +               return 1;
> +}
> 
>  #define __access_mask ((long)(get_fs().seg))
> 
> 
> Index: arch/mips64/kernel/unaligned.c
> ===================================================================
> RCS file:
> /home/repository/sw/linux-2.4.18/arch/mips64/kernel/unaligned.c,v
> retrieving revision 1.2
> diff -u -r1.2 unaligned.c
> --- arch/mips64/kernel/unaligned.c      23 May 2002 11:11:45 -0000
> 1.2
> +++ arch/mips64/kernel/unaligned.c      17 Jun 2002 11:51:30 -0000
> @@ -89,11 +89,14 @@
>  #define __STR(x)  #x
> 
>  /*
> - * User code may only access USEG; kernel code may access the
> - * entire address space.
> + * User code may only access USEG;
> + * Kernel code may access the entire address space, except the area
> between
> + * USEG (XUSEG) and KSEG0.
>   */
> -#define check_axs(pc,a,s)                              \
> -       if ((long)(~(pc) & ((a) | ((a)+(s)))) < 0)      \
> +#define check_axs(pc,a,s)
> \
> +        if (((pc < KUSIZE) && (((a) | ((a)+(s))) >= KUSIZE))
> ||               \
> +           ((((a) | ((a)+(s))) < K0BASE) &&
> \
> +            (((a) | ((a)+(s))) >= KUSIZE)))
> \
>                 goto sigbus;
> 
> 
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
> 
> 
> 
> 
