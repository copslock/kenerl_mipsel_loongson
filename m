Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Aug 2012 22:17:24 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:60153 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901761Ab2HSURQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Aug 2012 22:17:16 +0200
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.72)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1T3Bvu-000399-M0; Sun, 19 Aug 2012 22:17:14 +0200
Date:   Sun, 19 Aug 2012 22:17:14 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
Message-ID: <20120819201714.GA3152@breakpoint.cc>
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97cb21b8063a02a9664baf8b749ae200@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
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

On Sat, Aug 18, 2012 at 10:18:01AM -0700, Kevin Cernekee wrote:

This is a quick look :)

> diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
> new file mode 100644
> index 0000000..da68f43
> --- /dev/null
> +++ b/drivers/usb/gadget/bcm63xx_udc.c
<snip>

> +static irqreturn_t bcm63xx_udc_data_isr(int irq, void *dev_id)
> +{
> +	struct bcm63xx_udc *udc = dev_id;
> +	struct bcm63xx_ep *bep;
> +	struct iudma_ch *iudma = NULL;
> +	struct usb_request *req = NULL;
> +	struct bcm63xx_req *breq = NULL;
> +	int is_done = 0, rc, i;
> +
> +	spin_lock(&udc->lock);
> +
> +	for (i = 0; i < NUM_IUDMA; i++)
> +		if (udc->iudma[i].irq == irq)
> +			iudma = &udc->iudma[i];
> +	BUG_ON(!iudma);

This is rough. Please don't do this. Bail out in probe or print an error here
and return with IRQ_NONE and time will close this irq.

<snip>

> +static int __devinit bcm63xx_udc_probe(struct platform_device *pdev)
> +{

<snip>

> +	for (i = 0; i < NUM_IUDMA + 1; i++) {
> +		int irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			dev_err(dev, "missing IRQ resource #%d\n", i);
> +			goto out_uninit;
> +		}
> +		if (devm_request_irq(dev, irq,
> +		    i ? &bcm63xx_udc_data_isr : &bcm63xx_udc_ctrl_isr,
> +		    0, dev_name(dev), udc) < 0) {
> +			dev_err(dev, "error requesting IRQ #%d\n", irq);
> +			goto out_uninit;
> +		}
> +		if (i > 0)
> +			udc->iudma[i - 1].irq = irq;
> +	}

According to this code, i in iudma[] can be in 1..5. You could have more than
one IRQ. The comment above this for loop is point less. So I think if you can
only have _one_ idma irq than you could remove the for loop in
bcm63xx_udc_data_isr().

Sebastian
