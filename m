Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 12:08:13 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990946AbeKGLIIX61HE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 12:08:08 +0100
Date:   Wed, 7 Nov 2018 11:08:08 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: SiByte: Set 32-bit bus mask for BCM1250 PCI
In-Reply-To: <20181107075828.GC24381@lst.de>
Message-ID: <alpine.LFD.2.21.1811071100030.20378@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811050350070.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1811050428180.20378@eddie.linux-mips.org> <20181107075828.GC24381@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 7 Nov 2018, Christoph Hellwig wrote:

> > +static int sb1250_bus_dma_mask(struct pci_dev *dev, void *data)
> > +{
> > +	struct sb1250_bus_dma_mask_exclude *exclude = data;
> > +
> > +	if (!exclude->set && (dev->vendor == PCI_VENDOR_ID_SIBYTE &&
> > +			      dev->device == PCI_DEVICE_ID_BCM1250_HT)) {
> > +		exclude->start = dev->subordinate->number;
> > +		exclude->end = pci_bus_max_busnr(dev->subordinate);
> > +		exclude->set = true;
> > +		dev_dbg(&dev->dev, "not disabling DAC for [bus %02x-%02x]",
> > +			exclude->start, exclude->end);
> > +	} else if (!exclude->set ||
> > +		   (exclude->set && (dev->bus->number < exclude->start ||
> > +				     dev->bus->number > exclude->end))) {
> > +		dev_dbg(&dev->dev, "disabling DAC for device");
> > +		dev->dev.bus_dma_mask = DMA_BIT_MASK(32);
> > +	} else {
> > +		dev_dbg(&dev->dev, "not disabling DAC for device");
> > +	}
> > +	return 0;
> 
> Hmm, these conditions look very hard to read to me.  Wouldn't this
> have the same effect?
> 
> 	if (exclude->set)
> 		return;

 Nope, `exclude->set' only means we already know what range to exclude 
(and that gets set mid-way through scanning as the HT bridge is 
encountered).  Then if it's unset, we know we are (still) outside that 
range.

 Maybe I can flatten the conditions at the small cost of executing some 
code unnecessarily.  But that won't be a big deal as this stuff is only 
executed once at boot and isn't performance critical.

 It'll have to wait until next week though as I'll be travelling 
throughout the rest of this and won't be able to test anything.

  Maciej
