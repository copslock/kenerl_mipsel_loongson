Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 15:18:41 +0100 (BST)
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:56544 "EHLO
	stout.engsoc.carleton.ca") by ftp.linux-mips.org with ESMTP
	id S28640826AbZDIOQy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 15:16:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id EB2465840C0;
	Thu,  9 Apr 2009 10:16:45 -0400 (EDT)
Received: from stout.engsoc.carleton.ca ([127.0.0.1])
	by localhost (stout.engsoc.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ICdQLzcTLkD; Thu,  9 Apr 2009 10:16:45 -0400 (EDT)
Received: from mobius.cowpig.ca (cowpig.ca [134.117.69.79])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id C61645840BC;
	Thu,  9 Apr 2009 10:16:45 -0400 (EDT)
Received: by mobius.cowpig.ca (Postfix, from userid 1000)
	id EF5FD160189; Thu,  9 Apr 2009 10:16:34 -0400 (EDT)
Date:	Thu, 9 Apr 2009 10:16:34 -0400
From:	Philippe Vachon <philippe@cowpig.ca>
To:	yanhua <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	?????? <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 1/14] lemote: Loongson2F based machines support
Message-ID: <20090409141634.GA17941@cowpig.ca>
References: <49DD7E88.7040305@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DD7E88.7040305@lemote.com>
User-Agent: Mutt/1.5.9i
Return-Path: <philippe@cowpig.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe@cowpig.ca
Precedence: bulk
X-list: linux-mips

I think this patch would be a lot better off broken up into several
pieces, but I also have found there's a lot of code that is duplicated
in there that needs to be tidied up (even if the implementation isn't
identical, the functionality is). This comment in particular applies to
the yeelong/ and fuloong/ directories.

As well, there's pretty egregious abuse of inline asm to do things that
really don't require inline asm, like manipulating MMIO registers.

The feedback I've provided is generally at a glance, though I have some
familiarity with Lemote's code, so some of these are issues I've
anticipated would come up. :-)

I've also avoided stylistic feedback -- I think there are people who are
far better qualified to comment on that.

On Thu, Apr 09, 2009 at 12:50:16PM +0800, yanhua wrote:
> +#ifdef CONFIG_TRACE_BOOT
> + printk(KERN_INFO"arch_initcall:pcibios_init\n");
> + printk(KERN_INFO"register_pci_controller :
> %x\n",&loongson2f_pci_controller);
> +#endif
> +
> +#ifdef CONFIG_64BIT
> + loongson2f_pci_mem_resource.start = 0x50000000UL;
> + loongson2f_pci_mem_resource.end = 0x7fffffffUL;
> + __asm__(".set mips3\n"
> + "dli $2,0x900000003ff00000\n"
> + "li $3,0x40000000\n"
> + "sd $3,0x18($2)\n"
> + "or $3,1\n"
> + "sd $3,0x58($2)\n"
> + "dli $3,0xffffffffc0000000\n"
> + "sd $3,0x38($2)\n"
> + ".set mips0\n"
> + :::"$2","$3","memory"
> + );

This is completely unnecessary and should be rewritten without the
inline asm; I've prepared a header that has both register offsets and
bases, as well as accessor macros that look a lot neater than this mess.

This can be found at: 
http://git.linux-cisco.org/?p=linux-mips.git;a=blob;f=arch/mips/include/asm/mach-stls2f/stls2f.h;h=9dbbb5d068618a1530c9396af32dfc4a394ea826;hb=refs/heads/linux-gdium

(pardon the long URL)

> +++ b/arch/mips/lemote/lm2f/fuloong/dbg_io.c
> @@ -0,0 +1,182 @@
*snip*
> +#ifdef CONFIG_64BIT
> +#define BASE (0xffffffffbff003f8)
> +#else
> +#define BASE (0xbff003f8)
> +#endif
> +
> +#else /* USE_CS5536_UART1/2 */
> +
> +#ifdef CONFIG_64BIT
> +#define BASE 0xffffffffbfd002f8
> +#else
> +#define BASE 0xbfd002f8
> +#endif
> +
> +#endif /* end of USE_GODSON2F_UART */

More magic numbers that should likely be moved into a header.

*more code snipped*

> +++ b/arch/mips/lemote/lm2f/fuloong/prom.c
> +
> +#ifdef CONFIG_32BIT
> + *(volatile u32*)0xbfe00180 |= 0x7;
> +#else
> + *(volatile u32*)0xffffffffbfe00180 |= 0x7;
> +#endif
> + _rdmsr(0xe0000014, &hi, &lo);
> + lo |= 0x00000001;
> + _wrmsr(0xe0000014, hi, lo);
> +

More magic numbers that should have names. Accesses to MMIO registers
should be done through accessors.

> + printk("Hard reset not take effect!!\n");
> + __asm__ __volatile__ (
> + ".long 0x3c02bfc0\n"
> + ".long 0x00400008\n"
> + :::"v0"
> + );

This is really REALLY scary. Perhaps it'd be even slightly neater to
convert that jump to a void function pointer -- something like

((void (*)(void))(RESET_VECTOR)))();

