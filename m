Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2007 00:06:26 +0100 (BST)
Received: from rgminet01.oracle.com ([148.87.113.118]:4688 "EHLO
	rgminet01.oracle.com") by ftp.linux-mips.org with ESMTP
	id S20022715AbXIFXGR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Sep 2007 00:06:17 +0100
Received: from agmgw2.us.oracle.com (agmgw2.us.oracle.com [152.68.180.213])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id l86N5UaE006636;
	Thu, 6 Sep 2007 17:05:31 -0600
Received: from acsmt351.oracle.com (acsmt351.oracle.com [141.146.40.151])
	by agmgw2.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l86BdTx8028749;
	Thu, 6 Sep 2007 17:05:13 -0600
Received: from pool-96-225-192-201.ptldor.fios.verizon.net by rcsmt252.oracle.com
	with ESMTP id 3189743281189119899; Thu, 06 Sep 2007 17:04:59 -0600
Date:	Thu, 6 Sep 2007 16:04:57 -0700
From:	Randy Dunlap <randy.dunlap@oracle.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org,
	ejka@imfi.kspu.ru, jgarzik@pobox.com, netdev@vger.kernel.org,
	davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de
Subject: Re: [PATCH][MIPS][7/7] AR7: ethernet
Message-Id: <20070906160457.8cb0cc1b.randy.dunlap@oracle.com>
In-Reply-To: <20070906153025.7cb71cb1.akpm@linux-foundation.org>
References: <200708201704.11529.technoboy85@gmail.com>
	<200709061734.11170.technoboy85@gmail.com>
	<20070906153025.7cb71cb1.akpm@linux-foundation.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Return-Path: <randy.dunlap@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randy.dunlap@oracle.com
Precedence: bulk
X-list: linux-mips

On Thu, 6 Sep 2007 15:30:25 -0700 Andrew Morton wrote:

> > On Thu, 6 Sep 2007 17:34:10 +0200 Matteo Croce <technoboy85@gmail.com> wrote:
> > Driver for the cpmac 100M ethernet driver.
> > It works fine disabling napi support, enabling it gives a kernel panic
> > when the first IPv6 packet has to be forwarded.
> > Other than that works fine.
> > 
> 
> I'm not too sure why I got cc'ed on this (and not on patches 1-6?) but
> whatever.
> 
> This patch introduces quite a number of basic coding-style mistakes. 
> Please run it through scripts/checkpatch.pl and review the output.
> 
> The patch introduces vast number of volatile structure fields.  Please see
> Documentation/volatile-considered-harmful.txt.
> 
> The patch inroduces a modest number of unneeded (and undesirable) casts of
> void*, such as
> 
> +	struct cpmac_mdio_regs *regs = (struct cpmac_mdio_regs *)bus->priv;
> 
> please check for those and fix them up.
> 
> The driver implements a driver-private skb pool.  I don't know if this is
> something which we like net drivers doing?  If it is approved then surely
> there should be a common implementation for it somewhere?
> 
> The driver does a lot of open-coded dma_cache_inv() calls (in a way which
> assumes a 32-bit bus, too).  I assume that dma_cache_inv() is some mips
> thing.  I'd have thought that it would be better to use the dma mapping API
> thoughout the driver, and its associated dma invalidation APIs.
> 
> The driver has some LINUX_VERSION_CODE ifdefs.  We usually prefer that such
> code not be present in a merged-up driver.
> 
> 
> 
> > +			priv->regs->mac_hash_low = 0xffffffff;
> > +			priv->regs->mac_hash_high = 0xffffffff;
> > +		} else {
> > +			for (i = 0, iter = dev->mc_list; i < dev->mc_count;
> > +			    i++, iter = iter->next) {
> > +				hash = 0;
> > +				tmp = iter->dmi_addr[0];
> > +				hash  ^= (tmp >> 2) ^ (tmp << 4);
> > +				tmp = iter->dmi_addr[1];
> > +				hash  ^= (tmp >> 4) ^ (tmp << 2);
> > +				tmp = iter->dmi_addr[2];
> > +				hash  ^= (tmp >> 6) ^ tmp;
> > +				tmp = iter->dmi_addr[4];
> > +				hash  ^= (tmp >> 2) ^ (tmp << 4);
> > +				tmp = iter->dmi_addr[5];
> > +				hash  ^= (tmp >> 4) ^ (tmp << 2);
> > +				tmp = iter->dmi_addr[6];
> > +				hash  ^= (tmp >> 6) ^ tmp;
> > +				hash &= 0x3f;
> > +				if (hash < 32) {
> > +					hashlo |= 1<<hash;
> > +				} else {
> > +					hashhi |= 1<<(hash - 32);
> > +				}
> > +			}
> > +
> > +			priv->regs->mac_hash_low = hashlo;
> > +			priv->regs->mac_hash_high = hashhi;
> > +		}
> 
> Do we not have a library function anywhere which will perform this little
> multicasting hash?

Depends on the ethernet controller, but the ones that I know about
just use a CRC (crc-16 IIRC) calculation for the multicast hash.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
