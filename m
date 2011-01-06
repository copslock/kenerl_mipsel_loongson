Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2011 21:11:43 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:62299 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490979Ab1AFULk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jan 2011 21:11:40 +0100
Received: by fxm19 with SMTP id 19so15733269fxm.36
        for <linux-mips@linux-mips.org>; Thu, 06 Jan 2011 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=K+5bzQEwroc0ouRBfhfzTPGudJlKJ71izLvqakdBBLg=;
        b=wt+o0gD+VDNGC886hI3FHExIj2soRoRNVGbt/lWKvusqcPmWj5uuqG1oU4MUslySj9
         co2QY/LZDGgQIDs/1RUj2Ig57DfmMydQZ5XWTakPrB0hJqqbu+Dl6OYsgfudq1lBp/zw
         2ZPfRWC9RrHpEuMAsS2uCJzXNsgUoqcs0gzbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cxZPjwrnqmaJCgcklMW2g+Dnr74TFqUp/uzLH42AWMniTrskiB5btrzyWws/QkIgY6
         iKTOv5vFONXi6I2tIsJ9DVl6KkM4vYg4rb89zHeJkQFQgP7t0+FDxn8NhA00FYjkcCX3
         GY8DTo6T7HqjanxJRSXbcYVBjZY+XG5zBNnfQ=
Received: by 10.223.83.144 with SMTP id f16mr756334fal.4.1294344695432;
        Thu, 06 Jan 2011 12:11:35 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id n1sm5961573fam.40.2011.01.06.12.11.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 12:11:32 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D24C525.5000306@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
         <1293470392.27661.202.camel@paanoop1-desktop>
         <1293524389.27661.210.camel@paanoop1-desktop>
         <4D19A31E.1090905@paralogos.com>
         <1293798476.27661.279.camel@paanoop1-desktop>
         <4D1EE913.1070203@paralogos.com>
         <1294067561.27661.293.camel@paanoop1-desktop>
         <4D21F5D3.50604@paralogos.com>
         <1294082426.27661.330.camel@paanoop1-desktop>
         <4D22D7B3.2050609@paralogos.com>
         <1294146165.27661.361.camel@paanoop1-desktop>
         <1294151822.27661.375.camel@paanoop1-desktop>
         <4D235717.1000603@paralogos.com>
         <1294163657.27661.386.camel@paanoop1-desktop>
         <4D2367EE.7000702@paralogos.com>
         <1294233097.27661.391.camel@paanoop1-desktop>
         <4D24C525.5000306@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 07 Jan 2011 01:53:16 +0530
Message-ID: <1294345396.27661.422.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2011-01-05 at 11:23 -0800, Kevin D. Kissell wrote:
> >   		LONG_S	$5, PT_R5(sp)
> >   		LONG_S	v1, PT_STATUS(sp)
> 
> That's exactly what I'd propose as the cleanest minimal fix.  I've got a 
> version that also replaces the .set mips32 / .set mips0 with the .set 
> push / .set pop paradigm, which I'd have used in the original code if 
> I'd known at the time about that assembler directive.  I'm hoping to be 
> able to test on a Malta/34K reference platform, and make sure there 
> isn't breakage on that platform branch as well, before we commit to the 
> repository.

I hope somebody can test this patch on Malta/34K platform. I don't have
access to any malta boards and I believe 34K MT simulations is not
available on qemu.

> 
> Your msp_smtc.c file looks plausible on the face of it.  The 
> init_secondary function has the quirk that it expects to execute on each 
> "CPU" in numerical order, which is very likely but not guaranteed. It 
> *ought* to be harmless in the rare case where it fails, but the 
> assumption is worth a comment, IMHO.
Yes I will add a comment. 

> 
> At this point, there shouldn't be a whole lot of SMTC-specific mystery 
> to get your timer running on the second VPE.  You know it's taking 
> interrupts, because of the IPIs getting through, so in principle you 
> just need to run the chain of enables from the clock peripheral itself 
> through the CIC to the CPU core and the IM bits.

I hope we are almost there. I have made some progress with the debug . I
think you should be able to give better insight to the observation I
have made.

1. Without selecting CONFIG_MIPS_MT_SMTC_IM_BACKSTOP My kernel hangs in
calibration loop itself . ( I haven't looked further into this).

2. With CONFIG_MIPS_MT_SMTC_IM_BACKSTOP I found I am getting 3
VPE1-TIMER interrupt ( one for each TC of VPE1) .However this interrupts
are not getting carried till c0_compare_interrupt . 

do_IRQ call had a SMTC hook which is modifying tccontext ( To reduce
complexity I haven't selected SMTC affinity). 

Once I disabled this call . I am seeing VPE1 timer interrupts and able
to boot completely without any issue's so far :).

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6
  1:        171     727459     727561     727533         27     727446
727453            MIPS  SMTC_IPI
  6:          0          0          0          0          0          0
0            MIPS  MSP CIC cascade
  8:          0          0          0          0          0          0
0         MSP_CIC  Softreset button
  9:          0          0          0          0          0          0
0         MSP_CIC  Standby switch
 21:          0          0          0          0          0          0
0         MSP_CIC  MSP PER cascade
 25:     727507        484         11          0          0          0
0         MSP_CIC  timer
 27:          0          0          0          0        258         10
1         MSP_CIC  serial
 34:          0          0          0          0     727533          7
1         MSP_CIC  timer


BTW following code in my cic init was setting hwmask.

        /* initialize all the IRQ descriptors */
        for (i = MSP_CIC_INTBASE ; i < MSP_CIC_INTBASE + 32 ; i++) {
                set_irq_chip_and_handler(i, &msp_cic_irq_controller,
                                         handle_level_irq);
#ifdef CONFIG_MIPS_MT_SMTC
                irq_hwmask[i] = C_IRQ4;
#endif
        }



> It would be really cool if we could get a stable repository branch that 
> boots SMTC out-of-the-box on both Malta and the MSP platform.
:)

> 
>              Regards,
> 
>              Kevin K.
> 
> 
Thanks
Anoop
