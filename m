Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 22:10:45 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:55011 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028469AbcEIUKnpPHuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 22:10:43 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MI6Uo-1b3hFw2mQI-003soO; Mon, 09 May
 2016 22:10:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, benh@au1.ibm.com,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        johnyoun@synopsys.com, gregkh@linuxfoundation.org,
        a.seppala@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Mon, 09 May 2016 22:10:18 +0200
Message-ID: <6124820.1RD3TMPoMQ@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <2764525.eheC8xZt4u@debian64>
References: <4231696.iL6nGs74X8@debian64> <4908563.V9YuKsSrTJ@wuerfel> <2764525.eheC8xZt4u@debian64>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:saw3GJ7B4DdlY7y145bFISwRHGi5eFPmGhOLsYUWyb1rihxhcvz
 0p5YbMU1hYlkeV68mlKPf5D11QWEValu1T5BAUs07KKcilDQLKw+O0cgjJMzEWw1s2jEre+
 UiRgyXrnWWmx1zsa/svCzho+BLcDuxptPTwqCzLBRnw0vIHPML0rksvGXjOcL2tKaagrSXY
 h9jDp1m9Crenwl5bGrQKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hdUgKeXYRvY=:J/VacrO9+6gGe1wZXYtRBh
 ShaVEoUNclK3UeLxDy1plSKR1S8o/I5lADTzE4uZuLYYf1uU5wF2lV6/a8Nm/G9QtqLCXzmao
 mCFjTjQWL6qf8CnfTplDi42x1sqb1gKtY23r1XEUMfV77lQlVjcwa5GpESmiX04SqFbOaKIsC
 Zf0HbCoBamNxCxmkvEz+WELLxK1e07ACjB58D+9db1A0Cw8jkjSbR1A+89fKn4jJePqNw2hSW
 mdprEGoYUzX5AKa7n+RAM67FrDm+b+p1erFkbPOZrugFP+71uXRmv/8hjvQE07RarAZnqEtTO
 XDNJDBW1k3D3B083w3sa4jwvFQyk/zUud3RxmQNKOodQY8e6FgivDMcGL+9U58+7viATMVcM0
 x5RM+R5szS2euvaSPrkBv14rjcfGq+I36WuV67MKrJwRsGB5JKTdZrYpqs9HuNyv7RKCTfNHw
 DQGDLzT4erE/a63CntzNqkWKUOKfcUA+lSDDhu78dY52Ujw9Oytb6e1p+fm0IsIaGTRpT8Ioe
 M5ikPZ/7USOYTkeByy8Rb2ph/AKRtrgMHLKRVquZysxzOBsX7j4PEoROLkfw8nNv4c362veTM
 c2zs4UHc5ROjPW3/PCqeZFkQHd8jVabBfgtr5e8eKK2qbY3mhRHydpZIwXF7rGaRdkNwflHtg
 yjqLA1rP6y865i++GGgEOAargZlf81KyafRsg7gR3MUuFaosg1NOO1QCiVn4K2LFEpIzqFd2b
 2aX49KzhZLg5w2Ql
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 09 May 2016 21:06:07 Christian Lamparter wrote:
> Uh, Thanks for the participation!
> 
> On Monday, May 09, 2016 05:08:48 PM Arnd Bergmann wrote:
> > On Monday 09 May 2016 13:39:50 Felipe Balbi wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > > On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
> > > >> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
> > > >
> > > > The patch that caused the problem had multiple issues:
> > > >
> > > > - it broke big-endian ARM kernels: any machine that was working
> > > >   correctly with a little-endian kernel is no longer using byteswaps
> > > >   on big-endian kernels, which clearly breaks them.
> > > > - On PowerPC the same thing must be true: if it was working before,
> > > >   using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
> > > >   usually uses big-endian kernels, so they are likely all broken.
> > > > - The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
> > > >   so the MMIO no longer synchronizes with DMA operations.
> > > > - On architectures that require specific CPU instructions for MMIO
> > > >   access, using the __raw_ variant may turn this into a pointer
> > > >   dereference that does not have the same effect as the readl/writel.
> > > >
> > > > I think we can simply make this set of accessors architecture-dependent
> > > > (MIPS vs. the rest of the world) to revert ARM and PowerPC back to
> > > > the working version.
> > > 
> > > and patch all drivers similarly? Shouldn't arch/mips itself deal with it
> > > and hide it from drivers ?
> > > 
> > 
> > Unfortunately, I don't see any way this could be done in MIPS specific
> > code: There is typically a byteswap between the internal bus and the PCI
> > bus on big-endian MIPS systems, so the PCI MMIO ends up being little-endian,
> > which matches the expected behavior of readl/writel. However, drivers
> > for non-PCI devices often use the same readl/writel accessors because
> > that is how it's done on ARMv6/ARMv7.
> > 
> > Doing it hardcoded by architecture is just the simplest way to deal
> > with it, working on the assumption that nothing actually needs the
> > runtime detection that Ben suggested. Detecting the endianess of the
> > device is probably the best future-proof solution, but it's also
> > considerably more work to do in the driver, and comes with a
> > tiny runtime overhead.
> > 
> Ok, just to have it on the table. I went ahead and implemented the
> "Detect Endian". 
> 
> I looked in the DWC USB OTG's Databook documents v3.30a (If someone wants
> them too, PM me). If I read the Application Interface Feature list on
> page 30 correctly. The endianess is selectable by a "pin".... That said
> I don't know which one is it in the APM82181 or any other arch. I looked
> around for configuration registers and stuff but unlike DesignWare's AHB
> DMA  Controller, there's no Bit in the "User HW Config Registers" that
> would tell us if it was configured as big-endian or little-endian at
> the moment.
> 
> One way out would be to detect the endianess automatically by looking at
> the values in the GSNPSID register. This is a read-only register containing
> the release number of the core being used. The "upper" 16-bits of it are
> hardcoded to 0x4f45 (The comment in dwc2_get_hwparams [1] has it backwards
> but not the code below).

