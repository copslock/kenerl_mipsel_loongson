Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 16:01:20 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:14778 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991063AbeG2OBPbZLp8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 16:01:15 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id CDCD041338;
        Sun, 29 Jul 2018 16:01:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id MNbkNxLE2TJ6; Sun, 29 Jul 2018 16:01:08 +0200 (CEST)
Subject: Re: [PATCH 2/4] net: dsa: Add Lantiq / Intel GSWIP tag support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-3-hauke@hauke-m.de> <20180725142021.GB13891@lunn.ch>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <473cef0a-f5ea-2c1a-19fd-f38fa22f6abe@hauke-m.de>
Date:   Sun, 29 Jul 2018 16:01:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180725142021.GB13891@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 07/25/2018 04:20 PM, Andrew Lunn wrote:
> On Sat, Jul 21, 2018 at 09:13:56PM +0200, Hauke Mehrtens wrote:
>> This handles the tag added by the PMAC on the VRX200 SoC line.
>>
>> The GSWIP uses internally a GSWIP special tag which is located after the
>> Ethernet header. The PMAC which connects the GSWIP to the CPU converts
>> this special tag used by the GSWIP into the PMAC special tag which is
>> added in front of the Ethernet header.
>>
>> This was tested with GSWIP 2.0 found in the VRX200 SoCs, other GSWIP
>> versions use slightly different PMAC special tags
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> Hi Hauke
> 
> This looks good. A new minor nitpicks below.
> 
>> +#include <linux/bitops.h>
>> +#include <linux/etherdevice.h>
>> +#include <linux/skbuff.h>
>> +#include <net/dsa.h>
>> +
>> +#include "dsa_priv.h"
>> +
>> +
>> +#define GSWIP_TX_HEADER_LEN		4
> 
> Single newline is sufficient.

removed
> 
>> +/* Byte 3 */
>> +#define GSWIP_TX_CRCGEN_DIS		BIT(23)
> 
> BIT(23) in a byte is a bit odd.

OK, this should be BIT(7)
The ordering of these defines was also strange I fixed that.

> 
>> +#define GSWIP_TX_SLPID_SHIFT		0	/* source port ID */
>> +#define  GSWIP_TX_SLPID_CPU		2
>> +#define  GSWIP_TX_SLPID_APP1		3
>> +#define  GSWIP_TX_SLPID_APP2		4
>> +#define  GSWIP_TX_SLPID_APP3		5
>> +#define  GSWIP_TX_SLPID_APP4		6
>> +#define  GSWIP_TX_SLPID_APP5		7
>> +
>> +
>> +#define GSWIP_RX_HEADER_LEN	8
> 
> Single newline is sufficient. Please fix them all, if there are more
> of them.

ok

>> +
>> +/* special tag in RX path header */
>> +/* Byte 7 */
>> +#define GSWIP_RX_SPPID_SHIFT		4
>> +#define GSWIP_RX_SPPID_MASK		GENMASK(6, 4)
>> +
>> +static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
>> +				     struct net_device *dev,
>> +				     struct packet_type *pt)
>> +{
>> +	int port;
>> +	u8 *gswip_tag;
>> +
>> +	if (unlikely(!pskb_may_pull(skb, GSWIP_RX_HEADER_LEN)))
>> +		return NULL;
>> +
>> +	gswip_tag = ((u8 *)skb->data) - ETH_HLEN;
> 
> The cast should not be needed, data already is an unsigned char.

OK, I removed that.

>> +	skb_pull_rcsum(skb, GSWIP_RX_HEADER_LEN);
>> +
>> +	/* Get source port information */
>> +	port = (gswip_tag[7] & GSWIP_RX_SPPID_MASK) >> GSWIP_RX_SPPID_SHIFT;
>> +	skb->dev = dsa_master_find_slave(dev, 0, port);
>> +	if (!skb->dev)
>> +		return NULL;
>> +
>> +	return skb;
>> +}
> 
>   Andrew
> 
