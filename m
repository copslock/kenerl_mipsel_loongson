Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2011 08:45:24 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:61488 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491033Ab1AGHpU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jan 2011 08:45:20 +0100
Received: by ywf7 with SMTP id 7so7286233ywf.36
        for <linux-mips@linux-mips.org>; Thu, 06 Jan 2011 23:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer;
        bh=QEODe1XXZ8V5oIxJuC53hdLga2tRKB03NGlurjIbyUM=;
        b=MXkt1QqitM7Ytai1hcYTmhn5tCIKnioHNXVzQLZr3UygaFCqXlPG5SoiXHWQwvk0L/
         8I8ZxLgz1Lr+mfzOmZIE1VcT/3IWIJvye+h3zQruYZqyFzJbI9Pa5asCK0wpenfQqumi
         pCRT95wdJ+7+BhDWEtQYNKsEJjqTgXBPHSgpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer;
        b=kxzodfEIaRaIbK+D1Rankc4lDOA2mszZ1UD3sbnZW3GID047xDAIw3aKk9uyMb67wf
         BKZ6Zf5vt5QIlx25giJWEIUeRsWMl/9UXaNwq5QyVKyPsCgOl1lNkWfuF8Eud52s8xsr
         ZrcqOjylbNHRhPsKhzr1YH9Okj04qJKj5Ib7w=
Received: by 10.151.42.3 with SMTP id u3mr5861018ybj.374.1294386312452;
        Thu, 06 Jan 2011 23:45:12 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id b7sm2884863ybn.23.2011.01.06.23.45.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 23:45:09 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D2650D6.4030102@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
         <1293470392.27661.202.camel@paanoop1-desktop>
         <1293524389.27661.210.camel@paanoop1-desktop>
         <4D19A31E.1090905@paralogos.com>
         <1293798476.27661.279.camel@paanoop1-desktop>
         <4D1EE913.1070203@paralogos.com>
         <1294067561.27661.293.camel@paanoop1-desktop>
         <4D21F5D3.50604@paralogos.com>
         <1294082426.27661.330.camel@paanoop1-desktop>
         <4D22D7B3.2050609@paralogos.com>
         <1294146165.27661.361.camel@paanoop1-desktop>
         <1294151822.27661.375.camel@paanoop1-desktop>
         <4D235717.1000603@paralogos.com>
         <1294163657.27661.386.camel@paanoop1-desktop>
         <4D2367EE.7000702@paralogos.com>
         <1294233097.27661.391.camel@paanoop1-desktop>
         <4D24C525.5000306@paralogos.com>
         <1294345396.27661.422.camel@paanoop1-desktop>
         <4D2650D6.4030102@paralogos.com>
Content-Type: multipart/mixed; boundary="=-nDxvhOOi4yjj2vbP9Xbb"
Date:   Fri, 07 Jan 2011 13:26:59 +0530
Message-ID: <1294387019.27661.458.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips


--=-nDxvhOOi4yjj2vbP9Xbb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-01-06 at 15:31 -0800, Kevin D. Kissell wrote:
> On 01/06/11 12:23, Anoop P A wrote:

> 
> I'm sure I've said this before, and it's in various comments in the SMTC
> code, but remember, one of the main problems that the SMTC kernel
> had to solve was to prevent all TCs of a VPE from "convoying" after every
> interrupt.  The way this is done is that the interrupt vector code, before
> clearing EXL, masks off the Status.IM bit associated with the incoming
> interrupt.  Of course, to get another interrupt from the same source
> (or collection of sources), that IM bit needs to be restored.  The "correct"
> mechanism for this is by having the appropriate irq_hwmask[] value set,
> so that smtc_im_ack_irq(), which should be invoked on an irq "ack()"
> (meaning that the source has been quenched and any new occurrence
> should be considered a new interrupt), will restore the bit in Status.
> This function got moved around a bit in the various SMTC prototypes,
> but it proved least intrusive to put it into the xxx_mask_and_ack() 
> functions
> for the interrupt controllers - see irq-msc01.c and i8259.c.  If you haven't
> done the same in any equivalent code for a different on-chip controller,
> you'll definitely have problems.
> 
> The Backstop scheme works OK for peripheral interrupts that didn't
> have an appropriate irq_hwmask[] value set up, but clock interrupts
> don't follow the same code paths and can't depend on the backstop.

