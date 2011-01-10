Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2011 20:30:23 +0100 (CET)
Received: from gateway02.websitewelcome.com ([69.93.106.20]:47332 "HELO
        gateway02.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491118Ab1AJTaT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jan 2011 20:30:19 +0100
Received: (qmail 30875 invoked from network); 10 Jan 2011 19:29:28 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway02.websitewelcome.com with SMTP; 10 Jan 2011 19:29:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=weBmeYrxF89dDlkRogUKFindxliuuWeXxLARYATK58ti7XxVzi+gyd8IPg0voG0+lvKTjVk5Ibaj1hKJjq1tDv652MNM/SumqVjxi9b/4D/KNa+IV1c1ohd/eFIKqX/O;
Received: from [216.239.45.4] (port=26221 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PcNRU-0006BD-AQ; Mon, 10 Jan 2011 13:30:12 -0600
Message-ID: <4D2B5E46.3070609@paralogos.com>
Date:   Mon, 10 Jan 2011 11:30:14 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>      <1293470392.27661.202.camel@paanoop1-desktop>   <1293524389.27661.210.camel@paanoop1-desktop>   <4D19A31E.1090905@paralogos.com>        <1293798476.27661.279.camel@paanoop1-desktop>   <4D1EE913.1070203@paralogos.com>        <1294067561.27661.293.camel@paanoop1-desktop>   <4D21F5D3.50604@paralogos.com>  <1294082426.27661.330.camel@paanoop1-desktop>   <4D22D7B3.2050609@paralogos.com>        <1294146165.27661.361.camel@paanoop1-desktop>   <1294151822.27661.375.camel@paanoop1-desktop>   <4D235717.1000603@paralogos.com>        <1294163657.27661.386.camel@paanoop1-desktop>   <4D2367EE.7000702@paralogos.com>        <1294233097.27661.391.camel@paanoop1-desktop>   <4D24C525.5000306@paralogos.com>        <1294345396.27661.422.camel@paanoop1-desktop>   <4D2650D6.4030102@paralogos.com> <1294387019.27661.458.camel@paanoop1-desktop>
In-Reply-To: <1294387019.27661.458.camel@paanoop1-desktop>
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
X-archive-position: 28892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 01/06/11 23:56, Anoop P A wrote:
> On Thu, 2011-01-06 at 15:31 -0800, Kevin D. Kissell wrote:
>> I'm sure I've said this before, and it's in various comments in the SMTC
>> code, but remember, one of the main problems that the SMTC kernel
>> had to solve was to prevent all TCs of a VPE from "convoying" after every
>> interrupt.  The way this is done is that the interrupt vector code, before
>> clearing EXL, masks off the Status.IM bit associated with the incoming
>> interrupt.  Of course, to get another interrupt from the same source
>> (or collection of sources), that IM bit needs to be restored.  The "correct"
>> mechanism for this is by having the appropriate irq_hwmask[] value set,
>> so that smtc_im_ack_irq(), which should be invoked on an irq "ack()"
>> (meaning that the source has been quenched and any new occurrence
>> should be considered a new interrupt), will restore the bit in Status.
>> This function got moved around a bit in the various SMTC prototypes,
>> but it proved least intrusive to put it into the xxx_mask_and_ack()
>> functions
>> for the interrupt controllers - see irq-msc01.c and i8259.c.  If you haven't
>> done the same in any equivalent code for a different on-chip controller,
>> you'll definitely have problems.
>>
>> The Backstop scheme works OK for peripheral interrupts that didn't
>> have an appropriate irq_hwmask[] value set up, but clock interrupts
>> don't follow the same code paths and can't depend on the backstop.
> Ok. Well thanks much for your detailed explanation. Well I hope I found
> the root cause . smtc_clockevent_init() was overriding irq_hwmask even
> if are using platform specific get_c0_compare_int. With following patch
> everything seems to be working for me.

Would this still be with a "tickful" kernel?  I was able to run some
experiments on a Malta over the weekend, using mostly default
Malta defconfig options including tickless operation.  The 2.6.32.27
build comes up with both VPEs and all TCs firing.  2.6.36.2 with
the stackframe.h patch boots all the way up on a single VPE, but
VERY slowly - as if the Clock/Compare setups weren't being done
correctly and timer intervals were waiting the full Count register
rollover cycle.  I've been looking at diffs, and merged one change
that was made to cevt-r4k.c into the analogous routine in cevt-smtc.c
(no change), but there's clearly more breakage to the SMTC/Malta
configuration post-2.6.32 than just the stackframe.h patch.  Going
tickful may work around it, but tickful+SMTC is grossly inefficient.

             Regards,

             Kevin K.
