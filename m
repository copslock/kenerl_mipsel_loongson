Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 22:55:47 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59238 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492381Ab0F3Uzm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jun 2010 22:55:42 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o5UKtQk7031201
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 30 Jun 2010 13:55:27 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id o5UKtPVJ025854;
        Wed, 30 Jun 2010 13:55:26 -0700
Date:   Wed, 30 Jun 2010 13:55:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Matt Fleming <matt@console-pimps.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3] MMC: Add JZ4740 mmc driver
Message-Id: <20100630135525.1f6a9704.akpm@linux-foundation.org>
In-Reply-To: <1277688041-23522-1-git-send-email-lars@metafoo.de>
References: <1276924111-11158-19-git-send-email-lars@metafoo.de>
        <1277688041-23522-1-git-send-email-lars@metafoo.de>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
X-archive-position: 27289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20580

On Mon, 28 Jun 2010 03:20:41 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> This patch adds support for the mmc controller on JZ4740 SoCs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: linux-mmc@vger.kernel.org
>
> ...
>
> +#define JZ4740_MMC_MAX_TIMEOUT 10000000

That was a really big timeout.  How long do 1e7 readw's take?  Oh well.

>
> ...
>
> +static void jz4740_mmc_clock_disable(struct jz4740_mmc_host *host)
> +{
> +	uint32_t status;
> +
> +	writew(JZ_MMC_STRPCL_CLOCK_STOP, host->base + JZ_REG_MMC_STRPCL);
> +	do {
> +		status = readl(host->base + JZ_REG_MMC_STATUS);
> +	} while (status & JZ_MMC_STATUS_CLK_EN);
> +}
> +
> +static void jz4740_mmc_reset(struct jz4740_mmc_host *host)
> +{
> +	uint32_t status;
> +
> +	writew(JZ_MMC_STRPCL_RESET, host->base + JZ_REG_MMC_STRPCL);
> +	udelay(10);
> +	do {
> +		status = readl(host->base + JZ_REG_MMC_STATUS);
> +	} while (status & JZ_MMC_STATUS_IS_RESETTING);
> +}

Maybe these should have a timeout too?

>
> ...
>
> +static inline unsigned int jz4740_mmc_wait_irq(struct jz4740_mmc_host *host,
> +	unsigned int irq)
> +{
> +	unsigned int timeout = JZ4740_MMC_MAX_TIMEOUT;
> +	uint16_t status;
> +
> +	do {
> +		status = readw(host->base + JZ_REG_MMC_IREG);
> +	} while (!(status & irq) && --timeout);
> +
> +	return timeout;
> +}

This guy's too big to inline.  Recent gcc's know that and they tend to
uninline such things behind your back anwyay.

>
> ...
>
> +struct jz4740_mmc_platform_data {
> +	int gpio_power;
> +	int gpio_card_detect;
> +	int gpio_read_only;
> +	unsigned card_detect_active_low:1;
> +	unsigned read_only_active_low:1;
> +	unsigned power_active_low:1;
> +
> +	unsigned data_1bit:1;
> +};

The bitfields will all share the same word, so modification of one
field can race against modification of another field.  Hence some form
of locking which covers *all* the bitfields is needed.

Is that a problem in this driver?
