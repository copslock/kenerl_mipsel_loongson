Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8A7SRx07337
	for linux-mips-outgoing; Mon, 10 Sep 2001 00:28:27 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8A7SFd07334;
	Mon, 10 Sep 2001 00:28:15 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA28012;
	Mon, 10 Sep 2001 00:28:07 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA00658;
	Mon, 10 Sep 2001 00:28:04 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f8A7S2a05943;
	Mon, 10 Sep 2001 09:28:02 +0200 (MEST)
Message-ID: <3B9C6B81.94FB616@mips.com>
Date: Mon, 10 Sep 2001 09:28:02 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
References: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp> <20010908013638.A19154@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Fri, Sep 07, 2001 at 08:26:52PM +0900, Atsushi Nemoto wrote:
>
> > I found that if setup_frame() fails in certain conditions the process
> > which caused the signal grabs CPU and never be killed.
> >
> > Here is a sample test program.
> >
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <signal.h>
> >
> > void sighandler(int sig)
> > {
> >       printf("SIGNAL %d!\n", sig);
> >       exit(2);
> > }
> > void setup_signal(int sig)
> > {
> >       struct sigaction act;
> >       memset(&act, 0, sizeof(act));
> >       act.sa_handler = sighandler;
> >       act.sa_flags = SA_NOMASK | SA_RESTART;
> >       sigaction(sig, &act, 0);
> > }
> >
> > int main(int argc, char **argv)
> > {
> >       setup_signal(SIGILL);
> >       setup_signal(SIGQUIT);
> >       setup_signal(SIGINT);
> >
> >       __asm__ __volatile__("move $29,$0");
> >       __asm__ __volatile__("mfc0 $0,$0");
> >       printf("done!\n");
> >       return 0;
> > }
> >
> >
> > This program setups signal handlers and causes Coprocessor Unusable
> > Exception with $sp == 0.
> >
> > If we run this program,
> >
> > 1.  "mfc1" instruction raises a exception.
> > 2.  The exception handler queues SIGILL(4).
> > 3.  do_signal() dequeue a signal with LOWEST number.
> > 4.  setup_frame() fails and queues SIGSEGV(11).
> > 5.  returns to user process.
> > 6.  again from 1. (forever)
> >
> > So, even SIGKILL can not kill the process.  (SIGHUP can do it).
> >
> > I make a change for do_signal() to check failure of setup_frame() and
> > continue processing pending signals.  It seems work for me.  Here is
> > the patch.  Any comments are welcome.
>
> Nice test case.  Thanks. I decied for a differnet fix attached below.

I like the printout then getting a Reserved Instruction Exception, it indicates a
problem and things are much easier to debug when getting such messages.
So it would be a pity, if we need to get rid of that.


>
>   Ralf
>
> Index: arch/mips64/kernel/traps.c
> ===================================================================
> RCS file: /home/pub/cvs/linux/arch/mips64/kernel/traps.c,v
> retrieving revision 1.20
> diff -u -r1.20 traps.c
> --- arch/mips64/kernel/traps.c 2001/07/11 23:32:54 1.20
> +++ arch/mips64/kernel/traps.c 2001/09/07 23:29:16
> @@ -347,11 +347,9 @@
>
>  void do_ri(struct pt_regs *regs)
>  {
> -       printk("Cpu%d[%s:%d] Illegal instruction at %08lx ra=%08lx\n",
> -               smp_processor_id(), current->comm, current->pid, regs->cp0_epc,
> -               regs->regs[31]);
>         if (compute_return_epc(regs))
>                 return;
> +
>         force_sig(SIGILL, current);
>  }
>
> @@ -388,6 +386,7 @@
>         return;
>
>  bad_cid:
> +       compute_return_epc(regs);
>         force_sig(SIGILL, current);
>  }
>
> Index: arch/mips/kernel/traps.c
> ===================================================================
> RCS file: /home/pub/cvs/linux/arch/mips/kernel/traps.c,v
> retrieving revision 1.78
> diff -u -r1.78 traps.c
> --- arch/mips/kernel/traps.c 2001/09/06 13:22:24 1.78
> +++ arch/mips/kernel/traps.c 2001/09/07 23:29:16
> @@ -606,9 +606,6 @@
>
>  asmlinkage void do_ri(struct pt_regs *regs)
>  {
> -       unsigned int opcode;
> -
> -       get_insn_opcode(regs, &opcode);
>         if (compute_return_epc(regs))
>                 return;
>
> @@ -659,6 +656,7 @@
>         return;
>
>  bad_cid:
> +       compute_return_epc(regs);
>         force_sig(SIGILL, current);
>  }
>

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
