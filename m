Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 16:04:51 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:53626 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491853Ab0KKPEs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Nov 2010 16:04:48 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oABF4eVH026996;
        Thu, 11 Nov 2010 07:04:40 -0800
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oABF4dC2010418;
        Thu, 11 Nov 2010 07:04:39 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oABF4dI03317;
        Thu, 11 Nov 2010 07:04:39 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel is stuck in Calibrating delay loop
Date:   Thu, 11 Nov 2010 07:04:38 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760132BE5D@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTikXc+x8Qp+oQjmytA4F6WabTN66VOmDmZWSvvuK@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel is stuck in Calibrating delay loop
Thread-Index: AcuBQ1Lndw2zVe1FSiia4jaaYqwMQAAbMViw
References: <AEA634773855ED4CAD999FBB1A66D0760132BB00@CORPEXCH1.na.ads.idt.com> <AANLkTikXc+x8Qp+oQjmytA4F6WabTN66VOmDmZWSvvuK@mail.gmail.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "wu zhangjin" <wuzhangjin@gmail.com>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi Wu,

I have those options enabled for my platform, I found that because of some h/w logic which is muxing different sources of interrupts to the MIPS h/w 5 interrupt the c0_compare_int_usable() failed in r4k_clockevent_init(). After fixing that I have timer interrupts but instead of coming every 10ms I have two interrupts 10ms, 1.8ms, 10ms, 1.8ms ... etc. So there is an additional one I am struggling to understand what can be the issue. 
One other issue I see is that when an interrupt happens I see Cause.IV bit is zero. That is not good because in my target I configured cpu_has_vint=1 to use Vectored Interrupt and I was relying on Linux to set correctly this bit. 
Any idea or advice is appreciated.

Thanks,
Andrei



 

-----Original Message-----
From: wu zhangjin [mailto:wuzhangjin@gmail.com] 
Sent: Wednesday, November 10, 2010 8:24 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel is stuck in Calibrating delay loop

On Wed, Nov 10, 2010 at 11:49 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:
> Hi,
>
> I am porting MIPS Malta on a new platform and during the boot process
> the Kernel remains in a infinite loop in "Calibrating delay loop ..." in
> calibrate.c.
> I checked and the timer interrupt which is supposed to be wired on h/w 5
> interrupt (MIPS 7 irq) is not activated in MIPS Status.IM7 register.
> Where in the Kernel the MIPS irq wired to the timer interrupt needs to
> be enabled?  Can I use enable_irq()?
> On my platform I don't have any 8259 and I am trying to use MIPS
> Count/Compare internal timer for Kernel tick.

Did you select the r4k timer for your platform?

arch/mips/Kconfig:

config MIPS_MALTA
        [snip]
        select CEVT_R4K
        select CSRC_R4K
        [snip]

And please check if arch/mips/kernel/*r4k.c are compiled into your kernel image.

Regards,
Wu Zhangjin
