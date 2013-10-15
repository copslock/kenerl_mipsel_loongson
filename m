Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2013 01:24:48 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37541 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827341Ab3JOXYpXKCzO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Oct 2013 01:24:45 +0200
Received: by mail-wi0-f175.google.com with SMTP id hm4so3544279wib.2
        for <linux-mips@linux-mips.org>; Tue, 15 Oct 2013 16:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=H/L4bieuZtvqYR8SF/ON9bu3Tb+UNlHl00M8+JMePg0=;
        b=NGtXZOHQZXlULAR+BKpmOQ9qo2wJ84xtm+IOAgW4bK9E9xRr0YRch6XUPef8Y6LzCd
         r92GsLiBD/7mNWNQlRbIirDHkIvpLxLLoUVhK+NtKYma8PUM2/8UTio9t7t3OEQQI0dj
         xWncbiGVdtndSdhReCgrL5WBKhFAgnApAY5MQBYx5ml8nid7KKgN+4YUn5vucWgZKwN4
         jR3iK7pYBpoHfNOBgbKpxeE15LEzd6XDmTU/9WsnB+xYjZElRv9wPpegWqPfzzZxY3Hr
         i5gozBi5kKTYaNQ1zs3alck0fBLzduEXYdCSCBtma3H78Agofalr1F2W/PCw2zADf2PU
         evIw==
X-Gm-Message-State: ALoCoQlTgANK79kQJZiOP1vuZ5XhDLLKJI2a8zwYoeenlbKoJJe1aL5gbGvDEYk519rihvi/X9Um
X-Received: by 10.194.235.138 with SMTP id um10mr37149950wjc.30.1381879479891;
        Tue, 15 Oct 2013 16:24:39 -0700 (PDT)
Received: from trevor.secretlab.ca (host86-141-177-155.range86-141.btcentralplus.com. [86.141.177.155])
        by mx.google.com with ESMTPSA id eq12sm215323wic.7.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 16:24:38 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 19F61C40099; Wed, 16 Oct 2013 00:24:36 +0100 (BST)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 08/10] of/platform: Resolve interrupt references at probe time
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <rob.herring@calxeda.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1379510692-32435-9-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com> <1379510692-32435-9-git-send-email-treding@nvidia.com>
Date:   Wed, 16 Oct 2013 00:24:36 +0100
Message-Id: <20131015232436.19F61C40099@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, 18 Sep 2013 15:24:50 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> Interrupt references are currently resolved very early (when a device is
> created). This has the disadvantage that it will fail in cases where the
> interrupt parent hasn't been probed and no IRQ domain for it has been
> registered yet. To work around that various drivers use explicit
> initcall ordering to force interrupt parents to be probed before devices
> that need them are created. That's error prone and doesn't always work.
> If a platform device uses an interrupt line connected to a different
> platform device (such as a GPIO controller), both will be created in the
> same batch, and the GPIO controller won't have been probed by its driver
> when the depending platform device is created. Interrupt resolution will
> fail in that case.

What is the reason for all the rework on the irq parsing return values?
A return value of '0' is always an error on irq parsing, regardless of
architecture even if NO_IRQ is defined as -1. I may have missed it, but
I don't see any checking for specific error values in the return paths
of the functions.

If the specific return value isn't required (and I don't think it is),
then you can simplify the whole series by getting rid of the rework
patches.

g.

