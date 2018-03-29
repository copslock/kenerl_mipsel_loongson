Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 19:32:32 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:47818
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbeC2RcY0fi8a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 19:32:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=aiWT9N072vbutDPA3gT4paZMQV25npqtI1zzaYoGTU8=;
        b=k2tCKtMiXlT+G0Zn8CAtWflC7LhJNW3fYGaFT6gQr9Xbln/kZrIj+tVC2bXNjcChBLp0CSefIUMf7ZuwDsofFTfE3hkNgBks0G/hBoBaeadqp0VYXUZNcmdDQdW7duipVTZJT5kCPyvjZ1k0dRlT2uOMLZfGtZmmask7sx12LXU=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:57080)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1f1bOK-0000VU-1F; Thu, 29 Mar 2018 18:31:12 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1f1bOD-0006t7-AH; Thu, 29 Mar 2018 18:31:05 +0100
Date:   Thu, 29 Mar 2018 18:31:03 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Rob Landley <rob@landley.net>
Cc:     Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <20180329173103.GE16141@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <c91e8781-5f31-70e8-e7ef-1a80bd5d9454@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91e8781-5f31-70e8-e7ef-1a80bd5d9454@landley.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Thu, Mar 29, 2018 at 11:39:24AM -0500, Rob Landley wrote:
> 
> 
> On 03/28/2018 05:14 PM, Russell King - ARM Linux wrote:
> > On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
> >>
> >>
> >> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> >>> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> >>>> On 03/28/2018 10:26 AM, Shea Levy wrote:
> >>>>> Now only those architectures that have custom initrd free requirements
> >>>>> need to define free_initrd_mem.
> >>>> ...
> >>>>> --- a/arch/arc/mm/init.c
> >>>>> +++ b/arch/arc/mm/init.c
> >>>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >>>>>  {
> >>>>>  	free_initmem_default(-1);
> >>>>>  }
> >>>>> -
> >>>>> -#ifdef CONFIG_BLK_DEV_INITRD
> >>>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> >>>>> -{
> >>>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> >>>>> -}
> >>>>> -#endif
> >>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>>>> index 3f972e83909b..19d1c5594e2d 100644
> >>>>> --- a/arch/arm/Kconfig
> >>>>> +++ b/arch/arm/Kconfig
> >>>>> @@ -47,6 +47,7 @@ config ARM
> >>>>>  	select HARDIRQS_SW_RESEND
> >>>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >>>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> >>>>> +	select HAVE_ARCH_FREE_INITRD_MEM
> >>>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >>>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >>>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> >>>>
> >>>> Isn't this why weak symbols were invented?
> >>>
> >>> Weak symbols means that we end up with both the weakly-referenced code
> >>> and the arch code in the kernel image.  That's fine if the weak code
> >>> is small.
> >>
> >> The kernel's been able to build with link time garbage collection since 2016:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
> >>
> >> Wouldn't that remove the unused one?
> > 
> > Probably, if anyone bothered to use that, which they don't.
> > 
> > LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> > what I can see, nothing selects it.  Therefore, the symbol is always
> > disabled, and so the feature never gets used in mainline kernels.
> 
> It looks like there are per-architecture linker scripts that need to be updated?
> So if an architecture supports it, it's always done (well, it probes for the
> toolchain supporting the flag). And if the architecture doesn't support it, the
> linker script needs to be updated to mark sections with "I know nothing seems to
> reference this at the ELF level but keep it anyway, we're pulling an assembly
> trick".

It looks like it needs much more than just architecture changes as the
reason it fails on ARM is because the init thread structure is missing
due to missing KEEP()s in INIT_TASK_DATA().  Probably means it doesn't
work anywhere.

8<===
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] Fix LD_DEAD_CODE_DATA_ELIMINATION

LD_DEAD_CODE_DATA_ELIMINATION fails to boot on ARM because the linker
eliminates the init thread data from the bottom of the init threads
stack.  This causes recursive faults that end up overwriting parts
of the kernel before they can print any message.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 include/asm-generic/vmlinux.lds.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ab0e520d6fc..41af8a74aae4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -279,8 +279,8 @@
 	VMLINUX_SYMBOL(__start_init_task) = .;				\
 	VMLINUX_SYMBOL(init_thread_union) = .;				\
 	VMLINUX_SYMBOL(init_stack) = .;					\
-	*(.data..init_task)						\
-	*(.data..init_thread_info)					\
+	KEEP(*(.data..init_task))					\
+	KEEP(*(.data..init_thread_info))				\
 	. = VMLINUX_SYMBOL(__start_init_task) + THREAD_SIZE;		\
 	VMLINUX_SYMBOL(__end_init_task) = .;
 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
