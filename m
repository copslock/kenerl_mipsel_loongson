Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 12:05:22 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:47825 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22724711AbYJ3MFM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 12:05:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9UC5BJN012465;
	Thu, 30 Oct 2008 12:05:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9UC5BLV012464;
	Thu, 30 Oct 2008 12:05:11 GMT
Date:	Thu, 30 Oct 2008 12:05:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tiejun Chen <tiejun.chen@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Support RTC on Malta
Message-ID: <20081030120510.GH26256@linux-mips.org>
References: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 30, 2008 at 07:15:44PM +0800, Tiejun Chen wrote:

Looks reasonable but I have a few comments:

> diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
> index cef2db8..26284fc 100644
> --- a/arch/mips/mti-malta/Makefile
> +++ b/arch/mips/mti-malta/Makefile
> @@ -9,7 +9,7 @@ obj-y				:= malta-amon.o malta-cmdline.o \
>  				   malta-display.o malta-init.o malta-int.o \
>  				   malta-memory.o malta-mtd.o \
>  				   malta-platform.o malta-reset.o \
> -				   malta-setup.o malta-time.o
> +				   malta-setup.o malta-time.o malta-rtc.o

Could you please fold malta-rtc.c into the existing malta-platform.c instead
of creating a new file?

> +++ b/arch/mips/mti-malta/malta-rtc.c
> @@ -0,0 +1,73 @@

> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc("rtc_cmos", -1);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	ret = platform_device_add_resources(pdev, malta_platform_rtc_resource,
> +	                                       ARRAY_SIZE(malta_platform_rtc_resource));
> +	if (ret)
> +		goto err;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto err;

You can simplify this a bit by using a static struct platform_device like:

static struct platform_device rtc_device = {
        .name                   = "rtc_cmos",
        .id                     = -1,
	.resource		= &malta_platform_rtc_resource,
	.num_resources		= ARRAY_SIZE(malta_platform_rtc_resource),
};

> +
> +	/* Try setting rtc as BCD mode to support
> +	 * current alarm code if possible.
> +	 */
> +	if (!RTC_ALWAYS_BCD)
> +		CMOS_WRITE(CMOS_READ(RTC_CONTROL) & ~RTC_DM_BINARY, RTC_CONTROL);

RTC_ALWAYS_BCD is 0, so the if condition is always true and the if can be
eleminated.

Can you fix that?

  Ralf