(note that I haven't tested that, and RESET_VECTOR would have to be
something appropriate, i.e. CKSEG1ADDR(BONITO_BOOT_BASE) in this case,
though I think CKSEG1ADDR is frowned upon)


> +static void loongson2f_halt(void)
> +{
> +#ifdef CONFIG_32BIT
> + u32 base;
> +#else
> + u64 base;
> +#endif
> + u32 hi, lo, val;
> +
> + _rdmsr(0x8000000c, &hi, &lo);
> +#ifdef CONFIG_32BIT
> + base = (lo & 0xff00) | 0xbfd00000;
> +#else
> + base = (lo & 0xff00) | 0xffffffffbfd00000ULL;
> +#endif
> + val = (val & ~(1 << (16 + 13))) | (1 << 13);
> + delay();
> + *(__volatile__ u32 *)(base + 0x04) = val;
> + delay();
> + val = (val & ~(1 << (13))) | (1 << (16 + 13));
> + delay();
> + *(__volatile__ u32 *)(base + 0x00) = val;
> + delay();
> +}

See above, re: magic numbers.

*snip*

> +++ b/arch/mips/lemote/lm2f/fuloong/setup.c
> +
> +#ifdef CONFIG_64BIT
> +#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
> +#else
> +#define PTR_PAD(p) (p)
> +#endif

This shouldn't be necessary at all.

> +#ifdef CONFIG_64BIT
> + __asm__(
> + ".set mips3\n"
> + "dli $2, 0x900000003ff00000\n"
> + "dli $3, 0x0000000080000000\n"
> + "sd $3, 0x10($2)\n"
> + "sd $0, 0x50($2)\n"
> + "dli $3, 0xffffffff80000000\n"
> + "sd $3, 0x30($2)\n"
> + ".set mips0\n"
> + :::"$2","$3","memory");
> + if (highmemsize > 0) {
> + add_memory_region(0x90000000, highmemsize << 20, BOOT_MEM_RAM);
> + }
> +#endif

This can all be done using accessors, as described above.

I notice there seems to be a lot of duplicated code in the yeelong
directory. Perhaps it is worthwhile to try to further consolidate some
of it?

My comments above seem to largely apply to the Yeelong code as well.

> +++ b/arch/mips/pci/fixup-fl2f.c
> +#ifdef CONFIG_64BIT
> + *(volatile u32*)0xffffffffbfe0004c = 0xd2000001;
> +#else
> + *(volatile u32*)0xbfe0004c = 0xd2000001;
> +#endif

Again, stuff like this is really unnecessary.

I generally mirror Arnaud's sentiment about the structuring of the code
-- I suspect a loongson/ directory in arch/mips makes more sense, then 
followed by an ls2f/ and ls2e/ directory.

Cheers,
Phil
