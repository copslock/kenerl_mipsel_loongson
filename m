Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2009 01:52:49 +0000 (GMT)
Received: from fwtops.0.225.230.202.in-addr.arpa ([202.230.225.126]:21983 "EHLO
	topsms.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S21368806AbZCQBwm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2009 01:52:42 +0000
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 647E942BFB;
	Tue, 17 Mar 2009 10:46:03 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4F39D1DCFC;
	Tue, 17 Mar 2009 10:46:03 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id n2H1qVnf026516;
	Tue, 17 Mar 2009 10:52:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 17 Mar 2009 10:52:30 +0900 (JST)
Message-Id: <20090317.105230.118904211.nemoto@toshiba-tops.co.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <e9c3a7c20903161420u7568e7f9jfb10d518a3ca6fea@mail.gmail.com>
References: <e9c3a7c20902251745t314c1e0cs114d2199ccc8cf36@mail.gmail.com>
	<20090227.002436.106263719.anemo@mba.ocn.ne.jp>
	<e9c3a7c20903161420u7568e7f9jfb10d518a3ca6fea@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 16 Mar 2009 14:20:56 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> > Maybe I should move this DMA_CTRL_ACK setting to txx9dmac_desc_put()?
> 
> Perhaps a comment.  I think this scheme is ok, it just raised alarm
> bells as I read it.

OK, I will do.

> >> > + � � � disable_irq_nosync(irq);
> >> > +
> >> > + � � � return IRQ_HANDLED;
> >> > +}
> >>
> >> Why do you need to disable interrupts here?
> >
> > Because interrupts are not cleared until txx9dmac_tasklet() calls
> > txx9dmac_scan_descriptors() and it writes to CSR. �Touching CSR in
> > txx9dmac_interrupt() seems bad while dc->lock spinlock does not
> > protect from interrupts. �I chose calling disable_irq here instead of
> > replace all spin_lock with spin_lock_irqsave.
> 
> I believe in this case you are protected by the fact this IRQ handler
> will not race against itself, i.e. even though other interrupts are
> enabled this handler will be masked until it returns.

Yes, IRQ handler will be masked, but tasklet will not be masked.  If I
did not disable irq here, the kernel hangs just after returning from
this IRQ handler (and before tasklet routine is invoked).

> > I need the reserved_chan to make channel 3 named "dma0chan3". �If I
> > can chose chan_id for each channels in dma_device, the reserved_chan
> > is not needed.
> 
> Can you post the code that communicates chan_id to the routine calling
> dma_request_channel?  I am not understanding why you need to control
> chan_id.  Why not have the filter_fn passed to dma_request_channel
> ignore non-private devices?

You mean the filter_fn provided by client driver?  I don't want to let
client driver know which channel is used for memcpy.  And if
"dma0chan3" was not the Ch3 of the DMAC, it looks confusing...

Here is an excerpt from client under construction.

struct txx9aclc_dmadata {
	struct resource *dma_res;
	struct txx9dmac_slave dma_slave;
	struct dma_chan *dma_chan;
	...
};

static bool filter(struct dma_chan *chan, void *param)
{
	struct txx9aclc_dmadata *dmadata = param;

	if (strcmp(dev_name(chan->device->dev), dmadata->dma_res->name) == 0 &&
	    dmadata->dma_res->start == chan->chan_id) {
		chan->private = &dmadata->dma_slave;
		return true;
	}
	return false;
}

	struct txx9dmac_slave *ds = &dmadata->dma_slave;
	...
	dmadata->dma_res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
	...
	dmadata->dma_chan = dma_request_channel(mask, filter, dmadata);

The IORESOURCE_DMA resource for the client device contains a name of a
DMA driver (dma_res->name) and its channel ID (dma_res->start).

---
Atsushi Nemoto
