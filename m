Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2018 19:17:58 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3]:59622
        "EHLO bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992096AbeCZRRsXRL9w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2018 19:17:48 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id F1A5C26017A
Message-ID: <1522084610.31319.2.camel@collabora.com>
Subject: Re: [PATCH v3 00/14] Enable SD/MMC on JZ4780 SoCs
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        Mathieu Malaterre <malat@debian.org>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Mon, 26 Mar 2018 14:16:50 -0300
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.com
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

Hi Ulf,

On Wed, 2018-03-21 at 16:27 -0300, Ezequiel Garcia wrote:
> From: Ezequiel Garcia <ezequiel@collabora.co.uk>
> 
> This patchset adds support for SD/MMC on JZ4780 based
> platforms, such as the MIPS Creator CI20 board.
> 
> Most of the work has been done by Alex, Paul and Zubair,
> while I've only prepared the upstream submission, cleaned
> some patches, and written some commit logs where needed.
> 
> All praises should go to them, all rants to me.
> 
> The series is based on v4.16-rc4.
> 
> Changes from v2:
>   * Fix commit log in "mmc: dt-bindings: add MMC support to JZ4740
> SoC"
> 
> Changes from v1:
>   * Reordered patches, fixes first, for easier backporting.
>   * Added Link and Fixes tags to patch "Fix race condition",
>     for easier backporting.
>   * Enabled the DMA in the dtsi for jz4780, dropped it from the ci20
> dts.
>   * Reworded config and help user visible text.
>   * Reworded commit logs, using imperative.
>   * Re-authored my patches, as Collabora is partially
>     sponsoring them.
> 
> 
> Alex Smith (3):
>   mmc: jz4740: Fix race condition in IRQ mask update
>   mmc: jz4740: Set clock rate to mmc->f_max rather than
> JZ_MMC_CLK_RATE
>   mmc: jz4740: Add support for the JZ4780
> 
> Ezequiel Garcia (9):
>   mmc: jz4780: Order headers alphabetically
>   mmc: jz4740: Use dev_get_platdata
>   mmc: jz4740: Introduce devicetree probe
>   mmc: dt-bindings: add MMC support to JZ4740 SoC
>   mmc: jz4740: Use dma_request_chan()
>   MIPS: dts: jz4780: Add DMA controller node to the devicetree
>   MIPS: dts: jz4780: Add MMC controller node to the devicetree
>   MIPS: dts: ci20: Enable MMC in the devicetree
>   MIPS: configs: ci20: Enable DMA and MMC support
> 
> Paul Cercueil (1):
>   mmc: jz4740: Fix error exit path in driver's probe
> 
> Zubair Lutfullah Kakakhel (1):
>   mmc: jz4740: Reset the device requesting the interrupt
> 
>  Documentation/devicetree/bindings/mmc/jz4740.txt |  38 ++++
>  arch/mips/boot/dts/ingenic/ci20.dts              |  34 ++++
>  arch/mips/boot/dts/ingenic/jz4780.dtsi           |  52 +++++
>  arch/mips/configs/ci20_defconfig                 |   3 +
>  drivers/mmc/host/Kconfig                         |   9 +-
>  drivers/mmc/host/jz4740_mmc.c                    | 230
> ++++++++++++++++-------
>  include/dt-bindings/dma/jz4780-dma.h             |  49 +++++
>  7 files changed, 345 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt
>  create mode 100644 include/dt-bindings/dma/jz4780-dma.h
> 

Any chance this gets queued for 4.17 ?

Thanks,
Eze
