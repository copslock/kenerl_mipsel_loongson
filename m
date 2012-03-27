Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 03:21:34 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:46742 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2C0BVS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 03:21:18 +0200
Received: by obbup16 with SMTP id up16so7158680obb.36
        for <multiple recipients>; Mon, 26 Mar 2012 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ik3bjwF2iiPUUSvFK+FDUVIl1eYSP0CyWtSLGwYrcXI=;
        b=unevhKjv6Ww1wxihW881y06I7fokdLO0gP/SEqZ7PYBCpX5LIzp2ViFQDlQYDP9Ilh
         2AuC/BmSVO5BSpFI6hFGUHDqI9jo2MYAjDvDkPVxB/plXe7jQGhyf5bq9ZY1CNlrYJqc
         10bOoGcPy4DuOebb6IB9M08dhsXEi88jSpJHFFKxmSUcE5bz/WIpnToYEwkXUGz0wpaU
         GYovijl5C1qQlvbP24BWWNFNgfnq3N5+8Yd20xKG1Qu7RHCkLn5CcjhGA1bsf5ei2TXK
         9WfXFX0w+s/rDqh+r0gnE0NorFegXUjet6dNfwdxhQOI1Fp3InPNnoA1iEIx+F0vTWGN
         SUPQ==
Received: by 10.60.22.10 with SMTP id z10mr31709034oee.16.1332811271906;
        Mon, 26 Mar 2012 18:21:11 -0700 (PDT)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id n10sm18094193obu.23.2012.03.26.18.21.09
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 18:21:10 -0700 (PDT)
Message-ID: <4F7115FA.6080507@gmail.com>
Date:   Mon, 26 Mar 2012 20:20:58 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>
Subject: Re: [PATCH 1/5] i2c: Convert i2c-octeon.c to use device tree.
References: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com> <1332808075-8333-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1332808075-8333-2-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/26/2012 07:27 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> There are three parts to this:
> 
> 1) Remove the definitions of OCTEON_IRQ_TWSI and OCTEON_IRQ_TWSI2.
>    The interrupts are specified by the device tree and these hard
>    coded irq numbers block the used of the irq lines by the irq_domain
>    code.
> 
> 2) Remove platform device setup code from octeon-platform.c, it is
>    now unused.
> 
> 3) Convert i2c-octeon.c to use device tree.  Part of this includes
>    using the devm_* functions instead of the raw counterparts, thus
>    simplifying error handling.  No functionality is changed.

Shouldn't this patch go after converting the platform to DT?

> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
> Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
> Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
> Cc: linux-i2c@vger.kernel.org
> ---
> 
> Should probably go via Ralf's linux-mips.org tree.
> 
>  arch/mips/cavium-octeon/octeon-irq.c      |    2 -
>  arch/mips/cavium-octeon/octeon-platform.c |   84 -------------------------
>  arch/mips/include/asm/octeon/octeon.h     |    5 --
>  drivers/i2c/busses/i2c-octeon.c           |   94 ++++++++++++++++-------------
>  4 files changed, 52 insertions(+), 133 deletions(-)

snip

