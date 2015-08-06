Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 03:47:33 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:47095 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012535AbbHFBrbIDcKQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 03:47:31 +0200
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN01R3Q0YYH500@mailout2.samsung.com>; Thu,
 06 Aug 2015 10:47:22 +0900 (KST)
Received: from epcpsbgm2new.samsung.com ( [172.20.52.113])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id 0F.BF.28411.AACB2C55; Thu,
 6 Aug 2015 10:47:22 +0900 (KST)
X-AuditID: cbfee68e-f79c56d000006efb-16-55c2bcaae64d
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2new.samsung.com (EPCPMTA) with SMTP id 68.66.07062.9ACB2C55; Thu,
 6 Aug 2015 10:47:22 +0900 (KST)
Received: from [10.252.81.186] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NSN004JU0YXY060@mmp1.samsung.com>; Thu,
 06 Aug 2015 10:47:21 +0900 (KST)
Message-id: <55C2BCA9.5080202@samsung.com>
Date:   Thu, 06 Aug 2015 10:47:21 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
MIME-version: 1.0
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        CPGS <cpgs@samsung.com>
Subject: Re: [RFC PATCH v3 0/5]
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <55C2A001.2090506@samsung.com> <55C2AE1C.7080502@rock-chips.com>
In-reply-to: <55C2AE1C.7080502@rock-chips.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0yTVxjO6Xcr3Ug+UNwZZoGQ6TIdVRDYu0CMyX7sW8ySJYuX7A8UaMAM
        sLZgRrY4FpgydVwKC6wiMJG2sAKl1QmCWLpSiNhOaOTiZlt6URgUHCqXEeha6zL/PTnP9STn
        8InIR3Q0/0RBoVhaIMqLowWkZnvSqfj2fuOR/drF3dC2tImg9L6XAaV/lQelOhmUT7TwwNn4
        Kw2bcjMDS8qLCCYeNNEwZ3wXmkxWCizKQRoqF36m4PIlOYI1r50E82MnBX7XPAXWv9oQDG1I
        4KpnhoH52QSodM8T8Pw3NYKFGT0CnXuCAtvNBhqqfpQzYPJXIlh2+gmo/32AB53dDxj4wxYO
        JpsGQd+kFUHr5BgPHC2rCO5MPg246jpI0NZvkeBW+xgY738bvD/pafjulomBtbsXSFj8xYPg
        T08XBXXDPgrOms0U6DvPMTBVV0bBE8cYARUd4zRoa/oCXdU1CIY7joHxuosEVWMiDCy3IvA1
        DzEw9/cICZ6hWgKmNfeYQwe5llU7wWkaNYgrK71Icxv/yBGncFho7lLJGMnZKn7gcZuPJ0mu
        5+FVxN3sbaA4j24McdWWeK5X8ZDh2lTPaM59uZvhykw+6tPYzwVp2eK8E6fF0n0HMwS55TdU
        jOTZ3i+dK9eYEmSOPY/C+JhNwt0LDhTCO/A9exd9Hgn4kawa4dm+O+R/os6udV6IaEV4ddz1
        UuVE2K/qf6EKZ/dg74KcF8Qkuwvrl27TQUyz7+EbK8MvzqPYo/hufflLfQReq7GTwaDtrArh
        BmsvFSQIdioC97hSgngbG4P7RjqZUNsFhJdvzxBBIowV4tFBd6CBHzC8g2tr80PeGKzX+Iig
        HrNVr2Hz3BU6tIjFKzVGMqjH7FtYZyBCV3sTD6qnyCq0Q/HKJsX/qYpXUpsR0Y6ixJIsiSwz
        R5oolInyZUUFOcKsk/k6FHj+o1uPKnrQtCHViFg+ins93KkxHomkRKdlxflGlBwYUU1ER2Wd
        DPyYgsL0hAMpiZCclHwg8f0PUuLeCM+IXv8sks0RFYq/EIslYmm6tChPLDMiHj8sugQRbmW7
        7/7OLvuKsGl+ZxjZbCj6MEL8yYhg+Nb094c8+59fqU/NtmVLrX5nfKbStXE827B1LCXzo0yh
        c5/qeovdrfh6dpcnzfuNioqV8dvO5KapLKZtT7WHm4q//firU91z5+KPD5yRnV03WKYcjHRg
        NEOt7Ul/slic2knsPgwxcaQsV5Swh5DKRP8Ct8Plu/kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xbZRjG8/XcClJz6MZ2ZCaQymKcFmjH5SURMGrmSWQLmUOXRcUjnAAZ
        LdjCdP4zIqjI2LgaLmOMyaVjK7d2bNy2ZQUK4TagGSAKFMplEyoO2UAIYAubLvr99X7P+/ze
        J/m+vEJMrKdchTHKBF6l5GIlpCPevWmhpVdbDGHevSYGKhc3ECTfn6GgYmtFAMk6NaQOlQrA
        XHyDhI1sIwWLFekIhkYvkfDQ8BpcausjoLfiLgkZC5cJuHghG8HqzDgOxjkzAVtT8wT0/VaJ
        oH09HsqmJymYfyCDDMs8Bo9bryBYmNQj0FmGCDA1FZGQ+WM2BW1bGQiWzFsY5N+7LYDqulEK
        fjGJoM2kRdA83IegfHhAABOlKwi6hv+0UXlVONTmb+JguWKlYLDFA2YK9CR8e6uNgtWeszj8
        fm0awa/TNQTkdVgJ+M5oJEBf/T0FI3kpBPwxMYDB+apBEmpzmm1ZWTkIOqo+AkP9FA6aYjnc
        XipHYC1pp+Dho04cpttzMfhZ20+9FcSWroxjrLZYi9iU5HSSXV/LRmzhRC/JXkgawFnT+XMC
        dmNuGGcbxsoQ29RYRLDTugHEZvVK2cbCMYqt1CyTrOViHcWmtFmJUPcTSejNaJ6L5FXuvDIi
        LjJGGRUoef+D8HfCff28ZVJZAPhL3JWcgg+UvBsSKj0UE2v7SYn7KS420SaFcmq1xCvo/xPC
        jh2SwjPwuPTwsaP/MHLv/5zPtCg69aaGil9+/Svzk+tUEjK6pyEHIUP7MNU1fwl26j1M/3gN
        mYYchWK6HDErg1NPL2bEbGlacLtLRB9gZhaytwmc3s/oF++Q9pqk32BuPunY1l3oD5me/NSn
        fmdmNWcctw/aTWsQU9TXSNgbGD3izDRM+dnrXbQb09xZTe2knUXM0p1JzN5woD2Z7rsWW4LQ
        BrzK5OYqdlg3Rq+1YpmILnwuo/BfV+FzrhKEXUUMHx8Rr/48SiFX8l96qjmFOlEZ5RkRp9Ch
        7YWZ3deAWpveMyBaiCROIrPWECYmuFPq0woDYoSYZLdoMdUmiSK501/zqrhwVWIsrzYgX9sj
        ZGGuLhFxtvVTJoTLDvr4yQPk/jKQH/SX7BV5+ejCxHQUl8Cf5Pl4XvWMEwgdXJPQuf1xh9fX
        8ut31bwc2BosvhciZo5Kc46kejy+tddpvevkXPdL/en3jY8ub37SoOU9GoLXRnTXxhyTz3T+
        IJz1/aZgecUw2xRk1Zg+bQ7dM+41ktaV6FOGzjh93Or6iqS4vt3ti5A6l8zrwZbigh7n4IAX
        Hrj99HbMvlqnIzcG5zpGS16U4OpoTnYAU6m5vwG4GvBjRgQAAA==
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh80.chung@samsung.com
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

