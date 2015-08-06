Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 09:08:38 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:55740 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011282AbbHFHITqKctk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 09:08:19 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN00T7XFTFZ7D0@mailout2.samsung.com>; Thu,
 06 Aug 2015 16:08:03 +0900 (KST)
Received: from epcpsbgm2new.samsung.com ( [172.20.52.113])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id 78.F5.24422.3D703C55; Thu,
 6 Aug 2015 16:08:03 +0900 (KST)
X-AuditID: cbfee68f-f793b6d000005f66-c2-55c307d3cf3f
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 6C.2C.07062.2D703C55; Thu,  6 Aug 2015 16:08:03 +0900 (KST)
Received: from [10.252.81.186] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NSN006VMFTE6440@mmp2.samsung.com>; Thu,
 06 Aug 2015 16:08:02 +0900 (KST)
Message-id: <55C307D2.7020501@samsung.com>
Date:   Thu, 06 Aug 2015 16:08:02 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
MIME-version: 1.0
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
In-reply-to: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeyyVYRzHe7y3Q9HjhJ6k2s7qD5fc6TFl1h/tpa3ZmjT/6MSbhJPOwWqt
        YmR1EnIZToRIGKlDk6jTOeiYWzi5TEi5LLfVHIp1kbfTVv99993n9/19f9tPQAgzKGtBhCSW
        k0rEUSLahKy2cL+wX8e0BDpntUOcNDDN4FmNLS5q7aFwd7maxqvT4yRe/zhP4bKpDwye/+SC
        0yfnCaycHKSw7nkBjTNyMhncup4O8NLEOoHz3rw0wu90prhpqAfg/ua9eHSqlsLamiCcOFdD
        4Km2bMLXik1OSqXZuwl9JNuoGGPYycInDJva2AVYZdVNmh0dbKbZtsoaI7au7Br7U6Ei2bT6
        KsA2DN4j2HqVHrB65e4As2CTg2FcVEQ8J3XyOWVytnniBxmzaHOxfKiMSgBjlnJgLEDQHeV3
        DAGDtkK947W0HJgIhLACoLWm24wcCP5AvQXnDL4CoLn2FYYfEMIJgFa/XOW1KbRD3/oXaJ4n
        4T7UqkK8TUMH1PBVa8RrS3gCdeXdIA24OVrNGid53AL6ImWRBR9PwBIK5S3N0DyzDe5Bs/la
        yrCKRdcXDD2NoR/KyV2m+FkCOqL3fXa8TWzgddWLhOGUJGM08MKH1ySE6GuWhjRcsgspX/1F
        diB1xTCZAawU/xVS/AtV/BdaDIgqYMnFhMbITodL3Rxl4mhZnCTcMfR8tBJsPErnr5n0Z2Ds
        lbcGQAEQbTGdqNYECilxvOxStAZ4bJS4Q1hbhp7f+C1JbIiLm6cr9nD3cHM94OUp2m5aYr12
        XAjDxbFcJMfFcNIQaVwUJ9MAI4GxdQJg9K8XbgxeUJ8075Cnpzr6n+l5emRA7pPvbe9kG3/F
        xT/K1VnbskyMOPR+VulECY8f4ZSAXF3X4bC01FubbajWxEKzTdOqTDfzjKOxycMXBfbd2aU7
        HyQ9jAwufjvSr/cowfJjLX7qFUJeWFnsdWhcqyv9TnGXU+5/WIreGtRJi0jZWbGLHSGViX8D
        1wtvEiMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsVy+t9jQd3L7IdDDe50clo0X33KbvHykKbF
        /CPnWC3OLjvIZvHj6T0Wi/+PXrNaLHnykN3i9QtDi/7Hr5ktNj2+xmpxedccNosJUyexWxz5
        389o8enBf2aLGef3MVncvsxrsfv6OUaLS3tULO48Wc9qcXxtuEXjq7XMFk+OTmF2EPNoae5h
        85jdcJHFY+esu+wej+duZPfo2XmG0WPTqk42jzvX9rB5HF25lslj85J6j7+z9rN49G1Zxeix
        /do8Zo8t+z8zenzeJBfAF9XAaJORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCX
        mJtqq+TiE6DrlpkD9LmSQlliTilQKCCxuFhJ3w7ThNAQN10LmMYIXd+QILgeIwM0kLCGMWPP
        gz8sBW9lKpZdX8LawHhXtIuRg0NCwETiwpysLkZOIFNM4sK99WxdjFwcQgKzGCVenfjKDpIQ
        EnjAKPHjQx2IzSugJfH90hs2kF4WAVWJI/slQMJsAjoS278dZwKxRQXCJM7M6GCBKBeU+DH5
        HgtIuYiAg8Sm+SIg45kFFrJKzPj0jA2kRlhAXuLlzOOsEKs8JFrfXGcEsTkFPCWmTv/CCtLL
        LKAncf+iFkiYGah885q3zBMYgW5E2DALoWoWkqoFjMyrGCVSC5ILipPSc43yUsv1ihNzi0vz
        0vWS83M3MYLT1jPpHYyHd7kfYhTgYFTi4X2w5lCoEGtiWXFl7iFGCQ5mJRHerReAQrwpiZVV
        qUX58UWlOanFhxhNgSEwkVlKNDkfmFLzSuINjU3MjCyNzA0tjIzNlcR59U02hQoJpCeWpGan
        phakFsH0MXFwSjUwFj5KN5sitc2tbsfzO8x1bEGF+U2ZHKaep2fe7PnxWnrupEMbTxXu4w75
        f09vw7pnNUumP9pzLYthxtdt8yRKZ7bJNswwDDZSCziYEcAaHqWVwSQUZLvG9NnrJ9uvPC4N
        k/oZarH1h+9sBdmDDgsfbXX4GXnj8Fnd45GGAYfE/m9f65ixsCV/qhJLcUaioRZzUXEiAOYu
        BsdxAwAA
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48662
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