>  
> -	if (i2c_data == NULL) {
> -		dev_err(i2c->dev, "no I2C frequency data\n");
> +	/*
> +	 * "clock-rate" is a legacy binding, the official binding is
> +	 * "clock-frequency".  Try the official one first and then
> +	 * fall back if it doesn't exist.
> +	 */
> +	data = of_get_property(pdev->dev.of_node, "clock-frequency", &len);
> +	if (!data || len != sizeof(*data))
> +		data = of_get_property(pdev->dev.of_node, "clock-rate", &len);
> +	if (data && len == sizeof(*data)) {
> +		i2c->twsi_freq = be32_to_cpup(data);

Can't you use of_property_read_u32?

Does the legacy binding really exist as DT support is new?

Otherwise,

Acked-by: Rob Herring <rob.herring@calxeda.com>

> +	} else {
> +		dev_err(i2c->dev,
> +			"no I2C 'clock-rate' or 'clock-frequency' property\n");
>  		result = -ENXIO;
> -		goto fail_region;
> +		goto out;
>  	}
>  
> -	i2c->twsi_phys = res_mem->start;
> -	i2c->regsize = resource_size(res_mem);
> -	i2c->twsi_freq = i2c_data->i2c_freq;
> -	i2c->sys_freq = i2c_data->sys_freq;
> +	i2c->sys_freq = octeon_get_io_clock_rate();
>  
> -	if (!request_mem_region(i2c->twsi_phys, i2c->regsize, res_mem->name)) {
> +	if (!devm_request_mem_region(&pdev->dev, i2c->twsi_phys, i2c->regsize,
> +				      res_mem->name)) {
>  		dev_err(i2c->dev, "request_mem_region failed\n");
> -		goto fail_region;
> +		goto out;
>  	}
> -	i2c->twsi_base = ioremap(i2c->twsi_phys, i2c->regsize);
> +	i2c->twsi_base = devm_ioremap(&pdev->dev, i2c->twsi_phys, i2c->regsize);
>  
>  	init_waitqueue_head(&i2c->queue);
>  
>  	i2c->irq = irq;
>  
> -	result = request_irq(i2c->irq, octeon_i2c_isr, 0, DRV_NAME, i2c);
> +	result = devm_request_irq(&pdev->dev, i2c->irq,
> +				  octeon_i2c_isr, 0, DRV_NAME, i2c);
>  	if (result < 0) {
>  		dev_err(i2c->dev, "failed to attach interrupt\n");
> -		goto fail_irq;
> +		goto out;
>  	}
>  
>  	result = octeon_i2c_initlowlevel(i2c);
>  	if (result) {
>  		dev_err(i2c->dev, "init low level failed\n");
> -		goto  fail_add;
> +		goto  out;
>  	}
>  
>  	result = octeon_i2c_setclock(i2c);
>  	if (result) {
>  		dev_err(i2c->dev, "clock init failed\n");
> -		goto  fail_add;
> +		goto  out;
>  	}
>  
>  	i2c->adap = octeon_i2c_ops;
>  	i2c->adap.dev.parent = &pdev->dev;
> -	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
> +	i2c->adap.dev.of_node = pdev->dev.of_node;
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	platform_set_drvdata(pdev, i2c);
>  
> -	result = i2c_add_numbered_adapter(&i2c->adap);
> +	result = i2c_add_adapter(&i2c->adap);
>  	if (result < 0) {
>  		dev_err(i2c->dev, "failed to add adapter\n");
>  		goto fail_add;
>  	}
> -
>  	dev_info(i2c->dev, "version %s\n", DRV_VERSION);
>  
> -	return result;
> +	of_i2c_register_devices(&i2c->adap);
> +
> +	return 0;
>  
>  fail_add:
>  	platform_set_drvdata(pdev, NULL);
> -	free_irq(i2c->irq, i2c);
> -fail_irq:
> -	iounmap(i2c->twsi_base);
> -	release_mem_region(i2c->twsi_phys, i2c->regsize);
> -fail_region:
> -	kfree(i2c);
>  out:
>  	return result;
>  };
> @@ -613,19 +619,24 @@ static int __devexit octeon_i2c_remove(struct platform_device *pdev)
>  
>  	i2c_del_adapter(&i2c->adap);
>  	platform_set_drvdata(pdev, NULL);
> -	free_irq(i2c->irq, i2c);
> -	iounmap(i2c->twsi_base);
> -	release_mem_region(i2c->twsi_phys, i2c->regsize);
> -	kfree(i2c);
>  	return 0;
>  };
>  
> +static struct of_device_id octeon_i2c_match[] = {
> +	{
> +		.compatible = "cavium,octeon-3860-twsi",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, octeon_i2c_match);
> +
>  static struct platform_driver octeon_i2c_driver = {
>  	.probe		= octeon_i2c_probe,
>  	.remove		= __devexit_p(octeon_i2c_remove),
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= DRV_NAME,
> +		.of_match_table = octeon_i2c_match,
>  	},
>  };
>  
> @@ -635,4 +646,3 @@ MODULE_AUTHOR("Michael Lawnick <michael.lawnick.ext@nsn.com>");
>  MODULE_DESCRIPTION("I2C-Bus adapter for Cavium OCTEON processors");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_VERSION);
> -MODULE_ALIAS("platform:" DRV_NAME);
