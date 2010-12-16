Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2010 13:57:28 +0100 (CET)
Received: from mail-gw0-f41.google.com ([74.125.83.41]:59884 "EHLO
        mail-gw0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491922Ab0LPM5Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Dec 2010 13:57:25 +0100
Received: by gwj22 with SMTP id 22so1963334gwj.28
        for <linux-mips@linux-mips.org>; Thu, 16 Dec 2010 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=6KaOfjjuKMH0eDQ3mNIJTT+bdq7u1Vvn1yuhfA2qBsI=;
        b=nQ1cyGUzPkV1AikdXKnEVWxe9WdGP36pV1kCz1w2ClLDB3V73q4t4swJXwSuGULMfx
         uFx9Ll6Xfuui53KywcRtBg6xWpgU8osWhoPf7DTTPwoOhC9dbYUYcVrOTZzwbhUqDLOE
         uLpat6GIhB5/0iLhoLhDz6Ai+i7EQqwy8nSp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=gt/ZNuqfK2MVZYeGTCG0tAQXr4k8vmZN0RRdo2z2fX5FFkQ3F1QhLi9ehpUugUkjLQ
         I5QfoRlg338nA3w5HZry/sVE86OxfVJ2F9oBSMijhiVRgc1Zsd78CKLfTvWjFFm/eXiQ
         3XnTN5ZLtNpIngcDTkbi2u58KYaNzIbqbBj8E=
Received: by 10.150.143.20 with SMTP id q20mr841592ybd.73.1292504239007;
        Thu, 16 Dec 2010 04:57:19 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id l4sm4687153ybj.9.2010.12.16.04.57.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 04:57:16 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D091DEE.60009@paralogos.com>
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
         <4D012560.6020003@paralogos.com>
         <A7DEA48C84FD0B48AAAE33F328C020140595CEB0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
         <4D07B859.2020805@paralogos.com>
         <1292440738.27399.33.camel@paanoop1-desktop> <4D091DEE.60009@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 16 Dec 2010 18:33:47 +0530
Message-ID: <1292504627.27661.16.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-12-15 at 11:58 -0800, Kevin D. Kissell wrote:
> On 12/15/10 11:18, Anoop P A wrote:
> >> management algorithms I described
> > Even with command line maxtcs=1 and maxvpes=1 I am seeing same hung. The
> > register dump is copied below.
> I guess what jumps out at me is that VPE0.EPC doesn't look to have
> changed since the very initial boot vector, as if we'd never successfully
> taken an exception or interrupt of any kind, prior to the NMI (I'm assuming
> you're getting that MT state dump by breaking in with an NMI).
> I'm puzzled that TC0.TCStatus is being reported as 0, when it should
> have a bunch of bits in common with VPE0.Status.  And I'm particularly
> intrigued by the fact that you seem to have an interrupt bit set in Cause
> which is enabled in Status, with IE set and EXL/ERL clear, yet you don't
> seem to be getting interrupts.
> 
> Do you have access to some kind of EJTAG probe for your system?

Unfortunately I don't have access to a working EJTAG at the moment.

> 
> > I have tested few stable tags in git and isolated the code brake.
> >
> > 2.6.24-stable + patch[1] = SMTC boot success
> > 2.6.29-stable + patch[1] = SMTC boot success
> > 2.6.31-stable + patch[1] = SMTC boot success
> > 2.6.32-stable + patch[1] = SMTC boot success
> > 2.6.33-stable		 = SMTC boot failed
> > 2.6.35-stable 		 = SMTC boot failed
> >
> > So it looks like SMTC support got broke between 2.6.32 and 2.6.33 .
> That's a pretty good job of isolating the problem, and the fact
> that it happens even with no TC or VPE concurrency means it's
> not a failure of the SMTC logic per se, but that someone changed
> some code that's common to SMTC and "normal"/SMP operation
> in a way that breaks the more constrained assumptions of SMTC.
> 

I have tried digging diff between 2.6.32 and 2.6.33 but I couldn't spot
any likely causes.

I forgot to mention that I can boot newer kernels both in VSMP and UP
mode.

The other thing I have tried is booting kernel with pre-set lpj ( Just
to test how far I can go), which lead me to a dsp exception (spurious ?)

Let me know if you have any thoughts .

Thanks,
Anoop

################# log #############

Linux version 2.6.33.7-pmc (paanoop1@paanoop1-desktop) (gcc version
4.5.1 (GCC) ) #27 SMP PREEMPT Thu Dec 16 17:49:46 IST 2010
DSPRAM0: PA=1c100000,Size=00008000,enabled
UART clock set to 50000000
CPU revision is: 00019548 (MIPS 34Kc)
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 000ff000 @ 00001000 (usable)
 memory: 00271000 @ 00100000 (reserved)
 memory: 0fc5a200 @ 00371000 (usable)
Wasting 32 bytes for tracking 1 unused pages
Zone PFN ranges:
  Normal   0x00000000 -> 0x0000ffcb
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x0000ffcb
6 available secondary CPU TC(s)
PERCPU: Embedded 7 pages/cpu @81203000 s4896 r8192 d15584 u65536
pcpu-alloc: s4896 r8192 d15584 u65536 alloc=16*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
64971
Kernel command line: console=ttyS0,57600 lpj=796672
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
Writing ErrCtl register=00000000
Readback ErrCtl register=00000000
Memory: 255548k/259428k available (1861k kernel code, 3504k reserved,
400k data, 156k init, 0k highmem)
Hierarchical RCU implementation.
NR_IRQS:128
Clock rate set to 600000000
console [ttyS0] enabled
Calibrating delay loop (skipped) preset value.. 398.33 BogoMIPS
(lpj=796672)
Mount-cache hash table entries: 512
Cpu 0
$ 0   : 00000000 10102000 00000010 00000003
$ 4   : 00000003 00000000 00000000 8f82f758
$ 8   : 00000000 00000000 00000000 00000000
$12   : 00000000 00000007 8f82301c 00000000
$16   : 8f82f758 00800b00 8035d3c0 8f830000
$20   : 80329df8 00000000 8035d3c0 80360000
$24   : 00000000 00000001
$28   : 80328000 80329ce0 8f82f868 8010d018
Hi    : 0000004c
Lo    : 3831f4b4
epc   : 8010d054 copy_thread+0x88/0x348
    Not tainted
ra    : 8010d018 copy_thread+0x4c/0x348
Status: 10102000    KERNEL
Cause : 50804068
PrId  : 00019548 (MIPS 34Kc)
Kernel panic - not syncing: Unexpected DSP exception
