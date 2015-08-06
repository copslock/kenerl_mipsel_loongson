Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 09:09:12 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:32077 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011184AbbHFHJJamoNk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 09:09:09 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSN001Z8FV2WU40@mailout4.w1.samsung.com>; Thu,
 06 Aug 2015 08:09:02 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-c8-55c3080e5e2f
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id E1.3F.05269.E0803C55; Thu,
 6 Aug 2015 08:09:02 +0100 (BST)
Received: from [0.0.0.0] ([106.116.37.23])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NSN000FCFURP600@eusync1.samsung.com>; Thu,
 06 Aug 2015 08:09:02 +0100 (BST)
Message-id: <55C30808.1020704@samsung.com>
Date:   Thu, 06 Aug 2015 16:08:56 +0900
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.8.0
MIME-version: 1.0
To:     Shawn Lin <shawn.lin@rock-chips.com>, jh80.chung@samsung.com,
        ulf.hansson@linaro.org
Cc:     heiko@sntech.de, dianders@chromium.org, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v4 5/9] arm: exynos_defconfig: remove
 CONFIG_MMC_DW_IDMAC
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843539-24017-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1438843539-24017-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xy7p8HIdDDbZsEbZovvqU3WL+kXOs
        FmeXHWSz+PH0HovF/0evWS1u/GpjtVjy5CG7xesXhhb9j18zW2x6fI3V4vKuOWwWE6ZOYrc4
        8r+f0eLTg//MFjPO72OyuH2Z12L39XOMFpf2qFjcebKe1eL42nCLxldrmS2eHJ3C7CDm0dLc
        w+Yxu+Eii8fOWXfZPR7P3cju0bPzDKPHplWdbB53ru1h8zi6ci2Tx+Yl9R5/Z+1n8ejbsorR
        Y/u1ecweW/Z/ZvT4vEkugC+KyyYlNSezLLVI3y6BK2PF05/MBdNZKj60BjYwrmHuYuTgkBAw
        kVixk7eLkRPIFJO4cG89G4gtJLCUUeJuc10XIxeQ/YVR4k/nE1aQel4BLYljp5NAalgEVCU+
        vl7MBGKzCRhLbF6+BKxXVCBCYvnqk4wgNq+AoMSPyfdYQGwRgSiJw98esYHMZBa4ziLx5Pld
        sISwQLBE67JTjBDL2hklJu86ywiyjFPAU2LHFXYQk1lAT+L+RS2QcmYBeYnNa94yT2AUmIVk
        xSyEqllIqhYwMq9iFE0tTS4oTkrPNdIrTswtLs1L10vOz93ECInhrzsYlx6zOsQowMGoxMNr
        sf5QqBBrYllxZe4hRgkOZiUR3q0XgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5Z+56HyIkkJ5Y
        kpqdmlqQWgSTZeLglGpgtLTes8CE09yNf/GslcEfTm1e8PPPzpd6oSn3yoRXO2qu0tx5RZvV
        VG3n34X1i1/8XaI6c2GXft1TWbn29P53E49sWtThd/aUS5DF9ROHivh8DF915Tgy275kkJ4t
        ZHN4ha2m1YPk2/seuF3+9khuz6n5K8JljWetqyqVT4tWrU7JvnhI9/3ZJCWW4oxEQy3mouJE
        AErcpffdAgAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48663
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

On 06.08.2015 15:45, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/exynos_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
