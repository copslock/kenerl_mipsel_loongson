Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2015 11:49:40 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.131]:59606 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008534AbbJBJthvnlaz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Oct 2015 11:49:37 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.131])
        by lucky1.263xmail.com (Postfix) with SMTP id 0D9198830F;
        Fri,  2 Oct 2015 17:49:26 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [192.168.1.101] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id DB5013F1;
        Fri,  2 Oct 2015 17:49:21 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: cpgs@samsung.com
X-SENDER-IP: 220.200.59.127
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <82df4331ca0dfe5e2cbc01019631f110>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [192.168.1.101] (unknown [220.200.59.127])
        by smtp.263.net (Postfix) whith ESMTP id 19449OJ92XM;
        Fri, 02 Oct 2015 17:49:24 +0800 (CST)
Subject: Re: [RFC PATCH v8 0/10] Add external dma support for Synopsys MSHC
To:     Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
 <560CF98B.7010609@samsung.com>
Cc:     shawn.lin@rock-chips.com, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        dianders@chromium.org, linux-samsung-soc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        CPGS <cpgs@samsung.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <560E5320.6050003@rock-chips.com>
Date:   Fri, 2 Oct 2015 17:49:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <560CF98B.7010609@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49412
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

On 2015/10/1 17:14, Jaehoon Chung wrote:
> Dear, All.
>
> I will apply patch 01-03 at my repository on today.
> But i don't know better how i do about other patches relevant to config file.
>

Thanks, Jaehoon. :)

I guess it would be acceptable to pick the config changes, already they 
were acked by the soc maintainers, via dw_mmc tree when ulf merge dw_mmc 
tree into his mmc-tree.


> Best Regards,
> Jaehoon Chung
>
> On 09/16/2015 03:40 PM, Shawn Lin wrote:
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
>> Test emmc throughput on my platform with edmac support and without edmac support(pio only)
>> iozone -L64 -S32 -azecwI -+n -r4k -r64k -r128k -s1g -i0 -i1 -i2 -f datafile -Rb out.xls > /mnt/result.txt
>> (light cpu loading, Direct IO, fixed line size, all pattern recycle, 1GB data in total)
>>   ___________________________________________________________
>> |                   external dma mode                       |
>> |-----------------------------------------------------------|
>> |blksz | Random Read | Random Write | Seq Read   | Seq Write|
>> |-----------------------------------------------------------|
>> |4kB   |  13953kB/s  |    8602kB/s  | 13672kB/s  |  9785kB/s|
>> |-----------------------------------------------------------|
>> |64kB  |  46058kB/s  |   24794kB/s  | 48058kB/s  | 25418kB/s|
>> |-----------------------------------------------------------|
>> |128kB |  57026kB/s  |   35117kB/s  | 57375kB/s  | 35183kB/s|
>> |-----------------------------------------------------------|
>>                             VS
>>   ___________________________________________________________
>> |                          pio mode                         |
>> |-----------------------------------------------------------|
>> |blksz | Random Read  | Random Write | Seq Read  | Seq Write|
>> |-----------------------------------------------------------|
>> |4kB   |  11720kB/s   |    8644kB/s  | 11549kB/s |  9624kB/s|
>> |-----------------------------------------------------------|
>> |64kB  |  21869kB/s   |   24414kB/s  | 22031kB/s | 27986kB/s|
>> |-----------------------------------------------------------|
>> |128kB |  23718kB/s   |   34495kB/s  | 24698kB/s | 34637kB/s|
>> |-----------------------------------------------------------|
>>
>>
>> Changes in v8:
>> - remove trans_mode variable
>> - remove unnecessary dma_ops check
>> - remove unnecessary comment
>> - fix coding style based on latest ulf's next
>> - add Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>    for HCON's changes
>>
>> Changes in v7:
>> - rebased on Ulf's next
>> - combine condition state
>> - elaborate more about DMA_INTERFACE
>> - define some macro for DMA_INERFACE value
>> - spilt HCON ops' changes into another patch
>>
>> Changes in v6:
>> - add trans_mode condition for IDMAC initialization
>>    suggested by Heiko
>> - re-test my patch on rk3188 platform and update commit msg
>> - update performance of pio vs edmac in cover letter
>>
>> Changes in v5:
>> - add the title of cover letter
>> - fix typo of comment
>> - add macro for reading HCON register
>> - add "Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>" for exynos_defconfig patch
>> - add "Acked-by: Vineet Gupta <vgupta@synopsys.com>" for axs10x_defconfig patch
>> - add "Acked-by: Govindraj Raja <govindraj.raja@imgtec.com>" and
>>    "Acked-by: Ralf Baechle <ralf@linux-mips.org>" for pistachio_defconfig patch
>> - add "Acked-by: Joachim Eastwood <manabian@gmail.com>" for lpc18xx_defconfig patch
>> - add "Acked-by: Wei Xu <xuwei5@hisilicon.com>" for hisi_defconfig patch
>> - rebase on "https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2" for merging easily
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
>> Shawn Lin (10):
>>    mmc: dw_mmc: Add external dma interface support
>>    mmc: dw_mmc: use macro for HCON register operations
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
>>   drivers/mmc/host/dw_mmc.c                          | 272 +++++++++++++++++----
>>   drivers/mmc/host/dw_mmc.h                          |   9 +
>>   include/linux/mmc/dw_mmc.h                         |  23 +-
>>   15 files changed, 276 insertions(+), 75 deletions(-)
>>
>
>
>
>


-- 
Best Regards
Shawn Lin
