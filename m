Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6FGfsRw005496
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 09:41:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6FGfslC005495
	for linux-mips-outgoing; Mon, 15 Jul 2002 09:41:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hermod.qsicorp.com (mail.qsicorp.com [216.190.147.34])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6FGfgRw005485
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 09:41:42 -0700
Received: from qsicorp.com (computer195.qsicorp.com [216.190.147.195])
	by hermod.qsicorp.com (Postfix) with ESMTP
	id 314BF17043; Mon, 15 Jul 2002 10:46:34 -0600 (MDT)
Message-ID: <3D330B04.CDE3E332@qsicorp.com>
Date: Mon, 15 Jul 2002 10:48:52 -0700
From: Ryan Martindale <ryan@qsicorp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: fpu woes (TX3912)
References: <3D3300A3.FD50EDEA@qsicorp.com> <01c401c22c1c$1973a170$10eca8c0@grendel>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.1 required=5.0 tests=PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> > I'm using the tx3912 processor for an embedded device and since it
> > doesn't have an fpu, I don't have coprocessor #1.  Recently, I remember
> > seeing a fix in process.c for exit_thread and flush_thread, and did
> > apply it - but there still is a problem (at least for me). In traps.c,
> > the save_fp_context and restore_fp_context are set to _save_fp_context
> > (in r2300_fpu.S) which don't check to see if I have a coprocessor
> > available. As I am rather new to the linux/linux-mips development world,
> > I thought I'd give a heads up (it is causing my embedded system to
> > crash). Any direction on fixing it would be welcome, but I'm not sure
> > I'll get to the point where I will submit any patches any time soon.
> 
> People break things from time to time, but at least at one point
> in history, R3xxx platforms were correctly supported by the
> FPU emulator code.  Looking at the source code on my
> system, it looks like traps.c has been "cleaned up" in a
> somewhat wierd manner, such that the test for whether
> there is an FPU happens redundantly, once in the specific
> case of a 4K family CPU (which you would not hit on your
> TX39), and again just after the switch on the CPU type.
> Did someone screw up the setting of mips_cpu.options
> for a TX39xx or something?  Is that code missing from
> the sources that you're using?  Are you sure that it isn't
> something else blowing up on you?  There have been
> mods made locally here and there that might have
> broken the FPU emulator for R3xxx platforms, but
> I didn't think that any of them were up on OSS.sgi.com
> or kernel.org.
> 
>             Regards,
> 
>             Kevin K.

I am actually using the 2.4.18 stable kernel source, although I did
check the 2.5.14 source tree I have to see if any modifications had
taken place. My problem is the in signal.c function setup_sigcontext
has:

	if (current->used_math) {	/* fp is active.  */
		set_cp0_status(ST0_CU1);
		err |= save_fp_context(sc);
		last_task_used_math = NULL;
		regs->cp0_status &= ~ST0_CU1;
		current->used_math = 0;
	}

There is no check to see if I have an FPU. I modified it to:

	if (current->used_math) {	/* fp is active.  */
		if (mips_cpu.options & MIPS_CPU_FPU) {
			set_cp0_status(ST0_CU1);
			err |= save_fp_context(sc);
			regs->cp0_status &= ~ST0_CU1;
		}
		last_task_used_math = NULL;
		current->used_math = 0;
	}

And now I am not crashing. As far as how it is supposed to be setup, I
don't really know - like I said, I'm pretty new at this. I don't see any
ifdefs/checks around the code in traps.c

	case CPU_R2000:
	case CPU_R3000:
	case CPU_R3000A:
	case CPU_R3041:
	case CPU_R3051:
	case CPU_R3052:
	case CPU_R3081:
	case CPU_R3081E:
	case CPU_TX3912:
	case CPU_TX3922:
	case CPU_TX3927:
	        save_fp_context = _save_fp_context;
		restore_fp_context = _restore_fp_context;

I would think that traps.c would be were you would set up to handle
emulation (indeed it appears that there is an emulator option set up for
the processors with MIPS_CPU_4KEX && MIPS_CPU_4KTLB options set, but no
other locations seem to be concerned about this. Is this where floating
point should be dealt with?

Ryan
