Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:27:51 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42339 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011503AbbHEI1sRiNeu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 10:27:48 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSL003PKOU4A680@mailout1.w1.samsung.com>; Wed,
 05 Aug 2015 09:27:40 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-25-55c1c8fb39ec
Received: from eusync4.samsung.com ( [203.254.199.214])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 01.3C.04846.BF8C1C55; Wed,
 5 Aug 2015 09:27:39 +0100 (BST)
Received: from [0.0.0.0] ([106.116.37.23])
 by eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NSL00GGZOTIEJA0@eusync4.samsung.com>; Wed,
 05 Aug 2015 09:27:39 +0100 (BST)
Message-id: <55C1C8E9.1060808@samsung.com>
Date:   Wed, 05 Aug 2015 17:27:21 +0900
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
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUxTBxTHd3o/adbkgqh3btGlYTxgZGMzy3Fb5haT7W5Z3DS6GR/mClyB
        CNi0YKZbMhJQNmCgfFhWoGhKKR2FShucUIeCpcAm1doJjMlHaZENLCCDQSTAKM0y337nnN85
        /5fDEhE19DY2JT1DVKUrUuW0lPx1tatv13J3++FX7JV70DSzAph9f5zB2rVFCWZb1fhtn16C
        o7qrNK4UOxmcqS0A7BusprHa4aKwt7adxqJHlymsqigGXBofJtE5MUrh2tgUha5JE2DnshIN
        Q3M0Djw5R2GN38vg1J9xWOSbInDhVh3gI68N0Orro9DTWknj+bJiBh1rRYBzo2sElt9pk2Bj
        0yCDf3hk6PCYAe39LkBDv1uCI/pFwF/6/17f0jSQeKV8lURfXYDBe9ejcPwHG41nf3YwuHQ7
        n8Tpej/gA7+FQk1XgMJzTieFtsZcBgc0ORTOjrgJLGy4R+OVEvt61oUSwK6Gz7CjeYxEo+5V
        bJszAAYudTL41+NuEv2dpQT+br7LvLNX0C8OE4JZZwYhJ7uAFpafFIOgHemlhYosNyl4Cr+X
        CCsT/aRwbagGhNaWSkrwW90gXOjdJbRohxjBZJynBV9VEyPkOALUJy8elb6VKKamnBJVL7/9
        hTT5YWcLKAuf+9J5Y4zIgtzIPAhjeW4331zgoUK8hb87bKHzQMpGcAbgLQsOMlTMA2+62kQH
        LRkXw393+bYkyCT3Et9Qb9pgmnuNtxlrNpzN3BHeWN8DIT+cXyoZ3jgUyemAzztbAMGC4MbC
        +RvTdRvWJi6B17uvS0JxucAbJjREHrBsGPcBPzh5MIgEF8uPuGOCOsHt4G3mAHEeOO1TGdr/
        Le1T1iUgfoTNYmaCUh2flBYXq1akqTPTk2ITTqZZIfS789dA73yjAzgW5M/KZve1H46gFKfU
        p9M6gGcJeaQs+af1lixRcfqMqDp5TJWZKqo74HmWlG+VVbXOHIrgkhQZ4glRVIqq/6YSNmxb
        FiR0WyrCo1dHv/b2vPDePmNU4+vvj9elzFa3WwbevX/w0EX2K+/kR4GbrR9Hb/mn+UGspNu+
        1/1N/JmHUas6acan03sOtCRe3OkbXL7jyh/6rezzZ/LfVDe2PY5WelO4TQsZ+d7ScuuHzeXT
        mh03w7Yfk2/fH3nkuNVlr4jvKSvFE7n7fXJSnayIiyFUasW/wSevvrcDAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48583
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

On 05.08.2015 17:17, Shawn Lin wrote:
> synopsys-dw-mshc supports three types of transfer mode. We add bindings
> and description for how to use them at runtime. Without idmac and edmac
> property, pio is the default transfer mode. Make sure that Idmac and emdac
> should not be used simultaneously.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 346c609..30369cb 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -75,6 +75,25 @@ Optional properties:
>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>    specified we'll defer probe until we can find this regulator.
>  
> +* supports-idmac: Enables support for internal DMAC block within the Synopsys
> +  Designware Mobile Storage IP block. If supports-idmac property is present, then
> +  we MUST NOT add supports-edmac property since we'd assume that dw-mshc IP is
> +  integrated with only one type of dma master.
> +
> +* supports-edmac: Enables support for external DMAC block outside the Synopsys
> +  Designware Mobile Storage IP block. If supports-edmac property is present, then
> +  we MUST NOT add supports-idmac property since we'd assume that dw-mshc IP is
> +  integrated with only one type of dma master.
> +
> +  (Without "supports-idmac" and "supports-edmac", use PIO as default transfer mode)

Aren't you breaking here backward compatibility with existing DTB?

Best regards,
Krzysztof

> +
> +* dmas: List of DMA specifiers with the controller specific format as described
> +  in the generic DMA client binding. This property should be combined with
> +  supports-edmac. Refer to dma.txt for details.
> +
> +* dma-names: DMA request names. Must be "rx-tx". And This property should be
> +  combined with supports-edmac. Refer to dma.txt for details.
> +
>  Aliases:
>  
>  - All the MSHC controller nodes should be represented in the aliases node using
> @@ -95,6 +114,8 @@ board specific portions as listed below.
>  		#size-cells = <0>;
>  	};
>  
> +[board specific internal DMA resources]
> +
>  	dwmmc0@12200000 {
>  		clock-frequency = <400000000>;
>  		clock-freq-min-max = <400000 200000000>;
> @@ -106,4 +127,24 @@ board specific portions as listed below.
>  		bus-width = <8>;
>  		cap-mmc-highspeed;
>  		cap-sd-highspeed;
> +		supports-idmac;
>  	};
> +
> +[board specific generic DMA request binding]
> +
> +	dwmmc0@12200000 {
> +		clock-frequency = <400000000>;
> +		clock-freq-min-max = <400000 200000000>;
> +		num-slots = <1>;
> +		broken-cd;
> +		fifo-depth = <0x80>;
> +		card-detect-delay = <200>;
> +		vmmc-supply = <&buck8>;
> +		bus-width = <8>;
> +		cap-mmc-highspeed;
> +		cap-sd-highspeed;
> +		supports-edmac;
> +		dmas = <&pdma 12>;
> +		dma-names = "rx-tx";
> +	};
> +
> 
