Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6M6VARw012196
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 21 Jul 2002 23:31:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6M6VAiT012195
	for linux-mips-outgoing; Sun, 21 Jul 2002 23:31:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6M6UuRw012183;
	Sun, 21 Jul 2002 23:30:56 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6M6V5Xb017151;
	Sun, 21 Jul 2002 23:31:05 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA28362;
	Sun, 21 Jul 2002 23:31:05 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6M6V6b22220;
	Mon, 22 Jul 2002 08:31:06 +0200 (MEST)
Message-ID: <3D3BA6A2.DFE3988D@mips.com>
Date: Mon, 22 Jul 2002 08:31:06 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Stezenbach <js@convergence.de>
CC: linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: LTP testing: msgctl/IPC_STAT
References: <20020719143034.GA5956@convergence.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I also send this patch a week ago. Ralf could you please applied it.
If there is any objection against changing this structure in the kernel, then we
need a glibc fix instead.

/Carsten


Johannes Stezenbach wrote:

> I was investigating LTP test suite failures of the msgctl01,
> msgctl02, msgsnd01 and msgsnd02 tests. It seems that they
> are caused by a mismatch between /usr/include/bits/msq.h
> and linux/include/asm-mips/msgbuf.h.
>
> I suggest the following patch which makes mips' msgbuf.h
> a copy of the one in include/asm-i386.
>
> Johannes
>
> Index: linux/include/asm-mips/msgbuf.h
> ===================================================================
> RCS file: /cvs/linux/include/asm-mips/msgbuf.h,v
> retrieving revision 1.1
> diff -u -r1.1 msgbuf.h
> --- linux/include/asm-mips/msgbuf.h     2000/02/16 01:07:48     1.1
> +++ linux/include/asm-mips/msgbuf.h     2002/07/19 14:20:29
> @@ -2,26 +2,30 @@
>  #define _ASM_MSGBUF_H
>
>  /*
> - * The msqid64_ds structure for alpha architecture.
> + * The msqid64_ds structure for mips architecture.
>   * Note extra padding because this structure is passed back and forth
>   * between kernel and user space.
>   *
>   * Pad space is left for:
> - * - 2 miscellaneous 64-bit values
> + * - 64-bit time_t to solve y2038 problem
> + * - 2 miscellaneous 32-bit values
>   */
>
>  struct msqid64_ds {
>         struct ipc64_perm msg_perm;
>         __kernel_time_t msg_stime;      /* last msgsnd time */
> +       unsigned long   __unused1;
>         __kernel_time_t msg_rtime;      /* last msgrcv time */
> +       unsigned long   __unused2;
>         __kernel_time_t msg_ctime;      /* last change time */
> +       unsigned long   __unused3;
>         unsigned long  msg_cbytes;      /* current number of bytes on queue */
>         unsigned long  msg_qnum;        /* number of messages in queue */
>         unsigned long  msg_qbytes;      /* max number of bytes on queue */
>         __kernel_pid_t msg_lspid;       /* pid of last msgsnd */
>         __kernel_pid_t msg_lrpid;       /* last receive pid */
> -       unsigned long  __unused1;
> -       unsigned long  __unused2;
> +       unsigned long  __unused4;
> +       unsigned long  __unused5;
>  };
>
>  #endif /* _ASM_MSGBUF_H */

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
