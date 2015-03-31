Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 20:41:48 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:33127 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009059AbbCaSlqksl28 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 20:41:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E4D3728C95E;
        Tue, 31 Mar 2015 20:41:04 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com [209.85.192.42])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 55DD428C95D;
        Tue, 31 Mar 2015 20:41:02 +0200 (CEST)
Received: by qgfa8 with SMTP id a8so22863479qgf.0;
        Tue, 31 Mar 2015 11:41:40 -0700 (PDT)
X-Received: by 10.140.150.131 with SMTP id 125mr52333713qhw.55.1427827300774;
 Tue, 31 Mar 2015 11:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.42.229 with HTTP; Tue, 31 Mar 2015 11:41:20 -0700 (PDT)
In-Reply-To: <1427819134-29128-1-git-send-email-bert@biot.com>
References: <1427819134-29128-1-git-send-email-bert@biot.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 31 Mar 2015 20:41:20 +0200
Message-ID: <CAOiHx=krTV-NKPD-C1jMhyjmz8qWuLmBWQVwSYGqmaFyq96QWg@mail.gmail.com>
Subject: Re: [PATCH v4] spi: Add SPI driver for Mikrotik RB4xx series boards
To:     Bert Vermeulen <bert@biot.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, andy.shevchenko@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On Tue, Mar 31, 2015 at 6:25 PM, Bert Vermeulen <bert@biot.com> wrote:
> This driver mediates access between the connected CPLD and other devices
> on the bus.
>
> The m25p80-compatible boot flash and (some models) MMC use regular SPI,
> bitbanged as required by the SoC. However the SPI-connected CPLD has
> a "fast write" mode, in which two bits are transferred by SPI clock
> cycle. The second bit is transmitted with the SoC's CS2 pin.
>
> Protocol drivers using this fast write facility signal this by setting
> the cs_change flag on transfers.
>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  drivers/spi/Kconfig     |   6 ++
>  drivers/spi/Makefile    |   1 +
>  drivers/spi/spi-rb4xx.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/spi/spi-rb4xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ab8dfbe..aa76ce5 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -429,6 +429,12 @@ config SPI_ROCKCHIP
>           The main usecase of this controller is to use spi flash as boot
>           device.
>
> +config SPI_RB4XX
> +       tristate "Mikrotik RB4XX SPI master"
> +       depends on SPI_MASTER && ATH79_MACH_RB4XX

There is no ATH79_MACH_RB4XX in upstream. I suggest depending on just
ATH79, allowing maintainers/patch submitters to at least test build
any future modifications on it.


Regards
Jonas
