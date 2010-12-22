Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 12:43:30 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:41938 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490989Ab0LVLn1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 12:43:27 +0100
Received: by gyg4 with SMTP id 4so2333494gyg.36
        for <linux-mips@linux-mips.org>; Wed, 22 Dec 2010 03:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=dG03KCQQCR7bf/e3kvyJK4z1YmhbMqQ/fr7xZQu3VmY=;
        b=adgAASDY9jFO+hQcN55rj14x7OH8WUUZ1NftCTnEMdH/Dt+aSYj1HSV6XvnUHM3vA4
         2qEzDKzlZ46BJV9GUmQ+T5ZuSzfJuyb07brC6K4IqTTtEuU99rkNlU7w0rwduuWgDcsV
         9O4ULR7EzgWrnc8zOMsDqDmxGFmL4nWuusQQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=sM8xJZ/2qk1P8wkfFeVCI5ho6eQlCMXSTBk5DNHQMJr7OzmL6wMPMloKYkj8efcbLV
         9D9DNg0them+QHxWIY1W6IseqoW8v0aOPKbgk9V5vFfd+dMKcwuZOZ1UVyvi1Vnjtpiv
         Ps1YvmRTOI5F8PHUEKLUodgFbW2MICRxpOyKA=
Received: by 10.151.41.9 with SMTP id t9mr10112972ybj.255.1293018199850;
        Wed, 22 Dec 2010 03:43:19 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id u10sm8877219yba.1.2010.12.22.03.43.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 03:43:18 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>,
        STUART VENTERS <stuart.venters@adtran.com>,
        linux-mips@linux-mips.org
In-Reply-To: <4D11E2E2.80809@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB880@EXV1.corp.adtran.com>
         <4D0A677C.6040104@paralogos.com> <4D0A6F63.8080206@paralogos.com>
         <4D0BD7A0.1030504@paralogos.com>
         <AANLkTikTn_Lw=vqtfUyDW7GXxq75ZYLGi8_MyVVyPkKt@mail.gmail.com>
         <4D10F7A9.1020306@paralogos.com>
         <A7DEA48C84FD0B48AAAE33F328C020140595D731@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
         <A7DEA48C84FD0B48AAAE33F328C020140595D732@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
         <4D11D28D.80501@paralogos.com> <1293017702.27661.36.camel@paanoop1-desktop>
         <4D11E2E2.80809@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 22 Dec 2010 17:21:15 +0530
Message-ID: <1293018675.27661.40.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-12-22 at 03:37 -0800, Kevin D. Kissell wrote:
> Thanks.  This is indeed strange.  The VPE0 Status and TC0 TCStatus/Cause 
> all indicate that interrupts are enabled and not inhibited at the per-TC 
> level, and the presumed timer interrupt, in the 0x4000 bit, is present 
> and not masked-off.  Logically, the system must be entering (and 
> exiting) the interrupt handler, yet the timer calibration isn't 
> completing.  That leaves more complex possible explanations for failure, 
> most of which would fall into two categories:
> 
> 1)  The platform interrupt handler is failing to decode the event 
> properly as a timer event.
> 2)  Despite there being only one TC active, the calibration code is 
> waiting for some handshake from another "CPU"
> 
> To test the first, you might consider adding a kprintf() to the case of 
> a "spurious" timer-like interrupt being detected and ignored...

I have tried it . only one interrupt is coming and platform handler
detect it as timer interrupt and acknowledges properly . you can see a
time stamp change in the logs.

