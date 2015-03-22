Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Mar 2015 12:25:31 +0100 (CET)
Received: from kiutl.biot.com ([31.172.244.210]:57090 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006513AbbCVLZaUPJdF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Mar 2015 12:25:30 +0100
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YZe0Y-0002Dn-HE
        for linux-mips@linux-mips.org; Sun, 22 Mar 2015 12:25:30 +0100
Received: from [2a02:578:4a04:2a00::5]
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YZe0T-0002DQ-AE; Sun, 22 Mar 2015 12:25:25 +0100
Message-ID: <550EA6A4.6010206@biot.com>
Date:   Sun, 22 Mar 2015 12:25:24 +0100
From:   Bert Vermeulen <bert@biot.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
References: <1426853793-24454-1-git-send-email-bert@biot.com> <1426853793-24454-2-git-send-email-bert@biot.com> <20150320125139.GJ2869@sirena.org.uk>
In-Reply-To: <20150320125139.GJ2869@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bert@biot.com
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

On 03/20/2015 01:51 PM, Mark Brown wrote:

Mark,

Thanks very much for your detailed review. I'll fix things according to your
comments. However...

> On Fri, Mar 20, 2015 at 01:16:32PM +0100, Bert Vermeulen wrote:
>> +static void do_spi_byte(void __iomem *base, unsigned char byte)
>> +{
>> +	do_spi_clk(base, byte >> 7);
>> +	do_spi_clk(base, byte >> 6);
>> +	do_spi_clk(base, byte >> 5);
>> +	do_spi_clk(base, byte >> 4);
>> +	do_spi_clk(base, byte >> 3);
>> +	do_spi_clk(base, byte >> 2);
>> +	do_spi_clk(base, byte >> 1);
>> +	do_spi_clk(base, byte);
> 
> This looks awfully like it's bitbanging the value out, can we not use
> spi-bitbang here?
> 

[...]

>> +static inline void do_spi_clk_fast(void __iomem *base, unsigned bit1,
>> +				   unsigned bit2)
> 
> Why would we ever want the slow version?

It is bitbanging, at least on write. The hardware has a shift register that
is uses for reads. The generic spi for this board's architecture (ath79)
indeed uses spi-bitbang.

This "fast SPI" thing is what makes this one different: the boot flash and
MMC use regular SPI on the same bus as the CPLD. This CPLD needs this fast
SPI: a mode where it shifts in two bits per clock. The second bit is
apparently sent via the CS2 pin.

So I don't think spi-bitbang will do. I need to see about reworking things
to use less custom queueing -- I'm not that familiar with this yet.


-- 
Bert Vermeulen        bert@biot.com          email/xmpp
