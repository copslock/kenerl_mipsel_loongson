Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2010 01:46:10 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:39004 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492023Ab0GLXqH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jul 2010 01:46:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 518145EB;
        Tue, 13 Jul 2010 01:46:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id baup628Yss45; Tue, 13 Jul 2010 01:45:59 +0200 (CEST)
Received: from [172.31.16.228] (d043121.adsl.hansenet.de [80.171.43.121])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id A47EC5EA;
        Tue, 13 Jul 2010 01:45:58 +0200 (CEST)
Message-ID: <4C3BA927.3040307@metafoo.de>
Date:   Tue, 13 Jul 2010 01:45:43 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Fleming <matt@console-pimps.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v5] MMC: Add JZ4740 mmc driver
References: <1278970413-21617-1-git-send-email-lars@metafoo.de>         <1278973245-25451-1-git-send-email-lars@metafoo.de> <1278974710.1501.317.camel@Joe-Laptop.home>
In-Reply-To: <1278974710.1501.317.camel@Joe-Laptop.home>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Hi

Joe Perches wrote:
> On Tue, 2010-07-13 at 00:20 +0200, Lars-Peter Clausen wrote:
>> This patch adds support for the mmc controller on JZ4740 SoCs.
>> +static bool jz4740_mmc_write_data(struct jz4740_mmc_host *host,
>> +	struct mmc_data *data)
>> +{
>> +	struct sg_mapping_iter *miter = &host->miter;
>> +	uint32_t *buf;
>> +	bool timeout;
>> +	size_t i, j;
>> +
>> +	while (sg_miter_next(miter)) {
>> +		buf = miter->addr;
>> +		i = miter->length / 4;
>> +		j = i / 8;
>> +		i = i & 0x7;
>> +		while (j) {
>> +			timeout = jz4740_mmc_poll_irq(host, JZ_MMC_IRQ_TXFIFO_WR_REQ);
>> +			if (unlikely(timeout))
>> +				goto poll_timeout;
>> +
>> +			writel(buf[0], host->base + JZ_REG_MMC_TXFIFO);
> 
> Perhaps it'd be better to use a temporary for
> host->base + JZ_REG_MMC_TXFIFO
Hm, indeed host->addr is reloaded before each write.
> 
>> +			writel(buf[1], host->base + JZ_REG_MMC_TXFIFO);
>> +			writel(buf[2], host->base + JZ_REG_MMC_TXFIFO);
>> +			writel(buf[3], host->base + JZ_REG_MMC_TXFIFO);
>> +			writel(buf[4], host->base + JZ_REG_MMC_TXFIFO);
>> +			writel(buf[5], host->base + JZ_REG_MMC_TXFIFO);
>> +			writel(buf[6], host->base + JZ_REG_MMC_TXFIFO);
>> +			writel(buf[7], host->base + JZ_REG_MMC_TXFIFO);
>> +			buf += 8;
>> +			--j;
>> +		}
>> +		if (unlikely(i)) {
>> +			timeout = jz4740_mmc_poll_irq(host, JZ_MMC_IRQ_TXFIFO_WR_REQ);
>> +			if (unlikely(timeout))
>> +				goto poll_timeout;
>> +
>> +			while (i) {
>> +				writel(*buf, host->base + JZ_REG_MMC_TXFIFO);
>> +				++buf;
>> +				--i;
>> +			}
>> +		}
>> +		data->bytes_xfered += miter->length;
>> +	}
>  
> 

Thanks for reviewing
- Lars
