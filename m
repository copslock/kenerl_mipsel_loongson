Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:52:40 +0200 (CEST)
Received: from smtprelay4.synopsys.com ([198.182.47.9]:47127 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008877AbbHEIwgufrTu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Aug 2015 10:52:36 +0200
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 676EB24E20A7;
        Wed,  5 Aug 2015 01:52:27 -0700 (PDT)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id 071D04E213;
        Wed,  5 Aug 2015 01:52:27 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id EAEB14E202;
        Wed,  5 Aug 2015 01:52:25 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8F658F2D;
        Wed,  5 Aug 2015 01:52:19 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 88CA8F20;
        Wed,  5 Aug 2015 01:52:18 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.28) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 5 Aug 2015 01:52:18 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0195.001; Wed,
 5 Aug 2015 10:52:15 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC:     "dianders@chromium.org" <dianders@chromium.org>,
        "wangzhou.bry@gmail.com" <wangzhou.bry@gmail.com>,
        "tomeu.vizoso@collabora.com" <tomeu.vizoso@collabora.com>,
        "pawel.moll@arm.com" <pawel.moll@arm.com>,
        "javier.martinez@collabora.co.uk" <javier.martinez@collabora.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "haokexin@gmail.com" <haokexin@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>,
        "galak@codeaurora.org" <galak@codeaurora.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "long.wanglong@huawei.com" <long.wanglong@huawei.com>,
        "peter.griffin@linaro.org" <peter.griffin@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mjonker@synopsys.com" <mjonker@synopsys.com>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
        "tgih.jun@samsung.com" <tgih.jun@samsung.com>,
        "govindraj.raja@imgtec.com" <govindraj.raja@imgtec.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "k.kozlowski@samsung.com" <k.kozlowski@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "chaotian.jing@mediatek.com" <chaotian.jing@mediatek.com>,
        "trblinux@gmail.com" <trblinux@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "swarren@nvidia.com" <swarren@nvidia.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
        "vincent.yang.fujitsu@gmail.com" <vincent.yang.fujitsu@gmail.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "Weijun.Yang@csr.com" <Weijun.Yang@csr.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "khilman@linaro.org" <khilman@linaro.org>,
        "abrestic@chromium.org" <abrestic@chromium.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "l.majewski@samsung.com" <l.majewski@samsung.com>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "alexandre.belloni@free-electrons.com" 
        <alexandre.belloni@free-electrons.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "linux.amoon@gmail.com" <linux.amoon@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "sjoerd.simons@collabora.co.uk" <sjoerd.simons@collabora.co.uk>,
        "afaerber@suse.de" <afaerber@suse.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "jun.nie@linaro.org" <jun.nie@linaro.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "manabian@gmail.com" <manabian@gmail.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v3 5/5] ARM: dts: add supports-idmac property
Thread-Topic: [RFC PATCH v3 5/5] ARM: dts: add supports-idmac property
Thread-Index: AQHQz1fwuQLSHr3b7kC1oTKzlck8F53899UA
Date:   Wed, 5 Aug 2015 08:52:15 +0000
Message-ID: <1438764734.3504.9.camel@synopsys.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
         <1438762730-22368-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1438762730-22368-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.78]
Content-Type: text/plain; charset="utf-7"
Content-ID: <389F2642BBCCE444BE27E61447882A61@internal.synopsys.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Alexey.Brodkin@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexey.Brodkin@synopsys.com
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

Hi Shawn,

On Wed, 2015-08-05 at 16:18 +-0800, Shawn Lin wrote:
+AD4- DesignWare MMC Controller's transfer mode should be decided
+AD4- at runtime instead of compile-time. Add +ACI-supports-idmac+ACI- for
+AD4- all platforms that use internal dma mode to enable this feature
+AD4- at runtime.
+AD4- 
+AD4- Signed-off-by: Shawn Lin +ADw-shawn.lin+AEA-rock-chips.com+AD4-
+AD4- ---
+AD4- 
+AD4- Changes in v3: None
+AD4- Changes in v2: None
+AD4- 
+AD4-  arch/arm/boot/dts/exynos3250-monk.dts              +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos3250-rinato.dts            +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4412-origen.dts            +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4412-trats2.dts            +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4x12.dtsi                  +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos5250-arndale.dts           +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5250-smdk5250.dts          +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5250-snow.dts              +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/exynos5250-spring.dts            +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5260-xyref5260.dts         +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5410-smdk5410.dts          +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5420-arndale-octa.dts      +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5420-peach-pit.dts         +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/exynos5420-smdk5420.dts          +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5800-peach-pi.dts          +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/hisi-x5hd2.dtsi                  +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/rk3288-evb.dtsi                  +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/rk3288-firefly.dtsi              +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/rk3288-popmetal.dts              +AHw- 2 +-+-
+AD4-  arch/arm64/boot/dts/exynos/exynos7-espresso.dts    +AHw- 2 +-+-
+AD4-  22 files changed, 42 insertions(+-)

I'm wondering if you're going to care about other platforms
that use DW MMC?

Just grep for +ACI-snps,dw-mshc+ACI-, +ACI-altr,socfpga-dw-mshc+ACI-,
+ACI-img,pistachio-dw-mshc+ACI- and you'll see more dt+ACo- files to
be updated.

