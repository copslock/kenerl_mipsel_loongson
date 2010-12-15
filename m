Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2010 20:58:46 +0100 (CET)
Received: from gateway02.websitewelcome.com ([67.18.81.20]:54281 "HELO
        gateway02.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491826Ab0LOT6m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Dec 2010 20:58:42 +0100
Received: (qmail 28821 invoked from network); 15 Dec 2010 19:58:15 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway02.websitewelcome.com with SMTP; 15 Dec 2010 19:58:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=obGo1s4nTvDvALpKPIYPNuyheQj+ie1lvhEbp8TzSegNele3WGW740L4CAriRQcPZW9EFeXyJzT5u0yv1307gH3oYIxNyXBC37ojgIEQd6uPvuffMqxNdzvep+vga58Q;
Received: from [216.239.45.4] (port=21599 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PSxUh-0004Cq-Qi; Wed, 15 Dec 2010 13:58:36 -0600
Message-ID: <4D091DEE.60009@paralogos.com>
Date:   Wed, 15 Dec 2010 11:58:38 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>      <4D012560.6020003@paralogos.com>        <A7DEA48C84FD0B48AAAE33F328C020140595CEB0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>         <4D07B859.2020805@paralogos.com> <1292440738.27399.33.camel@paanoop1-desktop>
In-Reply-To: <1292440738.27399.33.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-archive-position: 28646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 12/15/10 11:18, Anoop P A wrote:
> On Tue, 2010-12-14 at 10:32 -0800, Kevin D. Kissell wrote:
>
>> I can't comment on your tweak to 2.6.24.7 without seeing it as a patch
>> diff.
> http://patchwork.linux-mips.org/patch/804/ I was speaking about this
> patch. Since my timer is connected through a cascaded CIC , It is
> required to check TI bit of cause register in order to ensure a timer
> interrupt. With above mentioned patch I was able to boot a 2.6.24-stable
> SMTC kernel. ( Not tested fully though )
OK, yes, of course, you'd need that patch.
>> The recommended procedure was, and remains, to isolate clock
>> propagation problems by using command line options "maxtcs="
>> and "maxvpes=".
>>
>> First, boot your SMTC kernel with maxtcs=1 and maxvpes=1,
>> a virtual uniprocessor.  If that doesn't run, you've got some fundamental
>> problem with support for your platform, or someone has really fundamentally
>> broken the SMTC build somewhere.  Next, try booting with maxtcs=2
>> and maxvpes=1, then with no constraint on maxtcs and maxvpes=1.
>> If those fail, your problem is probably in the interrupt mask
>> management algorithms I described
> Even with command line maxtcs=1 and maxvpes=1 I am seeing same hung. The
> register dump is copied below.
I guess what jumps out at me is that VPE0.EPC doesn't look to have
changed since the very initial boot vector, as if we'd never successfully
taken an exception or interrupt of any kind, prior to the NMI (I'm assuming
you're getting that MT state dump by breaking in with an NMI).
I'm puzzled that TC0.TCStatus is being reported as 0, when it should
have a bunch of bits in common with VPE0.Status.  And I'm particularly
intrigued by the fact that you seem to have an interrupt bit set in Cause
which is enabled in Status, with IE set and EXL/ERL clear, yet you don't
seem to be getting interrupts.

Do you have access to some kind of EJTAG probe for your system?

> I have tested few stable tags in git and isolated the code brake.
>
> 2.6.24-stable + patch[1] = SMTC boot success
> 2.6.29-stable + patch[1] = SMTC boot success
> 2.6.31-stable + patch[1] = SMTC boot success
> 2.6.32-stable + patch[1] = SMTC boot success
> 2.6.33-stable		 = SMTC boot failed
> 2.6.35-stable 		 = SMTC boot failed
>
> So it looks like SMTC support got broke between 2.6.32 and 2.6.33 .
That's a pretty good job of isolating the problem, and the fact
that it happens even with no TC or VPE concurrency means it's
not a failure of the SMTC logic per se, but that someone changed
some code that's common to SMTC and "normal"/SMP operation
in a way that breaks the more constrained assumptions of SMTC.

> Thanks and Regards,
> Anoop
>
> patch[1] : http://patchwork.linux-mips.org/patch/804/
>
>
> #############################Log###########################
>      0.000000] Calibrating delay loop... === MIPS MT State Dump ===
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
> [    0.000000]    VPE0.Cause : 50804000
> [    0.000000]    VPE0.Config7 : 00010000
> [    0.000000]   VPE 1
> [    0.000000]    VPEControl : 00060000
> [    0.000000]    VPEConf0 : 800f0000
> [    0.000000]    VPE1.Status : 00408305
> [    0.000000]    VPE1.EPC : 80100380 name_to_dev_t+0x50/0x430
> [    0.000000]    VPE1.Cause : 50000200
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
> [    0.000000]    TCRestart : 8f800020 0x8f800020
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00140000
> [    0.000000]   TC 2
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00400001
> [    0.000000]    TCRestart : 8f800020 0x8f800020
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00280000
> [    0.000000]   TC 3
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00600001
> [    0.000000]    TCRestart : 8f800020 0x8f800020
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 003c0000
> [    0.000000]   TC 4
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00800001
> [    0.000000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00500000
> [    0.000000]   TC 5
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00a00001
> [    0.000000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00640000
> [    0.000000]   TC 6
> [    0.000000]    TCStatus : 00000000
> [    0.000000]    TCBind : 00c00001
> [    0.000000]    TCRestart : 80268e00 aes_encrypt+0x10e4/0x164c
> [    0.000000]    TCHalt : 00000001
> [    0.000000]    TCContext : 00780000
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
> [    0.010000]    VPE1.EPC : 80100380 name_to_dev_t+0x50/0x430
> [    0.010000]    VPE1.Cause : 50000200
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
> [    0.010000]    TCRestart : 8f800020 0x8f800020
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00140000
> [    0.010000]   TC 2
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00400001
> [    0.010000]    TCRestart : 8f800020 0x8f800020
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00280000
> [    0.010000]   TC 3
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00600001
> [    0.010000]    TCRestart : 8f800020 0x8f800020
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 003c0000
> [    0.010000]   TC 4
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00800001
> [    0.010000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00500000
> [    0.010000]   TC 5
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00a00001
> [    0.010000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00640000
> [    0.010000]   TC 6
> [    0.010000]    TCStatus : 00000000
> [    0.010000]    TCBind : 00c00001
> [    0.010000]    TCRestart : 80268e00 aes_encrypt+0x10e4/0x164c
> [    0.010000]    TCHalt : 00000001
> [    0.010000]    TCContext : 00780000
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
>
>
>
