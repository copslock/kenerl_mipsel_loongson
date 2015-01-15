Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 12:59:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30659 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011595AbbAOL7by6J1i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 12:59:31 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3D4FE41F8DBF;
        Thu, 15 Jan 2015 11:59:26 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 15 Jan 2015 11:59:26 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 15 Jan 2015 11:59:26 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C85CDA0597BD8;
        Thu, 15 Jan 2015 11:59:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 15 Jan 2015 11:59:25 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 15 Jan
 2015 11:59:23 +0000
Message-ID: <54B7AB95.4080501@imgtec.com>
Date:   Thu, 15 Jan 2015 11:59:17 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Qais Yousef" <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        "John Crispin" <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 18/24] irqchip: mips-gic: Stop using per-platform mapping
 tables
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org> <1411076851-28242-19-git-send-email-abrestic@chromium.org>
In-Reply-To: <1411076851-28242-19-git-send-email-abrestic@chromium.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="3d8TLpjw4HNIaBb3MVqa7fFaFr9o72EWV"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--3d8TLpjw4HNIaBb3MVqa7fFaFr9o72EWV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 18/09/14 22:47, Andrew Bresticker wrote:
> Now that the GIC properly uses IRQ domains, kill off the per-platform
> routing tables that were used to make the GIC appear transparent.
>=20
> This includes:
>  - removing the mapping tables and the support for applying them,
>  - moving GIC IPI support to the GIC driver,
>  - properly routing the i8259 through the GIC on Malta, and
>  - updating IRQ assignments on SEAD-3 when the GIC is present.
>=20
> Platforms no longer will pass an interrupt mapping table to gic_init.
> Instead, they will pass the CPU interrupt vector (2 - 7) that they
> expect the GIC to route interrupts to.  Note that in EIC mode this
> value is ignored and all GIC interrupts are routed to EIC vector 1.
>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
> Tested-by: Qais Yousef <qais.yousef@imgtec.com>

This commit (18743d2781d01d34d132f952a2e16353ccb4c3de) appears to break
boot of interAptiv, dual core, dual vpe per core, on malta with
malta_defconfig.

It gets to here:
=2E..
CPU1 revision is: 0001a120 (MIPS interAptiv (multi))
FPU revision is: 0173a000
Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
MIPS secondary cache 1024kB, 8-way, linesize 32 bytes.
Synchronize counters for CPU 1: done.
Brought up 2 CPUs

and then appears to just hang. Passing nosmp works around it, allowing
it to get to userland.

Is that a problem you've already come across?

I'll keep debugging.

Thanks
James

