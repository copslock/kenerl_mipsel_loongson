Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id RAA243852 for <linux-archive@neteng.engr.sgi.com>; Tue, 27 Jan 1998 17:04:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA07488 for linux-list; Tue, 27 Jan 1998 17:02:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA07473 for <linux@engr.sgi.com>; Tue, 27 Jan 1998 17:01:59 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA18079
	for <linux@engr.sgi.com>; Tue, 27 Jan 1998 17:01:57 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA27185
	for <linux@engr.sgi.com>; Wed, 28 Jan 1998 02:01:54 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA08096;
	Wed, 28 Jan 1998 01:58:29 +0100
Message-ID: <19980128015827.34915@uni-koblenz.de>
Date: Wed, 28 Jan 1998 01:58:27 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Q: R3000, how to manipulate CP0_EPC?
References: <XFMail.980127183209.harald.koerfgen@netcologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <XFMail.980127183209.harald.koerfgen@netcologne.de>; from harald.koerfgen@netcologne.de on Tue, Jan 27, 1998 at 06:32:09PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 27, 1998 at 06:32:09PM +0100, harald.koerfgen@netcologne.de wrote:

> This is the begin of the RESTORE_ALL macro, which is used in ret_from_sys_call:
> #define RESTORE_ALL                                      \
>                 mfc0    t0, CP0_STATUS;                  \
>                 nop;                                     \
>                 ori     t0, 0x01;                        \
>                 xori    t0, 0x01;                        \
>                 mtc0    t0, CP0_STATUS;                  \
>                 lw      v0, PT_STATUS(sp);               \
>                 lw      v1, PT_LO(sp);                   \
>                 mtc0    v0, CP0_STATUS;                  \
>                 mtlo    v1;                              \
>                 lw      v0, PT_HI(sp);                   \
>                 lw      v1, PT_EPC(sp);                  \
>                 mthi    v0;                              \
>                 mtc0    v1, CP0_EPC;                     \
> ..
> 
> PT_EPC is manipulated in do_sys to point behind the syscall instruction and a
> PRINT(...) shows that v1 contains the correct value. Nevertheless CP0_EPC
> remains to be unchanged.
> 
> After finding that, I used the following test code:
> #define RESTORE_ALL_TEST                                \
>                 lui     v0,0xffff;                      \
>                 mtc0    v0,CP0_EPC;                     \
>                 nop;                                    \
>                 mfc0    a1,CP0_EPC;                     \
>                 nop;                                    \
>                 PRINT("CP0_EPC   : %08x\n");            \
> 
> which "compiles" into:
> 800375d0 <return_test> lui $v0,0xffff
> 800375d4 <return_test+4> mtc0 $v0,$14
> 800375dc <return_test+c> mfc0 $a1,$14
> 800375e4 <return_test+14> lui $a0,0x800c
> 800375e8 <return_test+18> jal 80054478 <printk>
> 800375ec <return_test+1c> addiu $a0,$a0,5680  
> 
> and the result is:
> CP0_EPC   : 80036aa4
> 
> which is the address of the syscall instruction itself. But the result should be
> 0xFFFF0000, shouldn't it?.
> 
> Has anybody an explanation for this, or am I just completely blind?

On the R3000 c0_epc is a readonly register - as documented.  That's ok
because the R3000 uses a different way of handling exceptions.  What you'll
have to do to return from an exception is about as follows:

   restore c0_status
   move k1, sp				; needed later
   restore all gp registers
   restore hi/lo registers
   lw	k0, PT_EPC(sp)
   jr   k0
   rfe					; in the delay slot of the jr

  Ralf
