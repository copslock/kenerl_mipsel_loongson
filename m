Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2010 19:52:25 +0100 (CET)
Received: from gateway02.websitewelcome.com ([69.56.170.20]:53936 "HELO
        gateway02.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491847Ab0LISwV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Dec 2010 19:52:21 +0100
Received: (qmail 4883 invoked from network); 9 Dec 2010 18:51:59 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway02.websitewelcome.com with SMTP; 9 Dec 2010 18:51:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=OnLxfoov2IdmAskBIOhmEf7+LHvDaIwQlzeCPkRiidjqwaSnUdoMzh4BvMu8BmklftPob7Lug+n/o2n+vs95UVKZRL91H+eyYEWV+JstsSFU40aTSBXErwi+QkOBE+Ui;
Received: from [216.239.45.4] (port=27791 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PQlbB-000712-CR; Thu, 09 Dec 2010 12:52:13 -0600
Message-ID: <4D012560.6020003@paralogos.com>
Date:   Thu, 09 Dec 2010 10:52:16 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
CC:     linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

I used to do occasional tests and damage control patches for SMTC, but 
haven't had the time and resources for the past year or so.  The 
"Calibrating delay loop" hang is an absolutely classic hang in SMTC 
systems that stems from the interrupt management system not being 
properly set up.  Ralf alluded to the intra-TC timer propagation 
protocol, but your problem could just as easily (more easily, actually) 
have to do with enable mask management. In order to keep multiple 
threads from "convoying" into interrupt handlers chasing a single event, 
SMTC manipulates the interrupt enable mask at entry into an interrupt 
exception to ensure that only the initial TC goes after it.  The 
interrupt is unmasked once the interrupt handler has quenched the source 
and invoked the IRQ ack function.  Unfortunately, generic timer 
functions don't always do the canonical source quench performed by most 
device driver interrupt handlers. I tried to make all this 
self-contained in generic architecture-specific code, but at some point 
it ended up being cleaner and more efficient to have *some* hooks in 
platform specific timer code.  It was there for Malta in the kernel.org 
mainline once upon a time, and I *thought* we'd propagated working code 
for the initial PMC-Sierra 34K-based SoC's at least as far as 
linux-mips.org, but the source tree has been considerably reorganized - 
there was a time when some of the hooks were under 
arch/mips/mips-boards/generic, which no longer exists - and I'm not sure 
where to point you.  Git and grep are your friends.

The first order of business is to break into that hung timer calibration 
loop and dump the CP0 registers for the VPE and the TCs, in particular 
checking the interrupt enable mask in Status against the pending 
interrupts in the Cause register.   If you're seeing the timer 
interrupt's bit set in Cause, but clear in Status, you need to fix the 
SMTC interrupt mask hook for your platform timer.  If that's *not* it, 
check to see if you're building for "tickless" operation.  Tickless ends 
up being really important for SMTC, and I did get it working properly 
back in 2008, but I the SMTC-specific cevt-smtc.c code uses common 
functions in cevt-r4k.c, and I've seen some patches to cevt-r4k.c going 
by that I rather doubt were ever tested against an SMTC build/platform.  
There might have been breakage there, and configuring to use a fixed 
interval timer (say, 100Hz) would be a way to test that hypothesis.

             Regards,

             Kevin K.

On 12/08/10 05:48, Anoop P.A. wrote:
> Hi list,
>
> Any body is aware of SMTC support status in latest git sources?. I have tried testing SMTC kernel for malta in qemu / OVP without any success ( emulators not working for 34k).
>
> I am trying to bring up SMTC Linux support for an mips34K based soc ( MSP71xx family).
>
> While booting , kernel getting hung on calibrate loop delay. I am getting only one interrupt from timer. With similar smtc platform support file (  changed to map smp_ops structure)  2.6.24-stable branch kernel ( where latest timer structure introduced) boots fine.
>
> [    0.000000] Linux version 2.6.37-rc1-pmc-00197-g5bfd3ba-dirty (paanoop1@paanoop1-desktop) (gcc version 4.5.1 (GCC) ) #168 SMP PREEMPT Wed Dec 8 19:19:490
> [    0.000000] DSPRAM0: PA=1c100000,Size=00008000,enabled
> [    0.000000] UART clock set to 50000000
> [    0.000000] CPU revision is: 00019548 (MIPS 34Kc)
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 00001000 @ 00000000 (reserved)
> [    0.000000]  memory: 000ff000 @ 00001000 (usable)
> [    0.000000]  memory: 003f2000 @ 00100000 (reserved)
> [    0.000000]  memory: 0fad9200 @ 004f2000 (usable)
> [    0.000000] Wasting 32 bytes for tracking 1 unused pages
> [    0.000000] Zone PFN ranges:
> [    0.000000]   Normal   0x00000000 ->  0x0000ffcb
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0: 0x00000000 ->  0x0000ffcb
> [    0.000000] 6 available secondary CPU TC(s)
> [    0.000000] PERCPU: Embedded 7 pages/cpu @81203000 s6464 r8192 d14016 u32768
> [    0.000000] pcpu-alloc: s6464 r8192 d14016 u32768 alloc=8*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64971
> [    0.000000] Kernel command line: console=ttyS0,57600
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
> [    0.000000] Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
> [    0.000000] Writing ErrCtl register=00000000
> [    0.000000] Readback ErrCtl register=00000000
> [    0.000000] Memory: 254360k/257888k available (3081k kernel code, 3528k reserved, 653k data, 200k init, 0k highmem)
> [    0.000000] Preemptable hierarchical RCU implementation.
> [    0.000000] NR_IRQS:128
> [    0.000000] console [ttyS0] enabled
> [    0.000000] Clock rate set to 600000000
> [    0.000000] Calibrating delay loop...
>
> Any idea to debug the issue ?.
>
> Thanks,
> Anoop
>
>
>
>    
