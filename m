Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2010 17:46:42 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:43037 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491968Ab0GAPqf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jul 2010 17:46:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 4D04F65A;
        Thu,  1 Jul 2010 17:46:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WPN4xNeURDIx; Thu,  1 Jul 2010 17:46:29 +0200 (CEST)
Received: from [172.31.16.228] (d079168.adsl.hansenet.de [80.171.79.168])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 561A4657;
        Thu,  1 Jul 2010 17:46:18 +0200 (CEST)
Message-ID: <4C2CB835.5010106@metafoo.de>
Date:   Thu, 01 Jul 2010 17:45:57 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Matt Fleming <matt@console-pimps.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3] MMC: Add JZ4740 mmc driver
References: <1276924111-11158-19-git-send-email-lars@metafoo.de>        <1277688041-23522-1-git-send-email-lars@metafoo.de> <20100630135525.1f6a9704.akpm@linux-foundation.org>
In-Reply-To: <20100630135525.1f6a9704.akpm@linux-foundation.org>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

Andrew Morton wrote:
> On Mon, 28 Jun 2010 03:20:41 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> This patch adds support for the mmc controller on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matt Fleming <matt@console-pimps.org>
>> Cc: linux-mmc@vger.kernel.org
>>
>> ...
>>
>> +#define JZ4740_MMC_MAX_TIMEOUT 10000000
> 
> That was a really big timeout.  How long do 1e7 readw's take?  Oh well.
> 

Hm, right. It doesn't hurt though. I'll do some tests and to try to come up with a
more realistic value.

>> ...
>>
>> +static void jz4740_mmc_clock_disable(struct jz4740_mmc_host *host)
>> +{
>> +	uint32_t status;
>> +
>> +	writew(JZ_MMC_STRPCL_CLOCK_STOP, host->base + JZ_REG_MMC_STRPCL);
>> +	do {
>> +		status = readl(host->base + JZ_REG_MMC_STATUS);
>> +	} while (status & JZ_MMC_STATUS_CLK_EN);
>> +}
>> +
>> +static void jz4740_mmc_reset(struct jz4740_mmc_host *host)
>> +{
>> +	uint32_t status;
>> +
>> +	writew(JZ_MMC_STRPCL_RESET, host->base + JZ_REG_MMC_STRPCL);
>> +	udelay(10);
>> +	do {
>> +		status = readl(host->base + JZ_REG_MMC_STATUS);
>> +	} while (status & JZ_MMC_STATUS_IS_RESETTING);
>> +}
> 
> Maybe these should have a timeout too?

Its very unlikely that these will ever timeout. But right, to be on the safe, there
should be a timeout as well.

> 
>> ...
>>
>> +static inline unsigned int jz4740_mmc_wait_irq(struct jz4740_mmc_host *host,
>> +	unsigned int irq)
>> +{
>> +	unsigned int timeout = JZ4740_MMC_MAX_TIMEOUT;
>> +	uint16_t status;
>> +
>> +	do {
>> +		status = readw(host->base + JZ_REG_MMC_IREG);
>> +	} while (!(status & irq) && --timeout);
>> +
>> +	return timeout;
>> +}
> 
> This guy's too big to inline.  Recent gcc's know that and they tend to
> uninline such things behind your back anwyay.

Actually, even without the inline attribute and compiling with -Os gcc will inline
this function by itself.

> 
>> ...
>>
>> +struct jz4740_mmc_platform_data {
>> +	int gpio_power;
>> +	int gpio_card_detect;
>> +	int gpio_read_only;
>> +	unsigned card_detect_active_low:1;
>> +	unsigned read_only_active_low:1;
>> +	unsigned power_active_low:1;
>> +
>> +	unsigned data_1bit:1;
>> +};
> 
> The bitfields will all share the same word, so modification of one
> field can race against modification of another field.  Hence some form
> of locking which covers *all* the bitfields is needed.
> 
> Is that a problem in this driver?
> 
They are all read-only in the driver.


Thanks for reviewing the patch
- - Lars

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkwsuDQACgkQBX4mSR26RiOiMACeMMNj4koCYFAUnxyM0LBr+wOZ
x6oAnizk5CaAvZjQ2doXrD6ZYgDeNjSr
=92D2
-----END PGP SIGNATURE-----
