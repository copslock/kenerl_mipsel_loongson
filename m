Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g56KwHnC026022
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 13:58:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g56KwHUT026021
	for linux-mips-outgoing; Thu, 6 Jun 2002 13:58:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g56Kw9nC026011
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 13:58:10 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id OAA17311
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 14:00:03 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id OAA19070;
	Thu, 6 Jun 2002 14:00:04 -0700 (PDT)
Received: from coplin19.mips.com (IDENT:root@coplin19 [192.168.205.89])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g56L04b02676;
	Thu, 6 Jun 2002 23:00:04 +0200 (MEST)
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g56L04B27079;
	Thu, 6 Jun 2002 23:00:04 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Thu, 6 Jun 2002 23:00:04 +0200 (CEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: Float crash. Fix in exit_thread()
In-Reply-To: <007501c20d86$f339b7a0$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.44.0206062255090.27062-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 6 Jun 2002, Kevin D. Kissell wrote:

> It's been a while since I worked on the code,
> but I'm not sure why last_task_used_math
> needs to be cleared if there is no FPU.
> The way the FPU emulator was integrated,
> the FPU register storage *is* the thread
> context, so if there is no FPU, there was no 
> FPU context switching, lazy or otherwise.  
> Sounds like someone broke this.

If you check do_cpu in traps.c you'll find:

fp_emul:
        if (last_task_used_math != current) {
                if (!current->used_math) {
                        fpu_emulator_init_fpu();
                        current->used_math = 1;
                }
        }
        sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
        last_task_used_math = current;
        if (sig)


fpu_emulator_init_fpu() is not called, when two processes are created like 
I described. Alternatively the test "if (last_task_used_math != current)" 
could be removed.

> Beyond that, the CFC1 instruction is presumably
> there because in the R4000 (at least) it is specified
> as the means to force the FP pipeline to drain
> before the context switch.  I would suppose this
> would be done in Linux to avoid mis-attribution
> of FP exceptions. (See chapter 6 of the R4000 
> User's manual, page 160 in the Second Edition).

Great. It was exactly something like that I was looking for. Perhaps a 
comment would be nice in the code here ;-)

/Kjeld

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
