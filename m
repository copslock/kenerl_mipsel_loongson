Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jan 2014 18:06:19 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:43304 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826363AbaAERFwbPze9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Jan 2014 18:05:52 +0100
Received: from [2001:470:d4ed:0:ea11:32ff:fea1:831a] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr94-0006GW-RZ; Sun, 05 Jan 2014 18:05:51 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr92-0004S0-8I; Sun, 05 Jan 2014 18:05:48 +0100
Date:   Sun, 5 Jan 2014 18:05:48 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 06/12] MIPS: Loongson 3: Add IRQ init and dispatch
 support
Message-ID: <20140105170548.GA14654@ohm.rr44.fr>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-7-git-send-email-chenhc@lemote.com>
 <20140104225427.GA20818@hall.aurel32.net>
 <CAAhV-H66B3xkDSm-ftu_1M3ov3MQndd4dO9TxqcMpKmJXL3NUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H66B3xkDSm-ftu_1M3ov3MQndd4dO9TxqcMpKmJXL3NUw@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Jan 05, 2014 at 05:26:52PM +0800, Huacai Chen wrote:
> On Sun, Jan 5, 2014 at 6:54 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> 
> > On Sun, Dec 15, 2013 at 08:14:30PM +0800, Huacai Chen wrote:
> > > IRQ routing path of Loongson-3:
> > > Devices(most) --> I8259 --> HT Controller --> IRQ Routing Table --> CPU
> > >                                                   ^
> > >                                                   |
> > > Device(legacy devices such as UART) --> Bonito ---|
> > >
> > > IRQ Routing Table route 32 INTs to CPU's INT0~INT3(IP2~IP5 of CP0), 32
> > > INTs include 16 HT INTs(mostly), 4 PCI INTs, 1 LPC INT, etc. IP6 is used
> > > for IPI and IP7 is used for internal MIPS timer. LOONGSON_INT_ROUTER_*
> > > are IRQ Routing Table registers.
> > >
> > > I8259 IRQs are 1:1 mapped to HT1 INTs. LOONGSON_HT1_* are configuration
> > > registers of HT1 controller.
> > >
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > Signed-off-by: Hongliang Tao <taohl@lemote.com>
> > > Signed-off-by: Hua Yan <yanh@lemote.com>
> > > ---
> > >  arch/mips/include/asm/mach-loongson/irq.h      |   24 +++++
> > >  arch/mips/include/asm/mach-loongson/loongson.h |    9 ++
> > >  arch/mips/loongson/Makefile                    |    6 ++
> > >  arch/mips/loongson/loongson-3/Makefile         |    4 +
> > >  arch/mips/loongson/loongson-3/irq.c            |  111
> > ++++++++++++++++++++++++
> > >  5 files changed, 154 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/mips/include/asm/mach-loongson/irq.h
> > >  create mode 100644 arch/mips/loongson/loongson-3/Makefile
> > >  create mode 100644 arch/mips/loongson/loongson-3/irq.c
> > >
> > > diff --git a/arch/mips/include/asm/mach-loongson/irq.h
> > b/arch/mips/include/asm/mach-loongson/irq.h
> > > new file mode 100644
> > > index 0000000..4787cd0
> > > --- /dev/null
> > > +++ b/arch/mips/include/asm/mach-loongson/irq.h
> > > @@ -0,0 +1,24 @@
> > > +#ifndef __ASM_MACH_LOONGSON_IRQ_H_
> > > +#define __ASM_MACH_LOONGSON_IRQ_H_
> > > +
> > > +#include <boot_param.h>
> > > +
> > > +/* cpu core interrupt numbers */
> > > +#define MIPS_CPU_IRQ_BASE 56
> > > +
> > > +#ifdef CONFIG_CPU_LOONGSON3
> > > +
> > > +#define LOONGSON_UART_IRQ   (MIPS_CPU_IRQ_BASE + 2) /* uart */
> > > +#define LOONGSON_I8259_IRQ  (MIPS_CPU_IRQ_BASE + 3) /* i8259 */
> >
> > For what I have read above and below, the i8259 is not directly
> > connected to the CPU, but rather through the HT controller. This should
> > therefore probably be LOONGSON_HT_IRQ
> >
> I think  LOONGSON_I8259_IRQ is also OK, since I8259 IRQs are 1:1 mapped to
> HT IRQs.

