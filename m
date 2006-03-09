Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2006 09:29:40 +0000 (GMT)
Received: from witte.sonytel.be ([80.88.33.193]:8631 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133439AbWCIJ3a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Mar 2006 09:29:30 +0000
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k299bplR009623;
	Thu, 9 Mar 2006 10:37:51 +0100 (MET)
Date:	Thu, 9 Mar 2006 10:37:50 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Francois Romieu <romieu@fr.zoreil.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, netdev@vger.kernel.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	"P. Horton" <pdh@colonel-panic.org>
Subject: Re: [PATCH, RESEND] Add MWI workaround for Tulip DC21143
In-Reply-To: <20060308224139.GA7536@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.62.0603091032490.9741@pademelon.sonytel.be>
References: <20060129230816.GD4094@colonel-panic.org> <20060218220851.GA1601@colonel-panic.org>
 <20060306225131.GA23327@unjust.cyrius.com> <20060306231530.GB16082@electric-eye.fr.zoreil.com>
 <20060307035824.GA24018@linux-mips.org> <Pine.LNX.4.62.0603071031520.5292@pademelon.sonytel.be>
 <20060308224139.GA7536@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 8 Mar 2006, Francois Romieu wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> :
> > On Tue, 7 Mar 2006, Ralf Baechle wrote:
> [...]
> > > I'm just not convinced of having such a workaround as a build option.
> > > The average person building a a kernel will probably not know if the
> > > option needs to be enabled or not.
> > 
> > Indeed, if it's mentioned in the errata of the chip, the driver should take
> > care of it.
> 
> Something like the patch below (+Mr Horton Signed-off-by: and description):
> 
> diff --git a/drivers/net/tulip/tulip.h b/drivers/net/tulip/tulip.h
> index 05d2d96..d109540 100644
> --- a/drivers/net/tulip/tulip.h
> +++ b/drivers/net/tulip/tulip.h
> @@ -262,7 +262,14 @@ enum t21143_csr6_bits {
>  #define RX_RING_SIZE	128 
>  #define MEDIA_MASK     31
>  
> +/* MWI can fail on 21143 rev 65 if the receive buffer ends
> +   on a cache line boundary. Ensure it doesn't ... */
> +
> +#ifdef CONFIG_MIPS_COBALT
> +#define PKT_BUF_SZ		(1536 + 4)
> +#else
>  #define PKT_BUF_SZ		1536	/* Size of each temporary Rx buffer. */
> +#endif
>  
>  #define TULIP_MIN_CACHE_LINE	8	/* in units of 32-bit words */
>  
> diff --git a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
> index c67c912..ca6eeda 100644
> --- a/drivers/net/tulip/tulip_core.c
> +++ b/drivers/net/tulip/tulip_core.c
> @@ -294,6 +294,8 @@ static void tulip_up(struct net_device *
>  	if (tp->mii_cnt  ||  (tp->mtable  &&  tp->mtable->has_mii))
>  		iowrite32(0x00040000, ioaddr + CSR6);
>  
> +	printk(KERN_DEBUG "%s: CSR0 %08x\n", dev->name, tp->csr0);
> +
>  	/* Reset the chip, holding bit 0 set at least 50 PCI cycles. */
>  	iowrite32(0x00000001, ioaddr + CSR0);
>  	udelay(100);
> @@ -1155,8 +1157,10 @@ static void __devinit tulip_mwi_config (
>  	/* if we have any cache line size at all, we can do MRM */
>  	csr0 |= MRM;
>  
> +#ifndef CONFIG_MIPS_COBALT
>  	/* ...and barring hardware bugs, MWI */
>  	if (!(tp->chip_id == DC21143 && tp->revision == 65))
> +#endif
>  		csr0 |= MWI;

So when compiling for Cobalt, we work around the hardware bug, while for other
platforms, we just disable MWI?

Wouldn't it be possible to always (I mean, when a rev 65 chip is detected) work
around the bug?

>  	/* set or disable MWI in the standard PCI command bit.
> @@ -1182,7 +1186,7 @@ static void __devinit tulip_mwi_config (
>  	 */
>  	switch (cache) {
>  	case 8:
> -		csr0 |= MRL | (1 << CALShift) | (16 << BurstLenShift);
> +		csr0 |= MRL | (1 << CALShift) | (8 << BurstLenShift);
>  		break;
>  	case 16:
>  		csr0 |= MRL | (2 << CALShift) | (16 << BurstLenShift);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
