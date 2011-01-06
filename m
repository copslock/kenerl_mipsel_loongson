Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2011 00:31:41 +0100 (CET)
Received: from gateway16.websitewelcome.com ([70.85.130.5]:40002 "HELO
        gateway16.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490993Ab1AFXbh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jan 2011 00:31:37 +0100
Received: (qmail 2162 invoked from network); 6 Jan 2011 23:31:07 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway16.websitewelcome.com with SMTP; 6 Jan 2011 23:31:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=FFdAiPk3borkIi7mmHXkbcHtLMEXVH+W6IDNp4Eh80NP/JEzrCWIKFDPPhG3B/CunEpktdPg3N5AavucUDrjjHV9F8F/hWEtJTygB5+Q1pVfkWtwEri18RSxtH+QPkiz;
Received: from [216.239.45.4] (port=51840 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PazIo-0002zz-Kz; Thu, 06 Jan 2011 17:31:30 -0600
Message-ID: <4D2650D6.4030102@paralogos.com>
Date:   Thu, 06 Jan 2011 15:31:34 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>         <1293470392.27661.202.camel@paanoop1-desktop>         <1293524389.27661.210.camel@paanoop1-desktop>         <4D19A31E.1090905@paralogos.com>         <1293798476.27661.279.camel@paanoop1-desktop>         <4D1EE913.1070203@paralogos.com>         <1294067561.27661.293.camel@paanoop1-desktop>         <4D21F5D3.50604@paralogos.com>         <1294082426.27661.330.camel@paanoop1-desktop>         <4D22D7B3.2050609@paralogos.com>         <1294146165.27661.361.camel@paanoop1-desktop>         <1294151822.27661.375.camel@paanoop1-desktop>         <4D235717.1000603@paralogos.com>         <1294163657.27661.386.camel@paanoop1-desktop>         <4D2367EE.7000702@paralogos.com>         <1294233097.27661.391.camel@paanoop1-desktop>         <4D24C525.5000306@paralogos.com> <1294345396.27661.422.camel@paanoop1-desktop>
In-Reply-To: <1294345396.27661.422.camel@paanoop1-desktop>
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
X-archive-position: 28871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 01/06/11 12:23, Anoop P A wrote:
> On Wed, 2011-01-05 at 11:23 -0800, Kevin D. Kissell wrote:
>> At this point, there shouldn't be a whole lot of SMTC-specific mystery
>> to get your timer running on the second VPE.  You know it's taking
>> interrupts, because of the IPIs getting through, so in principle you
>> just need to run the chain of enables from the clock peripheral itself
>> through the CIC to the CPU core and the IM bits.
> I hope we are almost there. I have made some progress with the debug . I
> think you should be able to give better insight to the observation I
> have made.
>
> 1. Without selecting CONFIG_MIPS_MT_SMTC_IM_BACKSTOP My kernel hangs in
> calibration loop itself . ( I haven't looked further into this).
That suggests a problem with Status.IM initialization and/or
the handling of irq_hwmask[].  Do you mean that this is always
true, or only if VPE1 is being booted?  You haven't mentioned it
before.

> 2. With CONFIG_MIPS_MT_SMTC_IM_BACKSTOP I found I am getting 3
> VPE1-TIMER interrupt ( one for each TC of VPE1) .However this interrupts
> are not getting carried till c0_compare_interrupt .
Would you expect them to?  I thought you were using an outboard
timer and not the CP0 Compare interrupt.
>   do_IRQ call had a SMTC hook which is modifying tccontext ( To reduce
> complexity I haven't selected SMTC affinity).
>
> Once I disabled this call . I am seeing VPE1 timer interrupts and able
> to boot completely without any issue's so far :).
So long as you've got the IM_BACKSTOP hack enabled, right?
Because otherwise, without that __DO_IRQ_SMTC_HOOK() invocation
> / # cat /proc/interrupts
>             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
> CPU6
>    1:        171     727459     727561     727533         27     727446
> 727453            MIPS  SMTC_IPI
>    6:          0          0          0          0          0          0
> 0            MIPS  MSP CIC cascade
>    8:          0          0          0          0          0          0
> 0         MSP_CIC  Softreset button
>    9:          0          0          0          0          0          0
> 0         MSP_CIC  Standby switch
>   21:          0          0          0          0          0          0
> 0         MSP_CIC  MSP PER cascade
>   25:     727507        484         11          0          0          0
> 0         MSP_CIC  timer
>   27:          0          0          0          0        258         10
> 1         MSP_CIC  serial
>   34:          0          0          0          0     727533          7
> 1         MSP_CIC  timer
>
>
> BTW following code in my cic init was setting hwmask.
>
>          /* initialize all the IRQ descriptors */
>          for (i = MSP_CIC_INTBASE ; i<  MSP_CIC_INTBASE + 32 ; i++) {
>                  set_irq_chip_and_handler(i,&msp_cic_irq_controller,
>                                           handle_level_irq);
> #ifdef CONFIG_MIPS_MT_SMTC
>                  irq_hwmask[i] = C_IRQ4;
> #endif
>          }

I'm sure I've said this before, and it's in various comments in the SMTC
code, but remember, one of the main problems that the SMTC kernel
had to solve was to prevent all TCs of a VPE from "convoying" after every
interrupt.  The way this is done is that the interrupt vector code, before
clearing EXL, masks off the Status.IM bit associated with the incoming
interrupt.  Of course, to get another interrupt from the same source
(or collection of sources), that IM bit needs to be restored.  The "correct"
mechanism for this is by having the appropriate irq_hwmask[] value set,
so that smtc_im_ack_irq(), which should be invoked on an irq "ack()"
(meaning that the source has been quenched and any new occurrence
should be considered a new interrupt), will restore the bit in Status.
This function got moved around a bit in the various SMTC prototypes,
but it proved least intrusive to put it into the xxx_mask_and_ack() 
functions
for the interrupt controllers - see irq-msc01.c and i8259.c.  If you haven't
done the same in any equivalent code for a different on-chip controller,
you'll definitely have problems.

The Backstop scheme works OK for peripheral interrupts that didn't
have an appropriate irq_hwmask[] value set up, but clock interrupts
don't follow the same code paths and can't depend on the backstop.

             Regards,

             Kevin K.
