Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 20:23:19 +0000 (GMT)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:5320 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20023399AbXJ1UXK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 20:23:10 +0000
Received: from freepuppy.rosehill (069-064-229-129.pdx.net [69.64.229.129])
	(authenticated bits=0)
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9SKMU09032240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 28 Oct 2007 13:22:32 -0700
Date:	Sun, 28 Oct 2007 13:22:04 -0700
From:	Stephen Hemminger <shemminger@linux-foundation.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix/Rewrite of the mipsnet driver
Message-ID: <20071028132204.5ab09c10@freepuppy.rosehill>
In-Reply-To: <20071028200308.GB22287@networkno.de>
References: <20071028043846.GM29176@networkno.de>
	<20071029002517.GB16913@linux-mips.org>
	<20071028200308.GB22287@networkno.de>
Organization: Linux Foundation
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.10.14; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <shemminger@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Sun, 28 Oct 2007 20:03:08 +0000
Thiemo Seufer <ths@networkno.de> wrote:

> Ralf Baechle wrote:
> > On Sun, Oct 28, 2007 at 04:38:46AM +0000, Thiemo Seufer wrote:
> > 
> > > Hello All,
> > > 
> > > currently the mipsnet driver fails after transmitting a number of
> > > packages because SKBs are allocated but never freed. I fixed that
> > > and coudn't refrain from removing the most egregious warts.
> > > 
> > > - mipsnet.h folded into mipsnet.c, as it doesn't provide any
> > >   useful external interface.
> > > - Free SKB after transmission.
> > > - Call free_irq in mipsnet_close, to balance the request_irq in
> > >   mipsnet_open.
> > > - Removed duplicate read of rxDataCount.
> > > - Some identifiers are now less verbose.
> > > - Removed dead and/or unnecessarily complex code.
> > > - Code formatting fixes.
> > > 
> > > Tested on Qemu's mipssim emulation, with this patch it can boot a
> > > Debian NFSroot.
> > 
> > The patch does no longer apply to a recent tree, can you respin it?
> 
> Updated against linux-mips.org head and appended. Only compile-tested
> this time, the mipssim kernel currently fails to build.
> 
> 
> Thiemo
> 
> 
> Signed-off-by: Thiemo Seufer <ths@networkno.de>
> ---
>  b/drivers/net/mipsnet.c |  201 ++++++++++++++++++++++++++++++++----------------
>  drivers/net/mipsnet.h   |  112 --------------------------
>  2 files changed, 134 insertions(+), 179 deletions(-)
> 
> diff --git a/drivers/net/mipsnet.c b/drivers/net/mipsnet.c
> index aafc3ce..e9c0c79 100644
> --- a/drivers/net/mipsnet.c
> +++ b/drivers/net/mipsnet.c
> @@ -4,8 +4,6 @@
>   * for more details.
>   */
>  
> -#define DEBUG
> -
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -15,11 +13,93 @@
>  #include <linux/platform_device.h>
>  #include <asm/mips-boards/simint.h>
>  
> -#include "mipsnet.h"		/* actual device IO mapping */
> +#define MIPSNET_VERSION "2007-10-28"
> +
> +/*
> + * Net status/control block as seen by sw in the core.
> + */
> +struct mipsnet_regs {
> +	/*
> +	 * Device info for probing, reads as MIPSNET%d where %d is some
> +	 * form of version.
> +	 */
> +	uint64_t devId;		/*0x00 */
>  
> -#define MIPSNET_VERSION "2005-06-20"
> +	/*
> +	 * read only busy flag.
> +	 * Set and cleared by the Net Device to indicate that an rx or a tx
> +	 * is in progress.
> +	 */
> +	uint32_t busy;		/*0x08 */
>  
> -#define mipsnet_reg_address(dev, field) (dev->base_addr + field_offset(field))
> +	/*
> +	 * Set by the Net Device.
> +	 * The device will set it once data has been received.
> +	 * The value is the number of bytes that should be read from
> +	 * rxDataBuffer.  The value will decrease till 0 until all the data
> +	 * from rxDataBuffer has been read.
> +	 */
> +	uint32_t rxDataCount;	/*0x0c */
> +#define MIPSNET_MAX_RXTX_DATACOUNT (1 << 16)
> +
> +	/*
> +	 * Settable from the MIPS core, cleared by the Net Device.
> +	 * The core should set the number of bytes it wants to send,
> +	 * then it should write those bytes of data to txDataBuffer.
> +	 * The device will clear txDataCount has been processed (not
> +	 * necessarily sent).
> +	 */
> +	uint32_t txDataCount;	/*0x10 */
> +
> +	/*
> +	 * Interrupt control
> +	 *
> +	 * Used to clear the interrupted generated by this dev.
> +	 * Write a 1 to clear the interrupt. (except bit31).
> +	 *
> +	 * Bit0 is set if it was a tx-done interrupt.
> +	 * Bit1 is set when new rx-data is available.
> +	 *    Until this bit is cleared there will be no other RXs.
> +	 *
> +	 * Bit31 is used for testing, it clears after a read.
> +	 *    Writing 1 to this bit will cause an interrupt to be generated.
> +	 *    To clear the test interrupt, write 0 to this register.
> +	 */
> +	uint32_t interruptControl;	/*0x14 */
> +#define MIPSNET_INTCTL_TXDONE     ((uint32_t)(1 << 0))
> +#define MIPSNET_INTCTL_RXDONE     ((uint32_t)(1 << 1))
> +#define MIPSNET_INTCTL_TESTBIT    ((uint32_t)(1 << 31))
> +
> +	/*
> +	 * Readonly core-specific interrupt info for the device to signal
> +	 * the core. The meaning of the contents of this field might change.
> +	 */
> +	/* XXX: the whole memIntf interrupt scheme is messy: the device
> +	 * should have no control what so ever of what VPE/register set is
> +	 * being used.
> +	 * The MemIntf should only expose interrupt lines, and something in
> +	 * the config should be responsible for the line<->core/vpe bindings.
> +	 */
> +	uint32_t interruptInfo;	/*0x18 */
> +
> +	/*
> +	 * This is where the received data is read out.
> +	 * There is more data to read until rxDataReady is 0.
> +	 * Only 1 byte at this regs offset is used.
> +	 */
> +	uint32_t rxDataBuffer;	/*0x1c */
> +
> +	/*
> +	 * This is where the data to transmit is written.
> +	 * Data should be written for the amount specified in the
> +	 * txDataCount register.
> +	 * Only 1 byte at this regs offset is used.
> +	 */
> +	uint32_t txDataBuffer;	/*0x20 */
> +};
> +
> +#define regaddr(dev, field) \
> +  (dev->base_addr + offsetof(struct mipsnet_regs, field))
>  
>  static char mipsnet_string[] = "mipsnet";
>  
> @@ -29,32 +109,27 @@ static char mipsnet_string[] = "mipsnet";
>  static int ioiocpy_frommipsnet(struct net_device *dev, unsigned char *kdata,
>  			int len)
>  {
> -	uint32_t available_len = inl(mipsnet_reg_address(dev, rxDataCount));
> -
> -	if (available_len < len)
> -		return -EFAULT;
> -
>  	for (; len > 0; len--, kdata++)
> -		*kdata = inb(mipsnet_reg_address(dev, rxDataBuffer));
> +		*kdata = inb(regaddr(dev, rxDataBuffer));
>  
> -	return inl(mipsnet_reg_address(dev, rxDataCount));
> +	return inl(regaddr(dev, rxDataCount));
>  }
>  
> -static inline ssize_t mipsnet_put_todevice(struct net_device *dev,
> +static inline void mipsnet_put_todevice(struct net_device *dev,
>  	struct sk_buff *skb)
>  {
>  	int count_to_go = skb->len;
>  	char *buf_ptr = skb->data;
>  
> -	outl(skb->len, mipsnet_reg_address(dev, txDataCount));
> +	outl(skb->len, regaddr(dev, txDataCount));
>  
>  	for (; count_to_go; buf_ptr++, count_to_go--)
> -		outb(*buf_ptr, mipsnet_reg_address(dev, txDataBuffer));
> +		outb(*buf_ptr, regaddr(dev, txDataBuffer));
>  
>  	dev->stats.tx_packets++;
>  	dev->stats.tx_bytes += skb->len;
>  
> -	return skb->len;
> +	dev_kfree_skb(skb);
>  }
>  
>  static int mipsnet_xmit(struct sk_buff *skb, struct net_device *dev)
> @@ -69,12 +144,14 @@ static int mipsnet_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return 0;
>  }
>  
> -static inline ssize_t mipsnet_get_fromdev(struct net_device *dev, size_t count)
> +static inline ssize_t mipsnet_get_fromdev(struct net_device *dev, size_t len)
>  {
>  	struct sk_buff *skb;
> -	size_t len = count;
>  
> -	skb = alloc_skb(len + 2, GFP_KERNEL);
> +	if (!len)
> +		return len;
> +
> +	skb = dev_alloc_skb(len + 2);
>  	if (!skb) {
>  		dev->stats.rx_dropped++;
>  		return -ENOMEM;
> @@ -92,50 +169,42 @@ static inline ssize_t mipsnet_get_fromdev(struct net_device *dev, size_t count)
>  	dev->stats.rx_packets++;
>  	dev->stats.rx_bytes += len;
>  
> -	return count;
> +	return len;
>  }
>  
>  static irqreturn_t mipsnet_interrupt(int irq, void *dev_id)
>  {
>  	struct net_device *dev = dev_id;
> -
> -	irqreturn_t retval = IRQ_NONE;
> -	uint64_t interruptFlags;
> -
> -	if (irq == dev->irq) {
> -		retval = IRQ_HANDLED;
> -
> -		interruptFlags =
> -		    inl(mipsnet_reg_address(dev, interruptControl));
> -
> -		if (interruptFlags & MIPSNET_INTCTL_TXDONE) {
> -			outl(MIPSNET_INTCTL_TXDONE,
> -			     mipsnet_reg_address(dev, interruptControl));
> -			/* only one packet at a time, we are done. */
> -			netif_wake_queue(dev);
> -		} else if (interruptFlags & MIPSNET_INTCTL_RXDONE) {
> -			mipsnet_get_fromdev(dev,
> -				    inl(mipsnet_reg_address(dev, rxDataCount)));
> -			outl(MIPSNET_INTCTL_RXDONE,
> -			     mipsnet_reg_address(dev, interruptControl));
> -
> -		} else if (interruptFlags & MIPSNET_INTCTL_TESTBIT) {
> -			/*
> -			 * TESTBIT is cleared on read.
> -			 * And takes effect after a write with 0
> -			 */
> -			outl(0, mipsnet_reg_address(dev, interruptControl));
> -		} else {
> -			/* Maybe shared IRQ, just ignore, no clearing. */
> -			retval = IRQ_NONE;
> -		}
> -
> -	} else {
> -		printk(KERN_INFO "%s: %s(): irq %d for unknown device\n",
> -		       dev->name, __FUNCTION__, irq);
> -		retval = IRQ_NONE;
> +	u32 int_flags;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	if (irq != dev->irq)
> +		goto out_badirq;
> +
> +	/* TESTBIT is cleared on read. */
> +	int_flags = inl(regaddr(dev, interruptControl));
> +	if (int_flags & MIPSNET_INTCTL_TESTBIT) {
> +		/* TESTBIT takes effect after a write with 0. */
> +		outl(0, regaddr(dev, interruptControl));
> +		ret = IRQ_HANDLED;
> +	} else if (int_flags & MIPSNET_INTCTL_TXDONE) {
> +		/* Only one packet at a time, we are done. */
> +		dev->stats.tx_packets++;
> +		netif_wake_queue(dev);
> +		outl(MIPSNET_INTCTL_TXDONE,
> +		     regaddr(dev, interruptControl));
> +		ret = IRQ_HANDLED;
> +	} else if (int_flags & MIPSNET_INTCTL_RXDONE) {
> +		mipsnet_get_fromdev(dev, inl(regaddr(dev, rxDataCount)));
> +		outl(MIPSNET_INTCTL_RXDONE, regaddr(dev, interruptControl));
> +		ret = IRQ_HANDLED;
>  	}
> -	return retval;
> +	return ret;
> +
> +out_badirq:
> +	printk(KERN_INFO "%s: %s(): irq %d for unknown device\n",
> +	       dev->name, __FUNCTION__, irq);
> +	return ret;
>  }
>  
>  static int mipsnet_open(struct net_device *dev)
> @@ -144,18 +213,15 @@ static int mipsnet_open(struct net_device *dev)
>  
>  	err = request_irq(dev->irq, &mipsnet_interrupt,
>  			  IRQF_SHARED, dev->name, (void *) dev);
> -
>  	if (err) {
> -		release_region(dev->base_addr, MIPSNET_IO_EXTENT);
> +		release_region(dev->base_addr, sizeof(struct mipsnet_regs));
>  		return err;
>  	}
>  
>  	netif_start_queue(dev);
>  
>  	/* test interrupt handler */
> -	outl(MIPSNET_INTCTL_TESTBIT,
> -	     mipsnet_reg_address(dev, interruptControl));
> -
> +	outl(MIPSNET_INTCTL_TESTBIT, regaddr(dev, interruptControl));
>  
>  	return 0;
>  }
> @@ -163,7 +229,7 @@ static int mipsnet_open(struct net_device *dev)
>  static int mipsnet_close(struct net_device *dev)
>  {
>  	netif_stop_queue(dev);
> -
> +	free_irq(dev->irq, dev);
>  	return 0;
>  }
>  
> @@ -194,10 +260,11 @@ static int __init mipsnet_probe(struct device *dev)
>  	 */
>  	netdev->base_addr = 0x4200;
>  	netdev->irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_MB0 +
> -		      inl(mipsnet_reg_address(netdev, interruptInfo));
> +		      inl(regaddr(netdev, interruptInfo));
>  
>  	/* Get the io region now, get irq on open() */
> -	if (!request_region(netdev->base_addr, MIPSNET_IO_EXTENT, "mipsnet")) {
> +	if (!request_region(netdev->base_addr, sizeof(struct mipsnet_regs),
> +			    "mipsnet")) {
>  		err = -EBUSY;
>  		goto out_free_netdev;
>  	}
> @@ -217,7 +284,7 @@ static int __init mipsnet_probe(struct device *dev)
>  	return 0;
>  
>  out_free_region:
> -	release_region(netdev->base_addr, MIPSNET_IO_EXTENT);
> +	release_region(netdev->base_addr, sizeof(struct mipsnet_regs));
>  
>  out_free_netdev:
>  	free_netdev(netdev);
> @@ -231,7 +298,7 @@ static int __devexit mipsnet_device_remove(struct device *device)
>  	struct net_device *dev = dev_get_drvdata(device);
>  
>  	unregister_netdev(dev);
> -	release_region(dev->base_addr, MIPSNET_IO_EXTENT);
> +	release_region(dev->base_addr, sizeof(struct mipsnet_regs));
>  	free_netdev(dev);
>  	dev_set_drvdata(device, NULL);
>  
> diff --git a/drivers/net/mipsnet.h b/drivers/net/mipsnet.h
> deleted file mode 100644
> index 0132c67..0000000
> --- a/drivers/net/mipsnet.h
> +++ /dev/null
> @@ -1,112 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -#ifndef __MIPSNET_H
> -#define __MIPSNET_H
> -
> -/*
> - *  Id of this Net device, as seen by the core.
> - */
> -#define MIPS_NET_DEV_ID ((uint64_t)	   \
> -			     ((uint64_t) 'M' <<  0)| \
> -			     ((uint64_t) 'I' <<  8)| \
> -			     ((uint64_t) 'P' << 16)| \
> -			     ((uint64_t) 'S' << 24)| \
> -			     ((uint64_t) 'N' << 32)| \
> -			     ((uint64_t) 'E' << 40)| \
> -			     ((uint64_t) 'T' << 48)| \
> -			     ((uint64_t) '0' << 56))
> -
> -/*
> - * Net status/control block as seen by sw in the core.
> - * (Why not use bit fields? can't be bothered with cross-platform struct
> - *  packing.)
> - */
> -struct net_control_block {
> -	/*
> -	 * dev info for probing
> -	 * reads as MIPSNET%d where %d is some form of version
> -	 */
> -	uint64_t devId;		/* 0x00 */
> -
> -	/*
> -	 * read only busy flag.
> -	 * Set and cleared by the Net Device to indicate that an rx or a tx
> -	 * is in progress.
> -	 */
> -	uint32_t busy;		/* 0x08 */
> -
> -	/*
> -	 * Set by the Net Device.
> -	 * The device will set it once data has been received.
> -	 * The value is the number of bytes that should be read from
> -	 * rxDataBuffer.  The value will decrease till 0 until all the data
> -	 * from rxDataBuffer has been read.
> -	 */
> -	uint32_t rxDataCount;	/* 0x0c */
> -#define MIPSNET_MAX_RXTX_DATACOUNT (1<<16)
> -
> -	/*
> -	 * Settable from the MIPS core, cleared by the Net Device.  The core
> -	 * should set the number of bytes it wants to send, then it should
> -	 * write those bytes of data to txDataBuffer.  The device will clear
> -	 * txDataCount has been processed (not necessarily sent).
> -	 */
> -	uint32_t txDataCount;	/* 0x10 */
> -
> -	/*
> -	 * Interrupt control
> -	 *
> -	 * Used to clear the interrupted generated by this dev.
> -	 * Write a 1 to clear the interrupt. (except bit31).
> -	 *
> -	 * Bit0 is set if it was a tx-done interrupt.
> -	 * Bit1 is set when new rx-data is available.
> -	 *      Until this bit is cleared there will be no other RXs.
> -	 *
> -	 * Bit31 is used for testing, it clears after a read.
> -	 *    Writing 1 to this bit will cause an interrupt to be generated.
> -	 *    To clear the test interrupt, write 0 to this register.
> -	 */
> -	uint32_t interruptControl;	/*0x14 */
> -#define MIPSNET_INTCTL_TXDONE     ((uint32_t)(1 <<  0))
> -#define MIPSNET_INTCTL_RXDONE     ((uint32_t)(1 <<  1))
> -#define MIPSNET_INTCTL_TESTBIT    ((uint32_t)(1 << 31))
> -#define MIPSNET_INTCTL_ALLSOURCES	(MIPSNET_INTCTL_TXDONE | \
> -					 MIPSNET_INTCTL_RXDONE | \
> -					 MIPSNET_INTCTL_TESTBIT)

It is standard practice in the kernel to use u32 rather than uint32_t.

Also cast of shift is unneeded  (1u << 0) works fine.



-- 
Stephen Hemminger <shemminger@linux-foundation.org>
