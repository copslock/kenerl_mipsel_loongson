Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2013 21:11:44 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:40672 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827506Ab3BFULlmsUvQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Feb 2013 21:11:41 +0100
Received: from localhost (nat-pool-rdu.redhat.com [66.187.233.202])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D0DD58426F;
        Wed,  6 Feb 2013 12:11:41 -0800 (PST)
Date:   Wed, 06 Feb 2013 15:11:36 -0500 (EST)
Message-Id: <20130206.151136.28894146016087360.davem@davemloft.net>
To:     ganesanr@broadcom.com
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] NET: ethernet/netlogic: Netlogic XLR/XLS GMAC
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1360063819-17555-1-git-send-email-ganesanr@broadcom.com>
References: <1360063819-17555-1-git-send-email-ganesanr@broadcom.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 35719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: ganesanr@broadcom.com
Date: Tue, 5 Feb 2013 17:00:19 +0530

> +config NETLOGIC_XLR_NET
> +	tristate "Netlogic XLR/XLS network device"
> +	default y
> +	select PHYLIB
> +	depends on CPU_XLR
> +	---help---
> +	This driver support Netlogic XLR/XLS on chip gigabit
> +	Ethernet.

No individual device driver should default to 'y'.   Vendor guards, yes, can
default to 'y', but not individual drivers.

> +/*
> + * The readl/writel implementation byteswaps on XLR/XLS, so
> + * we need to use __raw_ IO to read the NAE registers
> + * because they are in the big-endian MMIO area on the SoC.
> + */

Comments in the networking are to be formatted:

	/* Like
	 * this.
	 */

Please fix this up in your entire driver.

> +/*
> + * Table of net_device pointers indexed by port, this will be used to
> + * lookup the net_device corresponding to a port by the message ring handler.
> + *
> + * Maximum ports in XLR/XLS is 8(8 GMAC on XLS, 4 GMAC + 2 XGMAC on XLR)
> + */
> +static struct net_device *mac_to_ndev[8];

Make this a dynamic data structure, a parent device that the individual
netdevs are hung off of, it can still be an array.  That way you can have
a bonafide struct device instance and associated hierarchy of devices in
the kernel device list.

Also avoid this strange and non-standard usage of "MAC" as an integer
port index.  The canonical meaning of MAC is the link-layer address of
the device.

> +
> +static inline struct sk_buff *mac_get_skb_back_ptr(void *addr)
> +{
> +	struct sk_buff **back_ptr;
> +
> +	/* this function should be used only for newly allocated packets.
> +	 * It assumes the first cacheline is for the back pointer related
> +	 * book keeping info.
> +	 */
> +	back_ptr = (struct sk_buff **)(addr - MAC_SKB_BACK_PTR_SIZE);
> +	return *back_ptr;
> +}

Use the skb->cb[] control block rather than mis-using the skb data area
for storing internal driver state.

> +	paddr = virt_to_bus(addr);

virt_to_bus() is verboten, use the proper DMA APIs.  I don't care if
this is a specialized driver for a special platform.

> +		addr = bus_to_virt(msg->msg0 & 0xffffffffffULL);

bus_to_virt() is verbotten, use the proper DMA APIs and store correct
references to packets in a translation data structure in your per-netdev
software state.

> +static void __maybe_unused xlr_wakeup_queue(unsigned long dev)

This is really unused, just delete it.

That's enough for me, this driver needs a lot of work.
