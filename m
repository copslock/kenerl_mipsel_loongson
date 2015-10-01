Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Oct 2015 11:15:04 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:55379 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007239AbbJAJPA1yZ-T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Oct 2015 11:15:00 +0200
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NVJ02CGLB0S76B0@mailout3.samsung.com>; Thu,
 01 Oct 2015 18:14:52 +0900 (KST)
Received: from epcpsbgm1new.samsung.com ( [172.20.52.115])
        by epcpsbgr5.samsung.com (EPCPMTA) with SMTP id 4B.EB.05385.C89FC065; Thu,
 1 Oct 2015 18:14:52 +0900 (KST)
X-AuditID: cbfee691-f79d66d000001509-58-560cf98c08fb
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm1new.samsung.com (EPCPMTA) with SMTP id 0D.E3.23663.B89FC065; Thu,
 1 Oct 2015 18:14:52 +0900 (KST)
Received: from [10.252.81.186] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NVJ00LPTB0R1W10@mmp1.samsung.com>; Thu,
 01 Oct 2015 18:14:51 +0900 (KST)
Subject: Re: [RFC PATCH v8 0/10] Add external dma support for Synopsys MSHC
To:     Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
Cc:     Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
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
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <560CF98B.7010609@samsung.com>
Date:   Thu, 01 Oct 2015 18:14:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-version: 1.0
In-reply-to: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGefedNlF7XWpvVlbDgpbNTGdvJWH15w1/JERG9cOmfUxJ19hn
        akGoGUFms2ZFTUt/mKgo0iw6eJrDA+EpGzkrXaZ2clmQJa5S83NF/bu5uZ77eW54pJS8mAmS
        pujSeYNOk6pgvega/0hhU4HbO36zvckX5z1/y+FZUweHP9o24NK2Xgb3VLSyeOatk8bzoy4G
        l4+/4bDrQzguHHNR2DI2wGD74xIWX75m4nDbfCHAX0fmKXyjr1mCX9l9cIOjF+BnjSF4aLyO
        wZ21B3HuRC2Fx9uvUjHLyLm8Apb8/GECpDinnyaPzMMcGbt1lyMFj7oBsVRfYMnQQCNL2qtq
        JaS+PJvMmltoYrxXDciDgdsUudcyBciUJThuyWGv6GN8akoGbwjbedQr+clcMasfUWd9udlK
        5wDrhnwglSIYiUp+KfOBbEEGoqfOOjYfeEnlsBKgroZh7i/jMK70+HcAKuur/gONAPTeNQrE
        6aUwFp11zLDigD+MQZZSf9GWQ4JeVlxjRJ6CVgZ1vHcu8iwMRQ+mOyWi9oFKVPy0aNGn4Tpk
        LHIDMScAxqPO7hgP4odmipy0qGVwL7J8szEiQkEVet2/eD8FV6P6mklKXIVgoQyV1PUznkiI
        potstKfLKmSxUp6+y1Fr5SB9GQSa/9tg/pdq/i+1DFDVIIDXJ+mFRK1BrRI0acJJnVaVdCLN
        AhZ+pmvu3ZWH4LV1hw1AKVB4+yCtd7yc0WQIp9JsQL1wxBUqKCDpxMKb6dITwiOitmB1pDpi
        y9ZtUYplPqEr3PvlUKtJ54/zvJ43JBhOpvKCDUiksqAcsDZ6cqgperBdEhYx4PtdtbrGryHb
        6lhzRpGX8Il7eGS3an2ikHU9K+USq4qlcm+19dsNIT2mPvLZ13kgWCHdkRm36/7G7ZkNK88f
        7g12VdLudb36yevPuCPjpy8q97W7/cKaX44egsaDxliuaWJJPftqYkSmXmp6UWXfY3xxblJB
        C8macCVlEDS/ATZquE0uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsVy+t9jAd2enzxhBntXsFk0X33KbvF30jF2
        i5eHNC3mHznHanF22UE2ix9P77FY/H/0mtViyZOH7BavXxha9D9+zWyx6fE1VovLu+awWUyY
        Oond4sj/fkaLTw/+M1vMOL+PyeL2ZV6L3dfPMVpc2qNicefJelaL42vDLRpfrWW2eHJ0CrOD
        uEdLcw+bx+9fkxg9ZjdcZPHYOesuu8fjuRvZPXp2nmH02LSqk83jzrU9bB5HV65l8ti8pN7j
        76z9LB59W1Yxemy/No/ZY8v+z4wenzfJBfBHNTDaZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gDDQEmhLDGnFCgUkFhcrKRvh2lCaIibrgVMY4Sub0gQ
        XI+RARpIWMOYcfLfbLaCB6YV72ceZGlgPKDZxcjBISFgInG9T6aLkRPIFJO4cG89WxcjF4eQ
        wFJGiQXnV0E5Dxglnr9+xAhSJSzgLdF0/QcbSLOIgIPEpvkiIGEhAQ+JW8umsoLUMwscYJU4
        9vweWD2bgI7E9m/HmUBsXgEtidkXJoPFWQRUJfom/2QEmSMqECZx/IwDRImgxI/J91hAbE4B
        T4lNXw6xgpQwC+hJ3L+oBRJmFpCX2LzmLfMERoFZSDpmIVTNQlK1gJF5FaNEakFyQXFSeq5h
        Xmq5XnFibnFpXrpecn7uJkZwMnsmtYPx4C73Q4wCHIxKPLwHUnjChFgTy4orcw8xSnAwK4nw
        yrwFCvGmJFZWpRblxxeV5qQWH2I0BfpiIrOUaHI+MNHmlcQbGpuYGVkamRtaGBmbK4nz3jjE
        ECYkkJ5YkpqdmlqQWgTTx8TBKdXAeKr/q7d2nKTRAUPBtXyrSh8bqW+boH/O6MbRfpfl4c/T
        bkgv39N1SDVDqlqVzX+6VezBZ/v6Hdrnvj0psN728Y6Vafuy2dIPKnFlyLQn6/y71s7gz8D9
        L+bNLTuVg1O1Fa6+CeiQTsttnbZaUSL1nm6Z0asApbXTKjsXKziHbi/5qa4f+1FGiaU4I9FQ
        i7moOBEA+8QizHwDAAA=
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49409
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