Ok. Well thanks much for your detailed explanation. Well I hope I found
the root cause . smtc_clockevent_init() was overriding irq_hwmask even
if are using platform specific get_c0_compare_int. With following patch
everything seems to be working for me.
------------------------------------------------------------------------
diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
index 2e72d30..a25fc59 100644
--- a/arch/mips/kernel/cevt-smtc.c
+++ b/arch/mips/kernel/cevt-smtc.c
@@ -310,9 +310,14 @@ int __cpuinit smtc_clockevent_init(void)
 		return 0;
 	/*
 	 * And we need the hwmask associated with the c0_compare
-	 * vector to be initialized.
+	 * vector to be initialized. However incase of platform 
+	 * specific get_co_compare_int, don't override irq_hwmask
+	 * expect platform code to set a valid mask value. 
 	 */
-	irq_hwmask[irq] = (0x100 << cp0_compare_irq);
+
+	if (!get_c0_compare_int)
+		irq_hwmask[irq] = (0x100 << cp0_compare_irq);
+
 	if (cp0_timer_irq_installed)
 		return 0;
----------------------------------------------------------------------- 


Attaching my msp_ir_cic.c . Kindly have a look if possible.

Thanks
Anoop

> 
>              Regards,
> 
>              Kevin K.


--=-nDxvhOOi4yjj2vbP9Xbb
Content-Disposition: attachment; filename="msp_irq_cic.c"
Content-Type: text/x-csrc; name="msp_irq_cic.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/*
 * Copyright 2010 PMC-Sierra, Inc, derived from irq_cpu.c
 *
 * This file define the irq handler for MSP CIC subsystem interrupts.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/kernel.h>
#include <linux/bitops.h>
#include <linux/irq.h>

#include <asm/mipsregs.h>
#include <asm/system.h>

#include <msp_cic_int.h>
#include <msp_regs.h>

/*
 * External API
 */
extern void msp_per_irq_init(void);
extern void msp_per_irq_dispatch(void);


/*
 * Convenience Macro.  Should be somewhere generic.
 */
