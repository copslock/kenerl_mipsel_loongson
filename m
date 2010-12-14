Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2010 16:26:11 +0100 (CET)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:57196 "EHLO
        bby1mta03.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab0LNP0G convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Dec 2010 16:26:06 +0100
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 7FBFF10700B7;
        Tue, 14 Dec 2010 07:25:58 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (bby1exg02 [216.241.231.167])
        by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id 6265410700B6;
        Tue, 14 Dec 2010 07:25:58 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.159]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 14 Dec 2010 07:25:58 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SMTC support status in latest git head.
Date:   Tue, 14 Dec 2010 07:25:53 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C020140595CEB0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <4D012560.6020003@paralogos.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMTC support status in latest git head.
Thread-Index: AcuX0j1PIAaj8jwdRr+Z/ybT5uUfCQDzTakg
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <4D012560.6020003@paralogos.com>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 14 Dec 2010 15:25:58.0555 (UTC) FILETIME=[353FF6B0:01CB9BA3]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

> it ended up being cleaner and more efficient to have *some* hooks in
> platform specific timer code.  It was there for Malta in the
kernel.org
> mainline once upon a time, and I *thought* we'd propagated working
code
> for the initial PMC-Sierra 34K-based SoC's at least as far as
[Anoop P.A.] 
I was able to boot 2.6.24-7 git sources with a change in cevt-r4k.c (
c0_compare_int_pending changed as following "return (read_c0_cause() >>
cp0_compare_irq_shift) & (1ul << CAUSEB_IP)"
 
> linux-mips.org, but the source tree has been considerably reorganized
-
> there was a time when some of the hooks were under
> arch/mips/mips-boards/generic, which no longer exists - and I'm not
sure
> where to point you.  Git and grep are your friends.
[Anoop P.A.]malta code has been moved to arch/mips/mti-malta/
Can you recollect the version of l-m-o kernel with a known working SMTC
support ?.

> 
> The first order of business is to break into that hung timer
calibration
> loop and dump the CP0 registers for the VPE and the TCs, in particular
> checking the interrupt enable mask in Status against the pending
> interrupts in the Cause register.   If you're seeing the timer
> interrupt's bit set in Cause, but clear in Status, you need to fix the
> SMTC interrupt mask hook for your platform timer.  
[Anoop P.A.] 
I tried dumping registers from calibration while loop.
It looks like the timer interrupt bit stay high on both cause and status
register ( in my case timer interrupt is connected to Cascaded CIC
interrupt which is connected to irq -6 ( C_IRQ4)). Detailed log pasted
below

> check to see if you're building for "tickless" operation.  Tickless
ends
> up being really important for SMTC, and I did get it working properly
> back in 2008, but I the SMTC-specific cevt-smtc.c code uses common
> functions in cevt-r4k.c, and I've seen some patches to cevt-r4k.c
going
> by that I rather doubt were ever tested against an SMTC
build/platform.
> There might have been breakage there, and configuring to use a fixed
> interval timer (say, 100Hz) would be a way to test that hypothesis.

[Anoop P.A.] I have tried both tickles and fixed interval timer.

> 
>              Regards,
> 
>              Kevin K.


