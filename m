Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 01:45:33 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:26468 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011594AbbHEXpbmTJg1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 01:45:31 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSM001KGVBNRA00@mailout3.w1.samsung.com>; Thu,
 06 Aug 2015 00:45:23 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-05-55c2a01340f7
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id B8.61.05269.310A2C55; Thu,
 6 Aug 2015 00:45:23 +0100 (BST)
Received: from [0.0.0.0] ([106.116.37.23])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NSM00GIBVB0S900@eusync2.samsung.com>; Thu,
 06 Aug 2015 00:45:22 +0100 (BST)
Message-id: <55C2A001.2090506@samsung.com>
Date:   Thu, 06 Aug 2015 08:45:05 +0900
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.8.0
MIME-version: 1.0
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Seungwon Jeon <tgih.jun@samsung.com>
Cc:     dianders@chromium.org, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Stefan Agner <stefan@agner.ch>,
        Zhou Wang <wangzhou.bry@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Wang Long <long.wanglong@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Jun Nie <jun.nie@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hao <haokexin@gmail.com>,
        Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-samsung-soc@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vineet Gupta <vgupta@synopsys.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH v3 0/5]
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SYUxbZRSG/Xrv/e6ls/FSYN4MnUt1iSEZyrboiRqc0ywfiUt0kajEbKvs
        CkRgTTuWzV9EGC6VjQ1EWGEFhEKxhUEbFgZuy7rSohtIV0cRRyltER2UKg5bmQwpZHH/3nPO
        877vn8NR8m/wJi6v8IioLlTmK7CUvvHA+dO2hEZb5ouBLhbaw8sISm5Ps9C6EpFAiUUDJ0eb
        JeDTX8SwXOlgIdxajmB0vAFDg32YgaHWaxgq5poYOF9XiSA67aXBMeNjYMU/y8Dw3XYEA/dV
        YJhYwDC2VMZAS3CKhdnf0qAiMEvB4nUjgrkpKwJLYJQBd189hjPVlSzYVyoQLPhWKKj98YoE
        OrvHWfjFLQO724yg3zOMwOBxSWCyOYLgB89fq66aDhq6ah/QEDCGWLj13XMwfc6K4cRlOwvR
        m1/SMG8KIrgTvMBAjTPEQJnDwYC18wsWxmpKGfhj0kXB6Y5bGLqq+le7zlYhcHa8D7YePw1t
        +u1wZcGAINQ4wMLvfw7SEBz4ioKfzSPsrtdJc8RLEbPejEhpSTkm95cqEdFNDmFSV+yiifv0
        KQlZnvHQpHeiBZG+S/UMCVpciJwd2kYu6SZY0t52D5PA+W6WlNpDzDtbsqSvHRLz846K6hfS
        D0pz/VE/q/JuPTbztxsXo7FkLeI4gd8pmKpf0qK4VblRGPFewFok5eS8AQn6oX/R+nAPCf9c
        1OMYJeNThB7vKRwz0/xW4eueHbE15ncI1raWNSSJ/0BoM32P1vF4IVrlpWM5ibweCdoT5Wuh
        FO+PF67OG9eoBP4ZoX+wk41pOU+E8evBtaQ4PkMw1t2QxMooPlWYdKXE1tQqbjWHqDOI1z3S
        ofuf0j1CNSLqW5QkFmWrNB/nFGxP1SgLNEWFOanZhwssaP1zF3uRwfGKDfEcUjwuI3uuZcoZ
        5VHN8QIbEjhKkSgLn7RlymWHlMc/E9WHD6iL8kWNDSVztOJJ2bm+8HtyPkd5RPxUFFWi+uFV
        wsVtKkZ767l9l3d253qVT/gjlufpvZ8s4gZfU2thxlSyM7qhb6nTk9e0uTzt5Ve19XcSnBUb
        pW/2LOd+1N01nx7OMZqyPpRVD+4Lzd+dub0l/a1nj3k2j+wXy+KT3oWr1puR/t5f58jnb9SO
        +bN2k6d7d2U/5fM07MnYkGjaH2p/7G1VyRJS0JpcZVoKpdYo/wOIEPJltQMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 05.08.2015 17:16, Shawn Lin wrote:
