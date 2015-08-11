Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 03:24:22 +0200 (CEST)
Received: from irl-smtp01.263.net ([54.76.167.174]:37812 "EHLO
        irl-smtp01.263.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010776AbbHKBYU6ZvM7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 03:24:20 +0200
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by irl-smtp01.263.net (Postfix) with ESMTP id 94B15834E8;
        Tue, 11 Aug 2015 09:22:02 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: stripathi@apm.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <f92721998042678c475dac4b690f5fd2>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by irl-smtp01.263.net (Postfix) whith ESMTP id 11729CQISUG;
        Tue, 11 Aug 2015 09:22:01 +0800 (CST)
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add the support for sdhci-5.1
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
References: <1439255696-3263-1-git-send-email-shawn.lin@rock-chips.com>
Cc:     lintao@rock-chips.com, heiko@sntech.de, dianders@chromium.org,
        Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Suman Tripathi <stripathi@apm.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55C94E2F.5000907@rock-chips.com>
Date:   Tue, 11 Aug 2015 09:21:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1439255696-3263-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lintao@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48763
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

On 2015/8/11 9:14, Shawn Lin wrote:
> This patch adds the quirks and compatible string in sdhci-of-arasan.c
> to support sdhci-arasan5.1 version of controller.
>

Sorry for wrong send-email ops, pls ignore this patch :(

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>   Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 +-
>   drivers/mmc/host/sdhci-of-arasan.c                     | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 7e94903..da541c3 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -9,7 +9,7 @@ Device Tree Bindings for the Arasan SDHCI Controller
>
>   Required Properties:
>     - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> -                'arasan,sdhci-4.9a'
> +                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>     - reg: From mmc bindings: Register location and length.
>     - clocks: From clock bindings: Handles to clock inputs.
>     - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index ef5a7d2..c9012f5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -175,6 +175,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>   		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>   		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> +					   "arasan,sdhci-5.1")) {
> +		host->quirks |= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>   	}
>
>   	sdhci_get_of_property(pdev);
> @@ -217,6 +220,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>
>   static const struct of_device_id sdhci_arasan_of_match[] = {
>   	{ .compatible = "arasan,sdhci-8.9a" },
> +	{ .compatible = "arasan,sdhci-5.1" },
>   	{ .compatible = "arasan,sdhci-4.9a" },
>   	{ }
>   };
>


-- 
Shawn Lin
