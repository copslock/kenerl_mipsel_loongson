Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 13:02:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22228 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990519AbcIALCFPSHMD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 13:02:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 57E3AF1CAFC32;
        Thu,  1 Sep 2016 12:01:46 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 12:01:48 +0100
Subject: Re: [Patch v3 03/11] irqchip: axi-intc: Add support for parent intc
To:     Marc Zyngier <marc.zyngier@arm.com>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-4-git-send-email-Zubair.Kakakhel@imgtec.com>
 <57C70C71.3060603@arm.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <81b5f75c-51b5-0482-50d1-f51c5687edbc@imgtec.com>
Date:   Thu, 1 Sep 2016 12:01:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <57C70C71.3060603@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Hi,

Thanks for the review
Comments inline.

On 08/31/2016 05:57 PM, Marc Zyngier wrote:
> On 31/08/16 17:35, Zubair Lutfullah Kakakhel wrote:
>> The MIPS based xilfpga platform has the following IRQ structure
>>
>> Peripherals --> xilinx_intcontroller -> mips_cpu_int controller
>>
>> Add support for the driver to chain the irq handler
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>
>> ---
>> V2 -> V3
>> Reused existing parent node instead of finding again.
>> Cleanup up handler based on review
>>
>> V1 -> V2
>>
>> No change
>> ---
>>  drivers/irqchip/irq-axi-intc.c | 24 +++++++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-axi-intc.c b/drivers/irqchip/irq-axi-intc.c
>> index cb69241..30bb084 100644
>> --- a/drivers/irqchip/irq-axi-intc.c
>> +++ b/drivers/irqchip/irq-axi-intc.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/io.h>
>>  #include <linux/bug.h>
>> +#include <linux/of_irq.h>
>>
>>  /* No one else should require these constants, so define them locally here. */
>>  #define ISR 0x00			/* Interrupt Status Register */
>> @@ -154,11 +155,23 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
>>  	.map = xintc_map,
>>  };
>>
>> +static void xil_intc_irq_handler(struct irq_desc *desc)
>> +{
>> +	u32 pending;
>> +
>> +	do {
>> +		pending = get_irq();
>> +		if (pending == -1U)
>> +			break;
>> +		generic_handle_irq(pending);
>> +	} while (true);
>> +}
>> +
>>  static int __init xilinx_intc_of_init(struct device_node *intc,
>>  					     struct device_node *parent)
>>  {
>>  	u32 nr_irq;
>> -	int ret;
>> +	int ret, irq;
>>  	struct xintc_irq_chip *irqc;
>>
>>  	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
>> @@ -211,6 +224,15 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
>>  	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
>>  					    irqc);
>>
>> +	if (parent) {
>> +		irq = irq_of_parse_and_map(intc, 0);
>> +		if (irq)
>> +			irq_set_chained_handler_and_data(irq,
>> +							 xil_intc_irq_handler,
>> +							 root_domain);
>> +
>> +	}
>> +
>>  	irq_set_default_host(root_domain);
>>
>>  	return 0;
>>
>
> This doesn't seem right. You've now overridden the xintc_irqc pointer,
> so I don't know how you can still process interrupts once you've
> discovered a secondary interrupt controller. You've also allocated a
> second root_domain, changed the default domain to point to the secondary
> controller...
>
> Have you tested this code? Or am I missing something obvious?

Yes it works. I'll try to explain the platform setup a bit.
Perhaps that will make it clear about what I'm trying to do.

UART IRQ -> AXI INTC -> MIPS internal INTC -> CPU

MIPS Internal Interrupt controller in drivers/irqchip/irq-mips-cpu.c
uses irq_domain_add_legacy while AXI Intc uses irq_domain_add_linear

My aim was to set up a chained irq handler with least disturbance.

Hence the above code.

Your concerns are valid. The code is working because read/writes rely
on the static xintc_irqc in the file.
And the second root domain is also not breaking the platform because
the irq-mips-cpu.c uses irq_domain_add_legacy and doesn't use
irq_set_default_host.

# cat /proc/interrupts
            CPU0
   7:      43493      MIPS   7  timer
   8:         83  Xilinx INTC   1-level     eth0
   9:        417  Xilinx INTC   0-level     serial
  10:         15  Xilinx INTC   4-level     10a00000.i2c
ERR:          0
#

Given the above concerns. How about doing things this way?

	if (parent) {
		irq = irq_of_parse_and_map(intc, 0);
		if (irq)
			irq_set_chained_handler_and_data(irq,
							 xil_intc_irq_handler,
							 irqc);

	} else
		irq_set_default_host(root_domain);

default host is only set if no parent exists.
And the irqc pointer is passed as the data.

Thanks
ZubairLK

>
> Thanks,
>
> 	M.
>
