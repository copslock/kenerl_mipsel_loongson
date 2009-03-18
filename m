Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2009 02:02:10 +0000 (GMT)
Received: from fwtops.0.225.230.202.in-addr.arpa ([202.230.225.126]:12492 "EHLO
	topsms.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S21367690AbZCRCCD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Mar 2009 02:02:03 +0000
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6E45C42B62;
	Wed, 18 Mar 2009 10:55:23 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 62B0C18DBD;
	Wed, 18 Mar 2009 10:55:23 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id n2I21tnf031027;
	Wed, 18 Mar 2009 11:01:55 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 18 Mar 2009 11:01:54 +0900 (JST)
Message-Id: <20090318.110154.76582864.nemoto@toshiba-tops.co.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <e9c3a7c20903171823g1e6c42b9t5f042d550a6ddd47@mail.gmail.com>
References: <e9c3a7c20903171002n50964148v8366fa2f00e3164c@mail.gmail.com>
	<20090318.094935.238694196.nemoto@toshiba-tops.co.jp>
	<e9c3a7c20903171823g1e6c42b9t5f042d550a6ddd47@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 17 Mar 2009 18:23:46 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> Now, back to the issue at hand.  Does your driver still need direct
> control over chan->chan_id, or can it now rely on the fact that
> dma_async_device_register() will fail if a channel is not initialized?
>  Or, just use some platform_data to identify the channel in the same
> manner as atmel-mci?

Yes, I still want to control chan->chan_id.

The atmel-mci does not select "channel".  It just pick the first
usable channel of the dma_device specified by platform_data.  I
suppose dw_dmac is symmetric (it can use any channel for any slave).
But TXx9 SoC DMAC channels are hardwired to each peripheral devices.

And I want to call Channel-3 of DMAC-0 "dma0chan3" even if Channel-2
was assigned to for public memcpy channel.

---
Atsushi Nemoto