Good, that should work.

> I ran into the following issues:
> 	- gadget.c uses ioread32_rep [0] & iowrite32_rep [1].
> 	  This is interesting because both of these functions actually use
> 	  the __raw_io* on powerpc. This is because powerpc uses the default
> 	  defines of include/asm-generic/io.h [2].
> 
> 	  Ideally, this should be done by sth like a writesl_be or writesl(e)
> 	  function. But I found none so for now: Let's make a ugly hack:
> 	  to_correct_endian that will work for testing, but will be replaced.

You must have gotten this wrong: writesl() and the other variants
are used to copy byte streams, which are always in the correct
endianess, i.e. copying them one byte at a time should result in
the same in-memory representation as copying them four bytes at a time.
You should never need an additional swap in here.

> 	- is_little_endian (do we want a separate is_big_endian?)
> 	  Also, do we want to be able to overwrite the detection code
> 	  if the endian setting was set in the device tree?. For now
> 	  it always does auto detection (see dwc2_detect_endiannes() ).

I'd say that detecting endianess from the register is the safest
approach. We can also parse the standard DT properties to do the
same, but they can easily be stale, especially when the driver
has already gotten this wrong for some users.

> 	( - 80 character per line issues, is it possible to drop the
> 		 hsotg->reg + REGISTER from the dwc2_readl/writel since we
> 		 pass the hsotg now anyway and do the reg + REGISTER
> 		 calculation in the accessor? I played around with macros
> 		 as most functions calling the accessors have the hsotg
> 		 variable anyway )

I would definitely recommend doing this. If necessary there can
be an extra set of functions, but this is what a lot of drivers do
when you pass the device structure to an MMIO accessor.


> [0] <http://lxr.free-electrons.com/source/drivers/usb/dwc2/gadget.c#L1488>
> [1] <http://lxr.free-electrons.com/source/drivers/usb/dwc2/gadget.c#L462>
> [2] <http://lxr.free-electrons.com/source/include/asm-generic/io.h#L315>
> 
> +void dwc2_detect_endiannes(struct dwc2_hsotg *hsotg)
> +{
> +	u32 sid;
> +
> +	sid = __raw_readl(hsotg->regs + GSNPSID);
> +	if ((le32_to_cpu(sid) & 0xffff0000) == 0x4f540000)
> +		hsotg->is_little_endian = 1;
> +}

__raw_readl() might not do what you want here, I'd always use readl()
for the detection without the extra le32_to_cpu().

> +static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
> +			     void __iomem *addr)
> +{
> +	u32 value;
> +
> +	if (hsotg->is_little_endian)
> +		value = ioread32(addr);
> +	else
> +		value = ioread32be(addr);
> +
> +	return value;
> +}
> +
> +static inline void dwc2_writel(struct dwc2_hsotg *hsotg,
> +			       u32 value, void __iomem *addr)
> +{
> +	if (hsotg->is_little_endian)
> +		iowrite32(value, addr);
> +	else
> +		iowrite32be(value, addr);
> +
> +#ifdef DWC2_LOG_WRITES
> +	pr_info("INFO:: wrote %08x to %p\n", value, addr);
> +#endif
> +}

In terms of micro-optimizing this, it may be better to use readl/writel
instead of ioread32/iowrite32: On most architectures they are the
same, but notably on x86, ioread32/iowrite32 is slightly slower
because of the indirection.

We probably only need to worry about the big-endian registers on
architectures that have an efficient ioread32be/iowrite32be.

> @@ -292,6 +294,19 @@ static void dwc2_hsotg_unmap_dma(struct dwc2_hsotg *hsotg,
>  	usb_gadget_unmap_request(&hsotg->gadget, req, hs_ep->dir_in);
>  }
>  
> +static void to_correct_endian(struct dwc2_hsotg *hsotg, u32 *data, size_t len)
> +{
> +	size_t i;
> +
> +	if (hsotg->is_little_endian) {
> +		for (i = 0; i < len; i++)
> +			data[i] = cpu_to_le32(data[i]);
> +	} else {
> +		for (i = 0; i < len; i++)
> +			data[i] = cpu_to_be32(data[i]);
> +	}
> +}
> +
>  /**

My guess is that this leaves the big-endian powerpc machines broken, you
already have the correct byte stream using readsl/writesl or
ioread32_rep/iowrite32_rep.

If there is any location in the code that accesses the FIFO registers
readl/writel or a loop of those, that code should be changed to
use readsl/writesl so you don't have to double-swap the data.

	Arnd
