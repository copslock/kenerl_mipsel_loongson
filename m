Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2015 17:31:43 +0200 (CEST)
Received: from kiutl.biot.com ([31.172.244.210]:60143 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011114AbbDJPbltb9rb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Apr 2015 17:31:41 +0200
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YgauC-0005yA-T0
        for linux-mips@linux-mips.org; Fri, 10 Apr 2015 17:31:42 +0200
Received: from [2a02:578:4a04:2a00::5]
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1Ygato-0005wb-A2; Fri, 10 Apr 2015 17:31:16 +0200
Message-ID: <5527ECC3.1000209@biot.com>
Date:   Fri, 10 Apr 2015 17:31:15 +0200
From:   Bert Vermeulen <bert@biot.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, jogo@openwrt.org
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
References: <1428285263-15135-1-git-send-email-bert@biot.com> <20150406163905.GL6023@sirena.org.uk> <5526EFA0.2010108@biot.com> <20150409215047.GE6023@sirena.org.uk>
In-Reply-To: <20150409215047.GE6023@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46853
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

On 04/09/2015 11:50 PM, Mark Brown wrote:
> On Thu, Apr 09, 2015 at 11:31:12PM +0200, Bert Vermeulen wrote:
>>  The m25p80-compatible boot flash and (some models) MMC use regular SPI,
>>  bitbanged as required by the SoC. However the SPI-connected CPLD has
>>  a "fast write" mode, in which two bits are transferred by SPI clock
>>  cycle. The second bit is transmitted with the SoC's CS2 pin.
> 
>>  Protocol drivers using this fast write facility signal this by setting
>>  the cs_change flag on transfers.
> 
>> The cs_change flag is used here instead of the openwrt version's
>> spi_transfer.fast_write flag. The CPLD driver sets this flag on a
>> per-transfer basis.
> 
> No, this is broken - it's abusing a standard API in a way that's
> completly incompatible with the meaning of that API which is obviously a
> very bad idea, especially since good practice is to offload the
> implementation of that standard API to the core.  It *sounds* like
> you're just trying to implement two wire mode which does have a standard
> API, please use that.

Can you please advise what kind of solution would be acceptable then? I need
to signal from an SPI protocol driver to an SPI master on a per-transfer basis.

Adding a flag to struct spi_transfer for this one driver, as openwrt does,
seems stupid -- I agree. And sure, using spi_transfer.cs_change is a little
dodgy. But I don't see a standard way to do it otherwise, and I don't really
want to keep trying things until you approve of one. So tell me how you
would do it, and I'll implement it that way. I just want to get this code in.

Also, I have no idea what you mean by two-wire mode. This "fast mode" is SPI
+ one extra pin.


-- 
Bert Vermeulen        bert@biot.com          email/xmpp
