Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 16:52:19 +0200 (CEST)
Received: from mail-yh0-f53.google.com ([209.85.213.53]:53925 "EHLO
        mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012133AbaJVOwQwPmTB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 16:52:16 +0200
Received: by mail-yh0-f53.google.com with SMTP id b6so3602109yha.12
        for <multiple recipients>; Wed, 22 Oct 2014 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=llvAvUo8KNOYY5z0hheAJ1RsrmhYN4VvkYfL1asoI9o=;
        b=tWgFY2Vu9o1W1JTJ2MTr3qS99FesRM6wiGHmEzb2U2lbxrk/PU/l1qWKq7smYS0jSp
         8yAj2+TK/yRPcRjhY3f1KaQgUTp+a/JYEDfbamQIVuCZav2YDeESxBBiq7XJ+UbT7eoF
         g8KXAD+A8tmmeyhGUfRMVX4z0xjycDmpO7BLEfsDCIBHEvk6q4GRtcHSKF4OF5I7Kl/o
         Ob0m/1YjfQfHdo6Fwgm2+d8MEdAC+PdlUfzIvRitpujRMKplt9ob1hTwVYbcV7wcoyCR
         AeRCYNma2fVP/m0vBDdt3N/kVjzfgLHbzWfUC55kKkDAgxhnoTW+0Eio9jqp3pPN05ux
         kTww==
X-Received: by 10.236.4.231 with SMTP id 67mr42011656yhj.98.1413989530123;
 Wed, 22 Oct 2014 07:52:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Wed, 22 Oct 2014 07:51:49 -0700 (PDT)
In-Reply-To: <54476A46.4050006@openwrt.org>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-5-git-send-email-ryazanov.s.a@gmail.com> <54476A46.4050006@openwrt.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 22 Oct 2014 18:51:49 +0400
Message-ID: <CAHNKnsTxXXQXdtCRTdBW=P9-FvRHbTLGqAe-Wrg+5QfKcxCvZw@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] MIPS: ath25: add interrupts handling routines
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-10-22 12:26 GMT+04:00 John Crispin <blogic@openwrt.org>:
> few comments inline ....
>
> On 22/10/2014 01:03, Sergey Ryazanov wrote:
>> Add interrupts initialization and handling routines, also add AHB bus
>> error interrupt handlers for both SoCs families.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> ---
>>
>> Changes since RFC:
>>   - add all interrupts
>>   - use dynamic IRQ numbers allocation
>>
>> Changes since v1:
>>   - rename MIPS machine ar231x -> ath25
>>
>>  arch/mips/ath25/ar2315.c                       | 108 +++++++++++++++++++++++++
>>  arch/mips/ath25/ar2315.h                       |   2 +
>>  arch/mips/ath25/ar5312.c                       | 103 +++++++++++++++++++++++
>>  arch/mips/ath25/ar5312.h                       |   2 +
>>  arch/mips/ath25/board.c                        |  10 +++
>>  arch/mips/ath25/devices.h                      |   2 +
>>  arch/mips/include/asm/mach-ath25/ar2315_regs.h |  23 ++++++
>>  arch/mips/include/asm/mach-ath25/ar5312_regs.h |  23 ++++++
>>  arch/mips/include/asm/mach-ath25/ath25.h       |   2 +
>>  9 files changed, 275 insertions(+)
>>
>> diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
>> index 4eee362..e1a338b 100644
>> --- a/arch/mips/ath25/ar2315.c
>> +++ b/arch/mips/ath25/ar2315.c
>> @@ -27,6 +27,114 @@
>>  #include "devices.h"
>>  #include "ar2315.h"
>>
>> +static unsigned ar2315_misc_irq_base;
>> +
>> +static irqreturn_t ar2315_ahb_err_handler(int cpl, void *dev_id)
>> +{
>> +     ath25_write_reg(AR2315_AHB_ERR0, AR2315_AHB_ERROR_DET);
>> +     ath25_read_reg(AR2315_AHB_ERR1);
>> +
>> +     pr_emerg("AHB fatal error\n");
>> +     machine_restart("AHB error"); /* Catastrophic failure */
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static struct irqaction ar2315_ahb_err_interrupt  = {
>> +     .handler        = ar2315_ahb_err_handler,
>> +     .name           = "ar2315-ahb-error",
>> +};
>> +
>> +static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc *desc)
>> +{
>> +     u32 pending = ath25_read_reg(AR2315_ISR) & ath25_read_reg(AR2315_IMR);
>> +     unsigned base = ar2315_misc_irq_base;
>> +
>> +     if (pending & AR2315_ISR_SPI)
>> +             generic_handle_irq(base + AR2315_MISC_IRQ_SPI);
>> +     else if (pending & AR2315_ISR_TIMER)
>> +             generic_handle_irq(base + AR2315_MISC_IRQ_TIMER);
>> +     else if (pending & AR2315_ISR_AHB)
>> +             generic_handle_irq(base + AR2315_MISC_IRQ_AHB);
>> +     else if (pending & AR2315_ISR_GPIO) {
>> +             ath25_write_reg(AR2315_ISR, AR2315_ISR_GPIO);
>> +             generic_handle_irq(base + AR2315_MISC_IRQ_GPIO);
>> +     } else if (pending & AR2315_ISR_UART0)
>> +             generic_handle_irq(base + AR2315_MISC_IRQ_UART0);
>> +     else if (pending & AR2315_ISR_WD) {
>> +             ath25_write_reg(AR2315_ISR, AR2315_ISR_WD);
>> +             generic_handle_irq(base + AR2315_MISC_IRQ_WATCHDOG);
>> +     } else
>> +             spurious_interrupt();
>> +}
>> +
>> +static void ar2315_misc_irq_unmask(struct irq_data *d)
>> +{
>> +     u32 imr = ath25_read_reg(AR2315_IMR);
>> +
>> +     imr |= 1 << (d->irq - ar2315_misc_irq_base);
>> +     ath25_write_reg(AR2315_IMR, imr);
>> +}
>> +
>> +static void ar2315_misc_irq_mask(struct irq_data *d)
>> +{
>> +     u32 imr = ath25_read_reg(AR2315_IMR);
>> +
>> +     imr &= ~(1 << (d->irq - ar2315_misc_irq_base));
>> +     ath25_write_reg(AR2315_IMR, imr);
>> +}
>> +
>> +static struct irq_chip ar2315_misc_irq_chip = {
>> +     .name           = "ar2315-misc",
>> +     .irq_unmask     = ar2315_misc_irq_unmask,
>> +     .irq_mask       = ar2315_misc_irq_mask,
>> +};
>> +
>> +/*
>> + * Called when an interrupt is received, this function
>> + * determines exactly which interrupt it was, and it
>> + * invokes the appropriate handler.
>> + *
>> + * Implicitly, we also define interrupt priority by
>> + * choosing which to dispatch first.
>> + */
>> +static void ar2315_irq_dispatch(void)
>> +{
>> +     u32 pending = read_c0_status() & read_c0_cause();
>> +
>> +     if (pending & CAUSEF_IP3)
>> +             do_IRQ(AR2315_IRQ_WLAN0);
>> +     else if (pending & CAUSEF_IP2)
>> +             do_IRQ(AR2315_IRQ_MISC);
>> +     else if (pending & CAUSEF_IP7)
>> +             do_IRQ(ATH25_IRQ_CPU_CLOCK);
>> +     else
>> +             spurious_interrupt();
>> +}
>> +
>> +void __init ar2315_arch_init_irq(void)
>> +{
>> +     unsigned i;
>> +     int res;
>> +
>> +     ath25_irq_dispatch = ar2315_irq_dispatch;
>> +
>> +     res = irq_alloc_descs(-1, 0, AR2315_MISC_IRQ_COUNT, 0);
>> +     if (res < 0)
>> +             pr_emerg("Failed to allocate misc IRQ numbers\n");
>> +     ar2315_misc_irq_base = res;
>> +
>> +     for (i = 0; i < AR2315_MISC_IRQ_COUNT; i++) {
>> +             unsigned irq = ar2315_misc_irq_base + i;
>> +
>> +             irq_set_chip_and_handler(irq, &ar2315_misc_irq_chip,
>> +                                      handle_level_irq);
>> +     }
>> +     setup_irq(ar2315_misc_irq_base + AR2315_MISC_IRQ_AHB,
>> +               &ar2315_ahb_err_interrupt);
>> +     irq_set_chained_handler(AR2315_IRQ_MISC, ar2315_misc_irq_handler);
>> +}
>> +
>
> you should use irq_doamin here with a xlate function. this is just a 3
> liner.
I would like add code as-is, and then update it to use irq_domain. But
seems that everybody likes the irq_domain and this work should be done
now.