On 08/06/2015 09:45 AM, Shawn Lin wrote:
> On 2015/8/6 7:45, Krzysztof Kozlowski wrote:
>> On 05.08.2015 17:16, Shawn Lin wrote:
>>> Synopsys DesignWare mobile storage host controller supports three
>>> types of transfer mode: pio, internal dma and external dma. However,
>>> dw_mmc can only supports pio and internal dma now. Thus some platforms
>>> using dw-mshc integrated with generic dma can't work in dma mode. So we
>>> submit this patch to achieve it.
>>>
>>> And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
>>> (commit:f95f3850) for the first version of dw_mmc and never be touched from
>>> then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
>>> we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
>>> time. Nowadays, device-tree helps us to support a variety of boards with one
>>> kernel. That's why we need to remove it and decide the transfer mode at runtime.
>>>
>>> This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
>>> to make the running.
>>>
>>> Patch does the following things:
>>> - remove CONFIG_MMC_DW_IDMAC config option
>>> - add bindings for idmac and edmac used by synopsys-dw-mshc
>>>    at runtime
>>> - add edmac support for synopsys-dw-mshc
>>>
>>> Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc
>>>
>>>
>>> Changes in v3:
>>> - choose transfer mode at runtime
>>> - remove all CONFIG_MMC_DW_IDMAC config option
>>> - add supports-idmac property for some platforms
>>>
>>> Changes in v2:
>>> - Fix typo of dev_info msg
>>> - remove unused dmach from declaration of dw_mci_dma_slave
>>>
>>> Shawn Lin (5):
>>>    mmc: dw_mmc: Add external dma interface support
>>>    Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>>>    arm: configs: remove CONFIG_MMC_DW_IDMAC
>>>    mips: configs: remove CONFIG_MMC_DW_IDMAC
>>>    ARM: dts: add supports-idmac property
>> Please fix the title of cover letter.
>>
>> You CC-ed a lot of people. Probably the whole output of git_maintainers
>> which is not necessary. This means that your patches did not reach some
>> of the mailing lists because of too many recipients. I received your
>> patchset but I can't find it on any of the lists I subscribe.
>>
>> Please CC only REAL maintainers, not committers.
> 
> Right, not the whole output of "cc" by patchman automatically should be involved
> in the  iteration of this patch. I will omit them from this loop  in v4.

