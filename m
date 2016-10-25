Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 11:42:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20306 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990644AbcJYJmMUzn6r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 11:42:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2F4DB250E1068;
        Tue, 25 Oct 2016 10:42:03 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 25 Oct 2016 10:42:05 +0100
Subject: Re: [Patch v5 04/12] irqchip: xilinx: Add support for parent intc
To:     Marc Zyngier <marc.zyngier@arm.com>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <alistair@popple.id.au>,
        <mporter@kernel.crashing.org>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1476723176-39891-5-git-send-email-Zubair.Kakakhel@imgtec.com>
 <32f5f17d-7864-c782-7a6f-03660b7ab055@arm.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <benh@kernel.crashing.org>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <581adf44-388c-f8e5-8437-59d7ace2fa8f@imgtec.com>
Date:   Tue, 25 Oct 2016 10:42:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <32f5f17d-7864-c782-7a6f-03660b7ab055@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55565
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

Thanks for the review.
Some comments in-line.

On 10/21/2016 10:48 AM, Marc Zyngier wrote:
> On 17/10/16 17:52, Zubair Lutfullah Kakakhel wrote:
>> The MIPS based xilfpga platform has the following IRQ structure
>>
>> Peripherals --> xilinx_intcontroller -> mips_cpu_int controller
>>
>> Add support for the driver to chain the irq handler
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>
>> ---
>> V4 -> V5
>> Rebased to v4.9-rc1
>> Missing curly braces
>>
>> V3 -> V4
>> Clean up if/else when a parent is found
>> Pass irqchip structure to handler as data
>>
>> V2 -> V3
>> Reused existing parent node instead of finding again.
>> Cleanup up handler based on review
>>
>> V1 -> V2
>>
>> No change
>> ---
>>  drivers/irqchip/irq-xilinx-intc.c | 26 ++++++++++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
>> index 45e5154..dbf8b0c 100644
>> --- a/drivers/irqchip/irq-xilinx-intc.c
>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/io.h>
>>  #include <linux/bug.h>
>> +#include <linux/of_irq.h>
>>
>>  /* No one else should require these constants, so define them locally here. */
>>  #define ISR 0x00			/* Interrupt Status Register */
>> @@ -154,11 +155,23 @@ static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
>>  	.map = xintc_map,
>>  };
>>
>> +static void xil_intc_irq_handler(struct irq_desc *desc)
>> +{
>> +	u32 pending;
>> +
>> +	do {
>> +		pending = xintc_get_irq();
>> +		if (pending == -1U)
>> +			break;
>> +		generic_handle_irq(pending);
>> +	} while (true);
>
> This is missing the chained_irq_enter()/exit() calls, which will lead to
> races or lockups on the root irqchip.
>

I 'll fix it up in the next series.

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
>>  	if (xintc_irqc) {
>> @@ -221,7 +234,16 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
>>  		goto err_alloc;
>>  	}
>>
>> -	irq_set_default_host(root_domain);
>> +	if (parent) {
>> +		irq = irq_of_parse_and_map(intc, 0);
>> +		if (irq)
>> +			irq_set_chained_handler_and_data(irq,
>> +							 xil_intc_irq_handler,
>> +							 irqc);
>> +
>
> Shouldn't you return an error if irq is zero?
>

I'll add the following for the error case

	pr_err("%s: Parent exists but interrupts property not defined\n" , __func__);
	goto err_alloc;

Thanks
ZubairLK

>> +	} else {
>> +		irq_set_default_host(root_domain);
>> +	}
>>
>>  	return 0;
>>
>>
>
> Thanks,
>
> 	M.
>
