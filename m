Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IHninC025577
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 10:49:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IHni1p025576
	for linux-mips-outgoing; Tue, 18 Jun 2002 10:49:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IHnNnC025572
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 10:49:23 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA02555;
	Tue, 18 Jun 2002 10:52:02 -0700
Message-ID: <3D0F7213.6000002@mvista.com>
Date: Tue, 18 Jun 2002 10:46:59 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: Louis Hamilton <hamilton@redhat.com>, linux-mips@oss.sgi.com,
   sandcraft-elinux-project@redhat.com
Subject: Re: Bug in Linux?  fcr31 not being saved-restored
References: <3D0BD42E.20602@redhat.com> <3D0D7F98.566B3176@mips.com> <3D0E38E8.10804@mvista.com> <3D0EEA5A.1B5DAA23@mips.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Your first chunk is not clear as to where it applies.  Maybe you are using a 
different code base.

The second chunck is not necessary.  Although the FPU values in thread struct 
for the new thread are stale, the new program cannot assume the fpu register 
values and cannot use them without initialization anyway.

I don't see such a code in x86's code.  Current call to start_thread() is ok 
with or without this change.  I am afraid future use of start_thread() may 
give undesired effect after we make this change.

As for the new fpu context switch code, I wrote a experiemental patch after 
much discussion with Ralf and Kevin.  It is at

http://linux.junsun.net/patches/oss.sgi.com/experimental/020304-half-fpu-context-switch

I also did some performance study of this patch.  Did not get much feedbacks 
when I asked last time. :-(

Jun

Carsten Langgaard wrote:

> I believe this is the patch that solve the problem.
> The lazy fpu stuff has cause so many problems, that we have decided (together
> with Ralf) to get rid of it, and do the FPU context save and restore a little bit
> differently.
> We now have a solution here locally and we are testing it at the moment.
> 
> /Carsten
> 
> 
> Index: arch/mips/kernel/traps.c
> ===================================================================
> RCS file: /cvs/linux/arch/mips/kernel/traps.c,v
> retrieving revision 1.99.2.14
> diff -u -r1.99.2.14 traps.c
> --- arch/mips/kernel/traps.c    2002/05/28 06:33:13     1.99.2.14
> +++ arch/mips/kernel/traps.c    2002/06/18 07:53:47
> +               {
> +                       __enable_fpu();
>                         save_fp(last_task_used_math);
> +                       /* last_task_used_math loose fpu */
> +                       ((struct pt_regs *)(__KSTK_TOS(last_task_used_math) -
> +                                           sizeof(struct pt_regs)))->
> +                               cp0_status &= ~ST0_CU1;
> +               }
> 
> Index: include/asm-mips/processor.h
> ===================================================================
> RCS file: /cvs/linux/include/asm-mips/processor.h,v
> retrieving revision 1.43.2.2
> diff -u -r1.43.2.2 processor.h
> --- include/asm-mips/processor.h        2002/05/28 06:11:56     1.43.2.2
> +++ include/asm-mips/processor.h        2002/06/18 07:56:58
> @@ -215,6 +215,7 @@
>         regs->cp0_epc = new_pc;                                         \
>         regs->regs[29] = new_sp;                                        \
>         current->thread.current_ds = USER_DS;                           \
> +       current->used_math = 0;                                         \
>  } while (0)
> 
>  unsigned long get_wchan(struct task_struct *p);
> 
> 
> 
> Jun Sun wrote:
> 
> 
>>Carsten Langgaard wrote:
>>
>>
>>>This is one of the bugs, among others, we have fixed.
>>>I'm not sure, if Ralf have integrated the patches we send him yet.
>>>
>>>
>>Carsten,
>>
>>Do you remember the cause and the fix?  It appears to me the first ctc1
>>instruction should trap into kernel and mark current process as fpu owner, and
>>should not cause fcr31 corruption.
>>
>>Or somehow the ctc1 does not trap into kernel?
>>
>>Jun
>>
>>
>>>/Carsten
>>>
>>>Louis Hamilton wrote:
>>>
>>>
>>>
>>>>We have a customer here testing a 2.4.16 mips kernel on an embedded
>>>>Linux RM7000/SR71000 based system who has written a test that they
>>>>believe has uncovered a bug in Linux.  The FPU control register appears
>>>>to not get saved and restored.  I've reproduced the problem described
>>>>below and find the results consistent with their description.  The
>>>>problem occurs on both the RM7000 and SR71000 cpus.
>>>>
>>>>It looks like save_fp_context and restore_fp_context are not being
>>>>called since the kernel save-restore logic thinks the process is not
>>>>using floating point math.  If you do some fp math before calling the
>>>>test routine below, it seems to works fine.
>>>>
>>>>Is this a known caveat?  A true bug?  Or a contorted corner case
>>>>unlikely to be seen under typical end-user usage (see customer's
>>>>last paragraph :-) ?   If true bug, recommended remedy?
>>>>
>>>>TIA,
>>>>Louis
>>>>
>>>>Louis Hamilton
>>>>hamilton@redhat.com
>>>>
>>>>------ customer reports the following: ---------
>>>>We found a bug in Linux.  A ^C (control-C) typed into a shell (or a
>>>>running program, it doesn't matter), causes the FCR (floating-point
>>>>control register) to be corrupted in another, unrelated process.  This
>>>>is repeatable behavior.
>>>>
>>>>This can be reproduced with the following short assembly language
>>>>program that loops forever, waiting for the FCR to change.
>>>>
>>>>       .align 2
>>>>       .globl mips_float_debug_loop
>>>>mips_float_debug_loop:
>>>>       li      $9, 0xF000F02F
>>>>       ctc1    $9, $31         # set FCR to some non-zero value
>>>>       nop
>>>>1:      cfc1    $8, $31         # get FCR
>>>>       beq     $8, $9, 1b      # spin, waiting for FCR to change
>>>>       nop
>>>>       or      $2, $0, $8
>>>>       jr    $31
>>>>       nop
>>>>
>>>>You can call this function from a short C program and the return value
>>>>is the (corrupted) FCR, which turns out to alwyas be: 0x00000002.
>>>>
>>>>Run the above loop in one window (connected to the board using telnet)
>>>>and then in another window (connected to the same board) type ^C.
>>>>
>>>>I'm surprised this bug hasn't been encountered by other MIPS vendors.
>>>>
>>>><end>
>>>>
>>>--
>>>_    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
>>>|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
>>>| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>>>  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>>>                   Denmark            http://www.mips.com
>>>
>>>
>>>
>>>
>>>
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