> look at arch/mips/ralink/irq.c
>
Thank you for example!

>
>>  static void ar2315_restart(char *command)
>>  {
>>       void (*mips_reset_vec)(void) = (void *)0xbfc00000;
>> diff --git a/arch/mips/ath25/ar2315.h b/arch/mips/ath25/ar2315.h
>> index 98d32b2..2a57858 100644
>> --- a/arch/mips/ath25/ar2315.h
>> +++ b/arch/mips/ath25/ar2315.h
>> @@ -3,12 +3,14 @@
>>
>>  #ifdef CONFIG_SOC_AR2315
>>
>> +void ar2315_arch_init_irq(void);
>>  void ar2315_plat_time_init(void);
>>  void ar2315_plat_mem_setup(void);
>>  void ar2315_prom_init(void);
>>
>>  #else
>>
>> +static inline void ar2315_arch_init_irq(void) {}
>>  static inline void ar2315_plat_time_init(void) {}
>>  static inline void ar2315_plat_mem_setup(void) {}
>>  static inline void ar2315_prom_init(void) {}
>> diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
>> index 80d7ed7..e9c7f71 100644
>> --- a/arch/mips/ath25/ar5312.c
>> +++ b/arch/mips/ath25/ar5312.c
>> @@ -27,6 +27,109 @@
>>  #include "devices.h"
>>  #include "ar5312.h"
>>
>> +static unsigned ar5312_misc_irq_base;
>> +
>> +static irqreturn_t ar5312_ahb_err_handler(int cpl, void *dev_id)
>> +{
>> +     u32 proc1 = ath25_read_reg(AR5312_PROC1);
>> +     u32 proc_addr = ath25_read_reg(AR5312_PROCADDR); /* clears error */
>> +     u32 dma1 = ath25_read_reg(AR5312_DMA1);
>> +     u32 dma_addr = ath25_read_reg(AR5312_DMAADDR);   /* clears error */
>> +
>> +     pr_emerg("AHB interrupt: PROCADDR=0x%8.8x PROC1=0x%8.8x DMAADDR=0x%8.8x DMA1=0x%8.8x\n",
>> +              proc_addr, proc1, dma_addr, dma1);
>> +
>> +     machine_restart("AHB error"); /* Catastrophic failure */
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static struct irqaction ar5312_ahb_err_interrupt  = {
>> +     .handler = ar5312_ahb_err_handler,
>> +     .name    = "ar5312-ahb-error",
>> +};
>> +
>> +static void ar5312_misc_irq_handler(unsigned irq, struct irq_desc *desc)
>> +{
>> +     u32 pending = ath25_read_reg(AR5312_ISR) & ath25_read_reg(AR5312_IMR);
>> +     unsigned base = ar5312_misc_irq_base;
>> +
>> +     if (pending & AR5312_ISR_TIMER) {
>> +             generic_handle_irq(base + AR5312_MISC_IRQ_TIMER);
>> +             (void)ath25_read_reg(AR5312_TIMER);
>> +     } else if (pending & AR5312_ISR_AHBPROC)
>> +             generic_handle_irq(base + AR5312_MISC_IRQ_AHB_PROC);
>> +     else if (pending & AR5312_ISR_UART0)
>> +             generic_handle_irq(base + AR5312_MISC_IRQ_UART0);
>> +     else if (pending & AR5312_ISR_WD)
>> +             generic_handle_irq(base + AR5312_MISC_IRQ_WATCHDOG);
>> +     else
>> +             spurious_interrupt();
>> +}
>> +
>> +/* Enable the specified AR5312_MISC_IRQ interrupt */
>> +static void ar5312_misc_irq_unmask(struct irq_data *d)
>> +{
>> +     u32 imr = ath25_read_reg(AR5312_IMR);
>> +
>> +     imr |= 1 << (d->irq - ar5312_misc_irq_base);
>> +     ath25_write_reg(AR5312_IMR, imr);
>> +}
>> +
>> +/* Disable the specified AR5312_MISC_IRQ interrupt */
>> +static void ar5312_misc_irq_mask(struct irq_data *d)
>> +{
>> +     u32 imr = ath25_read_reg(AR5312_IMR);
>> +
>> +     imr &= ~(1 << (d->irq - ar5312_misc_irq_base));
>> +     ath25_write_reg(AR5312_IMR, imr);
>> +     ath25_read_reg(AR5312_IMR); /* flush write buffer */
>> +}
>> +
>> +static struct irq_chip ar5312_misc_irq_chip = {
>> +     .name           = "ar5312-misc",
>> +     .irq_unmask     = ar5312_misc_irq_unmask,
>> +     .irq_mask       = ar5312_misc_irq_mask,
>> +};
>> +
>> +static void ar5312_irq_dispatch(void)
>> +{
>> +     u32 pending = read_c0_status() & read_c0_cause();
>> +
>> +     if (pending & CAUSEF_IP2)
>> +             do_IRQ(AR5312_IRQ_WLAN0);
>> +     else if (pending & CAUSEF_IP5)
>> +             do_IRQ(AR5312_IRQ_WLAN1);
>> +     else if (pending & CAUSEF_IP6)
>> +             do_IRQ(AR5312_IRQ_MISC);
>> +     else if (pending & CAUSEF_IP7)
>> +             do_IRQ(ATH25_IRQ_CPU_CLOCK);
>> +     else
>> +             spurious_interrupt();
>> +}
>> +
>> +void __init ar5312_arch_init_irq(void)
>> +{
>> +     unsigned i;
>> +     int res;
>> +
>> +     ath25_irq_dispatch = ar5312_irq_dispatch;
>> +
>> +     res = irq_alloc_descs(-1, 0, AR5312_MISC_IRQ_COUNT, 0);
>> +     if (res < 0)
>> +             pr_emerg("Failed to allocate misc IRQ numbers\n");
>> +     ar5312_misc_irq_base = res;
>> +
>> +     for (i = 0; i < AR5312_MISC_IRQ_COUNT; i++) {
>> +             unsigned irq = ar5312_misc_irq_base + i;
>> +
>> +             irq_set_chip_and_handler(irq, &ar5312_misc_irq_chip,
>> +                                      handle_level_irq);
>> +     }
>> +     setup_irq(ar5312_misc_irq_base + AR5312_MISC_IRQ_AHB_PROC,
>> +               &ar5312_ahb_err_interrupt);
>> +     irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
>> +}
>
>
> same here, irq_domain is the current best practice
>
>> +
>>  static void ar5312_restart(char *command)
>>  {
>>       /* reset the system */
>> diff --git a/arch/mips/ath25/ar5312.h b/arch/mips/ath25/ar5312.h
>> index 339b28e..b60ad38 100644
>> --- a/arch/mips/ath25/ar5312.h
>> +++ b/arch/mips/ath25/ar5312.h
>> @@ -3,12 +3,14 @@
>>
>>  #ifdef CONFIG_SOC_AR5312
>>
>> +void ar5312_arch_init_irq(void);
>>  void ar5312_plat_time_init(void);
>>  void ar5312_plat_mem_setup(void);
>>  void ar5312_prom_init(void);
>>
>>  #else
>>
>> +static inline void ar5312_arch_init_irq(void) {}
>>  static inline void ar5312_plat_time_init(void) {}
>>  static inline void ar5312_plat_mem_setup(void) {}
>>  static inline void ar5312_prom_init(void) {}
>> diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
>> index a6b8c26..68447d3 100644
>> --- a/arch/mips/ath25/board.c
>> +++ b/arch/mips/ath25/board.c
>> @@ -16,9 +16,12 @@
>>  #include <asm/bootinfo.h>
>>  #include <asm/time.h>
>>
>> +#include "devices.h"
>>  #include "ar5312.h"
>>  #include "ar2315.h"
>>
>> +void (*ath25_irq_dispatch)(void);
>> +
>>  static void ath25_halt(void)
>>  {
>>       local_irq_disable();
>> @@ -42,6 +45,7 @@ void __init plat_mem_setup(void)
>>
>>  asmlinkage void plat_irq_dispatch(void)
>>  {
>> +     ath25_irq_dispatch();
>>  }
>>
>>  void __init plat_time_init(void)
>> @@ -61,5 +65,11 @@ void __init arch_init_irq(void)
>>  {
>>       clear_c0_status(ST0_IM);
>>       mips_cpu_irq_init();
>> +
>> +     /* Initialize interrupt controllers */
>> +     if (is_ar5312())
>> +             ar5312_arch_init_irq();
>> +     else
>> +             ar2315_arch_init_irq();
>>  }
>>
>> diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
>> index edda636..bbf2988 100644
>> --- a/arch/mips/ath25/devices.h
>> +++ b/arch/mips/ath25/devices.h
>> @@ -3,6 +3,8 @@
>>
>>  #include <linux/cpu.h>
>>
>> +extern void (*ath25_irq_dispatch)(void);
>> +
>>  static inline bool is_ar2315(void)
>>  {
>>       return (current_cpu_data.cputype == CPU_4KEC);
>> diff --git a/arch/mips/include/asm/mach-ath25/ar2315_regs.h b/arch/mips/include/asm/mach-ath25/ar2315_regs.h
>> index ff9a4a8..e680abc 100644
>> --- a/arch/mips/include/asm/mach-ath25/ar2315_regs.h
>> +++ b/arch/mips/include/asm/mach-ath25/ar2315_regs.h
>> @@ -15,6 +15,29 @@
>>  #define __ASM_MACH_ATH25_AR2315_REGS_H
>>
>>  /*
>> + * IRQs
>> + */
>> +#define AR2315_IRQ_MISC              (MIPS_CPU_IRQ_BASE + 2) /* C0_CAUSE: 0x0400 */
>> +#define AR2315_IRQ_WLAN0     (MIPS_CPU_IRQ_BASE + 3) /* C0_CAUSE: 0x0800 */
>> +#define AR2315_IRQ_ENET0     (MIPS_CPU_IRQ_BASE + 4) /* C0_CAUSE: 0x1000 */
>> +#define AR2315_IRQ_LCBUS_PCI (MIPS_CPU_IRQ_BASE + 5) /* C0_CAUSE: 0x2000 */
>> +#define AR2315_IRQ_WLAN0_POLL        (MIPS_CPU_IRQ_BASE + 6) /* C0_CAUSE: 0x4000 */
>> +
>> +/*
>> + * Miscellaneous interrupts, which share IP2.
>> + */
>> +#define AR2315_MISC_IRQ_UART0                0
>> +#define AR2315_MISC_IRQ_I2C_RSVD     1
>> +#define AR2315_MISC_IRQ_SPI          2
>> +#define AR2315_MISC_IRQ_AHB          3
>> +#define AR2315_MISC_IRQ_APB          4
>> +#define AR2315_MISC_IRQ_TIMER                5
>> +#define AR2315_MISC_IRQ_GPIO         6
>> +#define AR2315_MISC_IRQ_WATCHDOG     7
>> +#define AR2315_MISC_IRQ_IR_RSVD              8
>> +#define AR2315_MISC_IRQ_COUNT                9
>> +
>> +/*
>>   * Address map
>>   */
>>  #define AR2315_SPI_READ              0x08000000      /* SPI flash */
>> diff --git a/arch/mips/include/asm/mach-ath25/ar5312_regs.h b/arch/mips/include/asm/mach-ath25/ar5312_regs.h
>> index 76856d8..afcd0b2 100644
>> --- a/arch/mips/include/asm/mach-ath25/ar5312_regs.h
>> +++ b/arch/mips/include/asm/mach-ath25/ar5312_regs.h
>> @@ -12,6 +12,29 @@
>>  #define __ASM_MACH_ATH25_AR5312_REGS_H
>>
>>  /*
>> + * IRQs
>> + */
>> +#define AR5312_IRQ_WLAN0     (MIPS_CPU_IRQ_BASE + 2) /* C0_CAUSE: 0x0400 */
>> +#define AR5312_IRQ_ENET0     (MIPS_CPU_IRQ_BASE + 3) /* C0_CAUSE: 0x0800 */
>> +#define AR5312_IRQ_ENET1     (MIPS_CPU_IRQ_BASE + 4) /* C0_CAUSE: 0x1000 */
>> +#define AR5312_IRQ_WLAN1     (MIPS_CPU_IRQ_BASE + 5) /* C0_CAUSE: 0x2000 */
>> +#define AR5312_IRQ_MISC              (MIPS_CPU_IRQ_BASE + 6) /* C0_CAUSE: 0x4000 */
>> +
>> +/*
>> + * Miscellaneous interrupts, which share IP6.
>> + */
>> +#define AR5312_MISC_IRQ_TIMER                0
>> +#define AR5312_MISC_IRQ_AHB_PROC     1
>> +#define AR5312_MISC_IRQ_AHB_DMA              2
>> +#define AR5312_MISC_IRQ_GPIO         3
>> +#define AR5312_MISC_IRQ_UART0                4
>> +#define AR5312_MISC_IRQ_UART0_DMA    5
>> +#define AR5312_MISC_IRQ_WATCHDOG     6
>> +#define AR5312_MISC_IRQ_LOCAL                7
>> +#define AR5312_MISC_IRQ_SPI          8
>> +#define AR5312_MISC_IRQ_COUNT                9
>> +
>> +/*
>>   * Address Map
>>   *
>>   * The AR5312 supports 2 enet MACS, even though many reference boards only
>> diff --git a/arch/mips/include/asm/mach-ath25/ath25.h b/arch/mips/include/asm/mach-ath25/ath25.h
>> index bd66ce7..caf0794 100644
>> --- a/arch/mips/include/asm/mach-ath25/ath25.h
>> +++ b/arch/mips/include/asm/mach-ath25/ath25.h
>> @@ -3,6 +3,8 @@
>>
>>  #include <linux/io.h>
>>
>> +#define ATH25_IRQ_CPU_CLOCK  (MIPS_CPU_IRQ_BASE + 7) /* C0_CAUSE: 0x8000 */
>> +
>>  #define ATH25_REG_MS(_val, _field)   (((_val) & _field##_M) >> _field##_S)
>>
>>  static inline u32 ath25_read_reg(u32 reg)
>>

-- 
BR,
Sergey