Dear, All.

I will apply patch 01-03 at my repository on today.
But i don't know better how i do about other patches relevant to config file.

Best Regards,
Jaehoon Chung

On 09/16/2015 03:40 PM, Shawn Lin wrote:
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
> Test emmc throughput on my platform with edmac support and without edmac support(pio only)
> iozone -L64 -S32 -azecwI -+n -r4k -r64k -r128k -s1g -i0 -i1 -i2 -f datafile -Rb out.xls > /mnt/result.txt
> (light cpu loading, Direct IO, fixed line size, all pattern recycle, 1GB data in total)
>  ___________________________________________________________
> |                   external dma mode                       |
> |-----------------------------------------------------------|
> |blksz | Random Read | Random Write | Seq Read   | Seq Write|
> |-----------------------------------------------------------|
> |4kB   |  13953kB/s  |    8602kB/s  | 13672kB/s  |  9785kB/s|
> |-----------------------------------------------------------|
> |64kB  |  46058kB/s  |   24794kB/s  | 48058kB/s  | 25418kB/s|
> |-----------------------------------------------------------|
> |128kB |  57026kB/s  |   35117kB/s  | 57375kB/s  | 35183kB/s|
> |-----------------------------------------------------------|
>                            VS
>  ___________________________________________________________
> |                          pio mode                         |
> |-----------------------------------------------------------|
> |blksz | Random Read  | Random Write | Seq Read  | Seq Write|
> |-----------------------------------------------------------|
> |4kB   |  11720kB/s   |    8644kB/s  | 11549kB/s |  9624kB/s|
> |-----------------------------------------------------------|
> |64kB  |  21869kB/s   |   24414kB/s  | 22031kB/s | 27986kB/s|
> |-----------------------------------------------------------|
> |128kB |  23718kB/s   |   34495kB/s  | 24698kB/s | 34637kB/s|
> |-----------------------------------------------------------|
> 
> 
> Changes in v8:
> - remove trans_mode variable
> - remove unnecessary dma_ops check
> - remove unnecessary comment
> - fix coding style based on latest ulf's next
> - add Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>   for HCON's changes
> 
> Changes in v7:
> - rebased on Ulf's next
> - combine condition state
> - elaborate more about DMA_INTERFACE
> - define some macro for DMA_INERFACE value
> - spilt HCON ops' changes into another patch
> 
> Changes in v6:
> - add trans_mode condition for IDMAC initialization
>   suggested by Heiko
> - re-test my patch on rk3188 platform and update commit msg
> - update performance of pio vs edmac in cover letter
> 
> Changes in v5:
> - add the title of cover letter
> - fix typo of comment
> - add macro for reading HCON register
> - add "Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>" for exynos_defconfig patch
> - add "Acked-by: Vineet Gupta <vgupta@synopsys.com>" for axs10x_defconfig patch
> - add "Acked-by: Govindraj Raja <govindraj.raja@imgtec.com>" and
>   "Acked-by: Ralf Baechle <ralf@linux-mips.org>" for pistachio_defconfig patch
> - add "Acked-by: Joachim Eastwood <manabian@gmail.com>" for lpc18xx_defconfig patch
> - add "Acked-by: Wei Xu <xuwei5@hisilicon.com>" for hisi_defconfig patch
> - rebase on "https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2" for merging easily
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
> Shawn Lin (10):
>   mmc: dw_mmc: Add external dma interface support
>   mmc: dw_mmc: use macro for HCON register operations
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
>  drivers/mmc/host/dw_mmc.c                          | 272 +++++++++++++++++----
>  drivers/mmc/host/dw_mmc.h                          |   9 +
>  include/linux/mmc/dw_mmc.h                         |  23 +-
>  15 files changed, 276 insertions(+), 75 deletions(-)
> 
