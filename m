Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2015 23:31:45 +0200 (CEST)
Received: from kiutl.biot.com ([31.172.244.210]:58940 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010720AbbDIVboImlLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Apr 2015 23:31:44 +0200
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YgK36-0004Zs-MA
        for linux-mips@linux-mips.org; Thu, 09 Apr 2015 23:31:44 +0200
Received: from [2a02:578:4a04:2a00::5]
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YgK2d-0004Yb-Eo; Thu, 09 Apr 2015 23:31:15 +0200
Message-ID: <5526EFA0.2010108@biot.com>
Date:   Thu, 09 Apr 2015 23:31:12 +0200
From:   Bert Vermeulen <bert@biot.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, jogo@openwrt.org
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
References: <1428285263-15135-1-git-send-email-bert@biot.com> <20150406163905.GL6023@sirena.org.uk>
In-Reply-To: <20150406163905.GL6023@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46847
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

On 04/06/2015 06:39 PM, Mark Brown wrote:> On Mon, Apr 06, 2015 at
03:54:23AM +0200, Bert Vermeulen wrote:
>> +		if (spi->chip_select == 1 && t->cs_change) {
>> +			/* CPLD in bulk write mode gets two bits per clock */
>> +			do_spi_byte_fast(rbspi, spi_ioc, out);
>> +			/* Don't want the real CS toggled */
>> +			t->cs_change = 0;
>> +		} else {
>> +			do_spi_byte(rbspi, spi_ioc, out);
>> +		}
> 
> This is making very little sense to me and the fact that the driver is
> messing with cs_change is definitely buggy, it'll mean that repeated use
> of the same transfer will be broken.  What is the above code supposed to
> do, both with regard to selecting "fast" mode (why would you want slow
> mode?) and with regard to the chip select?
> 
> I queried this on a previous version and asked for the code to be better
> documented...

I documented it in the commit message:

 The m25p80-compatible boot flash and (some models) MMC use regular SPI,
 bitbanged as required by the SoC. However the SPI-connected CPLD has
 a "fast write" mode, in which two bits are transferred by SPI clock
 cycle. The second bit is transmitted with the SoC's CS2 pin.

 Protocol drivers using this fast write facility signal this by setting
 the cs_change flag on transfers.

The cs_change flag is used here instead of the openwrt version's
spi_transfer.fast_write flag. The CPLD driver sets this flag on a
per-transfer basis.

I wish I could tell you more about it, but I only know what I found in this
code.

>> +	ahb_clk = devm_clk_get(&pdev->dev, "ahb");
>> +	if (IS_ERR(ahb_clk))
>> +		return PTR_ERR(ahb_clk);
>> +
>> +	err = clk_prepare_enable(ahb_clk);
>> +	if (err)
>> +		return err;
> 
> There's no error handling (or indeed any other code) disabling the
> clock, probably this enable should happen later and those disables
> definitely need adding.  I'd also expect to see runtime PM to keep the
> clock disabled when the controller isn't in use in order to save power.

No problem disabling the clock on error/remove, but PM doesn't seem worth
doing in this case -- the ath79 platform's clock enable/disable are just
dummy functions. The ar7100 series SoCs have no power management, it seems.

I have a patch addressing all your other comments.


-- 
Bert Vermeulen        bert@biot.com          email/xmpp