Yes, but it looks strange later that in case of an "i8259" irq, you call 
ht_irqdispatch and not i8259_irqdispatch.

> > > +#define LOONGSON_TIMER_IRQ  (MIPS_CPU_IRQ_BASE + 7) /* cpu timer */
> > > +
> > > +#define LOONGSON_HT1_CFG_BASE                ht_control_base
> > > +#define LOONGSON_HT1_INT_VECTOR_BASE LOONGSON_HT1_CFG_BASE + 0x80
> > > +#define LOONGSON_HT1_INT_EN_BASE     LOONGSON_HT1_CFG_BASE + 0xa0
> > > +#define LOONGSON_HT1_INT_VECTOR(n)
> > LOONGSON3_REG32(LOONGSON_HT1_INT_VECTOR_BASE, 4 * n)
> > > +#define LOONGSON_HT1_INTN_EN(n)
> >  LOONGSON3_REG32(LOONGSON_HT1_INT_EN_BASE, 4 * n)
> > > +
> > > +#endif
> > > +
> > > +#include_next <irq.h>
> > > +#endif /* __ASM_MACH_LOONGSON_IRQ_H_ */
> > > diff --git a/arch/mips/include/asm/mach-loongson/loongson.h
> > b/arch/mips/include/asm/mach-loongson/loongson.h
> > > index 4f28b1f..40b4892 100644
> > > --- a/arch/mips/include/asm/mach-loongson/loongson.h
> > > +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> > > @@ -62,6 +62,12 @@ extern int mach_i8259_irq(void);
> > >  #define LOONGSON_REG(x) \
> > >       (*(volatile u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
> > >
> > > +#define LOONGSON3_REG8(base, x) \
> > > +     (*(volatile u8 *)((char *)TO_UNCAC(base) + (x)))
> > > +
> > > +#define LOONGSON3_REG32(base, x) \
> > > +     (*(volatile u32 *)((char *)TO_UNCAC(base) + (x)))
> > > +
> > >  #define LOONGSON_IRQ_BASE    32
> > >  #define LOONGSON2_PERFCNT_IRQ        (MIPS_CPU_IRQ_BASE + 6) /* cpu
> > perf counter */
> > >
> > > @@ -87,6 +93,9 @@ static inline void do_perfcnt_IRQ(void)
> > >  #define LOONGSON_REG_BASE    0x1fe00000
> > >  #define LOONGSON_REG_SIZE    0x00100000      /* 256Bytes + 256Bytes +
> > ??? */
> > >  #define LOONGSON_REG_TOP     (LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
> > > +#define LOONGSON3_REG_BASE   0x3ff00000
> > > +#define LOONGSON3_REG_SIZE   0x00100000      /* 256Bytes + 256Bytes +
> > ??? */
> > > +#define LOONGSON3_REG_TOP    (LOONGSON3_REG_BASE+LOONGSON3_REG_SIZE-1)
> >
> > I was about to say that CKSEG1ADDR could have been used to define
> > LOONGSON3_REG, that said it looks like LOONGSON3_REG_BASE can't be
> > accessed through CKSEG1ADDR. Given its address, it can be accessed
> > through XKPHYS only.
> >
> > That probably means a 32-bit kernel won't work on a Loongson-3 based
> > machine. However a few of the patches in this series have a #ifdef
> > CONFIG_64BIT.
> >
> Loongson-3 can really boot a 32-bit kernel, by replacing the 64-bit accesses
> with inline assembly. Of course the 32-bit code isn't in this patchset.

Yes, I have seen such a code in patch 11. However I don't understand how
it works:
- 64-bit instructions can always be used in kernel mode (that's not true
  in user mode), so it looks fine from that point of view
- 64-bit memory access like it is done in that case only works if KX bit
  of status register is enabled. This is usually not the case on a
  32-bit kernel.

Anyway if this patchset doesn't really support 32-bit kernels, it
should probably not try to support it partially (at least not define
CPU_SUPPORTS_32BIT_KERNEL). All support for 32-bit should be done in a
separate patchset.

> >  #define LOONGSON_LIO1_BASE   0x1ff00000
> > >  #define LOONGSON_LIO1_SIZE   0x00100000      /* 1M */
> > > diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
> > > index 0dc0055..7429994 100644
> > > --- a/arch/mips/loongson/Makefile
> > > +++ b/arch/mips/loongson/Makefile
> > > @@ -15,3 +15,9 @@ obj-$(CONFIG_LEMOTE_FULOONG2E)      += fuloong-2e/
> > >  #
> > >
> > >  obj-$(CONFIG_LEMOTE_MACH2F)  += lemote-2f/
> > > +
> > > +#
> > > +# All Loongson-3 family machines
> > > +#
> > > +
> > > +obj-$(CONFIG_CPU_LOONGSON3)  += loongson-3/
> > > diff --git a/arch/mips/loongson/loongson-3/Makefile
> > b/arch/mips/loongson/loongson-3/Makefile
> > > new file mode 100644
> > > index 0000000..b9968cd
> > > --- /dev/null
> > > +++ b/arch/mips/loongson/loongson-3/Makefile
> > > @@ -0,0 +1,4 @@
> > > +#
> > > +# Makefile for Loongson-3 family machines
> > > +#
> > > +obj-y                        += irq.o
> > > diff --git a/arch/mips/loongson/loongson-3/irq.c
> > b/arch/mips/loongson/loongson-3/irq.c
> > > new file mode 100644
> > > index 0000000..aaf18c2
> > > --- /dev/null
> > > +++ b/arch/mips/loongson/loongson-3/irq.c
> > > @@ -0,0 +1,111 @@
> > > +#include <loongson.h>
> > > +#include <irq.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +
> > > +#include <asm/irq_cpu.h>
> > > +#include <asm/i8259.h>
> > > +#include <asm/mipsregs.h>
> > > +
> > > +#define LOONGSON_INT_ROUTER_OFFSET   0x1400
> > > +#define LOONGSON_INT_ROUTER_INTEN
> >  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x24)
> > > +#define LOONGSON_INT_ROUTER_INTENSET
> > LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x28)
> > > +#define LOONGSON_INT_ROUTER_INTENCLR
> > LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x2c)
> > > +#define LOONGSON_INT_ROUTER_ENTRY(n) LOONGSON3_REG8(LOONGSON3_REG_BASE,
> > LOONGSON_INT_ROUTER_OFFSET + n)
> > > +#define LOONGSON_INT_ROUTER_LPC
> >  LOONGSON_INT_ROUTER_ENTRY(0x0a)
> > > +#define LOONGSON_INT_ROUTER_HT1(n)   LOONGSON_INT_ROUTER_ENTRY(n + 0x18)
> > > +
> > > +#define LOONGSON_INT_CORE0_INT0              0x11 /* route to int 0 of
> > core 0 */
> > > +#define LOONGSON_INT_CORE0_INT1              0x21 /* route to int 1 of
> > core 0 */
> > > +
> > > +extern void loongson3_ipi_interrupt(struct pt_regs *regs);
> > > +
> > > +static void ht_irqdispatch(void)
> > > +{
> > > +     unsigned int i, irq;
> > > +     unsigned int ht_irq[] = {1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
> > > +
> > > +     irq = LOONGSON_HT1_INT_VECTOR(0);
> > > +     LOONGSON_HT1_INT_VECTOR(0) = irq;
> >
> > I guess it is to acknowledge the IRQ. Maybe a comment should be added to
> > mention it?
> >
> Yes, here needs a comment.
> 
> 
> > > +
> > > +     for (i = 0; i < (sizeof(ht_irq) / sizeof(*ht_irq)); i++) {
> > > +             if (irq & (0x1 << ht_irq[i]))
> > > +                     do_IRQ(ht_irq[i]);
> > > +     }
> > > +}
> > > +
> > > +void mach_irq_dispatch(unsigned int pending)
> > > +{
> > > +     if (pending & CAUSEF_IP7)
> > > +             do_IRQ(LOONGSON_TIMER_IRQ);
> > > +#if defined(CONFIG_SMP)
> > > +     else if (pending & CAUSEF_IP6)
> > > +             loongson3_ipi_interrupt(NULL);
> > > +#endif
> > > +     else if (pending & CAUSEF_IP3)
> > > +             ht_irqdispatch();
> > > +     else if (pending & CAUSEF_IP2)
> > > +             do_IRQ(LOONGSON_UART_IRQ);
> > > +     else {
> > > +             printk(KERN_ERR "%s : spurious interrupt\n", __func__);
> > > +             spurious_interrupt();
> > > +     }
> > > +}
> > > +
> > > +static struct irqaction cascade_irqaction = {
> > > +     .handler = no_action,
> > > +     .name = "cascade",
> > > +};
> > > +
> > > +static inline void mask_loongson_irq(struct irq_data *d)
> > > +{
> > > +     clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
> > > +     irq_disable_hazard();
> > > +}
> > > +
> > > +static inline void unmask_loongson_irq(struct irq_data *d)
> > > +{
> > > +     set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
> > > +     irq_enable_hazard();
> > > +}
> > > +
> > > + /* For MIPS IRQs which shared by all cores */
> > > +static struct irq_chip loongson_irq_chip = {
> > > +     .name           = "Loongson",
> > > +     .irq_ack        = mask_loongson_irq,
> > > +     .irq_mask       = mask_loongson_irq,
> > > +     .irq_mask_ack   = mask_loongson_irq,
> > > +     .irq_unmask     = unmask_loongson_irq,
> > > +     .irq_eoi        = unmask_loongson_irq,
> > > +};
> > > +
> > > +void irq_router_init(void)
> > > +{
> > > +     int i;
> > > +
> > > +     /* route LPC int to cpu core0 int 0 */
> > > +     LOONGSON_INT_ROUTER_LPC = LOONGSON_INT_CORE0_INT0;
> > > +     /* route HT1 int0 ~ int7 to cpu core0 INT1*/
> > > +     for (i = 0; i < 8; i++)
> > > +             LOONGSON_INT_ROUTER_HT1(i) = LOONGSON_INT_CORE0_INT1;
> > > +     /* enable HT1 interrupt */
> > > +     LOONGSON_HT1_INTN_EN(0) = 0xffffffff;
> > > +     /* enable router interrupt intenset */
> > > +     LOONGSON_INT_ROUTER_INTENSET = LOONGSON_INT_ROUTER_INTEN | (0xffff
> > << 16) | 0x1 << 10;
> > > +}
> > > +
> > > +void __init mach_init_irq(void)
> > > +{
> > > +     clear_c0_status(ST0_IM | ST0_BEV);
> > > +
> > > +     irq_router_init();
> > > +     mips_cpu_irq_init();
> > > +     init_i8259_irqs();
> > > +     irq_set_chip_and_handler(LOONGSON_UART_IRQ,
> > > +                     &loongson_irq_chip, handle_level_irq);
> > > +
> > > +     /* setup i8259 irq */
> > > +     setup_irq(LOONGSON_I8259_IRQ, &cascade_irqaction);
> > > +
> > > +     set_c0_status(STATUSF_IP2 | STATUSF_IP6);
> > > +}
> > > --
> > > 1.7.7.3
> > >
> > >
> > >
> >
> > --
> > Aurelien Jarno                          GPG: 1024D/F1BCDB73
> > aurelien@aurel32.net                 http://www.aurel32.net
> >
> >

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