> 
>              Regards,
> 
>              Kevin K.
> 
> On 12/22/10 3:35 AM, Anoop P A wrote:
> > On Wed, 2010-12-22 at 02:27 -0800, Kevin D. Kissell wrote:
> >>> Sorry I misunderstood file. git blame shows that "andi" is around for
> >> quite
> >>   >  some time.
> >>
> >> I've never used git blame, so I don't know how far it can be trusted,
> >> but if that change was made in 2006, that would predate the major
> >> breakage by several
> >> years.  So my suggestion from yesterday is a reasonable one:
> > That change is present in booting 2.6.32 kernel.Corresponding patch can
> > be found in gitweb .
> > http://git.linux-mips.org/?p=linux.git;a=commitdiff;h=41c594ab65fc89573af296d192aa5235d09717ab#patch39
> >
> >>   >  I think that if you were to tweak mips-mt.c at line 103 to change
> >>   >  the
> >>   >
> >>   >         tcstatval = flags; /* And pre-dump TCStatus is flags */
> >>   >
> >>   >  to something more like
> >>   >
> >>   >  /* Pre-dump TCStatus Interrupt Inhibit bit is in flags variable */
> >>   >  tcstatval = (read_c0_tcstatus()&  ~0x400) | flags;
> >>   >
> >>   >  should fix the dump.
> >>
> >> With that patch, if you re-run the experiment of hang-breakout-dump, we
> >> might be able to deduce something.
> > Here is the dump with the patch.
> >
> > [    0.000000] Calibrating delay loop... === MIPS MT State Dump ===
> > [    0.000000] -- Global State --
> > [    0.000000]    MVPControl Passed: 00000000
> > [    0.000000]    MVPControl Read: 00000000
> > [    0.000000]    MVPConf0 : a8008406
> > [    0.000000] -- per-VPE State --
> > [    0.000000]   VPE 0
> > [    0.000000]    VPEControl : 00000000
> > [    0.000000]    VPEConf0 : 800f0003
> > [    0.000000]    VPE0.Status : 11004001
> > [    0.000000]    VPE0.EPC : 80100000 _stext+0x0/0x10
> > [    0.000000]    VPE0.Cause : e080407c
> > [    0.000000]    VPE0.Config7 : 00010000
> > [    0.000000]   VPE 1
> > [    0.000000]    VPEControl : 00030000
> > [    0.000000]    VPEConf0 : 800f0000
> > [    0.000000]    VPE1.Status : 00407904
> > [    0.000000]    VPE1.EPC : fffdffff 0xfffdffff
> > [    0.000000]    VPE1.Cause : 4000027c
> > [    0.000000]    VPE1.Config7 : 00010000
> > [    0.000000] -- per-TC State --
> > [    0.000000]   TC 0 (current TC with VPE EPC above)
> > [    0.000000]    TCStatus : 11004001
> > [    0.000000]    TCBind : 00000000
> > [    0.000000]    TCRestart : 803fc408 printk+0x10/0x30
> > [    0.000000]    TCHalt : 00000000
> > [    0.000000]    TCContext : 00000000
> > [    0.000000]   TC 1
> > [    0.000000]    TCStatus : 00000000
> > [    0.000000]    TCBind : 00200001
> > [    0.000000]    TCRestart : 3ffffffe 0x3ffffffe
> > [    0.000000]    TCHalt : 00000001
> > [    0.000000]    TCContext : efffffff
> > [    0.000000]   TC 2
> > [    0.000000]    TCStatus : 00000000
> > [    0.000000]    TCBind : 00400001
> > [    0.000000]    TCRestart : ffffffee 0xffffffee
> > [    0.000000]    TCHalt : 00000001
> > [    0.000000]    TCContext : efffffbf
> > [    0.000000]   TC 3
> > [    0.000000]    TCStatus : 00000000
> > [    0.000000]    TCBind : 00600001
> > [    0.000000]    TCRestart : ffe00200 0xffe00200
> > [    0.000000]    TCHalt : 00000001
> > [    0.000000]    TCContext : 7fffb77f
> > [    0.000000]   TC 4
> > [    0.000000]    TCStatus : 00000000
> > [    0.000000]    TCBind : 00800001
> > [    0.000000]    TCRestart : ffe00200 0xffe00200
> > [    0.000000]    TCHalt : 00000001
> > [    0.000000]    TCContext : 7ffdf736
> > [    0.000000]   TC 5
> > [    0.000000]    TCStatus : 00000000
> > [    0.000000]    TCBind : 00a00001
> > [    0.000000]    TCRestart : ffe00200 0xffe00200
> > [    0.000000]    TCHalt : 00000001
> > [    0.000000]    TCContext : ee5ffff7
> > [    0.000000]   TC 6
> > [    0.000000]    TCStatus : 00000000
> > [    0.000000]    TCBind : 00c00001
> > [    0.000000]    TCRestart : f7ff7ffe 0xf7ff7ffe
> > [    0.000000]    TCHalt : 00000001
> > [    0.000000]    TCContext : e6fffffb
> > [    0.000000] Counter Interrupts taken per CPU (TC)
> > [    0.000000] 0: 0
> > [    0.000000] 1: 0
> > [    0.000000] Self-IPI invocations:
> > [    0.000000] 0: 0
> > [    0.000000] 1: 0
> > [    0.000000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
> > [    0.000000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
> > [    0.000000] 0 Recoveries of "stolen" FPU
> > [    0.000000] ===========================
> > [    0.010000] === MIPS MT State Dump ===
> > [    0.010000] -- Global State --
> > [    0.010000]    MVPControl Passed: 00000000
> > [    0.010000]    MVPControl Read: 00000000
> > [    0.010000]    MVPConf0 : a8008406
> > [    0.010000] -- per-VPE State --
> > [    0.010000]   VPE 0
> > [    0.010000]    VPEControl : 00000000
> > [    0.010000]    VPEConf0 : 800f0003
> > [    0.010000]    VPE0.Status : 18004000
> > [    0.010000]    VPE0.EPC : 8010c9b4 mips_mt_regdump+0x3a4/0x3d4
> > [    0.010000]    VPE0.Cause : 50804000
> > [    0.010000]    VPE0.Config7 : 00010000
> > [    0.010000]   VPE 1
> > [    0.010000]    VPEControl : 00030000
> > [    0.010000]    VPEConf0 : 800f0000
> > [    0.010000]    VPE1.Status : 00407904
> > [    0.010000]    VPE1.EPC : fffdffff 0xfffdffff
> > [    0.010000]    VPE1.Cause : 4000027c
> > [    0.010000]    VPE1.Config7 : 00010000
> > [    0.010000] -- per-TC State --
> > [    0.010000]   TC 0 (current TC with VPE EPC above)
> > [    0.010000]    TCStatus : 18004000
> > [    0.010000]    TCBind : 00000000
> > [    0.010000]    TCRestart : 803fc408 printk+0x10/0x30
> > [    0.010000]    TCHalt : 00000000
> > [    0.010000]    TCContext : 00000000
> > [    0.010000]   TC 1
> > [    0.010000]    TCStatus : 00000000
> > [    0.010000]    TCBind : 00200001
> > [    0.010000]    TCRestart : 3ffffffe 0x3ffffffe
> > [    0.010000]    TCHalt : 00000001
> > [    0.010000]    TCContext : efffffff
> > [    0.010000]   TC 2
> > [    0.010000]    TCStatus : 00000000
> > [    0.010000]    TCBind : 00400001
> > [    0.010000]    TCRestart : ffffffee 0xffffffee
> > [    0.010000]    TCHalt : 00000001
> > [    0.010000]    TCContext : efffffbf
> > [    0.010000]   TC 3
> > [    0.010000]    TCStatus : 00000000
> > [    0.010000]    TCBind : 00600001
> > [    0.010000]    TCRestart : ffe00200 0xffe00200
> > [    0.010000]    TCHalt : 00000001
> > [    0.010000]    TCContext : 7fffb77f
> > [    0.010000]   TC 4
> > [    0.010000]    TCStatus : 00000000
> > [    0.010000]    TCBind : 00800001
> > [    0.010000]    TCRestart : ffe00200 0xffe00200
> > [    0.010000]    TCHalt : 00000001
> > [    0.010000]    TCContext : 7ffdf736
> > [    0.010000]   TC 5
> > [    0.010000]    TCStatus : 00000000
> > [    0.010000]    TCBind : 00a00001
> > [    0.010000]    TCRestart : ffe00200 0xffe00200
> > [    0.010000]    TCHalt : 00000001
> > [    0.010000]    TCContext : ee5ffff7
> > [    0.010000]   TC 6
> > [    0.010000]    TCStatus : 00000000
> > [    0.010000]    TCBind : 00c00001
> > [    0.010000]    TCRestart : f7ff7ffe 0xf7ff7ffe
> > [    0.010000]    TCHalt : 00000001
> > [    0.010000]    TCContext : e6fffffb
> > [    0.010000] Counter Interrupts taken per CPU (TC)
> > [    0.010000] 0: 0
> > [    0.010000] 1: 0
> > [    0.010000] Self-IPI invocations:
> > [    0.010000] 0: 0
> > [    0.010000] 1: 0
> > [    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
> > [    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
> > [    0.010000] 0 Recoveries of "stolen" FPU
> > [    0.010000] ===========================
> >
> >
> >
> 