-Alexey
From shawn.lin@rock-chips.com Wed Aug  5 10:56:32 2015
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:56:34 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.130]:43129 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008877AbbHEI4cQsvgu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 10:56:32 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.140])
        by lucky1.263xmail.com (Postfix) with SMTP id 2FDFA1E2FA5;
        Wed,  5 Aug 2015 16:56:21 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 353C3455;
        Wed,  5 Aug 2015 16:56:07 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: srinivas.kandagatla@linaro.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <3e5e207db49459c441a97bfd20625429>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 541ZJUUR7;
        Wed, 05 Aug 2015 16:56:17 +0800 (CST)
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <55C1C8E9.1060808@samsung.com> <55C1CCA8.7040304@rock-chips.com>
 <2567191.z5Kn3VDlTS@diego>
Cc:     shawn.lin@rock-chips.com,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Seungwon Jeon <tgih.jun@samsung.com>, dianders@chromium.org,
        linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ge ert Uytterhoeven <geert+renesas@glider.be>,
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
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55C1CFAA.4090100@rock-chips.com>
Date:   Wed, 5 Aug 2015 16:56:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <2567191.z5Kn3VDlTS@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48590
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

在 2015/8/5 16:45, Heiko Stübner 写道:
> Am Mittwoch, 5. August 2015, 16:43:20 schrieb Shawn Lin:
>> 在 2015/8/5 16:27, Krzysztof Kozlowski 写道:
>>> On 05.08.2015 17:17, Shawn Lin wrote:
>>>> synopsys-dw-mshc supports three types of transfer mode. We add bindings
>>>> and description for how to use them at runtime. Without idmac and edmac
>>>> property, pio is the default transfer mode. Make sure that Idmac and
>>>> emdac
>>>> should not be used simultaneously.
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>> ---
>>>>
>>>> Changes in v3: None
>>>> Changes in v2: None
>>>>
>>>>    .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 41
>>>>    ++++++++++++++++++++++ 1 file changed, 41 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>>> b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt index
>>>> 346c609..30369cb 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>>>
>>>> @@ -75,6 +75,25 @@ Optional properties:
>>>>    * vmmc-supply: The phandle to the regulator to use for vmmc.  If this
>>>>    is
>>>>    
>>>>      specified we'll defer probe until we can find this regulator.
>>>>
>>>> +* supports-idmac: Enables support for internal DMAC block within the
>>>> Synopsys +  Designware Mobile Storage IP block. If supports-idmac
>>>> property is present, then +  we MUST NOT add supports-edmac property
>>>> since we'd assume that dw-mshc IP is +  integrated with only one type of
>>>> dma master.
>>>> +
>>>> +* supports-edmac: Enables support for external DMAC block outside the
>>>> Synopsys +  Designware Mobile Storage IP block. If supports-edmac
>>>> property is present, then +  we MUST NOT add supports-idmac property
>>>> since we'd assume that dw-mshc IP is +  integrated with only one type of
>>>> dma master.
>>>> +
>>>> +  (Without "supports-idmac" and "supports-edmac", use PIO as default
>>>> transfer mode)>
>>> Aren't you breaking here backward compatibility with existing DTB?
>>>
>>> Best regards,
>>> Krzysztof
>>    Thanks, Krzysztof.
>>    I guess you mean that I should keep existing DTB w/o these two
>> properties work fine using idmac?
> yep
   Okay, I got it.
>
>>>> +
>>>> +* dmas: List of DMA specifiers with the controller specific format as
>>>> described +  in the generic DMA client binding. This property should be
>>>> combined with +  supports-edmac. Refer to dma.txt for details.
>>>> +
>>>> +* dma-names: DMA request names. Must be "rx-tx". And This property
>>>> should be +  combined with supports-edmac. Refer to dma.txt for details.
>>>> +
> Similarly the use of an external dmac could simply be detected, by the
> presence of the dma-* properties. So when the machine defines dma channels use
> the external dma, otherwise the internal (or none). So you wouldn't need
> separate new properties at all.
   Thanks, Heiko.  I understand your point.
   It will be done in v4.
>
>>>>    Aliases:
>>>>    
>>>>    - All the MSHC controller nodes should be represented in the aliases
>>>>    node using>>
>>>> @@ -95,6 +114,8 @@ board specific portions as listed below.
>>>>
>>>>    		#size-cells = <0>;
>>>>    	
>>>>    	};
>>>>
>>>> +[board specific internal DMA resources]
>>>> +
>>>>
>>>>    	dwmmc0@12200000 {
>>>>    	
>>>>    		clock-frequency = <400000000>;
>>>>    		clock-freq-min-max = <400000 200000000>;
>>>>
>>>> @@ -106,4 +127,24 @@ board specific portions as listed below.
>>>>
>>>>    		bus-width = <8>;
>>>>    		cap-mmc-highspeed;
>>>>    		cap-sd-highspeed;
>>>>
>>>> +		supports-idmac;
>>>>
>>>>    	};
>>>>
>>>> +
>>>> +[board specific generic DMA request binding]
>>>> +
>>>> +	dwmmc0@12200000 {
>>>> +		clock-frequency = <400000000>;
>>>> +		clock-freq-min-max = <400000 200000000>;
>>>> +		num-slots = <1>;
>>>> +		broken-cd;
>>>> +		fifo-depth = <0x80>;
>>>> +		card-detect-delay = <200>;
>>>> +		vmmc-supply = <&buck8>;
>>>> +		bus-width = <8>;
>>>> +		cap-mmc-highspeed;
>>>> +		cap-sd-highspeed;
>>>> +		supports-edmac;
>>>> +		dmas = <&pdma 12>;
>>>> +		dma-names = "rx-tx";
>>>> +	};
>>>> +
>
>
>


-- 
Shawn Lin
