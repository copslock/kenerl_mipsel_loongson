Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 12:59:22 +0100 (CET)
Received: from p508B7FA8.dip.t-dialin.net ([80.139.127.168]:38045 "EHLO
	p508B7FA8.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225205AbSLJL6o>; Tue, 10 Dec 2002 12:58:44 +0100
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:40699 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S868818AbSLJIzf>;
	Tue, 10 Dec 2002 09:55:35 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gBA8t2Nf022997;
	Tue, 10 Dec 2002 00:55:02 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA27012;
	Tue, 10 Dec 2002 00:55:04 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gBA8t4b11860;
	Tue, 10 Dec 2002 09:55:04 +0100 (MET)
Message-ID: <3DF5ABE7.CE94C334@mips.com>
Date: Tue, 10 Dec 2002 09:55:04 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Dominic Sweetman <dom@algor.co.uk>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
References: <3DEF7087.B6DEA7EC@mips.com> <20021209051845.A31939@linux-mips.org> <3DF4629B.F377F711@mips.com> <20021209173626.A27999@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Your patch seems to do the job, thanks a lot.

/Carsten


Ralf Baechle wrote:

> On Mon, Dec 09, 2002 at 10:30:03AM +0100, Carsten Langgaard wrote:
>
> > > The patch below adds 32 bytes.  It's still not the right thing though.  It's
> > > not fixing all stuff in the assembler code.  I have a better patch but it
> > > results in odd userspace behaviour.  Smells like a compiler problem ...
> >
> > I tried you patch below, but then nothing seems to work.
>
> The reason for this problem (and a few others is the broken call to
> __access_ok() in clear_user().  That should actually be access_ok().
> Basically the kernel was only working so far because addresses were just
> right ...
>
> Below my working version.  I still needs to make TASK_SIZE variable but
> with the clear_user thing fixed that should be easy.
>
>   Ralf
>
> Index: arch/mips64/kernel/scall_o32.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/kernel/scall_o32.S,v
> retrieving revision 1.48.2.21
> diff -u -r1.48.2.21 scall_o32.S
> --- arch/mips64/kernel/scall_o32.S      3 Dec 2002 14:23:05 -0000       1.48.2.21
> +++ arch/mips64/kernel/scall_o32.S      8 Dec 2002 06:08:55 -0000
> @@ -209,7 +209,7 @@
>         daddiu  a0, a1, 4
>         or      a0, a0, a1
>         and     a0, a0, v1
> -       bltz    a0, bad_address
> +       bnez    a0, bad_address
>
>         /* Ok, this is the ll/sc case.  World is sane :-)  */
>  1:     ll      v0, (a1)
> @@ -273,7 +273,7 @@
>         ld      v1, THREAD_CURDS($28)
>         or      v0, v0, t1
>         and     v1, v1, v0
> -       bltz    v1, efault
> +       bnez    v1, efault
>
>         move    a0, a1                  # shift argument registers
>         move    a1, a2
> Index: arch/mips64/lib/strlen_user.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/lib/strlen_user.S,v
> retrieving revision 1.4.2.1
> diff -u -r1.4.2.1 strlen_user.S
> --- arch/mips64/lib/strlen_user.S       1 Jul 2002 15:27:29 -0000       1.4.2.1
> +++ arch/mips64/lib/strlen_user.S       8 Dec 2002 06:08:55 -0000
> @@ -25,7 +25,7 @@
>  LEAF(__strlen_user_asm)
>         ld      v0, THREAD_CURDS($28)                   # pointer ok?
>         and     v0, a0
> -       bltz    v0, fault
> +       bnez    v0, fault
>
>  FEXPORT(__strlen_user_nocheck_asm)
>         move    v0, a0
> Index: arch/mips64/lib/strncpy_user.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/lib/strncpy_user.S,v
> retrieving revision 1.4
> diff -u -r1.4 strncpy_user.S
> --- arch/mips64/lib/strncpy_user.S      9 Jul 2001 00:25:37 -0000       1.4
> +++ arch/mips64/lib/strncpy_user.S      8 Dec 2002 06:08:55 -0000
> @@ -30,7 +30,7 @@
>  LEAF(__strncpy_from_user_asm)
>         ld      v0, THREAD_CURDS($28)           # pointer ok?
>         and     v0, a1
> -       bltz    v0, fault
> +       bnez    v0, fault
>
>  FEXPORT(__strncpy_from_user_nocheck_asm)
>         move    v0, zero
> Index: arch/mips64/lib/strnlen_user.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/lib/strnlen_user.S,v
> retrieving revision 1.2.2.2
> diff -u -r1.2.2.2 strnlen_user.S
> --- arch/mips64/lib/strnlen_user.S      1 Jul 2002 15:27:29 -0000       1.2.2.2
> +++ arch/mips64/lib/strnlen_user.S      8 Dec 2002 06:08:55 -0000
> @@ -25,7 +25,7 @@
>  LEAF(__strnlen_user_asm)
>         ld      v0, THREAD_CURDS($28)   # pointer ok?
>         and     v0, a0
> -       bltz    v0, fault
> +       bnez    v0, fault
>
>  FEXPORT(__strnlen_user_nocheck_asm)
>         move    v0, a0
> Index: include/asm-mips64/processor.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips64/processor.h,v
> retrieving revision 1.32.2.9
> diff -u -r1.32.2.9 processor.h
> --- include/asm-mips64/processor.h      4 Nov 2002 19:39:56 -0000       1.32.2.9
> +++ include/asm-mips64/processor.h      8 Dec 2002 06:09:38 -0000
> @@ -208,7 +208,7 @@
>         /* \
>          * For now the default is to fix address errors \
>          */ \
> -       MF_FIXADE, { 0 }, 0, 0 \
> +       MF_FIXADE, KERNEL_DS, 0, 0 \
>  }
>
>  #ifdef __KERNEL__
> Index: include/asm-mips64/uaccess.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips64/uaccess.h,v
> retrieving revision 1.13.2.1
> diff -u -r1.13.2.1 uaccess.h
> --- include/asm-mips64/uaccess.h        1 Jul 2002 15:27:31 -0000       1.13.2.1
> +++ include/asm-mips64/uaccess.h        8 Dec 2002 06:09:39 -0000
> @@ -22,8 +22,8 @@
>   *
>   * For historical reasons, these macros are grossly misnamed.
>   */
> -#define KERNEL_DS      ((mm_segment_t) { (unsigned long) 0L })
> -#define USER_DS                ((mm_segment_t) { (unsigned long) -1L })
> +#define KERNEL_DS      ((mm_segment_t) { 0UL })
> +#define USER_DS                ((mm_segment_t) { -TASK_SIZE })
>
>  #define VERIFY_READ    0
>  #define VERIFY_WRITE   1
> @@ -46,19 +46,19 @@
>   *  - OR we are in kernel mode.
>   */
>  #define __ua_size(size)                                                        \
> -       (__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 : (size))
> +       ((__builtin_constant_p(size) && (size)) > 0 ? 0 : (size))
>
> -#define __access_ok(addr,size,mask)                                    \
> -       (((signed long)((mask)&(addr | (addr + size) | __ua_size(size)))) >= 0)
> +#define __access_ok(addr, size, mask)                                  \
> +       (((mask) & ((addr) | ((addr) + (size)) | __ua_size(size))) == 0)
>
> -#define __access_mask ((long)(get_fs().seg))
> +#define __access_mask get_fs().seg
>
> -#define access_ok(type,addr,size) \
> -       __access_ok(((unsigned long)(addr)),(size),__access_mask)
> +#define access_ok(type, addr, size)                                    \
> +       __access_ok((unsigned long)(addr), (size), __access_mask)
>
>  static inline int verify_area(int type, const void * addr, unsigned long size)
>  {
> -       return access_ok(type,addr,size) ? 0 : -EFAULT;
> +       return access_ok(type, addr, size) ? 0 : -EFAULT;
>  }
>
>  /*
> @@ -340,8 +340,8 @@
>  ({                                                             \
>         void * __cl_addr = (addr);                              \
>         unsigned long __cl_size = (n);                          \
> -       if (__cl_size && __access_ok(VERIFY_WRITE,              \
> -              ((unsigned long)(__cl_addr)), __cl_size))        \
> +       if (__cl_size && access_ok(VERIFY_WRITE,                \
> +               ((unsigned long)(__cl_addr)), __cl_size))       \
>                 __cl_size = __clear_user(__cl_addr, __cl_size); \
>         __cl_size;                                              \
>  })

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
