Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:35:39 +0200 (CEST)
Received: from smtprelay2.synopsys.com ([198.182.60.111]:41596 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011503AbbHEIf3ybchu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Aug 2015 10:35:29 +0200
Received: from dc8secmta2.synopsys.com (dc8secmta2.synopsys.com [10.13.218.202])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5D51B10C0164;
        Wed,  5 Aug 2015 01:35:20 -0700 (PDT)
Received: from dc8secmta2.internal.synopsys.com (dc8secmta2.internal.synopsys.com [127.0.0.1])
        by dc8secmta2.internal.synopsys.com (Service) with ESMTP id F21D9A4102;
        Wed,  5 Aug 2015 01:35:19 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by dc8secmta2.internal.synopsys.com (Service) with ESMTP id EDDDAA4112;
        Wed,  5 Aug 2015 01:35:18 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9AAF6431;
        Wed,  5 Aug 2015 01:35:18 -0700 (PDT)
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id BC2A8427;
        Wed,  5 Aug 2015 01:35:15 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 5 Aug 2015 01:34:58 -0700
Received: from IN01WEMBXB.internal.synopsys.com ([169.254.4.157]) by
 IN01WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0195.001; Wed, 5
 Aug 2015 14:04:55 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "Seungwon Jeon" <tgih.jun@samsung.com>
CC:     "dianders@chromium.org" <dianders@chromium.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Stefan Agner <stefan@agner.ch>,
        Zhou Wang <wangzhou.bry@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Wang Long <long.wanglong@huawei.com>,
        "Rob Herring" <robh+dt@kernel.org>,
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
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "Scott Branden" <sbranden@broadcom.com>,
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
        "Joachim Eastwood" <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        "Peter Griffin" <peter.griffin@linaro.org>,
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
        "Wei Xu" <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [RFC PATCH v3 3/5] arm: configs: remove CONFIG_MMC_DW_IDMAC
Thread-Topic: [RFC PATCH v3 3/5] arm: configs: remove CONFIG_MMC_DW_IDMAC
Thread-Index: AQHQz1fY0OtxIPRfiEOAXke6l6D2tg==
Date:   Wed, 5 Aug 2015 08:34:54 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665B111F@IN01WEMBXB.internal.synopsys.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762690-22286-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.191]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On Wednesday 05 August 2015 01:52 PM, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option, and elaborate more in Documentation(synopsys-dw-mshc).
>
> Modify these files:
> arch/arc/configs/axs101_defconfig
> arch/arc/configs/axs103_defconfig
> arch/arc/configs/axs103_smp_defconfig

While you remove the config option from ARC defconfigs, you fail to add the
corresponding DT glue in ARC files (like you did for ARM). The pointer to DT is
contained in corresponding defconfig. Please fix that .

-Vineet