> Synopsys DesignWare mobile storage host controller supports three
> types of transfer mode: pio, internal dma and external dma. However,
> dw_mmc can only supports pio and internal dma now. Thus some platforms
> using dw-mshc integrated with generic dma can't work in dma mode. So we
> submit this patch to achieve it.
> 
> And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
> (commit:f95f3850) for the first version of dw_mmc and never be touched from
> then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
> we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
> time. Nowadays, device-tree helps us to support a variety of boards with one
> kernel. That's why we need to remove it and decide the transfer mode at runtime.
> 
> This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
> to make the running.
> 
> Patch does the following things:
> - remove CONFIG_MMC_DW_IDMAC config option
> - add bindings for idmac and edmac used by synopsys-dw-mshc
>   at runtime
> - add edmac support for synopsys-dw-mshc
> 
> Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc
> 
> 
> Changes in v3:
> - choose transfer mode at runtime
> - remove all CONFIG_MMC_DW_IDMAC config option
> - add supports-idmac property for some platforms
> 
> Changes in v2:
> - Fix typo of dev_info msg
> - remove unused dmach from declaration of dw_mci_dma_slave
> 
> Shawn Lin (5):
>   mmc: dw_mmc: Add external dma interface support
>   Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>   arm: configs: remove CONFIG_MMC_DW_IDMAC
>   mips: configs: remove CONFIG_MMC_DW_IDMAC
>   ARM: dts: add supports-idmac property

Please fix the title of cover letter.

You CC-ed a lot of people. Probably the whole output of git_maintainers
which is not necessary. This means that your patches did not reach some
of the mailing lists because of too many recipients. I received your
patchset but I can't find it on any of the lists I subscribe.

Please CC only REAL maintainers, not committers.

Additionally if DTS changes do not have to be introduced atomically
please split it per sub-architecture. Of course that applies only in
case of bisectable patches. And the patchset should preserve
bisectability and backward compatibility (mentioned earlier).

Best regards,
Krzysztof


> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  41 +++
>  arch/arc/configs/axs101_defconfig                  |   1 -
>  arch/arc/configs/axs103_defconfig                  |   1 -
>  arch/arc/configs/axs103_smp_defconfig              |   1 -
>  arch/arm/boot/dts/exynos3250-monk.dts              |   1 +
>  arch/arm/boot/dts/exynos3250-rinato.dts            |   1 +
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>  arch/arm/boot/dts/exynos4412-origen.dts            |   1 +
>  arch/arm/boot/dts/exynos4412-trats2.dts            |   1 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   1 +
>  arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +
>  arch/arm/boot/dts/exynos5250-snow.dts              |   3 +
>  arch/arm/boot/dts/exynos5250-spring.dts            |   2 +
>  arch/arm/boot/dts/exynos5260-xyref5260.dts         |   2 +
>  arch/arm/boot/dts/exynos5410-smdk5410.dts          |   2 +
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   2 +
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |   3 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   2 +
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   2 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |   3 +
>  arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   2 +
>  arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +
>  arch/arm/boot/dts/rk3288-firefly.dtsi              |   3 +
>  arch/arm/boot/dts/rk3288-popmetal.dts              |   2 +
>  arch/arm/configs/exynos_defconfig                  |   1 -
>  arch/arm/configs/hisi_defconfig                    |   1 -
>  arch/arm/configs/lpc18xx_defconfig                 |   1 -
>  arch/arm/configs/multi_v7_defconfig                |   1 -
>  arch/arm/configs/zx_defconfig                      |   1 -
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   2 +
>  arch/mips/configs/pistachio_defconfig              |   1 -
>  drivers/mmc/host/Kconfig                           |  11 +-
>  drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
>  drivers/mmc/host/dw_mmc.c                          | 277 +++++++++++++++++----
>  include/linux/mmc/dw_mmc.h                         |  28 ++-
>  36 files changed, 338 insertions(+), 72 deletions(-)
> 
