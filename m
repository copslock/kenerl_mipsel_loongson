Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g78JuMRw022754
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 8 Aug 2002 12:56:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g78JuMJd022753
	for linux-mips-outgoing; Thu, 8 Aug 2002 12:56:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g78JtmRw022739;
	Thu, 8 Aug 2002 12:55:48 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g78JvFXb021942;
	Thu, 8 Aug 2002 12:57:15 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA02221;
	Thu, 8 Aug 2002 12:57:15 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g78JvEb13962;
	Thu, 8 Aug 2002 21:57:14 +0200 (MEST)
Message-ID: <3D52CE5B.CD8C72C4@mips.com>
Date: Thu, 08 Aug 2002 22:02:35 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: siginfo structure in 64-bit kernel
References: <Pine.GSO.3.96.1020808155847.13783A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



"Maciej W. Rozycki" wrote:

> On Wed, 7 Aug 2002, Maciej W. Rozycki wrote:
>
> > I'll check the patch at run-time later.
>
>  I checked the patch and discovered you somehow made the order of struct
> members wrong.

Good spotted, that's what happens when MIPS is the only one that put 'si_code' before 'si_errno' in the structure.


>  Here is an updated version that works for me.  It includes
> both the ordering fix and unsigned type changes I suggested before.
>

With your sign changes we are doing things a little bit different than others, I know that's not really an argument, but does the unsigned types not work for you ?



