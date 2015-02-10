Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 03:59:40 +0100 (CET)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:53636 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013107AbbBJC7jZedaL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Feb 2015 03:59:39 +0100
Received: from resomta-ch2-08v.sys.comcast.net ([69.252.207.104])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id qSzZ1p0042Fh1PH01SzZgH; Tue, 10 Feb 2015 02:59:33 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-08v.sys.comcast.net with comcast
        id qSzX1p00C1duFqV01SzXEs; Tue, 10 Feb 2015 02:59:33 +0000
Message-ID: <54D9740D.5020009@gentoo.org>
Date:   Mon, 09 Feb 2015 21:59:25 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>,
        rtc-linux@googlegroups.com
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH 01/02 resend] RTC: Add driver for DS1685 family
 of real time clocks
References: <548B6892.9040200@gentoo.org> <20150209161844.942ff2d0ecd709a331083bac@linux-foundation.org>
In-Reply-To: <20150209161844.942ff2d0ecd709a331083bac@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1423537173;
        bh=hrkjApWjlsf7sSc3bjdWEeWH53c2rfvLKEJWTMHTKvQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=vu8e4+kna7IlwKJ4pBCiADcIa9TJHLLOI1SUG05NjpZ2JAxxBze6s2wLOCOxqza09
         xhwRE2JOyPSDWCLSKz0+0REFhAAzPkaxAT83O6RJCjLHxfFtvRAxG/u0AdG5n2chX3
         Mtcm4G/HpB+O5UUAfCgM/s0XHZ2sgUB8o6wv9z9iyBMw3ADgVe4K2AXCzi6vYFGq7Z
         jadoAOjnKrnjb4Gj1b/vl4SmERoJGxfpNrrOfj37R5chTVU7oQYYOZqFtcdpejdx55
         +WQE9B1U6gOuwdHKlEr449VeFIo4mwrkvTZim5jik4w+UbHxBQnf51sbGr3oZIkdKr
         SwI0/uyZ6+7zw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 02/09/2015 19:18, Andrew Morton wrote:
> On Fri, 12 Dec 2014 17:13:38 -0500 Joshua Kinard <kumba@gentoo.org> wrote:
> 
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> This adds a driver for the Dallas/Maxim DS1685-family of RTC chips.  It
>> supports the DS1685/DS1687, DS1688/DS1691, DS1689/DS1693, DS17285/DS17287,
>> DS17485/DS17487, and DS17885/DS17887 RTC chips.  These chips are commonly found
>> in SGI O2 and SGI Octane systems.  It was originally derived from a driver
>> patch submitted by Matthias Fuchs many years ago for use in EPPC-405-UC
>> modules, which also used these RTCs.  In addition to the time-keeping
>> functions, this RTC also handles the shutdown mechanism of the O2 and Octane
>> and acts as a partial NVRAM for the boot PROMS in these systems.
>>
>> Verified on both an SGI O2 and an SGI Octane.
>>
>> ...
>>
>> +static int
>> +ds1685_rtc_probe(struct platform_device *pdev)
>> +{
>> +	struct rtc_device *rtc_dev;
>> +	struct resource *res;
>> +	struct ds1685_priv *rtc;
>> +	struct ds1685_rtc_platform_data *pdata;
>> +	u8 ctrla, ctrlb, hours;
>> +	unsigned char am_pm;
>> +	int ret = 0;
>> +
>> +	/* Get the platform data. */
>> +	pdata = (struct ds1685_rtc_platform_data *) pdev->dev.platform_data;
> 
> That cast isn't needed.

Huh, I thought GCC complained about that once, but it doesn't now (gcc-4.7.4).
 Would you like me to remove it and re-send the patch, even though it looks
like you've added it to -mm?


>> +	if (!pdata)
>> +		return -ENODEV;
>> +
>> +	/* Allocate memory for the rtc device. */
>> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>> +	if (!rtc)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Allocate/setup any IORESOURCE_MEM resources, if required.  Not all
>> +	 * platforms put the RTC in an easy-access place.  Like the SGI Octane,
>> +	 * which attaches the RTC to a "ByteBus", hooked to a SuperIO chip
>> +	 * that sits behind the IOC3 PCI metadevice.
>> +	 */
>> +	if (pdata->alloc_io_resources) {
>> +		/* Get the platform resources. */
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +		if (!res)
>> +			return -ENXIO;
>> +		rtc->size = resource_size(res);
>> +
>> +		/* Request a memory region. */
>> +		/* XXX: mmio-only for now. */
>> +		if (!devm_request_mem_region(&pdev->dev, res->start, rtc->size,
>> +					     pdev->name))
>> +			return -EBUSY;
>> +
>> +		/*
>> +		 * Set the base address for the rtc, and ioremap its
>> +		 * registers.
>> +		 */
>> +		rtc->baseaddr = res->start;
>> +		rtc->regs = devm_ioremap(&pdev->dev, res->start, rtc->size);
>> +		if (!rtc->regs)
>> +			return -ENOMEM;
>> +	}
>> +	rtc->alloc_io_resources = pdata->alloc_io_resources;
>> +
>> +	/* Get the register step size. */
>> +	if (pdata->regstep > 0)
>> +		rtc->regstep = pdata->regstep;
>> +	else
>> +		rtc->regstep = 1;
>> +
>> +	/* Platform read function, else default if mmio setup */
>> +	if (pdata->plat_read)
>> +		rtc->read = pdata->plat_read;
> 
> I'm trying to understand how this works and I'm not getting very far. 
> Perhaps it is the intention that some code(?) is to allocate and
> populate a ds1685_rtc_platform_data and use platform_device_add_data()
> on it, but no such code exists.
> 
> Or something.  What's going on here?

Yeah, as you saw in the second patch, this is a mechanism to keep arch or
machine-specific code out of a general driver.  SGI O2's use MMIO to read/set
the RTC (which are the default methods in this patch), but SGI Octane's, whose
code is not in-tree yet, use this same RTC (DS1687-5) via PIO access because
the RTC is tucked behind the IOC3 PCI Metadevice's "ByteBus" (write an address
port, read a data port).  Thus, two different methods are needed by each
machine to talk to the same RTC driver, so this looked like the best approach,
after I looked at a few other drivers.


>> +	else
>> +		if (pdata->alloc_io_resources)
>> +			rtc->read = ds1685_read;
>> +		else
>> +			return -ENXIO;
>> +
>> +	/* Platform write function, else default if mmio setup */
>> +	if (pdata->plat_write)
>> +		rtc->write = pdata->plat_write;
>> +	else
>> +		if (pdata->alloc_io_resources)
>> +			rtc->write = ds1685_write;
>> +		else
>> +			return -ENXIO;
>> +
>> +	/* Platform pre-shutdown function, if defined. */
>> +	if (pdata->plat_prepare_poweroff)
>> +		rtc->prepare_poweroff = pdata->plat_prepare_poweroff;
>> +
>> +	/* Platform wake_alarm function, if defined. */
>> +	if (pdata->plat_wake_alarm)
>> +		rtc->wake_alarm = pdata->plat_wake_alarm;
>> +
>> +	/* Platform post_ram_clear function, if defined. */
>> +	if (pdata->plat_post_ram_clear)
>> +		rtc->post_ram_clear = pdata->plat_post_ram_clear;
>> +
>> +	/* Init the spinlock, workqueue, & set the driver data. */
>> +	spin_lock_init(&rtc->lock);
>> +	INIT_WORK(&rtc->work, ds1685_rtc_work_queue);
>> +	platform_set_drvdata(pdev, rtc);

--J