> 
> Another common workaround is for drivers to explicitly resolve interrupt
> references at probe time. This is suboptimal, however, because it will
> require every driver to duplicate the code.
> 
> This patch adds support for late interrupt resolution to the platform
> driver core, by resolving the references right before a device driver's
> .probe() function will be called. This not only delays the resolution
> until a much later time (giving interrupt parents a better chance of
> being probed in the meantime), but it also allows the platform driver
> core to queue the device for deferred probing if the interrupt parent
> hasn't registered its IRQ domain yet.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - split off IRQ parsing into separate function to make code flow simpler
> - add comments to point out some aspects of the implementation
> - make code idempotent (as pointed out by Grygorii Strashko
> 
>  drivers/base/platform.c     |   4 ++
>  drivers/of/platform.c       | 107 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/of_platform.h |   7 +++
>  3 files changed, 112 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 4f8bef3..8dcf835 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -481,6 +481,10 @@ static int platform_drv_probe(struct device *_dev)
>  	struct platform_device *dev = to_platform_device(_dev);
>  	int ret;
>  
> +	ret = of_platform_probe(dev);
> +	if (ret)
> +		return ret;
> +
>  	if (ACPI_HANDLE(_dev))
>  		acpi_dev_pm_attach(_dev, true);
>  
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 9b439ac..df6d56e 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -142,7 +142,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  				  struct device *parent)
>  {
>  	struct platform_device *dev;
> -	int rc, i, num_reg = 0, num_irq;
> +	int rc, i, num_reg = 0;
>  	struct resource *res, temp_res;
>  
>  	dev = platform_device_alloc("", -1);
> @@ -153,23 +153,21 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  	if (of_can_translate_address(np))
>  		while (of_address_to_resource(np, num_reg, &temp_res) == 0)
>  			num_reg++;
> -	num_irq = of_irq_count(np);
>  
>  	/* Populate the resource table */
> -	if (num_irq || num_reg) {
> -		res = kzalloc(sizeof(*res) * (num_irq + num_reg), GFP_KERNEL);
> +	if (num_reg) {
> +		res = kzalloc(sizeof(*res) * num_reg, GFP_KERNEL);
>  		if (!res) {
>  			platform_device_put(dev);
>  			return NULL;
>  		}
>  
> -		dev->num_resources = num_reg + num_irq;
> +		dev->num_resources = num_reg;
>  		dev->resource = res;
>  		for (i = 0; i < num_reg; i++, res++) {
>  			rc = of_address_to_resource(np, i, res);
>  			WARN_ON(rc);
>  		}
> -		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
>  	}
>  
>  	dev->dev.of_node = of_node_get(np);
> @@ -490,4 +488,101 @@ int of_platform_populate(struct device_node *root,
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(of_platform_populate);
> +
> +/**
> + * of_platform_parse_irq() - parse interrupt resource from device node
> + * @pdev: pointer to platform device
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +static int of_platform_parse_irq(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	unsigned int num_res = pdev->num_resources;
> +	struct resource *res = pdev->resource;
> +	unsigned int num_irq, num, c;
> +	int ret = 0;
> +
> +	num_irq = of_irq_count(pdev->dev.of_node);
> +	if (!num_irq)
> +		return 0;
> +
> +	/*
> +	 * Deferred probing may cause this function to be called multiple
> +	 * times, so check if all interrupts have been parsed already and
> +	 * return early.
> +	 */
> +	for (c = 0; c < num_irq; c++)
> +		if (platform_get_irq(pdev, c) < 0)
> +			break;
> +
> +	if (c == num_irq)
> +		return 0;
> +
> +	num = num_res + num_irq;
> +
> +	/*
> +	 * Note that in case we're called twice on the same device (due to
> +	 * deferred probing for example) this will simply be a nop because
> +	 * krealloc() returns the input pointer if the size of the memory
> +	 * block that it points to is larger than or equal to the new size
> +	 * being requested.
> +	 */
> +	res = krealloc(res, num * sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	pdev->resource = res;
> +	res += num_res;
> +
> +	/*
> +	 * It is possible for this to fail. If so, not that the number of
> +	 * resources is not updated, so that the next call to this function
> +	 * will parse all interrupts again. Otherwise we can't keep track of
> +	 * how many we've parsed so far.
> +	 */
> +	ret = of_irq_to_resource_table(np, res, num_irq);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * All interrupts are guaranteed to have been parsed and stored in
> +	 * the resource table, so the number of resources can now safely be
> +	 * updated.
> +	 */
> +	pdev->num_resources += num_irq;
> +
> +	return 0;
> +}
> +
> +/**
> + * of_platform_probe() - OF specific initialization at probe time
> + * @pdev: pointer to a platform device
> + *
> + * This function is called by the driver core to perform devicetree-specific
> + * setup for a given platform device at probe time. If a device's resources
> + * as specified in the device tree are not available yet, this function can
> + * return -EPROBE_DEFER and cause the device to be probed again later, when
> + * other drivers that potentially provide the missing resources have been
> + * probed in turn.
> + *
> + * Note that because of the above, all code executed by this function must
> + * be prepared to be run multiple times on the same device (i.e. it must be
> + * idempotent).
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int of_platform_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	if (!pdev->dev.of_node)
> +		return 0;
> +
> +	ret = of_platform_parse_irq(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
>  #endif /* CONFIG_OF_ADDRESS */
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index 05cb4a9..92fc4f6 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -72,6 +72,8 @@ extern int of_platform_populate(struct device_node *root,
>  				const struct of_device_id *matches,
>  				const struct of_dev_auxdata *lookup,
>  				struct device *parent);
> +
> +extern int of_platform_probe(struct platform_device *pdev);
>  #else
>  static inline int of_platform_populate(struct device_node *root,
>  					const struct of_device_id *matches,
> @@ -80,6 +82,11 @@ static inline int of_platform_populate(struct device_node *root,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int of_platform_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif	/* _LINUX_OF_PLATFORM_H */
> -- 
> 1.8.4
> 
