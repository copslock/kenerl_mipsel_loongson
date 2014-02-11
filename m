Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2014 04:44:16 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.138]:45801 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815989AbaBKDoLfj0Vt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Feb 2014 04:44:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 2807422DB6;
        Tue, 11 Feb 2014 11:44:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8V+8SS0G6bP2; Tue, 11 Feb 2014 11:43:52 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 950E222BBE;
        Tue, 11 Feb 2014 11:43:51 +0800 (CST)
Received: from 42.49.106.235
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Tue, 11 Feb 2014 11:43:52 +0800
Message-ID: <76a0675667a71254083bd7f4223aeb86.squirrel@mail.lemote.com>
In-Reply-To: <52F90AE5.1020606@imgtec.com>
References: <1391834342-8177-1-git-send-email-chenhc@lemote.com>
    <1391834342-8177-8-git-send-email-chenhc@lemote.com>
    <52F90AE5.1020606@imgtec.com>
Date:   Tue, 11 Feb 2014 11:43:52 +0800
Subject: Re: [PATCH V17 07/13] MIPS: Loongson 3: Add IRQ init and dispatch
 support
From:   =?gb2312?Q?=22=B3=C2=BB=AA=B2=C5=22?= <chenhc@lemote.com>
To:     "Alex Smith" <alex.smith@imgtec.com>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        "Aurelien Jarno" <aurelien@aurel32.net>, linux-mips@linux-mips.org,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "Hongliang Tao" <taohl@lemote.com>, "Hua Yan" <yanh@lemote.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

> Hi Huacai,
>
> On 08/02/14 04:38, Huacai Chen wrote:
>> IRQ routing path of Loongson-3:
>> Devices(most) --> I8259 --> HT Controller --> IRQ Routing Table --> CPU
>>                                                    ^
>>                                                    |
>> Device(legacy devices such as UART) --> Bonito ---|
>>
>> IRQ Routing Table route 32 INTs to CPU's INT0~INT3(IP2~IP5 of CP0), 32
>> INTs include 16 HT INTs(mostly), 4 PCI INTs, 1 LPC INT, etc. IP6 is used
>> for IPI and IP7 is used for internal MIPS timer. LOONGSON_INT_ROUTER_*
>> are IRQ Routing Table registers.
>>
>> I8259 IRQs are 1:1 mapped to HT1 INTs. LOONGSON_HT1_* are configuration
>> registers of HT1 controller.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> ---
>>   arch/mips/include/asm/mach-loongson/irq.h      |   41 ++++++++++
>>   arch/mips/include/asm/mach-loongson/loongson.h |   10 +++
>>   arch/mips/loongson/Makefile                    |    6 ++
>>   arch/mips/loongson/loongson-3/Makefile         |    4 +
>>   arch/mips/loongson/loongson-3/irq.c            |   95
>> ++++++++++++++++++++++++
>>   5 files changed, 156 insertions(+), 0 deletions(-)
>>   create mode 100644 arch/mips/include/asm/mach-loongson/irq.h
>>   create mode 100644 arch/mips/loongson/loongson-3/Makefile
>>   create mode 100644 arch/mips/loongson/loongson-3/irq.c
>>
>> diff --git a/arch/mips/include/asm/mach-loongson/irq.h
>> b/arch/mips/include/asm/mach-loongson/irq.h
>> new file mode 100644
>> index 0000000..7e18b46
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-loongson/irq.h
>> @@ -0,0 +1,41 @@
>> +#ifndef __ASM_MACH_LOONGSON_IRQ_H_
>> +#define __ASM_MACH_LOONGSON_IRQ_H_
>> +
>> +#include <boot_param.h>
>> +
>> +/* cpu core interrupt numbers */
>> +#define MIPS_CPU_IRQ_BASE 56
>
> Does this still work on Loongson 2 systems? Since this is outside the
> ifdef it will change the value of this from 16 for Loongson 2, which
> unless I'm mistaken then overlaps with the Bonito IRQ range for those
> systems (LOONGSON_IRQ_BASE, 32 to 64).
Sorry, this is my fault and need to fix.

Huacai