>
>  This version should be OK to apply.
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
> patch-mips-2.4.19-rc1-20020807-carsten-signal32-3
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/kernel/signal32.c linux-mips-2.4.19-rc1-20020807/arch/mips64/kernel/signal32.c
> --- linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/kernel/signal32.c  2002-08-06 02:57:36.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020807/arch/mips64/kernel/signal32.c        2002-08-08 00:20:04.000000000 +0000
> @@ -360,13 +360,55 @@ struct sigframe {
>         sigset_t sf_mask;
>  };
>
> -struct rt_sigframe {
> +struct rt_sigframe32 {
>         u32 rs_ass[4];                  /* argument save space for o32 */
>         u32 rs_code[2];                 /* signal trampoline */
> -       struct siginfo rs_info;
> +       struct siginfo32 rs_info;
>         struct ucontext rs_uc;
>  };
>
> +static int copy_siginfo_to_user32(siginfo_t32 *to, siginfo_t *from)
> +{
> +       int err;
> +
> +       if (!access_ok (VERIFY_WRITE, to, sizeof(siginfo_t32)))
> +               return -EFAULT;
> +
> +       /* If you change siginfo_t structure, please be sure
> +          this code is fixed accordingly.
> +          It should never copy any pad contained in the structure
> +          to avoid security leaks, but must copy the generic
> +          3 ints plus the relevant union member.
> +          This routine must convert siginfo from 64bit to 32bit as well
> +          at the same time.  */
> +       err = __put_user(from->si_signo, &to->si_signo);
> +       err |= __put_user(from->si_errno, &to->si_errno);
> +       err |= __put_user((short)from->si_code, &to->si_code);
> +       if (from->si_code < 0)
> +               err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
> +       else {
> +               switch (from->si_code >> 16) {
> +               case __SI_CHLD >> 16:
> +                       err |= __put_user(from->si_utime, &to->si_utime);
> +                       err |= __put_user(from->si_stime, &to->si_stime);
> +                       err |= __put_user(from->si_status, &to->si_status);
> +               default:
> +                       err |= __put_user(from->si_pid, &to->si_pid);
> +                       err |= __put_user(from->si_uid, &to->si_uid);
> +                       break;
> +               case __SI_FAULT >> 16:
> +                       err |= __put_user((long)from->si_addr, &to->si_addr);
> +                       break;
> +               case __SI_POLL >> 16:
> +                       err |= __put_user(from->si_band, &to->si_band);
> +                       err |= __put_user(from->si_fd, &to->si_fd);
> +                       break;
> +               /* case __SI_RT: This is not generated by the kernel as of now.  */
> +               }
> +       }
> +       return err;
> +}
> +
>  asmlinkage void sys32_sigreturn(abi64_no_regargs, struct pt_regs regs)
>  {
>         struct sigframe *frame;
> @@ -405,11 +447,11 @@ badframe:
>
>  asmlinkage void sys32_rt_sigreturn(abi64_no_regargs, struct pt_regs regs)
>  {
> -       struct rt_sigframe *frame;
> +       struct rt_sigframe32 *frame;
>         sigset_t set;
>         stack_t st;
>
> -       frame = (struct rt_sigframe *) regs.regs[29];
> +       frame = (struct rt_sigframe32 *) regs.regs[29];
>         if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
>                 goto badframe;
>         if (__copy_from_user(&set, &frame->rs_uc.uc_sigmask, sizeof(set)))
> @@ -588,7 +630,7 @@ static void inline setup_rt_frame(struct
>                                   struct pt_regs *regs, int signr,
>                                   sigset_t *set, siginfo_t *info)
>  {
> -       struct rt_sigframe *frame;
> +       struct rt_sigframe32 *frame;
>         int err = 0;
>
>         frame = get_sigframe(ka, regs, sizeof(*frame));
> @@ -613,8 +655,8 @@ static void inline setup_rt_frame(struct
>                 flush_cache_sigtramp((unsigned long) frame->rs_code);
>         }
>
> -       /* Create siginfo.  */
> -       err |= __copy_to_user(&frame->rs_info, info, sizeof(*info));
> +       /* Convert (siginfo_t -> siginfo_t32) and copy to user. */
> +       err |= copy_siginfo_to_user32(&frame->rs_info, info);
>
>         /* Create the ucontext.  */
>         err |= __put_user(0, &frame->rs_uc.uc_flags);
> @@ -639,7 +681,7 @@ static void inline setup_rt_frame(struct
>          *   a2 = pointer to ucontext
>          *
>          * $25 and c0_epc point to the signal handler, $29 points to
> -        * the struct rt_sigframe.
> +        * the struct rt_sigframe32.
>          */
>         regs->regs[ 4] = signr;
>         regs->regs[ 5] = (unsigned long) &frame->rs_info;
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/include/asm-mips64/siginfo.h linux-mips-2.4.19-rc1-20020807/include/asm-mips64/siginfo.h
> --- linux-mips-2.4.19-rc1-20020807.macro/include/asm-mips64/siginfo.h   2002-08-06 02:58:32.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020807/include/asm-mips64/siginfo.h 2002-08-08 07:14:29.000000000 +0000
> @@ -18,11 +18,21 @@ typedef union sigval {
>         void *sival_ptr;
>  } sigval_t;
>
> +#ifdef __KERNEL__
> +
> +typedef union sigval32 {
> +       int sival_int;
> +       s32 sival_ptr;
> +} sigval_t32;
> +
> +#endif /* __KERNEL__ */
> +
>  /* This structure matches IRIX 32/n32 ABIs for binary compatibility but
>     has Linux extensions.  */
>
>  #define SI_MAX_SIZE    128
> -#define SI_PAD_SIZE    ((SI_MAX_SIZE/sizeof(int)) - 3)
> +#define SI_PAD_SIZE    ((SI_MAX_SIZE/sizeof(int)) - 4)
> +#define SI_PAD_SIZE32  ((SI_MAX_SIZE/sizeof(int)) - 3)
>
>  typedef struct siginfo {
>         int si_signo;
> @@ -82,6 +92,68 @@ typedef struct siginfo {
>         } _sifields;
>  } siginfo_t;
>
> +#ifdef __KERNEL__
> +
> +typedef struct siginfo32 {
> +       int si_signo;
> +       int si_code;
> +       int si_errno;
> +
> +       union {
> +               int _pad[SI_PAD_SIZE32];
> +
> +               /* kill() */
> +               struct {
> +                       __kernel_pid_t32 _pid;  /* sender's pid */
> +                       __kernel_uid_t32 _uid;  /* sender's uid */
> +               } _kill;
> +
> +               /* SIGCHLD */
> +               struct {
> +                       __kernel_pid_t32 _pid;  /* which child */
> +                       __kernel_uid_t32 _uid;  /* sender's uid */
> +                       __kernel_clock_t32 _utime;
> +                       int _status;            /* exit code */
> +                       __kernel_clock_t32 _stime;
> +               } _sigchld;
> +
> +               /* IRIX SIGCHLD */
> +               struct {
> +                       __kernel_pid_t32 _pid;  /* which child */
> +                       __kernel_clock_t32 _utime;
> +                       int _status;            /* exit code */
> +                       __kernel_clock_t32 _stime;
> +               } _irix_sigchld;
> +
> +               /* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
> +               struct {
> +                       s32 _addr; /* faulting insn/memory ref. */
> +               } _sigfault;
> +
> +               /* SIGPOLL, SIGXFSZ (To do ...)  */
> +               struct {
> +                       int _band;      /* POLL_IN, POLL_OUT, POLL_MSG */
> +                       int _fd;
> +               } _sigpoll;
> +
> +               /* POSIX.1b timers */
> +               struct {
> +                       unsigned int _timer1;
> +                       unsigned int _timer2;
> +               } _timer;
> +
> +               /* POSIX.1b signals */
> +               struct {
> +                       __kernel_pid_t32 _pid;  /* sender's pid */
> +                       __kernel_uid_t32 _uid;  /* sender's uid */
> +                       sigval_t32 _sigval;
> +               } _rt;
> +
> +       } _sifields;
> +} siginfo_t32;
> +
> +#endif /* __KERNEL__ */
> +
>  /*
>   * How these fields are to be accessed.
>   */
