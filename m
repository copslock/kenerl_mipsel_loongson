Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6FI06Rw006794
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 11:00:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6FI06pB006793
	for linux-mips-outgoing; Mon, 15 Jul 2002 11:00:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from proteus.paralogos.com (aux-209-217-49-36.oklahoma.net [209.217.49.36])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6FHxsRw006774
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 10:59:54 -0700
Received: from grendel ([195.154.177.178])
	by proteus.paralogos.com (8.9.3/8.9.3) with SMTP id NAA18279;
	Mon, 15 Jul 2002 13:07:43 -0500
Message-ID: <01fa01c22c2a$3011d9c0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@kevink.net>
To: "Ryan Martindale" <ryan@qsicorp.com>
Cc: <linux-mips@oss.sgi.com>
References: <3D3300A3.FD50EDEA@qsicorp.com> <01c401c22c1c$1973a170$10eca8c0@grendel> <3D330B04.CDE3E332@qsicorp.com>
Subject: Re: fpu woes (TX3912)
Date: Mon, 15 Jul 2002 20:04:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I am actually using the 2.4.18 stable kernel source, although I did
> check the 2.5.14 source tree I have to see if any modifications had
> taken place. My problem is the in signal.c function setup_sigcontext
> has:

If you mean 2.4.18 from kernel.org, it's missing a lot of MIPS
fixes, I'm sorry to say.  Most of them went in at 2.4.19-pre2 or so.

> if (current->used_math) { /* fp is active.  */
> set_cp0_status(ST0_CU1);
> err |= save_fp_context(sc);
> last_task_used_math = NULL;
> regs->cp0_status &= ~ST0_CU1;
> current->used_math = 0;
> }
> 
> There is no check to see if I have an FPU. I modified it to:
> 
> if (current->used_math) { /* fp is active.  */
> if (mips_cpu.options & MIPS_CPU_FPU) {
> set_cp0_status(ST0_CU1);
> err |= save_fp_context(sc);
> regs->cp0_status &= ~ST0_CU1;
> }
> last_task_used_math = NULL;
> current->used_math = 0;
> }

This is a known (and old) problem, with a fix that somehow didn't
get distributed widely enough.   There are probably related problems
in the sources you are using that will likewise cause random core
dumps when the FP is used on a loaded system.  The 2.4.x branch
of the sources at http://oss.sgi.com/mips/ should have the full set
of fixes.

> And now I am not crashing. As far as how it is supposed to be setup, I
> don't really know - like I said, I'm pretty new at this. I don't see any
> ifdefs/checks around the code in traps.c
> 
> case CPU_R2000:
> case CPU_R3000:
> case CPU_R3000A:
> case CPU_R3041:
> case CPU_R3051:
> case CPU_R3052:
> case CPU_R3081:
> case CPU_R3081E:
> case CPU_TX3912:
> case CPU_TX3922:
> case CPU_TX3927:
>         save_fp_context = _save_fp_context;
>         restore_fp_context = _restore_fp_context;

The following lines in my copy of the file are:
                memcpy((void *)(KSEG0 + 0x80), &except_vec3_generic, 0x80);
                break;

        case CPU_UNKNOWN:
        default:
                panic("Unknown CPU type");
        }
        if (!(mips_cpu.options & MIPS_CPU_FPU)) {
                save_fp_context = fpu_emulator_save_context;
                restore_fp_context = fpu_emulator_restore_context;
        }

This should overwrite the fp_context save/restore pointers
with those of the emulator.  If that clause doesn't appear
in your traps.c file, please try putting it in.

            Regards,

            Kevin K.
