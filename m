Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:49:08 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.133]:38322 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011723AbbHEItGrhARu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 10:49:06 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.139])
        by regular1.263xmail.com (Postfix) with SMTP id 8A1548185;
        Wed,  5 Aug 2015 16:49:02 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 3FED5476;
        Wed,  5 Aug 2015 16:48:48 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: srinivas.kandagatla@linaro.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <d5da9f0883974fcfe273e3bd1c76db66>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 31340O9GRXU;
        Wed, 05 Aug 2015 16:48:57 +0800 (CST)
Subject: Re: [RFC PATCH v3 3/5] arm: configs: remove CONFIG_MMC_DW_IDMAC
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Seungwon Jeon <tgih.jun@samsung.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762690-22286-1-git-send-email-shawn.lin@rock-chips.com>
 <C2D7FE5348E1B147BCA15975FBA23075665B111F@IN01WEMBXB.internal.synopsys.com>
Cc:     shawn.lin@rock-chips.com,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
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
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55C1CDF4.5070302@rock-chips.com>
Date:   Wed, 5 Aug 2015 16:48:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665B111F@IN01WEMBXB.internal.synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48587
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

在 2015/8/5 16:34, Vineet Gupta 写道:
> On Wednesday 05 August 2015 01:52 PM, Shawn Lin wrote:
>> DesignWare MMC Controller's transfer mode should be decided
>> at runtime instead of compile-time. So we remove this config
>> option, and elaborate more in Documentation(synopsys-dw-mshc).
>>
>> Modify these files:
>> arch/arc/configs/axs101_defconfig
>> arch/arc/configs/axs103_defconfig
>> arch/arc/configs/axs103_smp_defconfig
> While you remove the config option from ARC defconfigs, you fail to add the
> corresponding DT glue in ARC files (like you did for ARM). The pointer to DT is
> contained in corresponding defconfig. Please fix that .

Yes,  I will fix it ASAP.
Thanks, Vineet.

> -Vineet
>
>
>


-- 
Shawn Lin
