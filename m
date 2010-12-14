Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2010 19:33:30 +0100 (CET)
Received: from gateway08.websitewelcome.com ([67.18.34.19]:52914 "HELO
        gateway08.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491814Ab0LNSdE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Dec 2010 19:33:04 +0100
Received: (qmail 32079 invoked from network); 14 Dec 2010 18:32:39 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway08.websitewelcome.com with SMTP; 14 Dec 2010 18:32:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=vtZI1tCCt1neVqXSmcX5zvbVpeOvjaTGFsCE0C7MWkMrD6H4Tl1+Yu9a8jzVQE9DMdjPGLGM29lJj6cJa/7y3Niiab6HfH356MD3Q18CTf5G6Thl7o1fIlTy429dTcay;
Received: from [216.239.45.4] (port=33776 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PSZgH-00054z-AU; Tue, 14 Dec 2010 12:32:57 -0600
Message-ID: <4D07B859.2020805@paralogos.com>
Date:   Tue, 14 Dec 2010 10:32:57 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
CC:     linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <4D012560.6020003@paralogos.com> <A7DEA48C84FD0B48AAAE33F328C020140595CEB0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C020140595CEB0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
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
X-archive-position: 28641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Between your mailer and mine (Thunderbird 3.1 on Ubuntu), the quoting
has become something of a dogs breakfast, so let me just lay things out
here as best I can.

I can't comment on your tweak to 2.6.24.7 without seeing it as a patch
diff.

I am no longer associated with MIPS Technologies and no longer have
access to my email archives from that period.  If I did, I could tell you
which LMO kernel version(s) had SMTC working "out of the box".  There
definitely was at least one, and I commented on it in an email.  You
might be able to find it in the LMO email archives, but it's possible that
I only sent it to a MIPS internal mailing list.

There was also a message I wrote that I had *thought* had gone to
the LMO mailing list, but may have only been sent to a group of internal
MIPS and customer engineers, in which I described the recommended
procedure for debugging exactly this canonical problem with porting
SMTC.

The recommended procedure was, and remains, to isolate clock
propagation problems by using command line options "maxtcs="
and "maxvpes=".

First, boot your SMTC kernel with maxtcs=1 and maxvpes=1,
a virtual uniprocessor.  If that doesn't run, you've got some fundamental
problem with support for your platform, or someone has really fundamentally
broken the SMTC build somewhere.  Next, try booting with maxtcs=2
and maxvpes=1, then with no constraint on maxtcs and maxvpes=1.
If those fail, your problem is probably in the interrupt mask
management algorithms I described.

On the other hand, if you boot with maxtcs=2 and maxvpes=2,
there will be only one TC per VPE and far less vulnerability to interrupt
mask lockup, but you need to have cross-VPE IPI interrupts working.
The preferred method of doing cross-VPE IPIs would be to use a physical
interrupt  input that's instantiated per-VPE and manipulable by software.
Malta didn't have one, so there's the historical hack of using
MIPS MT instructions to freeze the other VPE and set up a
software interrupt using MTTR to the remote Cause register.
The PMC-Sierra platforms did, if I recall correctly, have some kind
of register that one could write to cause a real cross-VPE hardware
interrupt, but I don't recall whether it got used in the SMTC port.

Your dump below looks as if it comes from 2 TCs running on
2 VPEs, and that the interrupt mask issues I alluded to earlier
are neither relevant nor manifest.  It looks instead as if the
initialization of "CPU 1" (VPE1/TC1) may not have been done
properly.  Under normal operation, it would be pretty rare to
catch TC 1 in the exception vector dispatch code, so the first
hypothesis that comes to mind is that something isn't right in
the vector/handler setup, and TC 1 is stuck in an infinite exception
loop, unable to handshake with TC 0 and thus locking up the
system.  But that's just my best guess based on limited data.

             Regards,

             Kevin K.

On 12/14/10 07:25, Anoop P.A. wrote:
>> it ended up being cleaner and more efficient to have *some* hooks in
>> platform specific timer code.  It was there for Malta in the
> kernel.org
>> mainline once upon a time, and I *thought* we'd propagated working
> code
>> for the initial PMC-Sierra 34K-based SoC's at least as far as
> [Anoop P.A.]
> I was able to boot 2.6.24-7 git sources with a change in cevt-r4k.c (
> c0_compare_int_pending changed as following "return (read_c0_cause()>>
> cp0_compare_irq_shift)&  (1ul<<  CAUSEB_IP)"
>
>> linux-mips.org, but the source tree has been considerably reorganized
> -
>> there was a time when some of the hooks were under
>> arch/mips/mips-boards/generic, which no longer exists - and I'm not
> sure
>> where to point you.  Git and grep are your friends.
> [Anoop P.A.]malta code has been moved to arch/mips/mti-malta/
> Can you recollect the version of l-m-o kernel with a known working SMTC
> support ?.
>
>> The first order of business is to break into that hung timer
> calibration
>> loop and dump the CP0 registers for the VPE and the TCs, in particular
>> checking the interrupt enable mask in Status against the pending
>> interrupts in the Cause register.   If you're seeing the timer
>> interrupt's bit set in Cause, but clear in Status, you need to fix the
>> SMTC interrupt mask hook for your platform timer.
> [Anoop P.A.]
> I tried dumping registers from calibration while loop.
> It looks like the timer interrupt bit stay high on both cause and status
> register ( in my case timer interrupt is connected to Cascaded CIC
> interrupt which is connected to irq -6 ( C_IRQ4)). Detailed log pasted
> below
>
>> check to see if you're building for "tickless" operation.  Tickless
> ends
>> up being really important for SMTC, and I did get it working properly
>> back in 2008, but I the SMTC-specific cevt-smtc.c code uses common
>> functions in cevt-r4k.c, and I've seen some patches to cevt-r4k.c
> going
>> by that I rather doubt were ever tested against an SMTC
> build/platform.
>> There might have been breakage there, and configuring to use a fixed
>> interval timer (say, 100Hz) would be a way to test that hypothesis.
> [Anoop P.A.] I have tried both tickles and fixed interval timer.
>
>>               Regards,
>>
>>               Kevin K.
>
> [Anoop P.A.] Thanks much for your and Ralf's detailed response.
> [Anoop P.A.]
> [    0.000000] Writing ErrCtl register=00000000
> [    0.000000] Readback ErrCtl register=00000000
> [    0.000000] Memory: 254384k/257912k available (3062k kernel code,
> 3528k reserved, 648k data, 200k init, 0k highmem)
> [    0.000000] Preemptable hierarchical RCU implementation.
> [    0.000000] NR_IRQS:128
> [    0.000000] console [ttyS0] enabled
> [    0.000000] Clock rate set to 600000000
> [    0.000000] Calibrating delay loop... === MIPS MT State Dump ===
> [    0.000000] -- Global State --
> [    0.000000]    MVPControl Passed: 00000000
> [    0.000000]    MVPControl Read: 00000000
> [    0.000000]    MVPConf0 : a8008406
> [    0.000000] -- per-VPE State --
> [    0.000000]   VPE 0
> [    0.000000]    VPEControl : 00000000
> [    0.000000]    VPEConf0 : 800f0003
> [    0.000000]    VPE0.Status : 11004001
> [    0.000000]    VPE0.EPC : 80100000 _stext+0x0/0x10
> [    0.000000]    VPE0.Cause : 40804000
> [    0.000000]    VPE0.Config7 : 00010000
> [    0.000000]   VPE 1
> [    0.000000]    VPEControl : 00060000
> [    0.000000]    VPEConf0 : 800f0000
> [    0.000000]    VPE1.Status : 00408305
> [    0.000000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
> [    0.000000]    VPE1.Cause : 40000200
> [    0.000000]    VPE1.Config7 : 00010000
> [    0.000000] -- per-TC State --
> [    0.000000]   TC 0 (current TC with VPE EPC above)
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00000000
> [    0.000000]    TCRestart : 8010d860 mips_mt_regdump+0x2f0/0x3c4
> [    0.000000]    TCHalt : 00000000
> [    0.000000]    TCContext : 00000000
> [    0.000000]   TC 1
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00200001
> [    0.000000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00180000
> [    0.000000]   TC 2
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00400001
> [    0.000000]    TCRestart : 7ffffffc 0x7ffffffc
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00300000
> [    0.000000]   TC 3
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00600001
> [    0.000000]    TCRestart : fff7ffae 0xfff7ffae
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00480000
> [    0.000000]   TC 4
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00800001
> [    0.000000]    TCRestart : f3fff7fe 0xf3fff7fe
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00600000
> [    0.000000]   TC 5
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00a00001
> [    0.000000]    TCRestart : 7ffffbfe 0x7ffffbfe
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00780000
> [    0.000000]   TC 6
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00c00001
> [    0.000000]    TCRestart : ffff7ffe 0xffff7ffe
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00900000
> [    0.000000] Counter Interrupts taken per CPU (TC)
> [    0.000000] 0: 0
> [    0.000000] 1: 0
> [    0.000000] 2: 0
> [    0.000000] 3: 0
> [    0.000000] 4: 0
> [    0.000000] 5: 0
> [    0.000000] 6: 0
> [    0.000000] 7: 0
> [    0.000000] Self-IPI invocations:
> [    0.000000] 0: 0
> [    0.000000] 1: 0
> [    0.000000] 2: 0
> [    0.000000] 3: 0
> [    0.000000] 4: 0
> [    0.000000] 5: 0
> [    0.000000] 6: 0
> [    0.000000] 7: 0
> [    0.000000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
> [    0.000000] 0 Recoveries of "stolen" FPU
> [    0.000000] ===========================
> [    0.000000] In platform cic dispatch cic_mask=0x22000 stat=0x2402000f
> pend=0x20000
> [    0.010000] === MIPS MT State Dump ===
> [    0.010000] -- Global State --
> [    0.010000]    MVPControl Passed: 00000000
> [    0.010000]    MVPControl Read: 00000000
> [    0.010000]    MVPConf0 : a8008406
> [    0.010000] -- per-VPE State --
> [    0.010000]   VPE 0
> [    0.010000]    VPEControl : 00000000
> [    0.010000]    VPEConf0 : 800f0003
> [    0.010000]    VPE0.Status : 18004000
> [    0.010000]    VPE0.EPC : 8010d900 mips_mt_regdump+0x390/0x3c4
> [    0.010000]    VPE0.Cause : 40804000
> [    0.010000]    VPE0.Config7 : 00010000
> [    0.010000]   VPE 1
> [    0.010000]    VPEControl : 00060000
> [    0.010000]    VPEConf0 : 800f0000
> [    0.010000]    VPE1.Status : 00408305
> [    0.010000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
> [    0.010000]    VPE1.Cause : 40000200
> [    0.010000]    VPE1.Config7 : 00010000
> [    0.010000] -- per-TC State --
> [    0.010000]   TC 0 (current TC with VPE EPC above)
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00000000
> [    0.010000]    TCRestart : 803f791c printk+0xc/0x30
> [    0.010000]    TCHalt : 00000000
> [    0.010000]    TCContext : 00000000
> [    0.010000]   TC 1
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00200001
> [    0.010000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00180000
> [    0.010000]   TC 2
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00400001
> [    0.010000]    TCRestart : 7ffffffc 0x7ffffffc
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00300000
> [    0.010000]   TC 3
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00600001
> [    0.010000]    TCRestart : fff7ffae 0xfff7ffae
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00480000
> [    0.010000]   TC 4
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00800001
> [    0.010000]    TCRestart : f3fff7fe 0xf3fff7fe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00600000
> [    0.010000]   TC 5
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00a00001
> [    0.010000]    TCRestart : 7ffffbfe 0x7ffffbfe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00780000
> [    0.010000]   TC 6
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00c00001
> [    0.010000]    TCRestart : ffff7ffe 0xffff7ffe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00900000
> [    0.010000] Counter Interrupts taken per CPU (TC)
> [    0.010000] 0: 0
> [    0.010000] 1: 0
> [    0.010000] 2: 0
> [    0.010000] 3: 0
> [    0.010000] 4: 0
> [    0.010000] 5: 0
> [    0.010000] 6: 0
> [    0.010000] 7: 0
> [    0.010000] Self-IPI invocations:
> [    0.010000] 0: 0
> [    0.010000] 1: 0
> [    0.010000] 2: 0
> [    0.010000] 3: 0
> [    0.010000] 4: 0
> [    0.010000] 5: 0
> [    0.010000] 6: 0
> [    0.010000] 7: 0
> [    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] 0 Recoveries of "stolen" FPU
> [    0.010000] ===========================
> [    0.010000] === MIPS MT State Dump ===
> [    0.010000] -- Global State --
> [    0.010000]    MVPControl Passed: 00000000
> [    0.010000]    MVPControl Read: 00000000
> [    0.010000]    MVPConf0 : a8008406
> [    0.010000] -- per-VPE State --
> [    0.010000]   VPE 0
> [    0.010000]    VPEControl : 00000000
> [    0.010000]    VPEConf0 : 800f0003
> [    0.010000]    VPE0.Status : 18004000
> [    0.010000]    VPE0.EPC : 8010d900 mips_mt_regdump+0x390/0x3c4
> [    0.010000]    VPE0.Cause : 40804000
> [    0.010000]    VPE0.Config7 : 00010000
> [    0.010000]   VPE 1
> [    0.010000]    VPEControl : 00060000
> [    0.010000]    VPEConf0 : 800f0000
> [    0.010000]    VPE1.Status : 00408305
> [    0.010000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
> [    0.010000]    VPE1.Cause : 40000200
> [    0.010000]    VPE1.Config7 : 00010000
> [    0.010000] -- per-TC State --
> [    0.010000]   TC 0 (current TC with VPE EPC above)
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00000000
> [    0.010000]    TCRestart : 803f791c printk+0xc/0x30
> [    0.010000]    TCHalt : 00000000
> [    0.010000]    TCContext : 00000000
> [    0.010000]   TC 1
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00200001
> [    0.010000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00180000
> [    0.010000]   TC 2
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00400001
> [    0.010000]    TCRestart : 7ffffffc 0x7ffffffc
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00300000
> [    0.010000]   TC 3
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00600001
> [    0.010000]    TCRestart : fff7ffae 0xfff7ffae
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00480000
> [    0.010000]   TC 4
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00800001
> [    0.010000]    TCRestart : f3fff7fe 0xf3fff7fe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00600000
> [    0.010000]   TC 5
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00a00001
> [    0.010000]    TCRestart : 7ffffbfe 0x7ffffbfe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00780000
> [    0.010000]   TC 6
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00c00001
> [    0.010000]    TCRestart : ffff7ffe 0xffff7ffe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00900000
> [    0.010000] Counter Interrupts taken per CPU (TC)
> [    0.010000] 0: 0
> [    0.010000] 1: 0
> [    0.010000] 2: 0
> [    0.010000] 3: 0
> [    0.010000] 4: 0
> [    0.010000] 5: 0
> [    0.010000] 6: 0
> [    0.010000] 7: 0
> [    0.010000] Self-IPI invocations:
> [    0.010000] 0: 0
> [    0.010000] 1: 0
> [    0.010000] 2: 0
> [    0.010000] 3: 0
> [    0.010000] 4: 0
> [    0.010000] 5: 0
> [    0.010000] 6: 0
> [    0.010000] 7: 0
> [    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] 0 Recoveries of "stolen" FPU
> [    0.010000] ===========================
> [    0.010000] === MIPS MT State Dump ===
> [    0.010000] -- Global State --
> [    0.010000]    MVPControl Passed: 00000000
> [    0.010000]    MVPControl Read: 00000000
> [    0.010000]    MVPConf0 : a8008406
> [    0.010000] -- per-VPE State --
> [    0.010000]   VPE 0
> [    0.010000]    VPEControl : 00000000
> [    0.010000]    VPEConf0 : 800f0003
> [    0.010000]    VPE0.Status : 18004000
> [    0.010000]    VPE0.EPC : 8010d900 mips_mt_regdump+0x390/0x3c4
> [    0.010000]    VPE0.Cause : 40804000
> [    0.010000]    VPE0.Config7 : 00010000
> [    0.010000]   VPE 1
> [    0.010000]    VPEControl : 00060000
> [    0.010000]    VPEConf0 : 800f0000
> [    0.010000]    VPE1.Status : 00408305
> [    0.010000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
> [    0.010000]    VPE1.Cause : 40000200
> [    0.010000]    VPE1.Config7 : 00010000
> [    0.010000] -- per-TC State --
> [    0.010000]   TC 0 (current TC with VPE EPC above)
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00000000
> [    0.010000]    TCRestart : 803f791c printk+0xc/0x30
> [    0.010000]    TCHalt : 00000000
> [    0.010000]    TCContext : 00000000
> [    0.010000]   TC 1
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00200001
> [    0.010000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00180000
> [    0.010000]   TC 2
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00400001
> [    0.010000]    TCRestart : 7ffffffc 0x7ffffffc
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00300000
> [    0.010000]   TC 3
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00600001
> [    0.010000]    TCRestart : fff7ffae 0xfff7ffae
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00480000
> [    0.010000]   TC 4
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00800001
> [    0.010000]    TCRestart : f3fff7fe 0xf3fff7fe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00600000
> [    0.010000]   TC 5
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00a00001
> [    0.010000]    TCRestart : 7ffffbfe 0x7ffffbfe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00780000
> [    0.010000]   TC 6
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00c00001
> [    0.010000]    TCRestart : ffff7ffe 0xffff7ffe
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00900000
> [    0.010000] Counter Interrupts taken per CPU (TC)
> [    0.010000] 0: 0
> [    0.010000] 1: 0
> [    0.010000] 2: 0
> [    0.010000] 3: 0
> [    0.010000] 4: 0
> [    0.010000] 5: 0
> [    0.010000] 6: 0
> [    0.010000] 7: 0
> [    0.010000] Self-IPI invocations:
> [    0.010000] 0: 0
> [    0.010000] 1: 0
> [    0.010000] 2: 0
> [    0.010000] 3: 0
> [    0.010000] 4: 0
> [    0.010000] 5: 0
> [    0.010000] 6: 0
> [    0.010000] 7: 0
> [    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
> [    0.010000] 0 Recoveries of "stolen" FPU
>
>
>
