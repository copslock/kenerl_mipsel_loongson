Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 18:43:16 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:50494 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006757AbcAERnOK5AEm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 18:43:14 +0100
Received: from [10.14.4.125] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Tue, 5 Jan 2016
 10:43:06 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
Subject: Re: [PATCH v2 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
To:     Marc Zyngier <marc.zyngier@arm.com>, <linux-kernel@vger.kernel.org>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
 <1450133093-7053-3-git-send-email-joshua.henderson@microchip.com>
 <5670471B.6090608@arm.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Message-ID: <568C0271.2020007@microchip.com>
Date:   Tue, 5 Jan 2016 10:50:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <5670471B.6090608@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Marc,

On 12/15/2015 10:00 AM, Marc Zyngier wrote:
> On 14/12/15 22:42, Joshua Henderson wrote:
>> From: Cristian Birsan <cristian.birsan@microchip.com>
>>
>> This adds support for the interrupt controller present on PIC32 class
>> devices.
>>
>> The following features are supported:
>>  - DT properties for EVIC and for devices that use interrupt lines
>>  - Persistent and non-persistent interrupt handling
>>  - irqdomain support
>>
>> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>>  drivers/irqchip/Makefile           |    1 +
>>  drivers/irqchip/irq-pic32-evic.c   |  321 ++++++++++++++++++++++++++++++++++++
>>  include/linux/irqchip/pic32-evic.h |   19 +++
>>  3 files changed, 341 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-pic32-evic.c
>>  create mode 100644 include/linux/irqchip/pic32-evic.h
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 177f78f..e3608fc 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -55,3 +55,4 @@ obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
>>  obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
>>  obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
>>  obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
>> +obj-$(CONFIG_MACH_PIC32)		+= irq-pic32-evic.o
>> diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
>> new file mode 100644
>> index 0000000..6a7747c
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-pic32-evic.c

[...]

>> +
>> +static struct irq_chip pic32_irq_chip = {
>> +	.name = "PIC32-EVIC",
>> +	.irq_ack = ack_pic32_irq,
>> +	.irq_mask = mask_pic32_irq,
>> +	.irq_mask_ack = mask_ack_pic32_irq,
>> +	.irq_unmask = unmask_pic32_irq,
>> +	.irq_eoi = ack_pic32_irq,
>> +	.irq_set_type = set_type_pic32_irq,
>> +	.irq_enable = unmask_pic32_irq,
>> +	.irq_disable = mask_pic32_irq,
> 
> I'm not sure I see the point of having all these methods. First, there
> is a lot of duplication: no need to provide enable/disable if all you
> have is mask/unmask - the core code can deal with that.

This is to avoid the lazy disable approach in irq_disable(). The .irq_enable is there for symmetry.  .irq_mask_ack is also redundant excluding performance.  These can be removed if the preference is to end up with:

static struct irq_chip pic32_irq_chip = {
	.name = "PIC32-EVIC",
	.irq_ack = ack_pic32_irq,
	.irq_mask = mask_pic32_irq,
	.irq_unmask = unmask_pic32_irq,
	.irq_eoi = ack_pic32_irq,
	.irq_set_type = set_type_pic32_irq,
};

> 
> Then, your EOI method is not really an EOI. It doesn't terminate the
> handling, or at least that's not what the name suggest. If this is
> really an EOI, then you should be able to simplify the whole thing on
> only use the fasteoi handler, including for edge interrupts.

There are two types of hardware interrupts: persistent and non persistent. For the persistent ones we need to clear the condition that caused the interrupt before clearing the interrupt flag and this one is mapped to the fasteoi handler. For the non persistent ones we can clear the interrupt flag as soon as we enter the interrupt handler, but we need to re-enable the interrupt to avoid missing any event that occur during servicing the interrupt. This one is mapped to the edge handler. This is needed, for example, with the core timer interrupt.

>
> It would be good to have an insight on how this thing actually works
> (I've tried to read the only documentation, but this is vague at best),
> that would help picking the right design for your use case.
> 

We're in agreement here on the lack of documentation.  While this chip is not released to the public yet, we do have a generic document that outlines the interrupt controllers across the PIC32 family that will shed some light on how this thing operates:  http://ww1.microchip.com/downloads/en/DeviceDoc/60001108H.pdf

> Thanks,
> 
> 	M.
> 

Josh
