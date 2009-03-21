Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2009 12:29:30 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:46062 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21369760AbZCUM3V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Mar 2009 12:29:21 +0000
Received: from localhost (p3064-ipad303funabasi.chiba.ocn.ne.jp [123.217.149.64])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AAE1AA7AD; Sat, 21 Mar 2009 21:29:14 +0900 (JST)
Date:	Sat, 21 Mar 2009 21:29:20 +0900 (JST)
Message-Id: <20090321.212920.25912728.anemo@mba.ocn.ne.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <e9c3a7c20903181026h1801ef6i945e6ce9ccb36b8a@mail.gmail.com>
References: <e9c3a7c20903171823g1e6c42b9t5f042d550a6ddd47@mail.gmail.com>
	<20090318.110154.76582864.nemoto@toshiba-tops.co.jp>
	<e9c3a7c20903181026h1801ef6i945e6ce9ccb36b8a@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 18 Mar 2009 10:26:13 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> > The atmel-mci does not select "channel".  It just pick the first
> > usable channel of the dma_device specified by platform_data.  I
> > suppose dw_dmac is symmetric (it can use any channel for any slave).
> 
> You are right, it does not hardwire the channel, but it does hardwire
> the device, see at32_add_device_mci [1].
> 
> > But TXx9 SoC DMAC channels are hardwired to each peripheral devices.
> 
> I think creating a dma_device instance per channel and specifying that
> device like atmel-mci is the more future-proof way to go.

Well, I have considered it but it looks overkill for me at that time.
Maybe time to think again...

> > And I want to call Channel-3 of DMAC-0 "dma0chan3" even if Channel-2
> > was assigned to for public memcpy channel.
> 
> The problem is you could pass in the chan_id to guarantee 'chan3', but
> there is no guarantee that you will get 'dma0', as the driver has no
> knowledge of what other dma devices may be in the system.

Yes, I do not expect 'dma0'.  My filter function uses
dev_name(chan->device->dev), which is "txx9dmac.0" in this case.

Anyway, "one dma-device per channel" manner will make things much simpler.

---
Atsushi Nemoto
