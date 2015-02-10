Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 01:18:54 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012911AbbBJASwS72Ah (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Feb 2015 01:18:52 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 690FDA5D;
        Tue, 10 Feb 2015 00:18:45 +0000 (UTC)
Date:   Mon, 9 Feb 2015 16:18:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     rtc-linux@googlegroups.com
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH 01/02 resend] RTC: Add driver for DS1685
 family of real time clocks
Message-Id: <20150209161844.942ff2d0ecd709a331083bac@linux-foundation.org>
In-Reply-To: <548B6892.9040200@gentoo.org>
References: <548B6892.9040200@gentoo.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Fri, 12 Dec 2014 17:13:38 -0500 Joshua Kinard <kumba@gentoo.org> wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> 
> This adds a driver for the Dallas/Maxim DS1685-family of RTC chips.  It
> supports the DS1685/DS1687, DS1688/DS1691, DS1689/DS1693, DS17285/DS17287,
> DS17485/DS17487, and DS17885/DS17887 RTC chips.  These chips are commonly found
> in SGI O2 and SGI Octane systems.  It was originally derived from a driver
> patch submitted by Matthias Fuchs many years ago for use in EPPC-405-UC
> modules, which also used these RTCs.  In addition to the time-keeping
> functions, this RTC also handles the shutdown mechanism of the O2 and Octane
> and acts as a partial NVRAM for the boot PROMS in these systems.
> 
> Verified on both an SGI O2 and an SGI Octane.
> 
> ...
>
> +static int
> +ds1685_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *rtc_dev;
> +	struct resource *res;
> +	struct ds1685_priv *rtc;
> +	struct ds1685_rtc_platform_data *pdata;
> +	u8 ctrla, ctrlb, hours;
> +	unsigned char am_pm;
> +	int ret = 0;
> +
> +	/* Get the platform data. */
> +	pdata = (struct ds1685_rtc_platform_data *) pdev->dev.platform_data;

That cast isn't needed.

> +	if (!pdata)
> +		return -ENODEV;
> +
> +	/* Allocate memory for the rtc device. */
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Allocate/setup any IORESOURCE_MEM resources, if required.  Not all
> +	 * platforms put the RTC in an easy-access place.  Like the SGI Octane,
> +	 * which attaches the RTC to a "ByteBus", hooked to a SuperIO chip
> +	 * that sits behind the IOC3 PCI metadevice.
> +	 */
> +	if (pdata->alloc_io_resources) {
> +		/* Get the platform resources. */
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res)
> +			return -ENXIO;
> +		rtc->size = resource_size(res);
> +
> +		/* Request a memory region. */
> +		/* XXX: mmio-only for now. */
> +		if (!devm_request_mem_region(&pdev->dev, res->start, rtc->size,
> +					     pdev->name))
> +			return -EBUSY;
> +
> +		/*
> +		 * Set the base address for the rtc, and ioremap its
> +		 * registers.
> +		 */
> +		rtc->baseaddr = res->start;
> +		rtc->regs = devm_ioremap(&pdev->dev, res->start, rtc->size);
> +		if (!rtc->regs)
> +			return -ENOMEM;
> +	}
> +	rtc->alloc_io_resources = pdata->alloc_io_resources;
> +
> +	/* Get the register step size. */
> +	if (pdata->regstep > 0)
> +		rtc->regstep = pdata->regstep;
> +	else
> +		rtc->regstep = 1;
> +
> +	/* Platform read function, else default if mmio setup */
> +	if (pdata->plat_read)
> +		rtc->read = pdata->plat_read;

I'm trying to understand how this works and I'm not getting very far. 
Perhaps it is the intention that some code(?) is to allocate and
populate a ds1685_rtc_platform_data and use platform_device_add_data()
on it, but no such code exists.

Or something.  What's going on here?

> +	else
> +		if (pdata->alloc_io_resources)
> +			rtc->read = ds1685_read;
> +		else
> +			return -ENXIO;
> +
> +	/* Platform write function, else default if mmio setup */
> +	if (pdata->plat_write)
> +		rtc->write = pdata->plat_write;
> +	else
> +		if (pdata->alloc_io_resources)
> +			rtc->write = ds1685_write;
> +		else
> +			return -ENXIO;
> +
> +	/* Platform pre-shutdown function, if defined. */
> +	if (pdata->plat_prepare_poweroff)
> +		rtc->prepare_poweroff = pdata->plat_prepare_poweroff;
> +
> +	/* Platform wake_alarm function, if defined. */
> +	if (pdata->plat_wake_alarm)
> +		rtc->wake_alarm = pdata->plat_wake_alarm;
> +
> +	/* Platform post_ram_clear function, if defined. */
> +	if (pdata->plat_post_ram_clear)
> +		rtc->post_ram_clear = pdata->plat_post_ram_clear;
> +
> +	/* Init the spinlock, workqueue, & set the driver data. */
> +	spin_lock_init(&rtc->lock);
> +	INIT_WORK(&rtc->work, ds1685_rtc_work_queue);
> +	platform_set_drvdata(pdev, rtc);
>
> ...
>
