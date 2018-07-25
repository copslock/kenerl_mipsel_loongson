Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 16:20:46 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:51407 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992289AbeGYOUmFSQXW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 16:20:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=gGxghg49+Ehyza/tzm8SCLHSpPJHJzrJyy0jYZ9uZ4E=;
        b=eIL6PoQuw1P+YPYEC+Kll0yoMXvr5r2rhA7H6YOf6z3Df+sB9IUKSJfNVdojPcdU5nPvntRfEIXATRbPBV//2R3eAQjrL1b07/xbEnMSMFeRja80MnjhYZHbicFkHiiPkhsxMBmpJx0eQnmXrCqLqLOu745O2PzEiRnQ3MlLcS4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fiKeL-0003yP-R3; Wed, 25 Jul 2018 16:20:21 +0200
Date:   Wed, 25 Jul 2018 16:20:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 2/4] net: dsa: Add Lantiq / Intel GSWIP tag support
Message-ID: <20180725142021.GB13891@lunn.ch>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-3-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721191358.13952-3-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

On Sat, Jul 21, 2018 at 09:13:56PM +0200, Hauke Mehrtens wrote:
> This handles the tag added by the PMAC on the VRX200 SoC line.
> 
> The GSWIP uses internally a GSWIP special tag which is located after the
> Ethernet header. The PMAC which connects the GSWIP to the CPU converts
> this special tag used by the GSWIP into the PMAC special tag which is
> added in front of the Ethernet header.
> 
> This was tested with GSWIP 2.0 found in the VRX200 SoCs, other GSWIP
> versions use slightly different PMAC special tags
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Hi Hauke

This looks good. A new minor nitpicks below.

> +#include <linux/bitops.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <net/dsa.h>
> +
> +#include "dsa_priv.h"
> +
> +
> +#define GSWIP_TX_HEADER_LEN		4

Single newline is sufficient.

> +/* Byte 3 */
> +#define GSWIP_TX_CRCGEN_DIS		BIT(23)

BIT(23) in a byte is a bit odd.

> +#define GSWIP_TX_SLPID_SHIFT		0	/* source port ID */
> +#define  GSWIP_TX_SLPID_CPU		2
> +#define  GSWIP_TX_SLPID_APP1		3
> +#define  GSWIP_TX_SLPID_APP2		4
> +#define  GSWIP_TX_SLPID_APP3		5
> +#define  GSWIP_TX_SLPID_APP4		6
> +#define  GSWIP_TX_SLPID_APP5		7
> +
> +
> +#define GSWIP_RX_HEADER_LEN	8

Single newline is sufficient. Please fix them all, if there are more
of them.

> +
> +/* special tag in RX path header */
> +/* Byte 7 */
> +#define GSWIP_RX_SPPID_SHIFT		4
> +#define GSWIP_RX_SPPID_MASK		GENMASK(6, 4)
> +
> +static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
> +				     struct net_device *dev,
> +				     struct packet_type *pt)
> +{
> +	int port;
> +	u8 *gswip_tag;
> +
> +	if (unlikely(!pskb_may_pull(skb, GSWIP_RX_HEADER_LEN)))
> +		return NULL;
> +
> +	gswip_tag = ((u8 *)skb->data) - ETH_HLEN;

The cast should not be needed, data already is an unsigned char.

> +	skb_pull_rcsum(skb, GSWIP_RX_HEADER_LEN);
> +
> +	/* Get source port information */
> +	port = (gswip_tag[7] & GSWIP_RX_SPPID_MASK) >> GSWIP_RX_SPPID_SHIFT;
> +	skb->dev = dsa_master_find_slave(dev, 0, port);
> +	if (!skb->dev)
> +		return NULL;
> +
> +	return skb;
> +}

  Andrew