#define get_current_vpe()   \
	((read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE) 

#ifdef CONFIG_SMP

#define LOCK_VPE(flags, mtflags) \
do {				\
	local_irq_save(flags);	\
	mtflags = dmt();	\
} while (0)

#define UNLOCK_VPE(flags, mtflags) \
do {				\
	emt(mtflags);		\
	local_irq_restore(flags);\
} while (0)

#define LOCK_CORE(flags, mtflags) \
do {				\
	local_irq_save(flags);	\
	mtflags = dvpe();	\
} while (0)

#define UNLOCK_CORE(flags, mtflags)		\
do {				\
	evpe(mtflags);		\
	local_irq_restore(flags);\
} while (0)

#else

#define LOCK_VPE(flags, mtflags) 
#define UNLOCK_VPE(flags, mtflags) 

#endif

/* ensure writes to cic are completed */
static inline void cic_wmb(void)
{
	const volatile void __iomem *cic_mem = CIC_VPE0_MSK_REG;
	volatile u32 dummy_read;

	wmb();
	dummy_read = __raw_readl(cic_mem);
	dummy_read++;
}


static inline void unmask_cic_irq(unsigned int irq)
{
	volatile u32   *cic_msk_reg = CIC_VPE0_MSK_REG;
	int vpe;
#ifdef CONFIG_SMP
	unsigned int mtflags;
	unsigned long  flags;

	/*
	* Make sure we have IRQ affinity.  It may have changed while
	* we were processing the IRQ.
	*/
	if (!cpumask_test_cpu(smp_processor_id(), irq_desc[irq].affinity))
		return;
#endif

	vpe = get_current_vpe();
	LOCK_VPE(flags, mtflags);
	cic_msk_reg[vpe] |= (1 << (irq - MSP_CIC_INTBASE));
	UNLOCK_VPE(flags, mtflags);
	cic_wmb();
}

static inline void mask_cic_irq(unsigned int irq)
{
	volatile u32 *cic_msk_reg = CIC_VPE0_MSK_REG;
	int	vpe = get_current_vpe();
#ifdef CONFIG_SMP
	unsigned long flags, mtflags;
#endif
	LOCK_VPE(flags, mtflags);
	cic_msk_reg[vpe] &= ~(1 << (irq - MSP_CIC_INTBASE));
	UNLOCK_VPE(flags, mtflags);
	cic_wmb();
}
static inline void msp_cic_irq_ack(unsigned int irq)
{
	mask_cic_irq(irq);
	/*
	* Only really necessary for 18, 16-14 and sometimes 3:0
	* (since these can be edge sensitive) but it doesn't
	* hurt for the others
	*/
	*CIC_STS_REG = (1 << (irq - MSP_CIC_INTBASE));
	smtc_im_ack_irq(irq);
}

static void msp_cic_irq_end(unsigned int irq)
{
	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
		unmask_cic_irq(irq);
}

#ifdef CONFIG_SMP
static inline int msp_cic_irq_set_affinity(unsigned int irq,
					const struct cpumask *cpumask)
{
	int cpu;
	unsigned long flags;
	unsigned int  mtflags;
	unsigned long imask = (1 << (irq - MSP_CIC_INTBASE));
	volatile u32 *cic_mask = (volatile u32 *)CIC_VPE0_MSK_REG;

	/* timer balancing should be disabled in kernel code */
	BUG_ON(irq == MSP_INT_VPE0_TIMER || irq == MSP_INT_VPE1_TIMER);

	LOCK_CORE(flags, mtflags);
	/* enable if any of each VPE's TCs require this IRQ */
	for_each_online_cpu(cpu) {
		if (cpumask_test_cpu(cpu, cpumask))
			cic_mask[cpu] |= imask;
		else
			cic_mask[cpu] &= ~imask;

	}

	UNLOCK_CORE(flags, mtflags);
	return 0;

}
#endif

static struct irq_chip msp_cic_irq_controller = {
	.name = "MSP_CIC",
	.mask = msp_cic_irq_ack,
	.mask_ack = msp_cic_irq_ack,
	.unmask = unmask_cic_irq,
	.ack = msp_cic_irq_ack,
	.end = msp_cic_irq_end,
#ifdef CONFIG_SMP
	.set_affinity = msp_cic_irq_set_affinity,
#endif
};

void __init msp_cic_irq_init(void)
{
	int i;
	/* Mask/clear interrupts. */
	*CIC_VPE0_MSK_REG = 0x00000000;
	*CIC_VPE1_MSK_REG = 0x00000000;
	*CIC_STS_REG      = 0xFFFFFFFF;
	/*
	* The MSP7120 RG and EVBD boards use IRQ[6:4] for PCI.
	* These inputs map to EXT_INT_POL[6:4] inside the CIC.
	* They are to be active low, level sensitive.
	*/
	*CIC_EXT_CFG_REG &= 0xFFFF8F8F;

	/* initialize all the IRQ descriptors */
	for (i = MSP_CIC_INTBASE ; i < MSP_CIC_INTBASE + 32 ; i++) {
		set_irq_chip_and_handler(i, &msp_cic_irq_controller,
					 handle_level_irq);
#ifdef CONFIG_MIPS_MT_SMTC
		/* Mask of CIC interrupt */
		irq_hwmask[i] = C_IRQ4;
#endif
	}

	/* Initialize the PER interrupt sub-system */
	 msp_per_irq_init();
}

/* CIC masked by CIC vector processing before dispatch called */
void msp_cic_irq_dispatch(void)
{
	volatile u32	*cic_msk_reg = (volatile u32 *)CIC_VPE0_MSK_REG;
	u32	cic_mask;
	u32	 pending;
	int	cic_status = *CIC_STS_REG;
	cic_mask = cic_msk_reg[get_current_vpe()];
	pending = cic_status & cic_mask;
	if (pending & (1 << (MSP_INT_VPE0_TIMER - MSP_CIC_INTBASE))) {
		do_IRQ(MSP_INT_VPE0_TIMER);
	} else if (pending & (1 << (MSP_INT_VPE1_TIMER - MSP_CIC_INTBASE))) {
		do_IRQ(MSP_INT_VPE1_TIMER);
	} else if (pending & (1 << (MSP_INT_PER - MSP_CIC_INTBASE))) {
		msp_per_irq_dispatch();
	} else if (pending) {
		do_IRQ(ffs(pending) + MSP_CIC_INTBASE - 1);
	} else{
		spurious_interrupt();
		/* Re-enable the CIC cascaded interrupt. */
		irq_desc[MSP_INT_CIC].chip->end(MSP_INT_CIC);
	}
}

--=-nDxvhOOi4yjj2vbP9Xbb--