>
> Thanks,
> Alex
>
>> +
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +
>> +#define LOONGSON_UART_IRQ   (MIPS_CPU_IRQ_BASE + 2) /* UART */
>> +#define LOONGSON_HT1_IRQ    (MIPS_CPU_IRQ_BASE + 3) /* HT1 */
>> +#define LOONGSON_TIMER_IRQ  (MIPS_CPU_IRQ_BASE + 7) /* CPU Timer */
>> +
>> +#define LOONGSON_HT1_CFG_BASE		loongson_sysconf.ht_control_base
>> +#define LOONGSON_HT1_INT_VECTOR_BASE	(LOONGSON_HT1_CFG_BASE + 0x80)
>> +#define LOONGSON_HT1_INT_EN_BASE	(LOONGSON_HT1_CFG_BASE + 0xa0)
>> +#define LOONGSON_HT1_INT_VECTOR(n)	\
>> +		LOONGSON3_REG32(LOONGSON_HT1_INT_VECTOR_BASE, 4 * n)
>> +#define LOONGSON_HT1_INTN_EN(n)		\
>> +		LOONGSON3_REG32(LOONGSON_HT1_INT_EN_BASE, 4 * n)
>> +
>> +#define LOONGSON_INT_ROUTER_OFFSET	0x1400
>> +#define LOONGSON_INT_ROUTER_INTEN	\
>> +	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET +
>> 0x24)
>> +#define LOONGSON_INT_ROUTER_INTENSET	\
>> +	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET +
>> 0x28)
>> +#define LOONGSON_INT_ROUTER_INTENCLR	\
>> +	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET +
>> 0x2c)
>> +#define LOONGSON_INT_ROUTER_ENTRY(n)	\
>> +	  LOONGSON3_REG8(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + n)
>> +#define LOONGSON_INT_ROUTER_LPC		LOONGSON_INT_ROUTER_ENTRY(0x0a)
>> +#define LOONGSON_INT_ROUTER_HT1(n)	LOONGSON_INT_ROUTER_ENTRY(n + 0x18)
>> +
>> +#define LOONGSON_INT_CORE0_INT0		0x11 /* route to int 0 of core 0 */
>> +#define LOONGSON_INT_CORE0_INT1		0x21 /* route to int 1 of core 0 */
>> +
>> +#endif
>> +
>> +#include_next <irq.h>
>> +#endif /* __ASM_MACH_LOONGSON_IRQ_H_ */
>> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h
>> b/arch/mips/include/asm/mach-loongson/loongson.h
>> index f0367ff..69e9d9e 100644
>> --- a/arch/mips/include/asm/mach-loongson/loongson.h
>> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
>> @@ -62,6 +62,12 @@ extern int mach_i8259_irq(void);
>>   #define LOONGSON_REG(x) \
>>   	(*(volatile u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
>>
>> +#define LOONGSON3_REG8(base, x) \
>> +	(*(volatile u8 *)((char *)TO_UNCAC(base) + (x)))
>> +
>> +#define LOONGSON3_REG32(base, x) \
>> +	(*(volatile u32 *)((char *)TO_UNCAC(base) + (x)))
>> +
>>   #define LOONGSON_IRQ_BASE	32
>>   #define LOONGSON2_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf
>> counter */
>>
>> @@ -87,6 +93,10 @@ static inline void do_perfcnt_IRQ(void)
>>   #define LOONGSON_REG_BASE	0x1fe00000
>>   #define LOONGSON_REG_SIZE	0x00100000	/* 256Bytes + 256Bytes + ??? */
>>   #define LOONGSON_REG_TOP	(LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
>> +/* Loongson-3 specific registers */
>> +#define LOONGSON3_REG_BASE	0x3ff00000
>> +#define LOONGSON3_REG_SIZE	0x00100000	/* 256Bytes + 256Bytes + ??? */
>> +#define LOONGSON3_REG_TOP	(LOONGSON3_REG_BASE+LOONGSON3_REG_SIZE-1)
>>
>>   #define LOONGSON_LIO1_BASE	0x1ff00000
>>   #define LOONGSON_LIO1_SIZE	0x00100000	/* 1M */
>> diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
>> index 0dc0055..7429994 100644
>> --- a/arch/mips/loongson/Makefile
>> +++ b/arch/mips/loongson/Makefile
>> @@ -15,3 +15,9 @@ obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fuloong-2e/
>>   #
>>
>>   obj-$(CONFIG_LEMOTE_MACH2F)  += lemote-2f/
>> +
>> +#
>> +# All Loongson-3 family machines
>> +#
>> +
>> +obj-$(CONFIG_CPU_LOONGSON3)  += loongson-3/
>> diff --git a/arch/mips/loongson/loongson-3/Makefile
>> b/arch/mips/loongson/loongson-3/Makefile
>> new file mode 100644
>> index 0000000..b9968cd
>> --- /dev/null
>> +++ b/arch/mips/loongson/loongson-3/Makefile
>> @@ -0,0 +1,4 @@
>> +#
>> +# Makefile for Loongson-3 family machines
>> +#
>> +obj-y			+= irq.o
>> diff --git a/arch/mips/loongson/loongson-3/irq.c
>> b/arch/mips/loongson/loongson-3/irq.c
>> new file mode 100644
>> index 0000000..7311df6
>> --- /dev/null
>> +++ b/arch/mips/loongson/loongson-3/irq.c
>> @@ -0,0 +1,95 @@
>> +#include <loongson.h>
>> +#include <irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +
>> +#include <asm/irq_cpu.h>
>> +#include <asm/i8259.h>
>> +#include <asm/mipsregs.h>
>> +
>> +static void ht_irqdispatch(void)
>> +{
>> +	unsigned int i, irq;
>> +	unsigned int ht_irq[] = {1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
>> +
>> +	irq = LOONGSON_HT1_INT_VECTOR(0);
>> +	LOONGSON_HT1_INT_VECTOR(0) = irq; /* Acknowledge the IRQs */
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ht_irq); i++) {
>> +		if (irq & (0x1 << ht_irq[i]))
>> +			do_IRQ(ht_irq[i]);
>> +	}
>> +}
>> +
>> +void mach_irq_dispatch(unsigned int pending)
>> +{
>> +	if (pending & CAUSEF_IP7)
>> +		do_IRQ(LOONGSON_TIMER_IRQ);
>> +	else if (pending & CAUSEF_IP3)
>> +		ht_irqdispatch();
>> +	else if (pending & CAUSEF_IP2)
>> +		do_IRQ(LOONGSON_UART_IRQ);
>> +	else {
>> +		pr_err("%s : spurious interrupt\n", __func__);
>> +		spurious_interrupt();
>> +	}
>> +}
>> +
>> +static struct irqaction cascade_irqaction = {
>> +	.handler = no_action,
>> +	.name = "cascade",
>> +};
>> +
>> +static inline void mask_loongson_irq(struct irq_data *d)
>> +{
>> +	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
>> +	irq_disable_hazard();
>> +}
>> +
>> +static inline void unmask_loongson_irq(struct irq_data *d)
>> +{
>> +	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
>> +	irq_enable_hazard();
>> +}
>> +
>> + /* For MIPS IRQs which shared by all cores */
>> +static struct irq_chip loongson_irq_chip = {
>> +	.name		= "Loongson",
>> +	.irq_ack	= mask_loongson_irq,
>> +	.irq_mask	= mask_loongson_irq,
>> +	.irq_mask_ack	= mask_loongson_irq,
>> +	.irq_unmask	= unmask_loongson_irq,
>> +	.irq_eoi	= unmask_loongson_irq,
>> +};
>> +
>> +void irq_router_init(void)
>> +{
>> +	int i;
>> +
>> +	/* route LPC int to cpu core0 int 0 */
>> +	LOONGSON_INT_ROUTER_LPC = LOONGSON_INT_CORE0_INT0;
>> +	/* route HT1 int0 ~ int7 to cpu core0 INT1*/
>> +	for (i = 0; i < 8; i++)
>> +		LOONGSON_INT_ROUTER_HT1(i) = LOONGSON_INT_CORE0_INT1;
>> +	/* enable HT1 interrupt */
>> +	LOONGSON_HT1_INTN_EN(0) = 0xffffffff;
>> +	/* enable router interrupt intenset */
>> +	LOONGSON_INT_ROUTER_INTENSET =
>> +		LOONGSON_INT_ROUTER_INTEN | (0xffff << 16) | 0x1 << 10;
>> +}
>> +
>> +void __init mach_init_irq(void)
>> +{
>> +	clear_c0_status(ST0_IM | ST0_BEV);
>> +
>> +	irq_router_init();
>> +	mips_cpu_irq_init();
>> +	init_i8259_irqs();
>> +	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
>> +			&loongson_irq_chip, handle_level_irq);
>> +
>> +	/* setup HT1 irq */
>> +	setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);
>> +
>> +	set_c0_status(STATUSF_IP2 | STATUSF_IP6);
>> +}
>>
>
>