> ---
> No changes from v1.
> ---
>  arch/mips/include/asm/gic.h                  |  35 +----
>  arch/mips/include/asm/mips-boards/maltaint.h |  14 +-
>  arch/mips/include/asm/mips-boards/sead3int.h |  13 ++
>  arch/mips/kernel/cevt-gic.c                  |   3 +-
>  arch/mips/mti-malta/malta-int.c              | 189 +++++--------------=
------
>  arch/mips/mti-sead3/sead3-ehci.c             |   8 +-
>  arch/mips/mti-sead3/sead3-int.c              |  28 +---
>  arch/mips/mti-sead3/sead3-net.c              |  14 +-
>  arch/mips/mti-sead3/sead3-platform.c         |  18 ++-
>  drivers/irqchip/irq-mips-gic.c               | 201 ++++++++++++++-----=
--------
>  10 files changed, 198 insertions(+), 325 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
> index efcf4de..cfbf907 100644
> --- a/arch/mips/include/asm/gic.h
> +++ b/arch/mips/include/asm/gic.h
> @@ -316,31 +316,6 @@
>  	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe)), =
\
>  		 GIC_SH_MAP_TO_VPE_REG_BIT(vpe))
> =20
> -/*
> - * Interrupt Meta-data specification. The ipiflag helps
> - * in building ipi_map.
> - */
> -struct gic_intr_map {
> -	unsigned int cpunum;	/* Directed to this CPU */
> -#define GIC_UNUSED		0xdead			/* Dummy data */
> -	unsigned int pin;	/* Directed to this Pin */
> -	unsigned int polarity;	/* Polarity : +/-	*/
> -	unsigned int trigtype;	/* Trigger  : Edge/Levl */
> -	unsigned int flags;	/* Misc flags	*/
> -#define GIC_FLAG_TRANSPARENT   0x01
> -};
> -
> -/*
> - * This is only used in EIC mode. This helps to figure out which
> - * shared interrupts we need to process when we get a vector interrupt=
=2E
> - */
> -#define GIC_MAX_SHARED_INTR  0x5
> -struct gic_shared_intr_map {
> -	unsigned int num_shared_intr;
> -	unsigned int intr_list[GIC_MAX_SHARED_INTR];
> -	unsigned int local_intr_mask;
> -};
> -
>  /* GIC nomenclature for Core Interrupt Pins. */
>  #define GIC_CPU_INT0		0 /* Core Interrupt 2 */
>  #define GIC_CPU_INT1		1 /* .		      */
> @@ -349,6 +324,9 @@ struct gic_shared_intr_map {
>  #define GIC_CPU_INT4		4 /* .		      */
>  #define GIC_CPU_INT5		5 /* Core Interrupt 7 */
> =20
> +/* Add 2 to convert GIC CPU pin to core interrupt */
> +#define GIC_CPU_PIN_OFFSET	2
> +
>  /* Local GIC interrupts. */
>  #define GIC_INT_TMR		(GIC_CPU_INT5)
>  #define GIC_INT_PERFCTR		(GIC_CPU_INT5)
> @@ -365,13 +343,12 @@ struct gic_shared_intr_map {
>  extern unsigned int gic_present;
>  extern unsigned int gic_frequency;
>  extern unsigned long _gic_base;
> -extern unsigned int gic_irq_base;
>  extern unsigned int gic_irq_flags[];
> -extern struct gic_shared_intr_map gic_shared_intr_map[];
> +extern unsigned int gic_cpu_pin;
> =20
>  extern void gic_init(unsigned long gic_base_addr,
> -	unsigned long gic_addrspace_size, struct gic_intr_map *intrmap,
> -	unsigned int intrmap_size, unsigned int irqbase);
> +	unsigned long gic_addrspace_size, unsigned int cpu_vec,
> +	unsigned int irqbase);
>  extern void gic_clocksource_init(unsigned int);
>  extern unsigned int gic_compare_int (void);
>  extern cycle_t gic_read_count(void);
> diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/i=
nclude/asm/mips-boards/maltaint.h
> index d741628..bdd6f39 100644
> --- a/arch/mips/include/asm/mips-boards/maltaint.h
> +++ b/arch/mips/include/asm/mips-boards/maltaint.h
> @@ -20,11 +20,10 @@
>  #define MIPSCPU_INT_SW1		1
>  #define MIPSCPU_INT_MB0		2
>  #define MIPSCPU_INT_I8259A	MIPSCPU_INT_MB0
> +#define MIPSCPU_INT_GIC		MIPSCPU_INT_MB0 /* GIC chained interrupt */
>  #define MIPSCPU_INT_MB1		3
>  #define MIPSCPU_INT_SMI		MIPSCPU_INT_MB1
> -#define MIPSCPU_INT_IPI0	MIPSCPU_INT_MB1 /* GIC IPI */
>  #define MIPSCPU_INT_MB2		4
> -#define MIPSCPU_INT_IPI1	MIPSCPU_INT_MB2 /* GIC IPI */
>  #define MIPSCPU_INT_MB3		5
>  #define MIPSCPU_INT_COREHI	MIPSCPU_INT_MB3
>  #define MIPSCPU_INT_MB4		6
> @@ -61,14 +60,7 @@
>  #define MSC01E_INT_PERFCTR	10
>  #define MSC01E_INT_CPUCTR	11
> =20
> -/* External Interrupts used for IPI */
> -#define GIC_IPI_EXT_INTR_RESCHED_VPE0	16
> -#define GIC_IPI_EXT_INTR_CALLFNC_VPE0	17
> -#define GIC_IPI_EXT_INTR_RESCHED_VPE1	18
> -#define GIC_IPI_EXT_INTR_CALLFNC_VPE1	19
> -#define GIC_IPI_EXT_INTR_RESCHED_VPE2	20
> -#define GIC_IPI_EXT_INTR_CALLFNC_VPE2	21
> -#define GIC_IPI_EXT_INTR_RESCHED_VPE3	22
> -#define GIC_IPI_EXT_INTR_CALLFNC_VPE3	23
> +/* GIC external interrupts */
> +#define GIC_INT_I8259A		3
> =20
>  #endif /* !(_MIPS_MALTAINT_H) */
> diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/i=
nclude/asm/mips-boards/sead3int.h
> index 11ebec9..a2e0095 100644
> --- a/arch/mips/include/asm/mips-boards/sead3int.h
> +++ b/arch/mips/include/asm/mips-boards/sead3int.h
> @@ -14,4 +14,17 @@
>  #define GIC_BASE_ADDR		0x1b1c0000
>  #define GIC_ADDRSPACE_SZ	(128 * 1024)
> =20
> +/* CPU interrupt offsets */
> +#define CPU_INT_GIC		2
> +#define CPU_INT_EHCI		2
> +#define CPU_INT_UART0		4
> +#define CPU_INT_UART1		4
> +#define CPU_INT_NET		6
> +
> +/* GIC interrupt offsets */
> +#define GIC_INT_NET		0
> +#define GIC_INT_UART1		2
> +#define GIC_INT_UART0		3
> +#define GIC_INT_EHCI		5
> +
>  #endif /* !(_MIPS_SEAD3INT_H) */
> diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
> index 6093716..a90bd4c 100644
> --- a/arch/mips/kernel/cevt-gic.c
> +++ b/arch/mips/kernel/cevt-gic.c
> @@ -91,7 +91,8 @@ int gic_clockevent_init(void)
> =20
>  	clockevents_register_device(cd);
> =20
> -	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_MAP), 0x80000002);
> +	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_MAP),
> +		 GIC_MAP_TO_PIN_MSK | gic_cpu_pin);
>  	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), GIC_VPE_SMASK_CMP_MSK);
> =20
>  	if (gic_timer_irq_installed)
> diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malt=
a-int.c
> index e56563c..3b3bc1d 100644
> --- a/arch/mips/mti-malta/malta-int.c
> +++ b/arch/mips/mti-malta/malta-int.c
> @@ -38,14 +38,9 @@
>  #include <asm/rtlx.h>
> =20
>  static unsigned long _msc01_biu_base;
> -static unsigned int ipi_map[NR_CPUS];
> =20
>  static DEFINE_RAW_SPINLOCK(mips_irq_lock);
> =20
> -#ifdef CONFIG_MIPS_GIC_IPI
> -DECLARE_BITMAP(ipi_ints, GIC_NUM_INTRS);
> -#endif
> -
>  static inline int mips_pcibios_iack(void)
>  {
>  	int irq;
> @@ -127,24 +122,10 @@ static void malta_hw0_irqdispatch(void)
>  #endif
>  }
> =20
> -static void malta_ipi_irqdispatch(void)
> +static irqreturn_t i8259_handler(int irq, void *dev_id)
>  {
> -#ifdef CONFIG_MIPS_GIC_IPI
> -	unsigned long irq;
> -	DECLARE_BITMAP(pending, GIC_NUM_INTRS);
> -
> -	gic_get_int_mask(pending, ipi_ints);
> -
> -	irq =3D find_first_bit(pending, GIC_NUM_INTRS);
> -
> -	while (irq < GIC_NUM_INTRS) {
> -		do_IRQ(MIPS_GIC_IRQ_BASE + irq);
> -
> -		irq =3D find_next_bit(pending, GIC_NUM_INTRS, irq + 1);
> -	}
> -#endif
> -	if (gic_compare_int())
> -		do_IRQ(MIPS_GIC_IRQ_BASE);
> +	malta_hw0_irqdispatch();
> +	return IRQ_HANDLED;
>  }
> =20
>  static void corehi_irqdispatch(void)
> @@ -203,6 +184,12 @@ static void corehi_irqdispatch(void)
>  	die("CoreHi interrupt", regs);
>  }
> =20
> +static irqreturn_t corehi_handler(int irq, void *dev_id)
> +{
> +	corehi_irqdispatch();
> +	return IRQ_HANDLED;
> +}
> +
>  static inline int clz(unsigned long x)
>  {
>  	__asm__(
> @@ -286,10 +273,9 @@ asmlinkage void plat_irq_dispatch(void)
> =20
>  	irq =3D irq_ffs(pending);
> =20
> -	if (irq =3D=3D MIPSCPU_INT_I8259A)
> -		malta_hw0_irqdispatch();
> -	else if (gic_present && ((1 << irq) & ipi_map[smp_processor_id()]))
> -		malta_ipi_irqdispatch();
> +	/* HACK: GIC doesn't properly dispatch local interrupts yet */
> +	if (gic_present && irq =3D=3D MIPSCPU_INT_GIC && gic_compare_int())
> +		do_IRQ(MIPS_GIC_IRQ_BASE);
>  	else
>  		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
>  }
> @@ -312,13 +298,6 @@ static void ipi_call_dispatch(void)
>  	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ);
>  }
> =20
> -#endif /* CONFIG_MIPS_MT_SMP */
> -
> -#ifdef CONFIG_MIPS_GIC_IPI
> -
> -#define GIC_MIPS_CPU_IPI_RESCHED_IRQ	3
> -#define GIC_MIPS_CPU_IPI_CALL_IRQ	4
> -
>  static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
>  {
>  #ifdef CONFIG_MIPS_VPE_APSP_API_CMP
> @@ -349,31 +328,16 @@ static struct irqaction irq_call =3D {
>  	.flags		=3D IRQF_PERCPU,
>  	.name		=3D "IPI_call"
>  };
> -#endif /* CONFIG_MIPS_GIC_IPI */
> -
> -static int gic_resched_int_base;
> -static int gic_call_int_base;
> -#define GIC_RESCHED_INT(cpu) (gic_resched_int_base+(cpu))
> -#define GIC_CALL_INT(cpu) (gic_call_int_base+(cpu))
> -
> -unsigned int plat_ipi_call_int_xlate(unsigned int cpu)
> -{
> -	return GIC_CALL_INT(cpu);
> -}
> -
> -unsigned int plat_ipi_resched_int_xlate(unsigned int cpu)
> -{
> -	return GIC_RESCHED_INT(cpu);
> -}
> +#endif /* CONFIG_MIPS_MT_SMP */
> =20
>  static struct irqaction i8259irq =3D {
> -	.handler =3D no_action,
> +	.handler =3D i8259_handler,
>  	.name =3D "XT-PIC cascade",
>  	.flags =3D IRQF_NO_THREAD,
>  };
> =20
>  static struct irqaction corehi_irqaction =3D {
> -	.handler =3D no_action,
> +	.handler =3D corehi_handler,
>  	.name =3D "CoreHi",
>  	.flags =3D IRQF_NO_THREAD,
>  };
> @@ -399,60 +363,6 @@ static msc_irqmap_t msc_eicirqmap[] __initdata =3D=
 {
> =20
>  static int msc_nr_eicirqs __initdata =3D ARRAY_SIZE(msc_eicirqmap);
> =20
> -/*
> - * This GIC specific tabular array defines the association between Ext=
ernal
> - * Interrupts and CPUs/Core Interrupts. The nature of the External
> - * Interrupts is also defined here - polarity/trigger.
> - */
> -
> -#define GIC_CPU_NMI GIC_MAP_TO_NMI_MSK
> -#define X GIC_UNUSED
> -
> -static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] =3D {
> -	{ X, X,		   X,		X,		0 },
> -	{ X, X,		   X,		X,		0 },
> -	{ X, X,		   X,		X,		0 },
> -	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT1, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT4, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ X, X,		   X,		X,		0 },
> -	{ X, X,		   X,		X,		0 },
> -	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_NMI,  GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_NMI,  GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ X, X,		   X,		X,		0 },
> -	/* The remainder of this table is initialised by fill_ipi_map */
> -};
> -#undef X
> -
> -#ifdef CONFIG_MIPS_GIC_IPI
> -static void __init fill_ipi_map1(int baseintr, int cpu, int cpupin)
> -{
> -	int intr =3D baseintr + cpu;
> -	gic_intr_map[intr].cpunum =3D cpu;
> -	gic_intr_map[intr].pin =3D cpupin;
> -	gic_intr_map[intr].polarity =3D GIC_POL_POS;
> -	gic_intr_map[intr].trigtype =3D GIC_TRIG_EDGE;
> -	gic_intr_map[intr].flags =3D 0;
> -	ipi_map[cpu] |=3D (1 << (cpupin + 2));
> -	bitmap_set(ipi_ints, intr, 1);
> -}
> -
> -static void __init fill_ipi_map(void)
> -{
> -	int cpu;
> -
> -	for (cpu =3D 0; cpu < nr_cpu_ids; cpu++) {
> -		fill_ipi_map1(gic_resched_int_base, cpu, GIC_CPU_INT1);
> -		fill_ipi_map1(gic_call_int_base, cpu, GIC_CPU_INT2);
> -	}
> -}
> -#endif
> -
>  void __init arch_init_ipiirq(int irq, struct irqaction *action)
>  {
>  	setup_irq(irq, action);
> @@ -461,6 +371,8 @@ void __init arch_init_ipiirq(int irq, struct irqact=
ion *action)
> =20
>  void __init arch_init_irq(void)
>  {
> +	int corehi_irq, i8259_irq;
> +
>  	init_i8259_irqs();
> =20
>  	if (!cpu_has_veic)
> @@ -507,34 +419,11 @@ void __init arch_init_irq(void)
>  					msc_nr_irqs);
>  	}
> =20
> -	if (cpu_has_veic) {
> -		set_vi_handler(MSC01E_INT_I8259A, malta_hw0_irqdispatch);
> -		set_vi_handler(MSC01E_INT_COREHI, corehi_irqdispatch);
> -		setup_irq(MSC01E_INT_BASE+MSC01E_INT_I8259A, &i8259irq);
> -		setup_irq(MSC01E_INT_BASE+MSC01E_INT_COREHI, &corehi_irqaction);
> -	} else if (cpu_has_vint) {
> -		set_vi_handler(MIPSCPU_INT_I8259A, malta_hw0_irqdispatch);
> -		set_vi_handler(MIPSCPU_INT_COREHI, corehi_irqdispatch);
> -		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq);
> -		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
> -						&corehi_irqaction);
> -	} else {
> -		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq);
> -		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
> -						&corehi_irqaction);
> -	}
> -
>  	if (gic_present) {
> -		/* FIXME */
>  		int i;
> -#if defined(CONFIG_MIPS_GIC_IPI)
> -		gic_call_int_base =3D GIC_NUM_INTRS -
> -			(NR_CPUS - nr_cpu_ids) * 2 - nr_cpu_ids;
> -		gic_resched_int_base =3D gic_call_int_base - nr_cpu_ids;
> -		fill_ipi_map();
> -#endif
> -		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
> -				ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
> +
> +		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, MIPSCPU_INT_GIC,
> +			 MIPS_GIC_IRQ_BASE);
>  		if (!mips_cm_present()) {
>  			/* Enable the GIC */
>  			i =3D REG(_msc01_biu_base, MSC01_SC_CFG);
> @@ -542,28 +431,8 @@ void __init arch_init_irq(void)
>  				(i | (0x1 << MSC01_SC_CFG_GICENA_SHF));
>  			pr_debug("GIC Enabled\n");
>  		}
> -#if defined(CONFIG_MIPS_GIC_IPI)
> -		/* set up ipi interrupts */
> -		if (cpu_has_vint) {
> -			set_vi_handler(MIPSCPU_INT_IPI0, malta_ipi_irqdispatch);
> -			set_vi_handler(MIPSCPU_INT_IPI1, malta_ipi_irqdispatch);
> -		}
> -		/* Argh.. this really needs sorting out.. */
> -		pr_info("CPU%d: status register was %08x\n",
> -			smp_processor_id(), read_c0_status());
> -		write_c0_status(read_c0_status() | STATUSF_IP3 | STATUSF_IP4);
> -		pr_info("CPU%d: status register now %08x\n",
> -			smp_processor_id(), read_c0_status());
> -		write_c0_status(0x1100dc00);
> -		pr_info("CPU%d: status register frc %08x\n",
> -			smp_processor_id(), read_c0_status());
> -		for (i =3D 0; i < nr_cpu_ids; i++) {
> -			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
> -					 GIC_RESCHED_INT(i), &irq_resched);
> -			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
> -					 GIC_CALL_INT(i), &irq_call);
> -		}
> -#endif
> +		i8259_irq =3D MIPS_GIC_IRQ_BASE + GIC_INT_I8259A;
> +		corehi_irq =3D MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
>  	} else {
>  #if defined(CONFIG_MIPS_MT_SMP)
>  		/* set up ipi interrupts */
> @@ -587,7 +456,21 @@ void __init arch_init_irq(void)
>  		arch_init_ipiirq(cpu_ipi_resched_irq, &irq_resched);
>  		arch_init_ipiirq(cpu_ipi_call_irq, &irq_call);
>  #endif
> +		if (cpu_has_veic) {
> +			set_vi_handler(MSC01E_INT_I8259A,
> +				       malta_hw0_irqdispatch);
> +			set_vi_handler(MSC01E_INT_COREHI,
> +				       corehi_irqdispatch);
> +			i8259_irq =3D MSC01E_INT_BASE + MSC01E_INT_I8259A;
> +			corehi_irq =3D MSC01E_INT_BASE + MSC01E_INT_COREHI;
> +		} else {
> +			i8259_irq =3D MIPS_CPU_IRQ_BASE + MIPSCPU_INT_I8259A;
> +			corehi_irq =3D MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
> +		}
>  	}
> +
> +	setup_irq(i8259_irq, &i8259irq);
> +	setup_irq(corehi_irq, &corehi_irqaction);
>  }
> =20
>  void malta_be_init(void)
> diff --git a/arch/mips/mti-sead3/sead3-ehci.c b/arch/mips/mti-sead3/sea=
d3-ehci.c
> index 772fc05..4ddaa0f 100644
> --- a/arch/mips/mti-sead3/sead3-ehci.c
> +++ b/arch/mips/mti-sead3/sead3-ehci.c
> @@ -10,6 +10,9 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
> =20
> +#include <asm/gic.h>
> +#include <asm/mips-boards/sead3int.h>
> +
>  struct resource ehci_resources[] =3D {
>  	{
>  		.start			=3D 0x1b200000,
> @@ -17,7 +20,6 @@ struct resource ehci_resources[] =3D {
>  		.flags			=3D IORESOURCE_MEM
>  	},
>  	{
> -		.start			=3D MIPS_CPU_IRQ_BASE + 2,
>  		.flags			=3D IORESOURCE_IRQ
>  	}
>  };
> @@ -37,6 +39,10 @@ static struct platform_device ehci_device =3D {
> =20
>  static int __init ehci_init(void)
>  {
> +	if (gic_present)
> +		ehci_resources[1].start =3D MIPS_GIC_IRQ_BASE + GIC_INT_EHCI;
> +	else
> +		ehci_resources[1].start =3D MIPS_CPU_IRQ_BASE + CPU_INT_EHCI;
>  	return platform_device_register(&ehci_device);
>  }
> =20
> diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead=
3-int.c
> index 8f36342..cb06cd9 100644
> --- a/arch/mips/mti-sead3/sead3-int.c
> +++ b/arch/mips/mti-sead3/sead3-int.c
> @@ -22,30 +22,6 @@
> =20
>  static unsigned long sead3_config_reg;
> =20
> -/*
> - * This table defines the setup for each external GIC interrupt. It is=

> - * indexed by interrupt number.
> - */
> -#define GIC_CPU_NMI GIC_MAP_TO_NMI_MSK
> -static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] =3D {
> -	{ 0, GIC_CPU_INT4, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT1, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT =
},
> -	{ GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED },
> -	{ GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED },
> -	{ GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED },
> -	{ GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED },
> -	{ GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED },
> -	{ GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED },
> -	{ GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED, GIC_UNUSED },
> -};
> -
>  asmlinkage void plat_irq_dispatch(void)
>  {
>  	unsigned int pending =3D read_c0_cause() & read_c0_status() & ST0_IM;=

> @@ -81,7 +57,7 @@ void __init arch_init_irq(void)
>  		(current_cpu_data.options & MIPS_CPU_VEIC) ?  "on" : "off");
> =20
>  	if (gic_present)
> -		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
> -			ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
> +		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, CPU_INT_GIC,
> +			 MIPS_GIC_IRQ_BASE);
>  }
> =20
> diff --git a/arch/mips/mti-sead3/sead3-net.c b/arch/mips/mti-sead3/sead=
3-net.c
> index dd11e7e..c9f728a 100644
> --- a/arch/mips/mti-sead3/sead3-net.c
> +++ b/arch/mips/mti-sead3/sead3-net.c
> @@ -10,6 +10,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/smsc911x.h>
> =20
> +#include <asm/gic.h>
> +#include <asm/mips-boards/sead3int.h>
> +
>  static struct smsc911x_platform_config sead3_smsc911x_data =3D {
>  	.irq_polarity =3D SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
>  	.irq_type =3D SMSC911X_IRQ_TYPE_PUSH_PULL,
> @@ -17,14 +20,13 @@ static struct smsc911x_platform_config sead3_smsc91=
1x_data =3D {
>  	.phy_interface =3D PHY_INTERFACE_MODE_MII,
>  };
> =20
> -struct resource sead3_net_resourcess[] =3D {
> +struct resource sead3_net_resources[] =3D {
>  	{
>  		.start			=3D 0x1f010000,
>  		.end			=3D 0x1f01ffff,
>  		.flags			=3D IORESOURCE_MEM
>  	},
>  	{
> -		.start			=3D MIPS_CPU_IRQ_BASE + 6,
>  		.flags			=3D IORESOURCE_IRQ
>  	}
>  };
> @@ -35,12 +37,16 @@ static struct platform_device sead3_net_device =3D =
{
>  	.dev			=3D {
>  		.platform_data	=3D &sead3_smsc911x_data,
>  	},
> -	.num_resources		=3D ARRAY_SIZE(sead3_net_resourcess),
> -	.resource		=3D sead3_net_resourcess
> +	.num_resources		=3D ARRAY_SIZE(sead3_net_resources),
> +	.resource		=3D sead3_net_resources
>  };
> =20
>  static int __init sead3_net_init(void)
>  {
> +	if (gic_present)
> +		sead3_net_resources[1].start =3D MIPS_GIC_IRQ_BASE + GIC_INT_NET;
> +	else
> +		sead3_net_resources[1].start =3D MIPS_CPU_IRQ_BASE + CPU_INT_NET;
>  	return platform_device_register(&sead3_net_device);
>  }
> =20
> diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3=
/sead3-platform.c
> index 6c3b33d..d9661eb 100644
> --- a/arch/mips/mti-sead3/sead3-platform.c
> +++ b/arch/mips/mti-sead3/sead3-platform.c
> @@ -9,10 +9,13 @@
>  #include <linux/init.h>
>  #include <linux/serial_8250.h>
> =20
> -#define UART(base, int)							\
> +#include <asm/gic.h>
> +#include <asm/mips-boards/sead3int.h>
> +
> +#define UART(base)							\
>  {									\
>  	.mapbase	=3D base,						\
> -	.irq		=3D int,						\
> +	.irq		=3D -1,						\
>  	.uartclk	=3D 14745600,					\
>  	.iotype		=3D UPIO_MEM32,					\
>  	.flags		=3D UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP, \
> @@ -20,8 +23,8 @@
>  }
> =20
>  static struct plat_serial8250_port uart8250_data[] =3D {
> -	UART(0x1f000900, MIPS_CPU_IRQ_BASE + 4),   /* ttyS0 =3D USB   */
> -	UART(0x1f000800, MIPS_CPU_IRQ_BASE + 4),   /* ttyS1 =3D RS232 */
> +	UART(0x1f000900),   /* ttyS0 =3D USB   */
> +	UART(0x1f000800),   /* ttyS1 =3D RS232 */
>  	{ },
>  };
> =20
> @@ -35,6 +38,13 @@ static struct platform_device uart8250_device =3D {
> =20
>  static int __init uart8250_init(void)
>  {
> +	if (gic_present) {
> +		uart8250_data[0].irq =3D MIPS_GIC_IRQ_BASE + GIC_INT_UART0;
> +		uart8250_data[1].irq =3D MIPS_GIC_IRQ_BASE + GIC_INT_UART1;
> +	} else {
> +		uart8250_data[0].irq =3D MIPS_CPU_IRQ_BASE + CPU_INT_UART0;
> +		uart8250_data[1].irq =3D MIPS_CPU_IRQ_BASE + CPU_INT_UART1;
> +	}
>  	return platform_device_register(&uart8250_device);
>  }
> =20
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-=
gic.c
> index 64dc5a9..6c9fcbf 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -8,6 +8,8 @@
>   */
>  #include <linux/bitmap.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
>  #include <linux/smp.h>
>  #include <linux/irq.h>
>  #include <linux/clocksource.h>
> @@ -22,11 +24,8 @@
>  unsigned int gic_frequency;
>  unsigned int gic_present;
>  unsigned long _gic_base;
> -unsigned int gic_irq_base;
>  unsigned int gic_irq_flags[GIC_NUM_INTRS];
> -
> -/* The index into this array is the vector # of the interrupt. */
> -struct gic_shared_intr_map gic_shared_intr_map[GIC_NUM_INTRS];
> +unsigned int gic_cpu_pin;
> =20
>  struct gic_pcpu_mask {
>  	DECLARE_BITMAP(pcpu_mask, GIC_NUM_INTRS);
> @@ -46,6 +45,8 @@ static struct gic_intrmask_regs intrmask_regs[NR_CPUS=
];
>  static DEFINE_SPINLOCK(gic_lock);
>  static struct irq_domain *gic_irq_domain;
> =20
> +static void __gic_irq_dispatch(void);
> +
>  #if defined(CONFIG_CSRC_GIC) || defined(CONFIG_CEVT_GIC)
>  cycle_t gic_read_count(void)
>  {
> @@ -117,21 +118,6 @@ void gic_send_ipi(unsigned int intr)
>  	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), 0x80000000 | intr);
>  }
> =20
> -static void gic_eic_irq_dispatch(void)
> -{
> -	unsigned int cause =3D read_c0_cause();
> -	int irq;
> -
> -	irq =3D (cause & ST0_IM) >> STATUSB_IP2;
> -	if (irq =3D=3D 0)
> -		irq =3D -1;
> -
> -	if (irq >=3D 0)
> -		do_IRQ(gic_irq_base + irq);
> -	else
> -		spurious_interrupt();
> -}
> -
>  static void __init vpe_local_setup(unsigned int numvpes)
>  {
>  	unsigned long timer_intr =3D GIC_INT_TMR;
> @@ -166,16 +152,15 @@ static void __init vpe_local_setup(unsigned int n=
umvpes)
>  				 GIC_MAP_TO_PIN_MSK | timer_intr);
>  		if (cpu_has_veic) {
>  			set_vi_handler(timer_intr + GIC_PIN_TO_VEC_OFFSET,
> -				gic_eic_irq_dispatch);
> -			gic_shared_intr_map[timer_intr + GIC_PIN_TO_VEC_OFFSET].local_intr_=
mask |=3D GIC_VPE_RMASK_TIMER_MSK;
> +				       __gic_irq_dispatch);
>  		}
> =20
>  		if (vpe_ctl & GIC_VPE_CTL_PERFCNT_RTBL_MSK)
>  			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_PERFCTR_MAP),
>  				 GIC_MAP_TO_PIN_MSK | perf_intr);
>  		if (cpu_has_veic) {
> -			set_vi_handler(perf_intr + GIC_PIN_TO_VEC_OFFSET, gic_eic_irq_dispa=
tch);
> -			gic_shared_intr_map[perf_intr + GIC_PIN_TO_VEC_OFFSET].local_intr_m=
ask |=3D GIC_VPE_RMASK_PERFCNT_MSK;
> +			set_vi_handler(perf_intr + GIC_PIN_TO_VEC_OFFSET,
> +				       __gic_irq_dispatch);
>  		}
>  	}
>  }
> @@ -343,64 +328,100 @@ static struct irq_chip gic_irq_controller =3D {
>  #endif
>  };
> =20
> -static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,=

