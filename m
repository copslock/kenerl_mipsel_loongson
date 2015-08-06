Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 09:33:52 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:35005 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010899AbbHFHduZXqyq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 09:33:50 +0200
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN02K5KH06VO50@mailout4.samsung.com>; Thu,
 06 Aug 2015 16:33:42 +0900 (KST)
Received: from epcpsbgm1new.samsung.com ( [172.20.52.116])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id 1C.BF.29324.6DD03C55; Thu,
 6 Aug 2015 16:33:42 +0900 (KST)
X-AuditID: cbfee68d-f79106d00000728c-27-55c30dd6dc52
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id 4C.FC.23663.6DD03C55; Thu,  6 Aug 2015 16:33:42 +0900 (KST)
Content-transfer-encoding: 8BIT
Received: from [10.252.81.186] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NSN007CEH05RG50@mmp2.samsung.com>; Thu,
 06 Aug 2015 16:33:42 +0900 (KST)
Message-id: <55C30DD6.8020802@samsung.com>
Date:   Thu, 06 Aug 2015 16:33:42 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
To:     Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
Cc:     heiko@sntech.de, dianders@chromium.org, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
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
Subject: Re: [RFC PATCH v4 0/9]
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <55C307D2.7020501@samsung.com> <55C30D52.6040802@rock-chips.com>
In-reply-to: <55C30D52.6040802@rock-chips.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXd2zs7E6WlNfRtlNYxUTPP+ShckIQ7mB6NZUJAtO6jp1DZn
        9klDoTJNnQprWlpI2NjSpnhJaW4qJs17aeWllXfFMCWxD7ncRti3H/wfnuf/wENifCUuJJPT
        MhlZmiRVRDixtYKQzGNjvK6441+LPFHexzkOWjL5oOruARz1vzASaGtumo2s31dwVDv7jYNW
        FgNR8cwKhvQzYzgafVNFoJIKJQd1W4sBWrdYMaQafMtCE6M81D4+ANBIhxeanK3HUa/uErq7
        rMPQbE85FulO5+cVEnRl7jCbblNPceiZJ685dGGbGdB6zQOCnhzrIOielzoW3VibQ/9RG9j0
        oyYNoFvGnmJ0k2ED0Bt6z1iXy04nbzCpyVmMLOD0Nack1eAHVkbroexJyw9WLjDDAsAlIRUC
        S3qqgYPd4dB0PVEAnEg+VQdgu8rA+ieyDH/GbMyn1AAat6JtzKP2wK2yaXYBIEmMOgi7R1Ic
        eBSWl0sdNhYAXy1rOA65L9z88s5uyaaOwL6nfXYmKD/YstlrZzfqIjSr7tstBVQk1FcLbD4Y
        9QyHqvV5wqbZuxO19LgXdwQ8BHBDuW3/jUv5wyHjIrAdIGUlYVXjEHCkUXCzzGR3hdQBqO/E
        HL32QWPdJ3YJcFf/V0e9W0e9W6cGYBrgxmQkZMivJ8oC/eUSqVyRluifkC7Vg52pvN+eL2oF
        E50nTIAigciZZ9Ga4vi4JEt+R2oCoTs/lGJCt4T0nXWlZcYHBocFodCQ0OCg8IgwkQfvsPD3
        BT6VKMlkUhgmg5HFyxSpjNwEWCRXmAta/XO43AqFNCHWWZV93sN6RnNzOKfVnB2xNljTG1Nq
        cTZv6vevGhdcf60t+8SU5ycFLP1UbJR1RJFCcfgpF++85173kEGpFetudZESgXeH/lyp4iyv
        0jQV1SYUZuHRDQ1QZ7jdPO7X7BLTr1WOXMXKhFfwNVexGCzUxayK2PIkSaAvJpNL/gK0mxDT
        JQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsVy+t9jQd1rvIdDDa48FbJovvqU3eLlIU2L
        +UfOsVqcXXaQzeLH03ssFv8fvWa1WPLkIbvF6xeGFv2PXzNbbHp8jdXi8q45bBYTpk5itzjy
        v5/R4tOD/8wWM87vY7K4fZnXYvf1c4wWl/aoWNx5sp7V4vjacIvGV2uZLZ4cncLsIObR0tzD
        5jG74SKLx85Zd9k9Hs/dyO7Rs/MMo8emVZ1sHneu7WHzOLpyLZPH5iX1Hn9n7Wfx6NuyitFj
        +7V5zB5b9n9m9Pi8SS6AL6qB0SYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
        MTfVVsnFJ0DXLTMH6HMlhbLEnFKgUEBicbGSvh2mCaEhbroWMI0Rur4hQXA9RgZoIGENY8aM
        81eYCnYoVNx58I6pgfGMRBcjJ4eEgInEg4s3mSFsMYkL99azgdhCArMYJQ7+8AKxeQUEJX5M
        vsfSxcjBwSwgL3HkUjaEqS4xZUpuFyMXUPUDRol1r1axQ5RrSXy7dYIJxGYRUJU4Oe8kmM0m
        oCOx/dtxMFtUIEzizIwOsJEiAg4Sm+aLgMxhFljIKjHj0zOwE4SBVr2ceZwVYkE3o8TnSf/A
        7uQU0JO4cPAF4wRGoCMRzpuFcN4shPMWMDKvYpRILUguKE5KzzXMSy3XK07MLS7NS9dLzs/d
        xAhOXM+kdjAe3OV+iFGAg1GJh/fBmkOhQqyJZcWVuYcYJTiYlUR4t14ACvGmJFZWpRblxxeV
        5qQWH2I0BfpvIrOUaHI+MKnmlcQbGpuYGVkamRtaGBmbK4nzym7YHCokkJ5YkpqdmlqQWgTT
        x8TBKdXAWPBlQup6gyPBpnuOFi05vyng7Y2PHEvL7KX3Mn7VPpm/UG+Wn/Pp+6+1X976Y/li
        5+/pH/O0c64LT35kWzGpl/fZhl92zsobhL6cVJXq/W0032PFSv4VAjG3f2lpFeQulvb5f1by
        OceRwKxJuYqBFo/Vyz0O+zy7fuiakrTQpT33mBksTq6/ya7EUpyRaKjFXFScCADTjnqtcgMA        AA==
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48666
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

