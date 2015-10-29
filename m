Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 03:33:05 +0100 (CET)
Received: from mailout2.samsung.com ([203.254.224.25]:56224 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011815AbbJ2CcpV4Ko1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 03:32:45 +0100
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWY02KI9N2CDJ40@mailout2.samsung.com>; Thu,
 29 Oct 2015 11:32:36 +0900 (KST)
Received: from epcpsbgm2new.samsung.com ( [172.20.52.113])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id 4A.F6.05274.34581365; Thu,
 29 Oct 2015 11:32:35 +0900 (KST)
X-AuditID: cbfee68d-f79ae6d00000149a-19-56318543c663
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 05.C1.18629.34581365; Thu, 29 Oct 2015 11:32:35 +0900 (KST)
Received: from [10.252.81.186] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NWY004REN2BKK80@mmp2.samsung.com>; Thu,
 29 Oct 2015 11:32:35 +0900 (KST)
Message-id: <56318543.3090900@samsung.com>
Date:   Thu, 29 Oct 2015 11:32:35 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
MIME-version: 1.0
To:     Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v8 10/10] arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
 <1442385808-1433-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1442385808-1433-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWyRsSkUNe51TDMYNt+G4vmq0/ZLf5OOsZu
        Mf/IOVaLs8sOsln8eHqPxeL/o9esFkuePGS3eP3C0KL/8Wtmi02Pr7FaXN41h81iwtRJ7BZH
        /vczWnx68J/ZYsb5fUwWty/zWuy+fo7R4tIeFYs7T9azWhxfG27R+Gots8WTo1OYHcQ8Wpp7
        2Dx+/5rE6DG74SKLx85Zd9k9Hs/dyO7Rs/MMo8emVZ1sHneu7WHzOLpyLZPH5iX1Hn9n7Wfx
        6NuyitFj+7V5zB5b9n9m9Pi8SS6AP4rLJiU1J7MstUjfLoErY8PSB+wFUzkqTmyextbAeIqt
        i5GTQ0LAROLFzstMELaYxIV764HiXBxCAisYJfo+L2CGKWo+8YAFIjGLUeJO1wRWCOcBo8TR
        Xy3sIFW8AloSNy/+AxvFIqAq8WznJbAVbAI6Etu/HQeLiwqESTxYt5cVol5Q4sfke0BTOThE
        BBwkNs0XAZnJLLCUVaLhZx9YvbCAv8TNDbeglrUxSlx+3AN2EqeAh8SMJ1OZQJqZBdQlpkzJ
        BQkzC8hLbF7zlhmkXkKgnVOiedZrdoiDBCS+TT4EtkxCQFZi0wGozyQlDq64wTKBUWwWkpNm
        IUydhWTqAkbmVYyiqQXJBcVJ6UWGesWJucWleel6yfm5mxiBaeb0v2e9OxhvH7A+xCjAwajE
        w7vAyDBMiDWxrLgy9xCjKdARE5mlRJPzgcksryTe0NjMyMLUxNTYyNzSTEmcV1HqZ7CQQHpi
        SWp2ampBalF8UWlOavEhRiYOTqkGRp2lc04lPinSmcTU9ELzS6lbuMicSxlTZe7c1GvwsZxj
        tHC3RovthVbVo/nGlzim9PzRWP5VPE0tnV/16J42B/kPDdcDShaXMh2ZateysP7gtSPhWwXP
        nEhI3vbz8q3zlxN75p2S/fH//4rD83r4L3QrlLjWnOmZ7CtzYKqyjEdbisWy7o2Ce5RYijMS
        DbWYi4oTAU8kaxQuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsVy+t9jQV3nVsMwg76JZhbNV5+yW/yddIzd
        Yv6Rc6wWZ5cdZLP48fQei8X/R69ZLZY8echu8fqFoUX/49fMFpseX2O1uLxrDpvFhKmT2C2O
        /O9ntPj04D+zxYzz+5gsbl/mtdh9/RyjxaU9KhZ3nqxntTi+Ntyi8dVaZosnR6cwO4h5tDT3
        sHn8/jWJ0WN2w0UWj52z7rJ7PJ67kd2jZ+cZRo9NqzrZPO5c28PmcXTlWiaPzUvqPf7O2s/i
        0bdlFaPH9mvzmD227P/M6PF5k1wAf1QDo01GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
        pYW5kkJeYm6qrZKLT4CuW2YO0P9KCmWJOaVAoYDE4mIlfTtME0JD3HQtYBojdH1DguB6jAzQ
        QMIaxowNSx+wF0zlqDixeRpbA+Mpti5GTg4JAROJ5hMPWCBsMYkL99YDxbk4hARmMUrc6ZrA
        CuE8YJQ4+quFHaSKV0BL4ubFf0wgNouAqsSznZfAJrEJ6Ehs/3YcLC4qECbxYN1eVoh6QYkf
        k+8BbeDgEBFwkNg0XwRkJrPAUlaJhp99YPXCAv4SNzfcglrWxihx+XEPM0iCU8BDYsaTqUwg
        zcwC6hJTpuSChJkF5CU2r3nLPIER6EyEFbMQqmYhqVrAyLyKUSK1ILmgOCk91ygvtVyvODG3
        uDQvXS85P3cTIziVPZPewXh4l/shRgEORiUe3gVGhmFCrIllxZW5hxglOJiVRHilWYBCvCmJ
        lVWpRfnxRaU5qcWHGE2BYTCRWUo0OR+YZvNK4g2NTcyMLI3MDS2MjM2VxHkvZGiECQmkJ5ak
        ZqemFqQWwfQxcXBKNTDuT+G5wBLm+XWawR+3RwKXt+5eN5E1b7GXaEpj3DWjxgmGj836n+57
        MHnhoZA1t1b2vqgzjY6wOlJf1hz5ZkZ2s2/ek2fKzc364VF/eqbzn2HuFfx9Jqr/eUQHZ9rW
        wHMXVuVGCC7ZOb9n3rc7vCoynrcdknhPxho5KJ9dEJif9lM3aFaGZZoSS3FGoqEWc1FxIgAz
        nk8qewMAAA==
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49759
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

Hi, All.

Is there any other opinion about this patch?


Best Regards,
Jaehoon Chung

On 09/16/2015 03:43 PM, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/zx_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/zx_defconfig b/arch/arm/configs/zx_defconfig
> index b200bb0..ab683fb 100644
> --- a/arch/arm/configs/zx_defconfig
> +++ b/arch/arm/configs/zx_defconfig
> @@ -83,7 +83,6 @@ CONFIG_MMC=y
>  CONFIG_MMC_UNSAFE_RESUME=y
>  CONFIG_MMC_BLOCK_MINORS=16
>  CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> 