> -	unsigned int pin, unsigned int polarity, unsigned int trigtype,
> -	unsigned int flags)
> +static void __gic_irq_dispatch(void)
>  {
> -	struct gic_shared_intr_map *map_ptr;
> -	int i;
> -
> -	/* Setup Intr to Pin mapping */
> -	if (pin & GIC_MAP_TO_NMI_MSK) {
> -		int i;
> +	unsigned int intr, virq;
> =20
> -		GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(intr)), pin);
> -		/* FIXME: hack to route NMI to all cpu's */
> -		for (i =3D 0; i < NR_CPUS; i +=3D 32) {
> -			GICWRITE(GIC_REG_ADDR(SHARED,
> -					  GIC_SH_MAP_TO_VPE_REG_OFF(intr, i)),
> -				 0xffffffff);
> -		}
> -	} else {
> -		GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(intr)),
> -			 GIC_MAP_TO_PIN_MSK | pin);
> -		/* Setup Intr to CPU mapping */
> -		GIC_SH_MAP_TO_VPE_SMASK(intr, cpu);
> -		if (cpu_has_veic) {
> -			set_vi_handler(pin + GIC_PIN_TO_VEC_OFFSET,
> -				gic_eic_irq_dispatch);
> -			map_ptr =3D &gic_shared_intr_map[pin + GIC_PIN_TO_VEC_OFFSET];
> -			if (map_ptr->num_shared_intr >=3D GIC_MAX_SHARED_INTR)
> -				BUG();
> -			map_ptr->intr_list[map_ptr->num_shared_intr++] =3D intr;
> -		}
> +	while ((intr =3D gic_get_int()) !=3D GIC_NUM_INTRS) {
> +		virq =3D irq_linear_revmap(gic_irq_domain, intr);
> +		do_IRQ(virq);
>  	}
> +}
> =20
> -	/* Setup Intr Polarity */
> -	GIC_SET_POLARITY(intr, polarity);
> +static void gic_irq_dispatch(unsigned int irq, struct irq_desc *desc)
> +{
> +	__gic_irq_dispatch();
> +}
> +
> +#ifdef CONFIG_MIPS_GIC_IPI
> +static int gic_resched_int_base;
> +static int gic_call_int_base;
> +
> +unsigned int plat_ipi_resched_int_xlate(unsigned int cpu)
> +{
> +	return gic_resched_int_base + cpu;
> +}
> =20
> -	/* Setup Intr Trigger Type */
> -	GIC_SET_TRIGGER(intr, trigtype);
> +unsigned int plat_ipi_call_int_xlate(unsigned int cpu)
> +{
> +	return gic_call_int_base + cpu;
> +}
> =20
> -	/* Init Intr Masks */
> -	GIC_CLR_INTR_MASK(intr);
> +static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
> +{
> +	scheduler_ipi();
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
> +{
> +	smp_call_function_interrupt();
> +
> +	return IRQ_HANDLED;
> +}
> =20
> -	/* Initialise per-cpu Interrupt software masks */
> +static struct irqaction irq_resched =3D {
> +	.handler	=3D ipi_resched_interrupt,
> +	.flags		=3D IRQF_PERCPU,
> +	.name		=3D "IPI resched"
> +};
> +
> +static struct irqaction irq_call =3D {
> +	.handler	=3D ipi_call_interrupt,
> +	.flags		=3D IRQF_PERCPU,
> +	.name		=3D "IPI call"
> +};
> +
> +static __init void gic_ipi_init_one(unsigned int intr, int cpu,
> +				    struct irqaction *action)
> +{
> +	int virq =3D irq_create_mapping(gic_irq_domain, intr);
> +	int i;
> +
> +	GIC_SH_MAP_TO_VPE_SMASK(intr, cpu);
>  	for (i =3D 0; i < NR_CPUS; i++)
>  		clear_bit(intr, pcpu_masks[i].pcpu_mask);
>  	set_bit(intr, pcpu_masks[cpu].pcpu_mask);
> =20
> -	if ((flags & GIC_FLAG_TRANSPARENT) && (cpu_has_veic =3D=3D 0))
> -		GIC_SET_INTR_MASK(intr);
> -	if (trigtype =3D=3D GIC_TRIG_EDGE)
> -		gic_irq_flags[intr] |=3D GIC_TRIG_EDGE;
> +	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
> +
> +	irq_set_handler(virq, handle_percpu_irq);
> +	setup_irq(virq, action);
>  }
> =20
> -static void __init gic_basic_init(int numintrs, int numvpes,
> -			struct gic_intr_map *intrmap, int mapsize)
> +static __init void gic_ipi_init(void)
>  {
> -	unsigned int i, cpu;
> -	unsigned int pin_offset =3D 0;
> +	int i;
> +
> +	/* Use last 2 * NR_CPUS interrupts as IPIs */
> +	gic_resched_int_base =3D GIC_NUM_INTRS - nr_cpu_ids;
> +	gic_call_int_base =3D gic_resched_int_base - nr_cpu_ids;
> +
> +	for (i =3D 0; i < nr_cpu_ids; i++) {
> +		gic_ipi_init_one(gic_call_int_base + i, i, &irq_call);
> +		gic_ipi_init_one(gic_resched_int_base + i, i, &irq_resched);
> +	}
> +}
> +#else
> +static inline void gic_ipi_init(void)
> +{
> +}
> +#endif
> +
> +static void __init gic_basic_init(int numintrs, int numvpes)
> +{
> +	unsigned int i;
> =20
>  	board_bind_eic_interrupt =3D &gic_bind_eic_interrupt;
> =20
> @@ -409,31 +430,8 @@ static void __init gic_basic_init(int numintrs, in=
t numvpes,
>  		GIC_SET_POLARITY(i, GIC_POL_POS);
>  		GIC_SET_TRIGGER(i, GIC_TRIG_LEVEL);
>  		GIC_CLR_INTR_MASK(i);
> -		if (i < GIC_NUM_INTRS) {
> +		if (i < GIC_NUM_INTRS)
>  			gic_irq_flags[i] =3D 0;
> -			gic_shared_intr_map[i].num_shared_intr =3D 0;
> -			gic_shared_intr_map[i].local_intr_mask =3D 0;
> -		}
> -	}
> -
> -	/*
> -	 * In EIC mode, the HW_INT# is offset by (2-1). Need to subtract
> -	 * one because the GIC will add one (since 0=3Dno intr).
> -	 */
> -	if (cpu_has_veic)
> -		pin_offset =3D (GIC_CPU_TO_VEC_OFFSET - GIC_PIN_TO_VEC_OFFSET);
> -
> -	/* Setup specifics */
> -	for (i =3D 0; i < mapsize; i++) {
> -		cpu =3D intrmap[i].cpunum;
> -		if (cpu =3D=3D GIC_UNUSED)
> -			continue;
> -		gic_setup_intr(i,
> -			intrmap[i].cpunum,
> -			intrmap[i].pin + pin_offset,
> -			intrmap[i].polarity,
> -			intrmap[i].trigtype,
> -			intrmap[i].flags);
>  	}
> =20
>  	vpe_local_setup(numvpes);
> @@ -448,7 +446,7 @@ static int gic_irq_domain_map(struct irq_domain *d,=
 unsigned int virq,
> =20
>  	spin_lock_irqsave(&gic_lock, flags);
>  	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
> -		 GIC_MAP_TO_PIN_MSK | 0);
> +		 GIC_MAP_TO_PIN_MSK | gic_cpu_pin);
>  	/* Map to VPE 0 by default */
>  	GIC_SH_MAP_TO_VPE_SMASK(hw, 0);
>  	set_bit(hw, pcpu_masks[0].pcpu_mask);
> @@ -463,8 +461,7 @@ static struct irq_domain_ops gic_irq_domain_ops =3D=
 {
>  };
> =20
>  void __init gic_init(unsigned long gic_base_addr,
> -		     unsigned long gic_addrspace_size,
> -		     struct gic_intr_map *intr_map, unsigned int intr_map_size,
> +		     unsigned long gic_addrspace_size, unsigned int cpu_vec,
>  		     unsigned int irqbase)
>  {
>  	unsigned int gicconfig;
> @@ -472,7 +469,6 @@ void __init gic_init(unsigned long gic_base_addr,
> =20
>  	_gic_base =3D (unsigned long) ioremap_nocache(gic_base_addr,
>  						    gic_addrspace_size);
> -	gic_irq_base =3D irqbase;
> =20
>  	GICREAD(GIC_REG(SHARED, GIC_SH_CONFIG), gicconfig);
>  	numintrs =3D (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
> @@ -483,10 +479,23 @@ void __init gic_init(unsigned long gic_base_addr,=

>  		  GIC_SH_CONFIG_NUMVPES_SHF;
>  	numvpes =3D numvpes + 1;
> =20
> +	if (cpu_has_veic) {
> +		/* Always use vector 1 in EIC mode */
> +		gic_cpu_pin =3D 0;
> +		set_vi_handler(gic_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
> +			       __gic_irq_dispatch);
> +	} else {
> +		gic_cpu_pin =3D cpu_vec - GIC_CPU_PIN_OFFSET;
> +		irq_set_chained_handler(MIPS_CPU_IRQ_BASE + cpu_vec,
> +					gic_irq_dispatch);
> +	}
> +
>  	gic_irq_domain =3D irq_domain_add_simple(NULL, GIC_NUM_INTRS, irqbase=
,
>  					       &gic_irq_domain_ops, NULL);
>  	if (!gic_irq_domain)
>  		panic("Failed to add GIC IRQ domain");
> =20
> -	gic_basic_init(numintrs, numvpes, intr_map, intr_map_size);
> +	gic_basic_init(numintrs, numvpes);
> +
> +	gic_ipi_init();
>  }
>=20


--3d8TLpjw4HNIaBb3MVqa7fFaFr9o72EWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUt6ucAAoJEGwLaZPeOHZ6XMAP/2fhlVkRgu5pE7NVtzCMdBPY
oI6Co+hTM3Agwdd4exWJWrOAQryLRU52tZrcAD9RNH0gfAHy4o9EnO4tlnj4GM/D
ss/WZUjy6oIWzNaNcC+m/7Yu3ksK8xqywfiN+LuFbte+RNWYZPDayj+tggc2w2ys
+Kw+yXTa0NDLByODbrrv77b6fJ9ZtQNftW/OGhavX2IBQZ6H6Hq34kTd4W7KDDBQ
+YbnqB8Lo9kUjHxLt53grdWCojQ+13/WNd7sdghnTHPF8Rx51dzPxeZMQcSeYG6R
enPKm4o1TFAaoZw4s5SDyMMdX8+SjKW1T7YC2cY5EnEdDw6DrwItzy3JXJzrJZYr
FrFyOQBOrAIU2Tu/GHhg5i46syNR59OiRwVNBZL1m3KNzunbof1YCeYKxQH/ppiA
38Om6j4jvq9sUAvQ4HGfAP388JunCJZS+Fyt+xlRfV/AWgEdonYv62KTTqLTy5Jv
cbHZIN3KGKZIpWLEHMhsG1hRk5KdZk3rBjBXnI5bIjPTFeqh1QeBm7Bpr0CB1gYZ
pIsaLtwAvx1PrnBC103YV6nVsXnntduXi0yetuwtZkmYDzmv5jrjBDPLA+Gbd0+K
zoevxownaOCuAKkiztFvprWmcCDtZty3CbmwbYl1zF2JSW5qU8I0GVZH5JQiYpJ1
nODHmBzJ/zbt0vhEi7kh
=xHFN
-----END PGP SIGNATURE-----

--3d8TLpjw4HNIaBb3MVqa7fFaFr9o72EWV--