[Anoop P.A.] Thanks much for your and Ralf's detailed response. 
> 
[Anoop P.A.] 
[    0.000000] Writing ErrCtl register=00000000
[    0.000000] Readback ErrCtl register=00000000
[    0.000000] Memory: 254384k/257912k available (3062k kernel code,
3528k reserved, 648k data, 200k init, 0k highmem)
[    0.000000] Preemptable hierarchical RCU implementation.
[    0.000000] NR_IRQS:128
[    0.000000] console [ttyS0] enabled
[    0.000000] Clock rate set to 600000000
[    0.000000] Calibrating delay loop... === MIPS MT State Dump ===
[    0.000000] -- Global State --
[    0.000000]    MVPControl Passed: 00000000
[    0.000000]    MVPControl Read: 00000000
[    0.000000]    MVPConf0 : a8008406
[    0.000000] -- per-VPE State --
[    0.000000]   VPE 0
[    0.000000]    VPEControl : 00000000
[    0.000000]    VPEConf0 : 800f0003
[    0.000000]    VPE0.Status : 11004001
[    0.000000]    VPE0.EPC : 80100000 _stext+0x0/0x10
[    0.000000]    VPE0.Cause : 40804000
[    0.000000]    VPE0.Config7 : 00010000
[    0.000000]   VPE 1
[    0.000000]    VPEControl : 00060000
[    0.000000]    VPEConf0 : 800f0000
[    0.000000]    VPE1.Status : 00408305
[    0.000000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
[    0.000000]    VPE1.Cause : 40000200
[    0.000000]    VPE1.Config7 : 00010000
[    0.000000] -- per-TC State --
[    0.000000]   TC 0 (current TC with VPE EPC above)
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00000000
[    0.000000]    TCRestart : 8010d860 mips_mt_regdump+0x2f0/0x3c4
[    0.000000]    TCHalt : 00000000
[    0.000000]    TCContext : 00000000
[    0.000000]   TC 1
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00200001
[    0.000000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00180000
[    0.000000]   TC 2
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00400001
[    0.000000]    TCRestart : 7ffffffc 0x7ffffffc
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00300000
[    0.000000]   TC 3
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00600001
[    0.000000]    TCRestart : fff7ffae 0xfff7ffae
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00480000
[    0.000000]   TC 4
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00800001
[    0.000000]    TCRestart : f3fff7fe 0xf3fff7fe
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00600000
[    0.000000]   TC 5
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00a00001
[    0.000000]    TCRestart : 7ffffbfe 0x7ffffbfe
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00780000
[    0.000000]   TC 6
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00c00001
[    0.000000]    TCRestart : ffff7ffe 0xffff7ffe
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00900000
[    0.000000] Counter Interrupts taken per CPU (TC)
[    0.000000] 0: 0
[    0.000000] 1: 0
[    0.000000] 2: 0
[    0.000000] 3: 0
[    0.000000] 4: 0
[    0.000000] 5: 0
[    0.000000] 6: 0
[    0.000000] 7: 0
[    0.000000] Self-IPI invocations:
[    0.000000] 0: 0
[    0.000000] 1: 0
[    0.000000] 2: 0
[    0.000000] 3: 0
[    0.000000] 4: 0
[    0.000000] 5: 0
[    0.000000] 6: 0
[    0.000000] 7: 0
[    0.000000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] 0 Recoveries of "stolen" FPU
[    0.000000] ===========================
[    0.000000] In platform cic dispatch cic_mask=0x22000 stat=0x2402000f
pend=0x20000
[    0.010000] === MIPS MT State Dump ===
[    0.010000] -- Global State --
[    0.010000]    MVPControl Passed: 00000000
[    0.010000]    MVPControl Read: 00000000
[    0.010000]    MVPConf0 : a8008406
[    0.010000] -- per-VPE State --
[    0.010000]   VPE 0
[    0.010000]    VPEControl : 00000000
[    0.010000]    VPEConf0 : 800f0003
[    0.010000]    VPE0.Status : 18004000
[    0.010000]    VPE0.EPC : 8010d900 mips_mt_regdump+0x390/0x3c4
[    0.010000]    VPE0.Cause : 40804000
[    0.010000]    VPE0.Config7 : 00010000
[    0.010000]   VPE 1
[    0.010000]    VPEControl : 00060000
[    0.010000]    VPEConf0 : 800f0000
[    0.010000]    VPE1.Status : 00408305
[    0.010000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
[    0.010000]    VPE1.Cause : 40000200
[    0.010000]    VPE1.Config7 : 00010000
[    0.010000] -- per-TC State --
[    0.010000]   TC 0 (current TC with VPE EPC above)
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00000000
[    0.010000]    TCRestart : 803f791c printk+0xc/0x30
[    0.010000]    TCHalt : 00000000
[    0.010000]    TCContext : 00000000
[    0.010000]   TC 1
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00200001
[    0.010000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00180000
[    0.010000]   TC 2
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00400001
[    0.010000]    TCRestart : 7ffffffc 0x7ffffffc
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00300000
[    0.010000]   TC 3
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00600001
[    0.010000]    TCRestart : fff7ffae 0xfff7ffae
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00480000
[    0.010000]   TC 4
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00800001
[    0.010000]    TCRestart : f3fff7fe 0xf3fff7fe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00600000
[    0.010000]   TC 5
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00a00001
[    0.010000]    TCRestart : 7ffffbfe 0x7ffffbfe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00780000
[    0.010000]   TC 6
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00c00001
[    0.010000]    TCRestart : ffff7ffe 0xffff7ffe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00900000
[    0.010000] Counter Interrupts taken per CPU (TC)
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] Self-IPI invocations:
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] 0 Recoveries of "stolen" FPU
[    0.010000] ===========================
[    0.010000] === MIPS MT State Dump ===
[    0.010000] -- Global State --
[    0.010000]    MVPControl Passed: 00000000
[    0.010000]    MVPControl Read: 00000000
[    0.010000]    MVPConf0 : a8008406
[    0.010000] -- per-VPE State --
[    0.010000]   VPE 0
[    0.010000]    VPEControl : 00000000
[    0.010000]    VPEConf0 : 800f0003
[    0.010000]    VPE0.Status : 18004000
[    0.010000]    VPE0.EPC : 8010d900 mips_mt_regdump+0x390/0x3c4
[    0.010000]    VPE0.Cause : 40804000
[    0.010000]    VPE0.Config7 : 00010000
[    0.010000]   VPE 1
[    0.010000]    VPEControl : 00060000
[    0.010000]    VPEConf0 : 800f0000
[    0.010000]    VPE1.Status : 00408305
[    0.010000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
[    0.010000]    VPE1.Cause : 40000200
[    0.010000]    VPE1.Config7 : 00010000
[    0.010000] -- per-TC State --
[    0.010000]   TC 0 (current TC with VPE EPC above)
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00000000
[    0.010000]    TCRestart : 803f791c printk+0xc/0x30
[    0.010000]    TCHalt : 00000000
[    0.010000]    TCContext : 00000000
[    0.010000]   TC 1
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00200001
[    0.010000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00180000
[    0.010000]   TC 2
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00400001
[    0.010000]    TCRestart : 7ffffffc 0x7ffffffc
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00300000
[    0.010000]   TC 3
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00600001
[    0.010000]    TCRestart : fff7ffae 0xfff7ffae
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00480000
[    0.010000]   TC 4
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00800001
[    0.010000]    TCRestart : f3fff7fe 0xf3fff7fe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00600000
[    0.010000]   TC 5
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00a00001
[    0.010000]    TCRestart : 7ffffbfe 0x7ffffbfe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00780000
[    0.010000]   TC 6
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00c00001
[    0.010000]    TCRestart : ffff7ffe 0xffff7ffe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00900000
[    0.010000] Counter Interrupts taken per CPU (TC)
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] Self-IPI invocations:
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] 0 Recoveries of "stolen" FPU
[    0.010000] ===========================
[    0.010000] === MIPS MT State Dump ===
[    0.010000] -- Global State --
[    0.010000]    MVPControl Passed: 00000000
[    0.010000]    MVPControl Read: 00000000
[    0.010000]    MVPConf0 : a8008406
[    0.010000] -- per-VPE State --
[    0.010000]   VPE 0
[    0.010000]    VPEControl : 00000000
[    0.010000]    VPEConf0 : 800f0003
[    0.010000]    VPE0.Status : 18004000
[    0.010000]    VPE0.EPC : 8010d900 mips_mt_regdump+0x390/0x3c4
[    0.010000]    VPE0.Cause : 40804000
[    0.010000]    VPE0.Config7 : 00010000
[    0.010000]   VPE 1
[    0.010000]    VPEControl : 00060000
[    0.010000]    VPEConf0 : 800f0000
[    0.010000]    VPE1.Status : 00408305
[    0.010000]    VPE1.EPC : 801024e0 except_vec_vi+0x0/0x84
[    0.010000]    VPE1.Cause : 40000200
[    0.010000]    VPE1.Config7 : 00010000
[    0.010000] -- per-TC State --
[    0.010000]   TC 0 (current TC with VPE EPC above)
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00000000
[    0.010000]    TCRestart : 803f791c printk+0xc/0x30
[    0.010000]    TCHalt : 00000000
[    0.010000]    TCContext : 00000000
[    0.010000]   TC 1
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00200001
[    0.010000]    TCRestart : 80104b64 copy_thread+0x2ac/0x2b4
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00180000
[    0.010000]   TC 2
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00400001
[    0.010000]    TCRestart : 7ffffffc 0x7ffffffc
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00300000
[    0.010000]   TC 3
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00600001
[    0.010000]    TCRestart : fff7ffae 0xfff7ffae
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00480000
[    0.010000]   TC 4
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00800001
[    0.010000]    TCRestart : f3fff7fe 0xf3fff7fe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00600000
[    0.010000]   TC 5
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00a00001
[    0.010000]    TCRestart : 7ffffbfe 0x7ffffbfe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00780000
[    0.010000]   TC 6
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00c00001
[    0.010000]    TCRestart : ffff7ffe 0xffff7ffe
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00900000
[    0.010000] Counter Interrupts taken per CPU (TC)
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] Self-IPI invocations:
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] 0 Recoveries of "stolen" FPU