As Krzysztof mentioned, I can't read these patchset at mailing list.
I will check these after resend..It's helpful to me for checking patches.

Best Regards,
Jaehoon Chung

> 
>>
>> Additionally if DTS changes do not have to be introduced atomically
>> please split it per sub-architecture. Of course that applies only in
>> case of bisectable patches. And the patchset should preserve
>> bisectability and backward compatibility (mentioned earlier).
> 
> okay, it will be split for each sub-architecture.
> Thanks, Krzysztof. It's helpful.
>> Best regards,
>> Krzysztof
>>
>>
>>>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  41 +++
>>>   arch/arc/configs/axs101_defconfig                  |   1 -
>>>   arch/arc/configs/axs103_defconfig                  |   1 -
>>>   arch/arc/configs/axs103_smp_defconfig              |   1 -
>>>   arch/arm/boot/dts/exynos3250-monk.dts              |   1 +
>>>   arch/arm/boot/dts/exynos3250-rinato.dts            |   1 +
>>>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>>>   arch/arm/boot/dts/exynos4412-origen.dts            |   1 +
>>>   arch/arm/boot/dts/exynos4412-trats2.dts            |   1 +
>>>   arch/arm/boot/dts/exynos4x12.dtsi                  |   1 +
>>>   arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +
>>>   arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +
>>>   arch/arm/boot/dts/exynos5250-snow.dts              |   3 +
>>>   arch/arm/boot/dts/exynos5250-spring.dts            |   2 +
>>>   arch/arm/boot/dts/exynos5260-xyref5260.dts         |   2 +
>>>   arch/arm/boot/dts/exynos5410-smdk5410.dts          |   2 +
>>>   arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   2 +
>>>   arch/arm/boot/dts/exynos5420-peach-pit.dts         |   3 +
>>>   arch/arm/boot/dts/exynos5420-smdk5420.dts          |   2 +
>>>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   2 +
>>>   arch/arm/boot/dts/exynos5800-peach-pi.dts          |   3 +
>>>   arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   2 +
>>>   arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +
>>>   arch/arm/boot/dts/rk3288-firefly.dtsi              |   3 +
>>>   arch/arm/boot/dts/rk3288-popmetal.dts              |   2 +
>>>   arch/arm/configs/exynos_defconfig                  |   1 -
>>>   arch/arm/configs/hisi_defconfig                    |   1 -
>>>   arch/arm/configs/lpc18xx_defconfig                 |   1 -
>>>   arch/arm/configs/multi_v7_defconfig                |   1 -
>>>   arch/arm/configs/zx_defconfig                      |   1 -
>>>   arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   2 +
>>>   arch/mips/configs/pistachio_defconfig              |   1 -
>>>   drivers/mmc/host/Kconfig                           |  11 +-
>>>   drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
>>>   drivers/mmc/host/dw_mmc.c                          | 277 +++++++++++++++++----
>>>   include/linux/mmc/dw_mmc.h                         |  28 ++-
>>>   36 files changed, 338 insertions(+), 72 deletions(-)
>>>
>>
>>
>>
> 
> 