On 08/06/2015 04:31 PM, Shawn Lin wrote:
> 在 2015/8/6 15:08, Jaehoon Chung 写道:
>> Hi, Shawn.
>>
>> I remembered that Krzysztof has mentioned "Fix the title of cover letter."
>> Your cover letter's title is nothing.. "[RFC PATCH v4 0/9] " ??
>> [RFC PATCH v4 0/9] your title...
>  Sorry, I forgot it, and will fix in next version...

No problem :) 
At next time,  add the title at your cover-letter, plz.

Best Regards,
Jaehoon Chung

> 
>> Best Regards,
>> Jaehoon Chung
>>
>> On 08/06/2015 03:44 PM, Shawn Lin wrote:
>>> Add external dma support for Synopsys MSHC
>>>
>>> Synopsys DesignWare mobile storage host controller supports three
>>> types of transfer mode: pio, internal dma and external dma. However,
>>> dw_mmc can only supports pio and internal dma now. Thus some platforms
>>> using dw-mshc integrated with generic dma can't work in dma mode. So we
>>> submit this patch to achieve it.
>>>
>>> And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
>>> (commit:f95f3850) for the first version of dw_mmc and never be touched since
>>> then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
>>> we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
>>> time. Nowadays, device-tree helps us to support a variety of boards with one
>>> kernel. That's why we need to remove it and decide the transfer mode by reading
>>> dw_mmc's HCON reg at runtime.
>>>
>>> This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
>>> to make the running.
>>>
>>> Patch does the following things:
>>> - remove CONFIG_MMC_DW_IDMAC config option
>>> - add bindings for edmac used by synopsys-dw-mshc
>>>    at runtime
>>> - add edmac support for synopsys-dw-mshc
>>>
>>> Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc
>>>
>>>
>>> Changes in v4:
>>> - remove "host->trans_mode" and use "host->use_dma" to indicate
>>>    transfer mode.
>>> - remove all bt-bindings' changes since we don't need new properities.
>>> - check transfer mode at runtime by reading HCON reg
>>> - spilt defconfig changes for each sub-architecture
>>> - fix the title of cover letter
>>> - reuse some code for reducing code size
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
>>> Shawn Lin (9):
>>>    mmc: dw_mmc: Add external dma interface support
>>>    Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>>>    mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>
>>>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  25 ++
>>>   arch/arc/configs/axs101_defconfig                  |   1 -
>>>   arch/arc/configs/axs103_defconfig                  |   1 -
>>>   arch/arc/configs/axs103_smp_defconfig              |   1 -
>>>   arch/arm/configs/exynos_defconfig                  |   1 -
>>>   arch/arm/configs/hisi_defconfig                    |   1 -
>>>   arch/arm/configs/lpc18xx_defconfig                 |   1 -
>>>   arch/arm/configs/multi_v7_defconfig                |   1 -
>>>   arch/arm/configs/zx_defconfig                      |   1 -
>>>   arch/mips/configs/pistachio_defconfig              |   1 -
>>>   drivers/mmc/host/Kconfig                           |  11 +-
>>>   drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
>>>   drivers/mmc/host/dw_mmc.c                          | 258 +++++++++++++++++----
>>>   include/linux/mmc/dw_mmc.h                         |  27 ++-
>>>   14 files changed, 257 insertions(+), 75 deletions(-)
>>>
>>
>>
>>
> 
> 
