Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 09:31:50 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.133]:38821 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010899AbbHFHbqMIzkq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 09:31:46 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.110])
        by lucky1.263xmail.com (Postfix) with SMTP id 0ACD84AEF9;
        Thu,  6 Aug 2015 15:31:38 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id CE7DD2D3D1;
        Thu,  6 Aug 2015 15:31:30 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: cpgs@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <a9c2c9f4de15dbdfba73c0c620df8df7>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 4831YJ7H95;
        Thu, 06 Aug 2015 15:31:33 +0800 (CST)
Subject: Re: [RFC PATCH v4 0/9]
To:     Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <55C307D2.7020501@samsung.com>
Cc:     shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org,
        Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        CPGS <cpgs@samsung.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55C30D52.6040802@rock-chips.com>
Date:   Thu, 6 Aug 2015 15:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <55C307D2.7020501@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

在 2015/8/6 15:08, Jaehoon Chung 写道:
> Hi, Shawn.
>
> I remembered that Krzysztof has mentioned "Fix the title of cover letter."
> Your cover letter's title is nothing.. "[RFC PATCH v4 0/9] " ??
> [RFC PATCH v4 0/9] your title...
  Sorry, I forgot it, and will fix in next version...

> Best Regards,
> Jaehoon Chung
>
> On 08/06/2015 03:44 PM, Shawn Lin wrote:
>> Add external dma support for Synopsys MSHC
>>
>> Synopsys DesignWare mobile storage host controller supports three
>> types of transfer mode: pio, internal dma and external dma. However,
>> dw_mmc can only supports pio and internal dma now. Thus some platforms
>> using dw-mshc integrated with generic dma can't work in dma mode. So we
>> submit this patch to achieve it.
>>
>> And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
>> (commit:f95f3850) for the first version of dw_mmc and never be touched since
>> then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
>> we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
>> time. Nowadays, device-tree helps us to support a variety of boards with one
>> kernel. That's why we need to remove it and decide the transfer mode by reading
>> dw_mmc's HCON reg at runtime.
>>
>> This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
>> to make the running.
>>
>> Patch does the following things:
>> - remove CONFIG_MMC_DW_IDMAC config option
>> - add bindings for edmac used by synopsys-dw-mshc
>>    at runtime
>> - add edmac support for synopsys-dw-mshc
>>
>> Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc
>>
>>
>> Changes in v4:
>> - remove "host->trans_mode" and use "host->use_dma" to indicate
>>    transfer mode.
>> - remove all bt-bindings' changes since we don't need new properities.
>> - check transfer mode at runtime by reading HCON reg
>> - spilt defconfig changes for each sub-architecture
>> - fix the title of cover letter
>> - reuse some code for reducing code size
>>
>> Changes in v3:
>> - choose transfer mode at runtime
>> - remove all CONFIG_MMC_DW_IDMAC config option
>> - add supports-idmac property for some platforms
>>
>> Changes in v2:
>> - Fix typo of dev_info msg
>> - remove unused dmach from declaration of dw_mci_dma_slave
>>
>> Shawn Lin (9):
>>    mmc: dw_mmc: Add external dma interface support
>>    Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>>    mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
>>    arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
>>    arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
>>    arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
>>    arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>    arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
>>    arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>
>>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  25 ++
>>   arch/arc/configs/axs101_defconfig                  |   1 -
>>   arch/arc/configs/axs103_defconfig                  |   1 -
>>   arch/arc/configs/axs103_smp_defconfig              |   1 -
>>   arch/arm/configs/exynos_defconfig                  |   1 -
>>   arch/arm/configs/hisi_defconfig                    |   1 -
>>   arch/arm/configs/lpc18xx_defconfig                 |   1 -
>>   arch/arm/configs/multi_v7_defconfig                |   1 -
>>   arch/arm/configs/zx_defconfig                      |   1 -
>>   arch/mips/configs/pistachio_defconfig              |   1 -
>>   drivers/mmc/host/Kconfig                           |  11 +-
>>   drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
>>   drivers/mmc/host/dw_mmc.c                          | 258 +++++++++++++++++----
>>   include/linux/mmc/dw_mmc.h                         |  27 ++-
>>   14 files changed, 257 insertions(+), 75 deletions(-)
>>
>
>
>


-- 
Shawn Lin
