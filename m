Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HJXJnC029098
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 12:33:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HJXJlR029097
	for linux-mips-outgoing; Mon, 17 Jun 2002 12:33:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HJX7nC029094
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 12:33:07 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA05594;
	Mon, 17 Jun 2002 12:33:18 -0700
Message-ID: <3D0E38E8.10804@mvista.com>
Date: Mon, 17 Jun 2002 12:30:48 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: Louis Hamilton <hamilton@redhat.com>, linux-mips@oss.sgi.com,
   sandcraft-elinux-project@redhat.com
Subject: Re: Bug in Linux?  fcr31 not being saved-restored
References: <3D0BD42E.20602@redhat.com> <3D0D7F98.566B3176@mips.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten Langgaard wrote:

> This is one of the bugs, among others, we have fixed.
> I'm not sure, if Ralf have integrated the patches we send him yet.
> 


Carsten,

Do you remember the cause and the fix?  It appears to me the first ctc1 
instruction should trap into kernel and mark current process as fpu owner, and 
should not cause fcr31 corruption.

Or somehow the ctc1 does not trap into kernel?

Jun


> /Carsten
> 
> Louis Hamilton wrote:
> 
> 
>>We have a customer here testing a 2.4.16 mips kernel on an embedded
>>Linux RM7000/SR71000 based system who has written a test that they
>>believe has uncovered a bug in Linux.  The FPU control register appears
>>to not get saved and restored.  I've reproduced the problem described
>>below and find the results consistent with their description.  The
>>problem occurs on both the RM7000 and SR71000 cpus.
>>
>>It looks like save_fp_context and restore_fp_context are not being
>>called since the kernel save-restore logic thinks the process is not
>>using floating point math.  If you do some fp math before calling the
>>test routine below, it seems to works fine.
>>
>>Is this a known caveat?  A true bug?  Or a contorted corner case
>>unlikely to be seen under typical end-user usage (see customer's
>>last paragraph :-) ?   If true bug, recommended remedy?
>>
>>TIA,
>>Louis
>>
>>Louis Hamilton
>>hamilton@redhat.com
>>
>>------ customer reports the following: ---------
>>We found a bug in Linux.  A ^C (control-C) typed into a shell (or a
>>running program, it doesn't matter), causes the FCR (floating-point
>>control register) to be corrupted in another, unrelated process.  This
>>is repeatable behavior.
>>
>>This can be reproduced with the following short assembly language
>>program that loops forever, waiting for the FCR to change.
>>
>>        .align 2
>>        .globl mips_float_debug_loop
>>mips_float_debug_loop:
>>        li      $9, 0xF000F02F
>>        ctc1    $9, $31         # set FCR to some non-zero value
>>        nop
>>1:      cfc1    $8, $31         # get FCR
>>        beq     $8, $9, 1b      # spin, waiting for FCR to change
>>        nop
>>        or      $2, $0, $8
>>        jr    $31
>>        nop
>>
>>You can call this function from a short C program and the return value
>>is the (corrupted) FCR, which turns out to alwyas be: 0x00000002.
>>
>>Run the above loop in one window (connected to the board using telnet)
>>and then in another window (connected to the same board) type ^C.
>>
>>I'm surprised this bug hasn't been encountered by other MIPS vendors.
>>
>><end>
>>
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
