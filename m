Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2009 14:17:08 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:6866 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20808984AbZCMORB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2009 14:17:01 +0000
Received: from localhost (p3109-ipad301funabasi.chiba.ocn.ne.jp [122.17.253.109])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ED075A95A; Fri, 13 Mar 2009 23:16:53 +0900 (JST)
Date:	Fri, 13 Mar 2009 23:16:59 +0900 (JST)
Message-Id: <20090313.231659.41197617.anemo@mba.ocn.ne.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090313.011950.61509382.anemo@mba.ocn.ne.jp>
References: <e9c3a7c20902251745t314c1e0cs114d2199ccc8cf36@mail.gmail.com>
	<20090227.002436.106263719.anemo@mba.ocn.ne.jp>
	<20090313.011950.61509382.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 13 Mar 2009 01:19:50 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Subject: dmaengine: Use chan_id provided by DMA device driver
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> If chan_id was already given by the DMA device driver, use it.
> Otherwise assign an incremental number for each channels.
> 
> This allows the DMA device driver to reserve some channel ID numbers.
...
> @@ -663,7 +664,9 @@ int dma_async_device_register(struct dma_device *device)
>  			continue;
>  		}
>  
> -		chan->chan_id = chancnt++;
> +		if (!chan->chan_id)
> +			chan->chan_id = chan_id++;
> +		chancnt++;
>  		chan->dev->device.class = &dma_devclass;
>  		chan->dev->device.parent = device->dev;
>  		chan->dev->chan = chan;

This patch will fix another potential problem.  Some driver, for
example ipu, assumes chan_id is an index of its internal array.  But
dmaengine core does not guarantee it.

	/* represent channels in sysfs. Probably want devs too */
	list_for_each_entry(chan, &device->channels, device_node) {
		chan->local = alloc_percpu(typeof(*chan->local));
		if (chan->local == NULL)
			continue;
		chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
		if (chan->dev == NULL) {
			free_percpu(chan->local);
			continue;
		}

		chan->chan_id = chancnt++;
		...
	}
	device->chancnt = chancnt;

If alloc_percpu or kzalloc failed, chan_id does not match with its
position in device->channels list.


And above "continue" looks buggy anyway.  Keeping incomplete channels
in device->channels list looks very dangerous...

---
Atsushi Nemoto
