Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Aug 2013 20:51:06 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48871 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6828015Ab3HMSuzqCXN0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Aug 2013 20:50:55 +0200
Message-ID: <520A7E67.1060604@openwrt.org>
Date:   Tue, 13 Aug 2013 20:43:51 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     Gabor Juhos <juhosg@openwrt.org>, linux-spi@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] SPI: ralink: add Ralink SoC spi driver
References: <1376074288-29302-1-git-send-email-blogic@openwrt.org> <1376074288-29302-2-git-send-email-blogic@openwrt.org> <20130811132642.GB6427@sirena.org.uk>
In-Reply-To: <20130811132642.GB6427@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi Mark,

Thanks for the review, I will send a V2 tomorrow, I want to verify my 
changes on real HW first.

a few comments inline ...

> There is presumably a maximum transfer size here from the FIFO that is
> holding the data?
The hardware is not running in DMA/IRQ mode and hence it can only 
read/write 1 byte at a time.

> Set min_speed_hz in the spi_master and the core will check this for you.

it seems that min_speed is not handled by the core yet. I saw several 
drivers do minimum speed testing. I am leaving this code in the driver 
until there is a generic minimum speed check
> clk_prepare_enable(), and it'd be nice to use runtime PM and enable the
> clock only when doing transfers though that's not essential.
>

The clock is free running and always running.

     John
