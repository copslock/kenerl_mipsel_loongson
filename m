Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 01:11:40 +0200 (CEST)
Received: from aeryn.fluff.org.uk ([87.194.8.8]:48901 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1493699AbZJMXLe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 01:11:34 +0200
Received: from ben by kira.home.fluff.org with local (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>)
	id 1Mxq3X-000411-FC; Tue, 13 Oct 2009 23:41:23 +0100
Date:	Tue, 13 Oct 2009 23:41:23 +0100
From:	Ben Dooks <ben@fluff.org>
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:	baruch@tkos.co.il, linux-i2c@vger.kernel.org, ben-linux@fluff.org,
	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
 I2C clock source
Message-ID: <20091013224123.GB13398@fluff.org.uk>
References: <4AD3E974.8080200@necel.com>
 <4AD3EB09.8050304@necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD3EB09.8050304@necel.com>
X-Disclaimer: These are my own opinions, so there!
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <ben@fluff.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@fluff.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 11:50:49AM +0900, Shinya Kuribayashi wrote:
> This driver is originally prepared for the ARM kernel where rich and
> well-maintained "clkdev" clock framework is available, and clock name
> might not be strictly required.  ARM's clkdev does slightly fuzzy
> matching where it basically gives preference to "struct device" mathing
> over "clock id".  As long as used for ARM machines, there's no problem.
> 
> However, all users of this driver necessarily don't have the same clk
> framework with ARM's, as the clk I/F implementation varies depending on
> ARCHs and machines.
> 
> This patch adds a clock name so that other users with simple/minimum/
> limited clk support could make use of the driver.

You're meant to match with both the device and name, I belive the
clkdev specification has always said this. I'm of the opinion if
the clkdev implementation isn't getting this right, then it is the
clkdev that should be fixed, not this driver.
 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
> ---
> drivers/i2c/busses/i2c-designware.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> index 9d81775..0f8bd4c 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -575,7 +575,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
> 	dev->irq = irq;
> 	platform_set_drvdata(pdev, dev);
> 
> -	dev->clk = clk_get(&pdev->dev, NULL);
> +	dev->clk = clk_get(&pdev->dev, "dw_i2c_clk");
> 	if (IS_ERR(dev->clk)) {
> 		r = -ENODEV;
> 		goto err_free_mem;

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
