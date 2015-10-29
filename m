Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 03:32:47 +0100 (CET)
Received: from mailout2.samsung.com ([203.254.224.25]:56224 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011674AbbJ2CcoUFqa1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 03:32:44 +0100
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWY02KHGN1YDJ40@mailout2.samsung.com>; Thu,
 29 Oct 2015 11:32:22 +0900 (KST)
Received: from epcpsbgm2new.samsung.com ( [172.20.52.113])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id AA.63.05272.63581365; Thu,
 29 Oct 2015 11:32:22 +0900 (KST)
X-AuditID: cbfee68e-f791c6d000001498-97-5631853609b7
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 10.C1.18629.63581365; Thu, 29 Oct 2015 11:32:22 +0900 (KST)
Received: from [10.252.81.186] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NWY005HIN1YSW50@mmp2.samsung.com>; Thu,
 29 Oct 2015 11:32:22 +0900 (KST)
Message-id: <56318536.1010408@samsung.com>
Date:   Thu, 29 Oct 2015 11:32:22 +0900
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
Subject: Re: [RFC PATCH v8 09/10] arm: multi_v7_defconfig: remove
 CONFIG_MMC_DW_IDMAC
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
 <1442385795-1389-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1442385795-1389-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRTm3XfZt9Hqbam9jW5IEV20bW72RhFF/fi6QIWgUZFO+zDLzbXP
        Sf1q4SUKm9MsastLpaGWmTPR1HJK1g/t5tQMzSzvTaMLDVfUmltR/855znOe5zlwGEJqo2RM
        ki6VM+g0yaG0mLwdpDoeFpmpiJY7PGqc3j0ixD/zHgtx0aNnFH56s4XG0yMDJPa+d1G4ZPid
        ELvGFThnyEVg+1APhZ0NV2lsuZgnxI+8OQB/GfQS+PLzhwLc55TgxlfPAO5sWob7h6so/KQy
        Bp/+UEng4bZ8YnMIm5GeTbM/vucB1mZ6SbL3rW+E7FBBtZDNvt8BWHvFWZrt72mi2bbySgFb
        U3KK/WltJlnzvQrA1vUUEuy95q+A/WpfvGfOfvHGw1xyUhpnWLspTnzEbjlP6muZE83mUYEJ
        TNLngIhBUIVKv6UTgToEvRio8uFiRgrLABovmhD8JVkKPxOBgRWg+ktOKtAMAjQ29dHPksBV
        KKNgyl+TcDkyZQ/6ZWm4BtW5n/jxYBiNBu88oAL8uWj6wgB5DjBMENyM7EVBM5oELKWQyWP2
        8+fBGOR50AYCZlkAdY16yJmBCLLI2zMEZpYJuALl52tnYAIuQTW3p/xJETwjQnfbu8hAIIjc
        F1r9ZgguQnbHn5MXoJayXtICQqz/RbL+U7X+p1oMiAoQzOkT9Hx8okEZzmu0vFGXGJ6QorUD
        38+0/xo114PXjg2tADIgdJbkmlIRLaU0afxJbStQ+0LkErLghBTfm+lSYxURkUqsVqkjlOvW
        R4bOl8TJPFFSmKhJ5Y5xnJ4zxBqMyRzfCgSMSGYCxkMSg/zDW9XWX3KbEh/YkvVes72qi9nX
        X7yEj7f1ik7k6py9ueKRO15j/WybzHB+l3AyqbozbTp+YqUrfPfOjlpaX2LsPnR04ZWoOtu2
        HTnuePnqWsWtsMaGsOvjfWNu84rapaIDvMOd9UXUsratXP/2zOe93cbJ2IOLMtd9uhFK8kc0
        ilWEgdf8Bgnoq8EuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsVy+t9jQV2zVsMwgwdf9Syarz5lt/g76Ri7
        xfwj51gtzi47yGbx4+k9Fov/j16zWix58pDd4vULQ4v+x6+ZLTY9vsZqcXnXHDaLCVMnsVsc
        +d/PaPHpwX9mixnn9zFZ3L7Ma7H7+jlGi0t7VCzuPFnPanF8bbhF46u1zBZPjk5hdhDzaGnu
        YfP4/WsSo8fshossHjtn3WX3eDx3I7tHz84zjB6bVnWyedy5tofN4+jKtUwem5fUe/ydtZ/F
        o2/LKkaP7dfmMXts2f+Z0ePzJrkA/qgGRpuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
        SwtzJYW8xNxUWyUXnwBdt8wcoP+VFMoSc0qBQgGJxcVK+naYJoSGuOlawDRG6PqGBMH1GBmg
        gYQ1jBmbJvSyFGzlqNjf94ypgfENWxcjJ4eEgInEhHkfmSFsMYkL99YDxbk4hARmMUrsmHaZ
        FcJ5wCjx/O07JpAqXgEtiZa5b8FsFgFViYaeB2DdbAI6Etu/HQeLiwqESTxYt5cVol5Q4sfk
        eyxdjBwcIgIOEpvmi4DMZBZYyirR8LMPrF5YIFzi596jjBDL2hglrjz7yQKS4BTwkPh/7TEj
        SDOzgLrElCm5IGFmAXmJzWveMk9gBDoTYcUshKpZSKoWMDKvYpRILUguKE5KzzXKSy3XK07M
        LS7NS9dLzs/dxAhOZc+kdzAe3uV+iFGAg1GJh3eBkWGYEGtiWXFl7iFGCQ5mJRFeaRagEG9K
        YmVValF+fFFpTmrxIUZTYBhMZJYSTc4Hptm8knhDYxMzI0sjc0MLI2NzJXHeCxkaYUIC6Ykl
        qdmpqQWpRTB9TBycUg2MPVuNn9yY12k4kVnzxNO/4XdXLbOPK99zb86OIwpbJ7zLu+3d8vbS
        fBs1vxP3X5j+uqSmEfyXh4Env27xXpMjYc/apAT2MHobPwgo/mZm2Vegw9wy67zc3b23gpc/
        bG/L3zKX5f2GuEtS/HOucVh0HftQIDbvev66lFv5wld8ll0JdF30OKbBXYmlOCPRUIu5qDgR
        AN/Kekd7AwAA
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49758
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
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 03deb7f..ad929ea 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -539,7 +539,6 @@ CONFIG_MMC_ATMELMCI=y
>  CONFIG_MMC_MVSDIO=y
>  CONFIG_MMC_SDHI=y
>  CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>  CONFIG_MMC_DW_PLTFM=y
>  CONFIG_MMC_DW_EXYNOS=y
>  CONFIG_MMC_DW_ROCKCHIP=y
> 