Hi, Shawn.

I remembered that Krzysztof has mentioned "Fix the title of cover letter."
Your cover letter's title is nothing.. "[RFC PATCH v4 0/9] " ??
[RFC PATCH v4 0/9] your title...

Best Regards,
Jaehoon Chung

On 08/06/2015 03:44 PM, Shawn Lin wrote:
> Add external dma support for Synopsys MSHC
> 
> Synopsys DesignWare mobile storage host controller supports three
> types of transfer mode: pio, internal dma and external dma. However,
> dw_mmc can only supports pio and internal dma now. Thus some platforms
> using dw-mshc integrated with generic dma can't work in dma mode. So we
> submit this patch to achieve it.
> 
> And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
> (commit:f95f3850) for the first version of dw_mmc and never be touched since
> then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
> we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
> time. Nowadays, device-tree helps us to support a variety of boards with one
> kernel. That's why we need to remove it and decide the transfer mode by reading
> dw_mmc's HCON reg at runtime.
> 
> This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
> to make the running.
> 
> Patch does the following things:
> - remove CONFIG_MMC_DW_IDMAC config option
> - add bindings for edmac used by synopsys-dw-mshc
>   at runtime
> - add edmac support for synopsys-dw-mshc
> 
> Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc
> 
> 
> Changes in v4:
> - remove "host->trans_mode" and use "host->use_dma" to indicate
>   transfer mode.
> - remove all bt-bindings' changes since we don't need new properities.
> - check transfer mode at runtime by reading HCON reg
> - spilt defconfig changes for each sub-architecture
> - fix the title of cover letter
> - reuse some code for reducing code size
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
> Shawn Lin (9):
>   mmc: dw_mmc: Add external dma interface support
>   Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>   mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
>   arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
>   arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
>   arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
>   arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
>   arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
>   arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  25 ++
>  arch/arc/configs/axs101_defconfig                  |   1 -
>  arch/arc/configs/axs103_defconfig                  |   1 -
>  arch/arc/configs/axs103_smp_defconfig              |   1 -
>  arch/arm/configs/exynos_defconfig                  |   1 -
>  arch/arm/configs/hisi_defconfig                    |   1 -
>  arch/arm/configs/lpc18xx_defconfig                 |   1 -
>  arch/arm/configs/multi_v7_defconfig                |   1 -
>  arch/arm/configs/zx_defconfig                      |   1 -
>  arch/mips/configs/pistachio_defconfig              |   1 -
>  drivers/mmc/host/Kconfig                           |  11 +-
>  drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
>  drivers/mmc/host/dw_mmc.c                          | 258 +++++++++++++++++----
>  include/linux/mmc/dw_mmc.h                         |  27 ++-
>  14 files changed, 257 insertions(+), 75 deletions(-)
> 
