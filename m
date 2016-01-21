Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 09:52:30 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:59899 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009408AbcAUIw2zox8e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 09:52:28 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292AA3A8;
        Thu, 21 Jan 2016 00:51:43 -0800 (PST)
Received: from [10.1.209.129] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48D053F21A;
        Thu, 21 Jan 2016 00:52:20 -0800 (PST)
Subject: Re: [PATCH 6/6] MIPS: ath79: irq: Move the CPU IRQ driver to
 drivers/irqchip
To:     Alban <albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
 <1447788896-15553-7-git-send-email-albeu@free.fr>
 <20160120124948.6917859f@sofa.wild-wind.fr.eu.org>
 <20160120204620.714636eb@tock>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <56A09C42.3090209@arm.com>
Date:   Thu, 21 Jan 2016 08:52:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160120204620.714636eb@tock>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 20/01/16 19:46, Alban wrote:
> On Wed, 20 Jan 2016 12:49:48 +0000
> Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> On Tue, 17 Nov 2015 20:34:56 +0100
>> Alban Bedel <albeu@free.fr> wrote:
>>
>>> Signed-off-by: Alban Bedel <albeu@free.fr>
>>> ---
>>>  arch/mips/ath79/irq.c                    | 81
>>> ++------------------------ arch/mips/include/asm/mach-ath79/ath79.h
>>> |  1 + drivers/irqchip/Makefile                 |  1 +
>>>  drivers/irqchip/irq-ath79-cpu.c          | 97
>>> ++++++++++++++++++++++++++++++++ 4 files changed, 105
>>> insertions(+), 75 deletions(-) create mode 100644
>>> drivers/irqchip/irq-ath79-cpu.c
>>>
>  
>  [...]
> 
>>> +asmlinkage void plat_irq_dispatch(void)
>>> +{
>>> +	unsigned long pending;
>>> +	int irq;
>>> +
>>> +	pending = read_c0_status() & read_c0_cause() & ST0_IM;
>>> +
>>> +	if (!pending) {
>>> +		spurious_interrupt();
>>> +		return;
>>> +	}
>>> +
>>> +	pending >>= CAUSEB_IP;
>>> +	while (pending) {
>>> +		irq = fls(pending) - 1;
>>> +		if (irq < ARRAY_SIZE(irq_wb_chan) && irq_wb_chan[irq] != -1)
>>> +			ath79_ddr_wb_flush(irq_wb_chan[irq]);
>>> +		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
>>
>> I'm rather unfamiliar with the MIPS IRQ handling, but I'm vaguely
>> surprised by the lack of domain. How do you unsure that the IRQ space
>> used here doesn't clash with the one created in your "misc" irqchip?
> 
> This driver extend the irq-mips-cpu driver which take care of setting up
> a legacy domain starting from MIPS_CPU_IRQ_BASE for these interrupts. I
> don't find this very nice either, but this patch is about moving the
> code out of arch/mips, so I tried to minimize unrelated changes.

As long as there is an underlying domain reserving the CPU range, then
this is fine.

So for this patch:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
