Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 00:33:30 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:5263 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S28640059AbXCCAdY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Mar 2007 00:33:24 +0000
Received: (qmail 10696 invoked by uid 101); 3 Mar 2007 00:32:11 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 3 Mar 2007 00:32:11 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l230WAnX003533;
	Fri, 2 Mar 2007 16:32:10 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCP2ZSS>; Fri, 2 Mar 2007 16:32:10 -0800
Message-ID: <45E8C1FA.3040708@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] mips: PMC MSP71xx core platform
Date:	Fri, 2 Mar 2007 16:31:54 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 03 Mar 2007 00:31:59.0218 (UTC) FILETIME=[5AD42D20:01C75D2B]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Ralf, thanks for taking the time to provide detailed feedback. I've
implemented your suggestions other than the few comments below.

Marc

Ralf Baechle wrote:
> On Fri, Feb 23, 2007 at 01:55:27PM -0600, Marc St-Jean wrote:

[...]

> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c

[...]

>  > +void msp_cic_irq_dispatch(void)
>  > +{
>  > +     u32 pending;
>  > +     int intbase;
>  > +
>  > +     intbase = MSP_CIC_INTBASE;
>  > +     pending = *CIC_STS_REG & *CIC_VPE0_MSK_REG;
>  > +
>  > +     /* check for PER interrupt */
>  > +     if (pending == (1 << (MSP_INT_PER - MSP_CIC_INTBASE))) {
>  > +             intbase = MSP_PER_INTBASE;
>  > +             pending = *PER_INT_STS_REG & *PER_INT_MSK_REG;
>  > +     }
>  > +
>  > +     /* check for spurious interrupt */
>  > +     if (pending == 0x00000000) {
>  > +             printk("Spurious %s interrupt? status %08x, mask %08x\n",
> 
> Again a KERN_* severity string please.
> 
> (Spurious interrupts may happen in many systems so I wonder if the printk
> is a good idea at all?)

Regarding the spurious interrupts, if it's not a big issue I'd prefer
to keep the output in there so they aren't hidden under production loads
with newly written drivers.

[...]

>  > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c 
> b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
[...]

>  > +
>  > +#include <linux/module.h>
>  > +#include <linux/kernel.h>
>  > +#include <linux/init.h>
>  > +#include <linux/string.h>
>  > +#include <linux/interrupt.h>
>  > +#include <linux/mm.h>
>  > +#ifdef CONFIG_CRAMFS
>  > +#include <linux/cramfs_fs.h>
>  > +#endif
>  > +#ifdef CONFIG_SQUASHFS
>  > +#include <linux/squashfs_fs.h>
>  > +#endif
> 
> Please remove the squashfs hook until it has not become part of the 
> standard
> kernel.

I can't think of a way to remove this short of defining our own magic
number for the super block. We can't drop squashfs support as some of
our customers have very constrained memory systems on their boards.

Since this is in our platform code and CONFIG_SQUASHFS won't be defined,
if a customer chooses not to apply the squashfs patch, the 2 #ifdef will
evaluate to false and the code won't be included. How is this causing
problems?

[...]

>  > +/* rootfs functions */
>  > +#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
>  > +bool get_ramroot(void **start, unsigned long *size)
>  > +{
>  > +     extern char _end[];
>  > +    
>  > +     /* Check for start following the end of the kernel */
>  > +     void *check_start = (void *)_end;
>  > +
>  > +     /* Check for supported rootfs types */
>  > +#ifdef CONFIG_CRAMFS
>  > +     if (*(__u32 *)check_start == CRAMFS_MAGIC) {
>  > +             /* Get CRAMFS size */
>  > +             *start = check_start;
>  > +             *size = PAGE_ALIGN(
>  > +                     ((struct cramfs_super *)check_start)->size);
>  > +            
>  > +             return true;
>  > +     }
>  > +#endif
>  > +#ifdef CONFIG_SQUASHFS
> 
> Please remove the squashfs hook until it has not become part of the 
> standard
> kernel.

Please see my comment above.


>  > +     if (*((unsigned int *)check_start) == SQUASHFS_MAGIC) {
>  > +             /* Get SQUASHFS size */
>  > +             *start = check_start;
>  > +             *size = PAGE_ALIGN(
>  > +                     ((struct squashfs_super_block 
> *)check_start)->bytes_used);
>  > +            
>  > +             return true;
>  > +     }
>  > +#endif
>  > +
>  > +     return false;
>  > +}

[...]

>  > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c 
> b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>  > new file mode 100644
>  > index 0000000..2e835cc
>  > --- /dev/null
>  > +++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c

[...]

>  > +
>  > +/* Actually performs the reset for 7120-based boards */
>  > +void msp7120_reset( void )
>  > +{
>  > +     int i;
>  > +     unsigned char *iptr, *start, *end;
>  > +
>  > +     local_irq_disable();
>  > +
>  > +#ifdef CONFIG_CPU_MIPS32_R2
> 
> Bare MIPS32R2 does not support multithreading.  So this #ifdef should be
> CONFIG_MIPS_MT instead.

I cannot find which Kconfig file this is defined in. Although I do see
it set in your malta_defconfig, and some Makefiles and r4kcache.h depending
on it.

I'm assuming it was present in older linux version. We don't always enable
SMP/SMTC but we still need to use MT extensions for our RTOS. Possibly I
should test CONFIG_SYS_SUPPORTS_MULTITHREADING instead?


>  > +     dvpe();
>  > +#endif
>  > +
>  > +     /*
>  > +      * Cache the rest of this function, since we put the DDRC into
>  > +      * self-refresh mode, and must ensure we do not touch RAM after 
> that
>  > +      */
>  > +     start = (unsigned char*)&&startpoint;
>  > +     end = (unsigned char*)&&endpoint;
> 
> You're relying on the assumption that gcc will actually compile the code
> between these two two labels.  This may work for this particular code
> and compiler version but has become very fragile with modern gcc which
> frequently moves code out of line for sake of improved branch prediction.
> 
> This is basically something that cannot be done in plain C.  To make this
> actually work reliable I think you will need to implement the part between
> the two labels in assembler - even inline assumbler would be ok.

I wonder if there would be any gcc pragmas that would prevent reordering?
I'd rather not re-write these macros in assembly for a single use.


>  > +
>  > +     if( (unsigned int)start % (unsigned int)(L1_CACHE_BYTES) )
>  > +             start -= ((unsigned int)start % (unsigned 
> int)(L1_CACHE_BYTES));
>  > +
>  > +     for( iptr = start; iptr < end; iptr += L1_CACHE_BYTES )
>  > +             cache_op( Fill, iptr );
>  > +            
>  > +startpoint:
>  > +     /* Put the DDRC into self-refresh mode */
>  > +     DDRC_INDIRECT_WRITE( DDRC_CTL(10), 0xb, (1<<16) );
>  > +
>  > +     /*
>  > +      * IMPORTANT!  DO NOT do anything from here on out that might 
> even think
>  > +      * about fetching from RAM - IE, don't call any not-inline 
> functions,
>  > +      * and be VERY sure that any unline functions you do call do 
> NOT access
>  > +      * any sort of RAM anywhere!
>  > +      */
>  > +
>  > +     /* Wait a bit for the DDRC to settle */
>  > +     for( i = 0; i < 100000000; i++);
>  > +
>  > +#if defined(CONFIG_PMC_MSP7120_GW)
>  > +     /*
>  > +      * Throw GPIO 9 HI, (tied to board reset logic)
>  > +      * GPIO 9 is the 4th GPIO of register 3
>  > +      *
>  > +      * Note, we cannot use the higher-level 'msp_gpio_pin_...' 
> functions
>  > +      * as they look up data in a static table somewhere else in RAM!
>  > +      */
>  > +     set_value_reg32( GPIO_CFG3_REG,
>  > +                     BASIC_MODE_REG_MASK(3),
>  > +                     BASIC_MODE_REG_VALUE(MSP_GPIO_OUTPUT, 3) );
>  > +     set_reg32( GPIO_DATA3_REG,
>  > +                     BASIC_DATA_REG_MASK(3) );
>  > +
>  > +     /*
>  > +      * In case GPIO9 doesn't *really* reset the board (jumper 
> configurable!)
>  > +      * fallback to generic 7120 reset register below to ensure SoC 
> reset.
>  > +      */
>  > +#endif
>  > +
>  > +     /*
>  > +      * There is a reset bit you can write to at 0xBC00_0014.
>  > +      * Writing a 1 to bit 0 will do a reset
>  > +      */
>  > +     *RST_SET_REG = 0x00000001;
>  > +
>  > +endpoint:
>  > +     return;
>  > +}
>  > +
>  > +void msp_restart(char *command)
>  > +{
>  > +     printk("Now rebooting .......\n");
>  > +
>  > +#if defined(CONFIG_PMC_MSP7120_EVAL) \
>  > + || defined(CONFIG_PMC_MSP7120_GW) \
>  > + || defined(CONFIG_PMC_MSP7120_FPGA)
>  > +     msp7120_reset();
>  > +#else
>  > +     /* No chip-specific reset code, just jump to the ROM reset 
> vector */
>  > +     set_c0_status(ST0_BEV | ST0_ERL);
>  > +     change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
>  > +     flush_cache_all();
>  > +     write_c0_wired(0);
>  > +
>  > +     __asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
>  > +#endif
>  > +}
>  > +
>  > +void msp_halt(void)
>  > +{
>  > +     printk(KERN_NOTICE "\n** You can safely turn off the power\n");
> 
> This message is soooo Windows 95 ;-)

I'll pass that on to the author of that line :)

[...]

>  > +
>  > +     /*
>  > +      * Processor Core Errata workarounds:
>  > +      * NOTE: cpu_probe is called just before prom_init so it safe 
> to use
>  > +      * current_cpu_data.
>  > +      */
>  > +     if(current_cpu_data.cputype == CPU_34K) {
>  > +             /*
>  > +              * Erratum "RPS May Cause Incorrect Instruction Execution"
>  > +              * This code only handles VPE0, any SMP/SMTC/RTOS code 
> making use of
>  > +              * VPE1 will be responsable for that VPE.
>  > +              */
>  > +             if((current_cpu_data.processor_id & PRID_BITMSK_REV)
>  > +                <= PRID_REV_RTL_1_0_2)
>  > +                     write_c0_config7(read_c0_config7() | 
> CONFIG7_BITMSK_RPS);
>  > +     }
> 
> This 34K erratum affects all systems not just MSPs, so the workaround 
> should
> be in generic MIPS code.  arch/mips/kernel/cpu-probe.c:check_bugs32() seems
> the best place.

OK, I will move this one. I'm not sure they can all be moved to generic code,
some erratum have multiple workarounds to choose from. Different platforms
will choose different options based on performance trade offs.

[...]


>  > +     
>  > +#ifdef CONFIG_SENSORS_PMCTWILED
>  > +     /* setup twi led interface */
>  > +     pmctwiled_setup();
> 
> SENSORS_PMCTWILED is a tristate.  So if configured as a module this call to
> pmctwiled_setup() will result in a link failure.  Aside, inserting these
> hooks should really be part of the "PMC MSP71xx LED driver" patch.
> 
> I think the preferable solution is to invoke PMC MSP71xx LED driver through
> something like subsys_initcall() - at least I didn't notice any ordering
> problems that could result.

It is normally statically linked since we have other drivers which need to
initialize LED states in their subsys_initcall() code. Since we can't assure
the order of initialization, the LED states must be initialized here.

I looked at kallsyms in the past but it's not practical for embedded systems.
Are you aware of any methods of checking if a symbol it's statically linked?


[...]

> diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h b/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h

[...]

>  > +/* Memory descriptor management. */
>  > +#define PROM_MAX_PMEMBLOCKS    7     /* 6 used */
>  > +
>  > +
>  > +enum yamon_memtypes {
>  > +        yamon_dontuse,
>  > +        yamon_prom,
>  > +        yamon_free,
>  > +};
> 
> Eh..  I thought you're using PMON?

We are using PMON, presumably the author decided to reuse these constants as
from some generic arch/mips code it was based on. See msp_prom.c.


>  > diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h 
> b/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h

[...]

> +/***************************************************************************/ 
> 
>  > +/* Memory Controller 
> defines                                               */
>  > 
> +/***************************************************************************/ 
> 
>  > +
>  > +/* Indirect memory controller registers */
>  > +#define DDRC_CFG(n)          (n)
>  > +#define DDRC_DEBUG(n)                (0x04 + n)
>  > +#define DDRC_CTL(n)          (0x40 + n)
>  > +
>  > +/* Macro to perform DDRC indirect write */
>  > +#define DDRC_INDIRECT_WRITE( reg, mask, value ) {\
>  > +     *MEM_SS_ADDR = ((mask & 0xf) << 8) | (reg & 0xff); \
>  > +     *MEM_SS_DATA = value; \
>  > +     *MEM_SS_WRITE = 1; \
>  > +}
> 
> Enclosing the macro in a { } is a good idea for macros with multiple
> statements but will fail for a construct like:
> 
>         if (condition)
>                 DDRC_INDIRECT_WRITE(...);
>         else
>                 something_else();
> 
> To make this really bulletproof, enclose the macro in a do { } while (0)
> block instead.  See also http://kernelnewbies.org/FAQ/DoWhile0.

Thanks, I chose the "slightly more legible" method ({ }) described at the end.

[...]

> 
>   Ralf
> 

Marc
