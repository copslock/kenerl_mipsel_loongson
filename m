Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 00:05:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45712 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013174AbbHLWFMSHmHI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 00:05:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t7CM56FK025178;
        Thu, 13 Aug 2015 00:05:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t7CM50VR025155;
        Thu, 13 Aug 2015 00:05:00 +0200
Date:   Thu, 13 Aug 2015 00:05:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     jh80.chung@samsung.com, ulf.hansson@linaro.org, heiko@sntech.de,
        dianders@chromium.org, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/9] mips: pistachio_defconfig: remove
 CONFIG_MMC_DW_IDMAC
Message-ID: <20150812220500.GD11636@linux-mips.org>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843515-23935-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438843515-23935-1-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Aug 06, 2015 at 02:45:15PM +0800, Shawn Lin wrote:

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
>  arch/mips/configs/pistachio_defconfig | 1 -

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Please feel free to merge this patch with the remainder
of the series.

  Ralf
