Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:46:50 +0200 (CEST)
Received: from gloria.sntech.de ([95.129.55.99]:37681 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008877AbbHEIqsg9-Pu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 10:46:48 +0200
Received: from [95.91.148.129] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1ZMuKJ-0007Wy-Jq; Wed, 05 Aug 2015 10:45:31 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
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
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
Date:   Wed, 05 Aug 2015 10:45:30 +0200
Message-ID: <2567191.z5Kn3VDlTS@diego>
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <55C1CCA8.7040304@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com> <55C1C8E9.1060808@samsung.com> <55C1CCA8.7040304@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Return-Path: <heiko@sntech.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko@sntech.de
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

Am Mittwoch, 5. August 2015, 16:43:20 schrieb Shawn Lin:
> 在 2015/8/5 16:27, Krzysztof Kozlowski 写道:
> > On 05.08.2015 17:17, Shawn Lin wrote:
> >> synopsys-dw-mshc supports three types of transfer mode. We add bindings
> >> and description for how to use them at runtime. Without idmac and edmac
> >> property, pio is the default transfer mode. Make sure that Idmac and
> >> emdac
> >> should not be used simultaneously.
> >> 
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> ---
> >> 
> >> Changes in v3: None
> >> Changes in v2: None
> >> 
> >>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 41
> >>   ++++++++++++++++++++++ 1 file changed, 41 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> >> b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt index
> >> 346c609..30369cb 100644
> >> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> >> 
> >> @@ -75,6 +75,25 @@ Optional properties:
> >>   * vmmc-supply: The phandle to the regulator to use for vmmc.  If this
> >>   is
> >>   
> >>     specified we'll defer probe until we can find this regulator.
> >> 
> >> +* supports-idmac: Enables support for internal DMAC block within the
> >> Synopsys +  Designware Mobile Storage IP block. If supports-idmac
> >> property is present, then +  we MUST NOT add supports-edmac property
> >> since we'd assume that dw-mshc IP is +  integrated with only one type of
> >> dma master.
> >> +
> >> +* supports-edmac: Enables support for external DMAC block outside the
> >> Synopsys +  Designware Mobile Storage IP block. If supports-edmac
> >> property is present, then +  we MUST NOT add supports-idmac property
> >> since we'd assume that dw-mshc IP is +  integrated with only one type of
> >> dma master.
> >> +
> >> +  (Without "supports-idmac" and "supports-edmac", use PIO as default
> >> transfer mode)> 
> > Aren't you breaking here backward compatibility with existing DTB?
> > 
> > Best regards,
> > Krzysztof
> 
>   Thanks, Krzysztof.
>   I guess you mean that I should keep existing DTB w/o these two
> properties work fine using idmac?

yep


> >> +
> >> +* dmas: List of DMA specifiers with the controller specific format as
> >> described +  in the generic DMA client binding. This property should be
> >> combined with +  supports-edmac. Refer to dma.txt for details.
> >> +
> >> +* dma-names: DMA request names. Must be "rx-tx". And This property
> >> should be +  combined with supports-edmac. Refer to dma.txt for details.
> >> +

Similarly the use of an external dmac could simply be detected, by the 
presence of the dma-* properties. So when the machine defines dma channels use 
the external dma, otherwise the internal (or none). So you wouldn't need 
separate new properties at all.


> >> 
> >>   Aliases:
> >>   
> >>   - All the MSHC controller nodes should be represented in the aliases
> >>   node using>> 
> >> @@ -95,6 +114,8 @@ board specific portions as listed below.
> >> 
> >>   		#size-cells = <0>;
> >>   	
> >>   	};
> >> 
> >> +[board specific internal DMA resources]
> >> +
> >> 
> >>   	dwmmc0@12200000 {
> >>   	
> >>   		clock-frequency = <400000000>;
> >>   		clock-freq-min-max = <400000 200000000>;
> >> 
> >> @@ -106,4 +127,24 @@ board specific portions as listed below.
> >> 
> >>   		bus-width = <8>;
> >>   		cap-mmc-highspeed;
> >>   		cap-sd-highspeed;
> >> 
> >> +		supports-idmac;
> >> 
> >>   	};
> >> 
> >> +
> >> +[board specific generic DMA request binding]
> >> +
> >> +	dwmmc0@12200000 {
> >> +		clock-frequency = <400000000>;
> >> +		clock-freq-min-max = <400000 200000000>;
> >> +		num-slots = <1>;
> >> +		broken-cd;
> >> +		fifo-depth = <0x80>;
> >> +		card-detect-delay = <200>;
> >> +		vmmc-supply = <&buck8>;
> >> +		bus-width = <8>;
> >> +		cap-mmc-highspeed;
> >> +		cap-sd-highspeed;
> >> +		supports-edmac;
> >> +		dmas = <&pdma 12>;
> >> +		dma-names = "rx-tx";
> >> +	};
> >> +
